let s:table = {}

function! s:log (...)
    call call(function('ime#log'), ['phonetic'] + a:000)
endfunction


function! ime_phonetic#_GetAllKeyStartsWith (table, key) " {{{
    " Return all keys in a:table that starts with a:key
    " for fuzzy input
    return filter(keys(a:table), 'strpart(v:val, 0, strlen(a:key)) == a:key')
endfunction " }}}


function! ime_phonetic#_GetBestWord (table, code_list, partial_result) " {{{
    " This function collects all words match a:code_list
    " and returns the one has maximum frequency
    "
    " If partial_result = 0, this function returns empty result when no such
    " word
    "
    " If partial_result = 1, this function returns the longest word it can
    " find

    let l:probes = [a:table]
    let l:leaves = []
    let l:code_list = copy(a:code_list)
    while len(l:code_list) > 0
        let l:code = l:code_list[0]
        let l:next_probe = []
        let l:leaves = []
        for l:probe in l:probes
            for l:key in ime_phonetic#_GetAllKeyStartsWith(l:probe, l:code)
                " The table is sqeezed, so the leaves have to be stored
                " separately
                if type(l:probe[(l:key)]) == type({})
                    call add(l:next_probe, l:probe[(l:key)])
                else
                    call add(l:leaves, l:probe[(l:key)])
                endif
            endfor
        endfor
        if len(l:next_probe) == 0 && a:partial_result == 1
            break
        endif
        let l:probes = l:next_probe
        call remove(l:code_list, 0)
    endwhile


    let l:best = {'w': '', 'f': -1}
    " Find the word that has maximum frequency
    for l:leaf in l:leaves + map(l:probes, 'get(v:val, ''_'', [])')
        for l:record in l:leaf
            if l:record['f'] > l:best['f']
                let l:best = l:record
            endif
        endfor
    endfor

    if a:partial_result == 1
        return {
            \ 'word': l:best['w'],
            \ 'remain': l:code_list,
            \ }
    else
        " Prevent further computation polluting the table
        return copy(l:best)
    endif
endfunction " }}}


function! ime_phonetic#_FindBestSentence (table, code_list) " {{{
    " This function searches optimal sentences of a:code_list from s:table
    " with dynamic programming

    let l:len = len(a:code_list)

    " l:dp_val[a][b] stores the best solution of code_list[a:b]
    let l:dp_val = map(
                \ range(l:len),
                \ 'map(range(l:len), ''{"v": -1, "w": "", "p": 0}'')')
    for l:i in range(l:len - 1, 0, -1)
        for l:j in range(l:i, l:len - 1)
            let l:local_best = ime_phonetic#_GetBestWord(a:table, a:code_list[(l:i):(l:j)], 0)
            if l:local_best['f'] > 0
                let l:local_best['p'] = (l:j - l:i + 1) * (l:j - l:i + 1)
            else
                let l:local_best['p'] = 0
            endif
            for l:middle in range(l:i, l:j - 1)
                let l:left = l:dp_val[(l:i)][(l:middle)]
                let l:right = l:dp_val[(l:middle + 1)][(l:j)]
                if l:left['p'] + l:right['p'] > l:local_best['p']
                    let l:local_best['f'] = l:left['f'] + l:right['f']
                    let l:local_best['w'] = l:left['w'] . l:right['w']
                    let l:local_best['p'] = l:left['p'] + l:right['p']
                elseif l:left['p'] + l:right['p'] == l:local_best['p']
                    if l:left['f'] + l:right['f']  > l:local_best['f']
                        let l:local_best['f'] = l:left['f'] + l:right['f']
                        let l:local_best['w'] = l:left['w'] . l:right['w']
                    endif
                endif
            endfor
            let l:dp_val[(l:i)][(l:j)] = l:local_best
        endfor
    endfor

    return l:dp_val[0][(l:len - 1)]['w']
endfunction " }}}


function! s:CompFreq (a, b) " {{{
    return a:a['f'] < a:b['f']
endfunction " }}}
function! ime_phonetic#_QueryOneWord (table, code_list) " {{{
    let l:result = []
    for l:key in ime_phonetic#_GetAllKeyStartsWith(a:table, a:code_list[0])
        call extend(l:result,
                \ type(a:table[(l:key)]) == type({}) ?
                \ get(a:table[(l:key)], '_', []) :
                \ a:table[(l:key)]
                \ )
    endfor
    return map(sort(copy(l:result), "<SID>CompFreq"), 'v:val[''w''] . phonetic_utils#CodeList2SymbolStr(a:code_list[1:])')
endfunction " }}}


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
    return [
        \ l:symbol_str,
        \ ] + ime_phonetic#_QueryOneWord(s:table, l:code_list)
    endif

    let l:partial_result = ime_phonetic#_GetBestWord(s:table, l:code_list, 1)

    return [
        \ l:symbol_str,
        \ ime_phonetic#_FindBestSentence(s:table, l:code_list),
        \ l:partial_result['word'] . phonetic_utils#CodeList2SymbolStr(l:partial_result['remain']),
        \ ] + ime_phonetic#_QueryOneWord(s:table, l:code_list)
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
