let s:table = {}

function! s:log (...)
    call call(function('ime#log'), ['phonetic'] + a:000)
endfunction


let s:abort = 'ime_phonetic_abort'


function! ime_phonetic#_GetAllKeyStartsWith (table, key) " {{{
    " Return all keys in a:table that starts with a:key
    " for fuzzy input
    return filter(keys(a:table), 'strpart(v:val, 0, strlen(a:key)) == a:key')
endfunction " }}}


function! ime_phonetic#_SearchWord (table, code_list) " {{{
    let l:probes_hist = [[a:table]]         " stack
    let l:leaves_hist = [[]]                " stack
    let l:code_list = copy(a:code_list)
    while len(l:code_list) > 0
        if getchar(1)
            throw s:abort
        endif

        let l:next_probes = []
        let l:next_leaves = []
        let l:code = l:code_list[0]
        let l:probes = l:probes_hist[0]
        for l:probe in l:probes
            for l:key in ime_phonetic#_GetAllKeyStartsWith(l:probe, l:code)
                if getchar(1)
                    throw s:abort
                endif

                " The table is sqeezed, so the leaves have to be stored
                " separately
                if type(l:probe[(l:key)]) == type({})
                    call add(l:next_probes, l:probe[(l:key)])
                else
                    call add(l:next_leaves, l:probe[(l:key)])
                endif
            endfor
        endfor
        call insert(l:probes_hist, l:next_probes, 0)
        call insert(l:leaves_hist, l:next_leaves, 0)
        call remove(l:code_list, 0)
    endwhile
    return [l:probes_hist, l:leaves_hist]
endfunction " }}}


function! ime_phonetic#_GetBestWord (table, code_list) " {{{
    " This function collects all words match a:code_list
    " and returns the one has maximum frequency
    "
    " This function returns an empty result when no such word in database

    let [l:probes_hist, l:leaves_hist] =
                \ ime_phonetic#_SearchWord(a:table, a:code_list)
    let l:best = {'w': '', 'f': -1}
    " Find the word that has maximum frequency
    for l:leaf in l:leaves_hist[0] + map(l:probes_hist[0], 'get(v:val, ''_'', [])')
        for l:record in l:leaf
            if getchar(1)
                throw s:abort
            endif

            if l:record['f'] > l:best['f']
                let l:best = l:record
            endif
        endfor
    endfor

    " Prevent further computation polluting the table
    return copy(l:best)
endfunction " }}}


function! ime_phonetic#_GetFirstBestWord (table, code_list) " {{{
    " This function collects all words match a:code_list
    " and returns the one has maximum frequency
    "
    " This function returns the longest result

    let [l:probes_hist, l:leaves_hist] =
                \ ime_phonetic#_SearchWord(a:table, a:code_list)

    while len(l:probes_hist[0]) == 0 && len(l:leaves_hist[0]) == 0
        if getchar(1)
            throw s:abort
        endif

        call remove(l:probes_hist, 0)
        call remove(l:leaves_hist, 0)
    endwhile

    let l:best = {'w': '', 'f': -1}
    " Find the word that has maximum frequency
    for l:leaf in l:leaves_hist[0] + map(l:probes_hist[0], 'get(v:val, ''_'', [])')
        for l:record in l:leaf
            if getchar(1)
                throw s:abort
            endif

            if l:record['f'] > l:best['f']
                let l:best = l:record
            endif
        endfor
    endfor

    " Prevent further computation polluting the table
    return {
        \ 'word': l:best['w'],
        \ 'remain': a:code_list[(len(l:probes_hist) - 1):],
        \ }
endfunction " }}}


function! ime_phonetic#_FindBestSentence (table, code_list) " {{{
    " This function searches optimal sentences of a:code_list from s:table
    " with dynamic programming

    let l:len = len(a:code_list)
    if l:len == 0
        return ''
    endif

    " l:dp_val[a][b] stores the best solution of code_list[a:b]
    let l:dp_val = map(
                \ range(l:len),
                \ 'map(range(l:len), ''{"v": -1, "w": "", "p": 0}'')')
    for l:i in range(l:len - 1, 0, -1)
        for l:j in range(l:i, l:len - 1)
            let l:local_best = ime_phonetic#_GetBestWord(a:table, a:code_list[(l:i):(l:j)])
            if l:local_best['f'] > 0
                let l:local_best['p'] = (l:j - l:i + 1) * (l:j - l:i + 1)
            else
                let l:local_best['p'] = 0
            endif
            for l:middle in range(l:i, l:j - 1)
                if getchar(1)
                    throw s:abort
                endif
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
    if a:code_list == []
        return []
    endif

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
    if s:table == {}
        let s:table = phonetic_table#table()
    endif

    let l:symbol_str = a:matchobj[0]

    " The single quote key only triggers the handler,
    " not insert any chars
    if a:trigger != ''''
        let l:symbol_str .= phonetic_utils#key_to_code(a:trigger)
    endif

    " No phonetic symbol given, just return it back
    if match(l:symbol_str, '\v^ *$') != -1
        return [l:symbol_str]
    endif

    try
        let l:code_list = phonetic_utils#SymbolStr2CodeList(l:symbol_str)

        " Special case for single character
        if a:trigger == ''''
            return [l:symbol_str] + ime_phonetic#_QueryOneWord(s:table, l:code_list)
        endif

        let l:best_sentence = ime_phonetic#_FindBestSentence(s:table, l:code_list)
        let l:first_word = ime_phonetic#_GetFirstBestWord(s:table, l:code_list)
        return [
            \ l:symbol_str,
            \ l:best_sentence,
            \ l:first_word['word'] . phonetic_utils#CodeList2SymbolStr(l:first_word['remain']),
            \ ] + ime_phonetic#_QueryOneWord(s:table, l:code_list)
    catch /^ime_phonetic_abort$/
        return [l:symbol_str]
    endtry
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
