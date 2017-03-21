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
    for l:code in l:code_list
        let l:pos = s:code_pos[l:code]
        if l:acc[l:pos] != ''
            call add(l:rtrn, join(l:acc, ''))
            let l:acc = ['', '', '', '']
        endif
        let l:acc[l:pos] = l:code
    endfor
    call add(l:rtrn, join(l:acc, ''))
    return l:rtrn
endfunction
function! Test_Symbol2Code () " {{{
    call s:log('[Test] SymbolStr2Code()')
    call s:Init()
    call AssertEqual(s:SymbolStr2Code('ㄘㄜˋ'), ['hk4'], 1)
    call AssertEqual(s:SymbolStr2Code('ㄘㄜˋㄕˋ'), ['hk4', 'g4'], 2)
    call AssertEqual(s:SymbolStr2Code('ㄕㄘㄜˋ'), ['g', 'hk4'], 3)
    call AssertEqual(s:SymbolStr2Code('ㄕㄘˋㄜ'), ['g', 'hk4'], 4)
    call AssertEqual(s:SymbolStr2Code('ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ'), ['hk4', 'g4', '5j/ ', 'jp6'], 5)
    call s:log('[Test] SymbolStr2Code() ends')
endfunction " }}}


function! s:CodeList2SymbolStr (code_list)
    return join(map(split(join(a:code_list, ''), '\zs'), 's:symbol_code_map[v:val]'), '')
endfunction
function! Test_CodeList2SymbolStr () " {{{
    call s:log('[Test] CodeList2SymbolStr()')
    call s:Init()
    call AssertEqual(s:CodeList2SymbolStr([]), '', 1)
    call AssertEqual(s:CodeList2SymbolStr(['hk4']), 'ㄘㄜˋ', 1)
    call AssertEqual(s:CodeList2SymbolStr(['hk4', 'g4']), 'ㄘㄜˋㄕˋ', 2)
    call AssertEqual(s:CodeList2SymbolStr(['g ', 'hk4']), 'ㄕ ㄘㄜˋ', 3)
    call AssertEqual(s:CodeList2SymbolStr(['hk4', 'g4', '5j/ ', 'jp6']), 'ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ', 4)
    call s:log('[Test] CodeList2SymbolStr() ends')
endfunction " }}}


function! ime_phonetic#handler (matchobj, trigger)
    if s:table == {}
        let s:table = phonetic_table#table()
    endif

    let l:symbol_str = a:matchobj[0] . s:symbol_code_map[a:trigger]
    if l:symbol_str == ' '
        return []
    endif

    let l:code_list = s:SymbolStr2Code(l:symbol_str)
    let l:probe = s:table
    while l:code_list != []
        let l:code = l:code_list[0]
        call remove(l:code_list, 0)

        if !has_key(l:probe, l:code)
            return [(l:symbol_str)]
        endif

        if type(l:probe[l:code]) == type({})
            let l:probe = l:probe[l:code]
        else
            return [(l:symbol_str)] + map(copy(l:probe[l:code]), 'v:val . s:CodeList2SymbolStr(l:code_list)')
        endif
    endwhile

    if has_key(l:probe, ' ')
        return [(l:symbol_str)] + l:probe[' ']
    endif
    return [(l:symbol_str)]
endfunction


function! ime_phonetic#info ()
    call s:Init()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Phonetic input mode',
    \ 'pattern':  '\v%(|['. s:symbols .']['. s:symbols .' ]*)$',
    \ 'handler': function('ime_phonetic#handler'),
    \ 'trigger': split(s:codes, '\zs') + ['<space>'],
    \ }
endfunction
