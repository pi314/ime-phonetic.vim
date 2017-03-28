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

let s:symbols = 'ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦˇˋˊ˙'
let s:codes = '1qaz2wsxedcrfv5tgbyhnujm8ik,9ol.0p;/-3467'

let s:symbol_set = split(s:symbols, '\zs')
let s:code_set = split(s:codes, '\zs')
let s:symbol_code_map = {}


function! s:log(msg)
    call ime#log('phonetic', a:msg)
endfunction


function! phonetic_utils#symbols ()
    return s:symbols
endfunction


function! phonetic_utils#code_set ()
    return s:code_set
endfunction


function! phonetic_utils#SymbolStr2CodeList (symbol_str) " {{{
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
endfunction " }}}
function! Test_Symbol2Code () " {{{
    call s:log('[Test] phonetic_utils#SymbolStr2CodeList()')
    call s:Init()
    call assert_equal(s:phonetic_utils#SymbolStr2CodeList('ㄘㄜˋ'), ['hk4'], 1)
    call assert_equal(s:phonetic_utils#SymbolStr2CodeList('ㄘㄜˋㄕˋ'), ['hk4', 'g4'], 2)
    call assert_equal(s:phonetic_utils#SymbolStr2CodeList('ㄕㄘㄜˋ'), ['g', 'hk4'], 3)
    call assert_equal(s:phonetic_utils#SymbolStr2CodeList('ㄕㄘˋㄜ'), ['g', 'hk4'], 4)
    call assert_equal(s:phonetic_utils#SymbolStr2CodeList('ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ'), ['hk4', 'g4', '5j/ ', 'jp6'], 5)
    call assert_equal(s:phonetic_utils#SymbolStr2CodeList('ㄉㄨ'), ['2j'], 6)
    call assert_equal(s:phonetic_utils#SymbolStr2CodeList('ㄨㄉ'), ['j', '2'], 7)
    call s:log('[Test] phonetic_utils#SymbolStr2CodeList() ends')
endfunction " }}}


function! phonetic_utils#key_to_code (key)
    return s:symbol_code_map[(a:key)]
endfunction


function! phonetic_utils#CodeList2SymbolStr (code_list)
    return join(map(split(join(a:code_list, ''), '\zs'), 's:symbol_code_map[v:val]'), '')
endfunction
function! Test_CodeList2SymbolStr () " {{{
    call s:log('[Test] phonetic_utils#CodeList2SymbolStr()')
    call s:Init()
    call assert_equal(phonetic_utils#CodeList2SymbolStr([]), '', 1)
    call assert_equal(phonetic_utils#CodeList2SymbolStr(['hk4']), 'ㄘㄜˋ', 1)
    call assert_equal(phonetic_utils#CodeList2SymbolStr(['hk4', 'g4']), 'ㄘㄜˋㄕˋ', 2)
    call assert_equal(phonetic_utils#CodeList2SymbolStr(['g ', 'hk4']), 'ㄕ ㄘㄜˋ', 3)
    call assert_equal(phonetic_utils#CodeList2SymbolStr(['hk4', 'g4', '5j/ ', 'jp6']), 'ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ', 4)
    call s:log('[Test] phonetic_utils#CodeList2SymbolStr() ends')
endfunction " }}}


function! s:Init ()
    for l:idx in range(len(s:symbol_set))
        let s:symbol_code_map[s:symbol_set[l:idx]] = s:code_set[l:idx]
        let s:symbol_code_map[s:code_set[l:idx]] = s:symbol_set[l:idx]
    endfor
    let s:symbol_code_map[' '] = ' '
endfunction

call s:Init()
