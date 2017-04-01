let s:table = {}

function! s:log (...)
    call call(function('ime#log'), ['phonetic'] + a:000)
endfunction


function! s:QuerySingleChar (code) " {{{
    if has_key(s:table, a:code)
        let l:tb = s:table[(a:code)]
        return (type(l:tb) == type([])) ? (l:tb) : (l:tb['_'])
    endif
    return []
endfunction " }}}


function! s:GetAllKeysInTableWithPrefix (tb, prefix)
    return filter(keys(a:tb), 'strpart(v:val, 0, strlen(a:prefix)) == a:prefix')
endfunction


function! s:BFS_WithCode(code, probe, m_probes, f_probes, m_leaves, f_leaves) " {{{
    " Iterate over all prefix-matched keys
    for l:key in s:GetAllKeysInTableWithPrefix(a:probe, a:code)
        if type(a:probe[(l:key)]) == type({})
            " Found a subtree
            if l:key == a:code
                let l:slot = a:m_probes
            else
                let l:slot = a:f_probes
            endif
        else
            " Found a subtree that has no subtree
            if l:key == a:code
                let l:slot = a:m_leaves
            else
                let l:slot = a:f_leaves
            endif
        endif
        call add(l:slot, a:probe[(l:key)])
    endfor
endfunction " }}}


function! s:CollectResults (m_probes, f_probes, m_leaves, f_leaves) " {{{
    let l:result = []
    for l:tmp in map(copy(a:m_probes), 'get(v:val, ''_'', [])')
        call extend(l:result, l:tmp)
    endfor
    for l:tmp in a:m_leaves
        call extend(l:result, l:tmp)
    endfor
    for l:tmp in map(copy(a:f_probes), 'get(v:val, ''_'', [])')
        call extend(l:result, l:tmp)
    endfor
    for l:tmp in a:f_leaves
        call extend(l:result, l:tmp)
    endfor
    return l:result
endfunction " }}}


function! s:BuildResult (symbol_str, m_probes, f_probes, m_leaves, f_leaves, postfix) " {{{
    let l:result = s:CollectResults(a:m_probes, a:f_probes, a:m_leaves, a:f_leaves)
    let l:result = map(l:result, 'v:val . a:postfix')

    if len(l:result) == 1 && len(a:m_leaves) == 1
        " Only one possibility, put it first
        return l:result + [(a:symbol_str)]
    else
        return [(a:symbol_str)] + l:result
    endif
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
        let l:code = l:code_list[0]
        let l:m_probes = []  " match BFS search range
        let l:f_probes = []         " fuzzy BFS search range
        let l:m_leaves = []         " match results
        let l:f_leaves = []         " fuzzy results
        call s:BFS_WithCode(l:code, s:table,
                    \ l:m_probes, l:f_probes,
                    \ l:m_leaves, l:f_leaves)
        return s:BuildResult(l:symbol_str,
                    \ l:m_probes, l:f_probes, l:m_leaves, l:f_leaves,
                    \ phonetic_utils#CodeList2SymbolStr(l:code_list[1:]))
    endif

    let l:m_probes = [s:table]  " match BFS search range
    let l:f_probes = []         " fuzzy BFS search range
    let l:m_leaves = []         " match results
    let l:f_leaves = []         " fuzzy results

    let l:lm_probes = []    " fallback match BFS search range
    let l:lf_probes = []    " fallback fuzzy BFS search range
    let l:lm_leaves = []    " fallback match results
    let l:lf_leaves = []    " fallback fuzzy results

    for l:idx in range(len(l:code_list))
        let l:code = l:code_list[(l:idx)]
        let l:lm_probes = l:m_probes
        let l:lf_probes = l:f_probes
        let l:tmp_m_probes = []
        let l:tmp_f_probes = []

        " Keep last results for fallback match
        let l:lm_leaves = l:m_leaves
        let l:lf_leaves = l:f_leaves

        let l:f_leaves = []
        let l:m_leaves = []

        " Do BFS
        for l:probe in l:m_probes
            call s:BFS_WithCode(l:code, l:probe,
                        \ l:tmp_m_probes, l:tmp_f_probes,
                        \ l:m_leaves, l:f_leaves)
        endfor

        for l:probe in l:f_probes
            call s:BFS_WithCode(l:code, l:probe,
                        \ l:tmp_f_probes, l:tmp_f_probes,
                        \ l:f_leaves, l:f_leaves)
        endfor

        " Suddenly no result, use fallback result
        if (len(s:CollectResults(l:tmp_m_probes, l:tmp_f_probes, l:m_leaves, l:f_leaves)) == 0 &&
                    \ (len(l:tmp_f_probes) + len(l:tmp_m_probes)) == 0)
            " the length checking is for situation:
            " s:table[a][b] has no leaf (and '_'),
            " but s:table[a][b][c] is a leaf or has '_'
            return s:BuildResult(l:symbol_str,
                        \ l:lm_probes, l:lf_probes, l:lm_leaves, l:lf_leaves,
                        \ phonetic_utils#CodeList2SymbolStr(l:code_list[(l:idx):]))
        endif

        let l:m_probes = l:tmp_m_probes
        let l:f_probes = l:tmp_f_probes

        if a:trigger == ''''
            break
        endif
    endfor

    return s:BuildResult(l:symbol_str, l:m_probes, l:f_probes, l:m_leaves, l:f_leaves, '')
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
