let s:table = {}

let s:symbols = 'ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦˇˋˊ˙'
let s:codes = '1qaz2wsxedcrfv5tgbyhnujm8ik,9ol.0p;/-3467'

let s:symbol_set = split(s:symbols, '\zs')
let s:code_set = split(s:codes, '\zs')
let s:symbol_code_map = {}

let s:code_pos = {} " {{{
let s:code_pos['1'] = 0
let s:code_pos['q'] = 0
let s:code_pos['a'] = 0
let s:code_pos['z'] = 0
let s:code_pos['2'] = 0
let s:code_pos['w'] = 0
let s:code_pos['s'] = 0
let s:code_pos['x'] = 0
let s:code_pos['e'] = 0
let s:code_pos['d'] = 0
let s:code_pos['c'] = 0
let s:code_pos['r'] = 0
let s:code_pos['f'] = 0
let s:code_pos['v'] = 0
let s:code_pos['5'] = 0
let s:code_pos['t'] = 0
let s:code_pos['g'] = 0
let s:code_pos['b'] = 0
let s:code_pos['y'] = 0
let s:code_pos['h'] = 0
let s:code_pos['n'] = 0
let s:code_pos['u'] = 1
let s:code_pos['j'] = 1
let s:code_pos['m'] = 1
let s:code_pos['8'] = 2
let s:code_pos['i'] = 2
let s:code_pos['k'] = 2
let s:code_pos[','] = 2
let s:code_pos['9'] = 2
let s:code_pos['o'] = 2
let s:code_pos['l'] = 2
let s:code_pos['.'] = 2
let s:code_pos['0'] = 2
let s:code_pos['p'] = 2
let s:code_pos[';'] = 2
let s:code_pos['/'] = 2
let s:code_pos['-'] = 2
let s:code_pos['3'] = 3
let s:code_pos['4'] = 3
let s:code_pos['6'] = 3
let s:code_pos['7'] = 3
let s:code_pos[' '] = 3" }}}

function! s:log(msg)
    call ime#log('phonetic', a:msg)
endfunction


function! s:Init ()
    for l:idx in range(len(s:symbol_set))
        let s:symbol_code_map[s:symbol_set[l:idx]] = s:code_set[l:idx]
        let s:symbol_code_map[s:code_set[l:idx]] = s:symbol_set[l:idx]
    endfor
    let s:symbol_code_map['<space>'] = ' '
    let s:symbol_code_map[' '] = ' '
endfunction


function! s:SymbolStr2Code (symbol_str)
    let l:code_list = map(split(a:symbol_str, '\zs'), 's:symbol_code_map[v:val]')
    let l:rtrn = []
    let l:acc = ['', '', '', '']
    let l:water_level = -1
    for l:code in l:code_list
        let l:pos = s:code_pos[l:code]
        if l:pos <= l:water_level
            call add(l:rtrn, join(l:acc, ''))
            let l:acc = ['', '', '', '']
            let l:water_level = -1
        endif
        let l:acc[l:pos] = l:code
        let l:water_level = l:pos
    endfor
    call add(l:rtrn, join(l:acc, ''))
    return l:rtrn
endfunction
function! Test_Symbol2Code () " {{{
    call s:log('[Test] SymbolStr2Code()')
    call s:Init()
    call assert_equal(s:SymbolStr2Code('ㄘㄜˋ'), ['hk4'], 1)
    call assert_equal(s:SymbolStr2Code('ㄘㄜˋㄕˋ'), ['hk4', 'g4'], 2)
    call assert_equal(s:SymbolStr2Code('ㄕㄘㄜˋ'), ['g', 'hk4'], 3)
    call assert_equal(s:SymbolStr2Code('ㄕㄘˋㄜ'), ['g', 'hk4'], 4)
    call assert_equal(s:SymbolStr2Code('ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ'), ['hk4', 'g4', '5j/ ', 'jp6'], 5)
    call assert_equal(s:SymbolStr2Code('ㄉㄨ'), ['2j'], 6)
    call assert_equal(s:SymbolStr2Code('ㄨㄉ'), ['j', '2'], 7)
    call s:log('[Test] SymbolStr2Code() ends')
endfunction " }}}


function! s:CodeList2SymbolStr (code_list)
    return join(map(split(join(a:code_list, ''), '\zs'), 's:symbol_code_map[v:val]'), '')
endfunction
function! Test_CodeList2SymbolStr () " {{{
    call s:log('[Test] CodeList2SymbolStr()')
    call s:Init()
    call assert_equal(s:CodeList2SymbolStr([]), '', 1)
    call assert_equal(s:CodeList2SymbolStr(['hk4']), 'ㄘㄜˋ', 1)
    call assert_equal(s:CodeList2SymbolStr(['hk4', 'g4']), 'ㄘㄜˋㄕˋ', 2)
    call assert_equal(s:CodeList2SymbolStr(['g ', 'hk4']), 'ㄕ ㄘㄜˋ', 3)
    call assert_equal(s:CodeList2SymbolStr(['hk4', 'g4', '5j/ ', 'jp6']), 'ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ', 4)
    call s:log('[Test] CodeList2SymbolStr() ends')
endfunction " }}}


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


function! s:CollectResults (match_leaves, fuzzy_leaves, probes) " {{{
    let l:result = []
    for l:leaf in a:match_leaves
        let l:result += l:leaf
    endfor
    for l:leaf in a:fuzzy_leaves
        let l:result += l:leaf
    endfor
    for l:probe in a:probes
        if has_key(l:probe, '_')
            let l:result += l:probe['_']
        endif
    endfor
    return l:result
endfunction " }}}


function! ime_phonetic#handler (matchobj, trigger)
    if s:table == {}
        let s:table = phonetic_table#table()
    endif

    let l:symbol_str = a:matchobj[0]

    " The single quote key only triggers the handler,
    " not insert any chars
    if a:trigger != ''''
        let l:symbol_str .= s:symbol_code_map[a:trigger]
    endif

    " No phonetic symbol given, return []
    if l:symbol_str == ' '
        return []
    endif

    let l:code_list = s:SymbolStr2Code(l:symbol_str)

    " Special case for single character: no speed input
    if len(l:code_list) == 1
        return [(l:symbol_str)] + s:QuerySingleChar(l:code_list[0])
    endif

    let l:probes = [s:table]    " fuzzy BFS search range
    let l:last_leaves = []      " fallback results
    let l:fuzzy_leaves = []     " results that matches prefix
    let l:match_leaves = []     " results that prefectly match
    for l:idx in range(len(l:code_list))
        let l:code = l:code_list[(l:idx)]
        let l:tmp_probes = []

        " Keep last results for fallback match
        let l:last_leaves = l:match_leaves + l:fuzzy_leaves

        let l:fuzzy_leaves = []
        let l:match_leaves = []

        " Do BFS
        for l:probe in l:probes
            " Iterate over all prefix-matched keys
            for l:key in s:GetAllKeysInTableWithPrefix(l:probe, l:code)
                if type(l:probe[(l:key)]) == type([])
                    " Found a subtree that has no subtree
                    if l:key == l:code
                        let l:slot = l:match_leaves
                    else
                        let l:slot = l:fuzzy_leaves
                    endif
                else
                    " Found a subtree
                    let l:slot = l:tmp_probes
                endif
                call add(l:slot, l:probe[(l:key)])
            endfor
        endfor

        " Suddenly no result, use fallback result
        if len(l:tmp_probes) + len(l:match_leaves) + len(l:fuzzy_leaves) == 0
            let l:result = s:CollectResults(l:last_leaves, [], l:probes)
            let l:remain_code_str = s:CodeList2SymbolStr(l:code_list[(l:idx):])
            return [(l:symbol_str)] + map(l:result, 'v:val . l:remain_code_str')
        endif
        let l:probes = l:tmp_probes
    endfor

    let l:result = s:CollectResults(l:match_leaves, l:fuzzy_leaves, l:probes)
    if len(l:result) == 1 && len(l:match_leaves) == 1
        " Only one possibility, put it first
        return l:result + [(l:symbol_str)]
    else
        return [(l:symbol_str)] + l:result
    endif
endfunction


function! ime_phonetic#info ()
    call s:Init()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Phonetic input mode',
    \ 'pattern':  '\v%(|['. s:symbols .']['. s:symbols .' ]*)$',
    \ 'handler': function('ime_phonetic#handler'),
    \ 'trigger': split(s:codes, '\zs') + ['<space>', ''''],
    \ }
endfunction
