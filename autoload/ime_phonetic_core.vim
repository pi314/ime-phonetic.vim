let s:table = {}
let s:max_length = 0

" s:cache[s] stores the best sentence of string s
let s:cache = {}
let s:cache_recent = []

let s:last_symbol_str = ''


function! s:log (...)
    call call(function('ime#log'), ['phonetic'] + a:000)
endfunction


let s:abort = 'ime_phonetic_abort'


function! ime_phonetic_core#_InjectTableForTesting (table, max_length) " {{{
    let s:table = a:table
    let s:max_length = a:max_length

    " cache invalidation
    let s:cache = {}
    let s:cache_recent = []
endfunction " }}}


function! ime_phonetic_core#_GetAllKeyStartsWith (table, key) " {{{
    " Return all keys in a:table that starts with a:key
    " for fuzzy input
    return filter(keys(a:table), 'strpart(v:val, 0, strlen(a:key)) == a:key')
endfunction " }}}


function! ime_phonetic_core#_SearchWord (code_list) " {{{
    let l:probes_hist = [[s:table]]         " stack
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
            for l:key in ime_phonetic_core#_GetAllKeyStartsWith(l:probe, l:code)
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


function! ime_phonetic_core#_GetBestWord (code_list) " {{{
    " This function collects all words match a:code_list
    " and returns the one has maximum frequency
    "
    " This function returns an empty result when no such word in database

    if len(a:code_list) > s:max_length
        return {'w': '', 'f': -1}
    endif

    let [l:probes_hist, l:leaves_hist] =
                \ ime_phonetic_core#_SearchWord(a:code_list)
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


function! ime_phonetic_core#_GetLongestMatchingWords (code_list) " {{{
    " This function returns all words match a:code_list
    " And if none, returns the longest matched results

    let [l:probes_hist, l:leaves_hist] =
                \ ime_phonetic_core#_SearchWord(a:code_list)

    while len(l:probes_hist[0]) == 0 && len(l:leaves_hist[0]) == 0
        if getchar(1)
            throw s:abort
        endif

        call remove(l:probes_hist, 0)
        call remove(l:leaves_hist, 0)
    endwhile

    let l:words = []
    for l:tmp in l:leaves_hist[0] + map(l:probes_hist[0], 'get(v:val, ''_'', [])')
        call extend(l:words, l:tmp)
    endfor

    return map(
        \ map(
            \ l:words,
            \ 'v:val[''w'']'
        \ ),
        \ '[v:val, a:code_list[(len(l:probes_hist) - 1):]]'
    \ )
endfunction " }}}


function! ime_phonetic_core#_FindBestSentence (code_list) " {{{
    " This function searches optimal sentences of a:code_list from s:table
    " with dynamic programming

    let l:len = len(a:code_list)
    if l:len == 0
        return ''
    endif

    for l:i in range(l:len - 1, 0, -1)
        for l:j in range(l:i, l:len - 1)
            let l:bar_joined_code = join(a:code_list[(l:i):(l:j)], '|')
            if has_key(s:cache, l:bar_joined_code)
                let l:tmp_idx = index(s:cache_recent, l:bar_joined_code)
                call remove(s:cache_recent, l:tmp_idx)
                call insert(s:cache_recent, l:bar_joined_code, 0)
                continue
            endif

            let l:local_best = ime_phonetic_core#_GetBestWord(a:code_list[(l:i):(l:j)])
            if l:local_best['f'] > 0
                let l:local_best['p'] = (l:j - l:i + 1) * (l:j - l:i + 1)
            else
                let l:local_best['p'] = 0
            endif
            for l:middle in range(l:i, l:j - 1)
                if getchar(1)
                    throw s:abort
                endif
                let l:left = get(s:cache, join(a:code_list[(l:i):(l:middle)], '|'), {'f': -1, 'w': '', 'p': 0})
                let l:right = get(s:cache, join(a:code_list[(l:middle + 1):(l:j)], '|'), {'f': -1, 'w': '', 'p': 0})
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
            let s:cache[(l:bar_joined_code)] = l:local_best
            call insert(s:cache_recent, l:bar_joined_code, 0)
        endfor
    endfor
    for l:code in s:cache_recent[(g:ime_phonetic_cache_size):]
        unlet s:cache[(l:code)]
    endfor
    let s:cache_recent = s:cache_recent[:(g:ime_phonetic_cache_size - 1)]
    return s:cache[join(a:code_list, '|')]['w']
endfunction " }}}


function! s:CompFreq (a, b) " {{{
    return a:a['f'] < a:b['f']
endfunction " }}}
function! ime_phonetic_core#_QueryOneChar (code_list) " {{{
    if a:code_list == []
        return []
    endif

    let l:result = []
    for l:key in ime_phonetic_core#_GetAllKeyStartsWith(s:table, a:code_list[0])
        call extend(l:result,
                \ type(s:table[(l:key)]) == type({}) ?
                \ get(s:table[(l:key)], '_', []) :
                \ s:table[(l:key)]
                \ )
    endfor
    return map(sort(copy(l:result), "<SID>CompFreq"), '[v:val[''w''], a:code_list[1:]]')
endfunction " }}}


function! ime_phonetic_core#handler (code_list, single_char)
    if s:table == {}
        let [s:table, s:max_length] = phonetic_table#table()
    endif

    try
        " Special case for single character
        if a:single_char && s:last_code_list != join(a:code_list, '|')
            let s:last_code_list = join(a:code_list, '|')
            return ime_phonetic_core#_QueryOneChar(a:code_list)
        endif

        let s:last_code_list = ''

        let l:best_sentence = ime_phonetic_core#_FindBestSentence(a:code_list)
        let l:words = ime_phonetic_core#_GetLongestMatchingWords(a:code_list)
        return [[l:best_sentence, []]] +
            \ l:words +
            \ ime_phonetic_core#_QueryOneChar(a:code_list)
    catch /^ime_phonetic_abort$/
        return []
    endtry
endfunction


if !exists('g:ime_phonetic_cache_size') ||
            \ type(g:ime_phonetic_cache_size) != type(0)
    let g:ime_phonetic_cache_size = 1000
endif
