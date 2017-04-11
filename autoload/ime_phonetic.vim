let s:table = {}

function! s:log (...)
    call call(function('ime#log'), ['phonetic'] + a:000)
endfunction


function! ime_phonetic#_GetAllKeyStartsWith (table, key)
    return filter(keys(a:table), 'strpart(v:val, 0, strlen(a:key)) == a:key')
endfunction


function! ime_phonetic#_GetBestWord (table, code_list)
    let l:probes = [a:table]
    let l:leaves = []
    let l:best = {'w': '', 'f': -1}
    for l:code in a:code_list
        let l:next_probe = []
        let l:leaves = []
        for l:probe in l:probes
            for l:key in ime_phonetic#_GetAllKeyStartsWith(l:probe, l:code)
                if type(l:probe[(l:key)]) == type({})
                    call add(l:next_probe, l:probe[(l:key)])
                else
                    call add(l:leaves, l:probe[(l:key)])
                endif
            endfor
        endfor
        let l:probes = l:next_probe
    endfor

    for l:leaf in l:leaves + map(l:probes, 'get(v:val, ''_'', [])')
        for l:record in l:leaf
            if l:record['f'] > l:best['f']
                let l:best = l:record
            endif
        endfor
    endfor
    return l:best
endfunction


function! ime_phonetic#_FindBestSentence (table, code_list)
    " This function searches optimal sentences of a:code_list from s:table
    " with dynamic programming

    let l:len = len(a:code_list)

    " l:dp_val[a][b] stores the best solution of code_list[a:b]
    let l:dp_val = map(
                \ range(l:len - 1),
                \ 'map(range(l:len - 1), ''{"v": -1, "w": ""}'')')
    for l:i in range(0, l:len - 1)
        for l:j in range(l:i, l:len - 1)
            call s:log(a:code_list[(l:i):(l:j)])
        endfor
    endfor
endfunction


function! ime_phonetic#handler (matchobj, trigger)
    if a:trigger == ':'
        return ['：']
    endif

    if s:table == {}
        let s:table = phonetic_table#table()
    endif

    let l:symbol_str = a:matchobj[0]

    " The single quote key only triggers the handler,
    " not insert any chars
    if a:trigger != ''''
        let l:symbol_str .= phonetic_utils#key_to_code(a:trigger)
    endif

    " No phonetic symbol given, return []
    if l:symbol_str == ' ' || l:symbol_str == ''
        return ['']
    endif

    let l:code_list = phonetic_utils#SymbolStr2CodeList(l:symbol_str)

    " Special case for single character
    if a:trigger == ''''
        return ['']
    endif

    return ['']
endfunction


function! ime_phonetic#info ()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Phonetic input mode',
    \ 'pattern':  '\v%(|:|['. phonetic_utils#symbols() .']['. phonetic_utils#symbols() .' ]*)$',
    \ 'handler': function('ime_phonetic#handler'),
    \ 'trigger': phonetic_utils#code_set() + [' ', '''', ':'],
    \ }
endfunction
