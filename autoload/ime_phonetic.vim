let s:table = {}

let s:symbols = 'ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦˇˋˊ˙'
let s:codes = '1qaz2wsxedcrfv5tgbyhnujm8ik,9ol.0p;/-3467'

let s:symbol_set = split(s:symbols, '\zs')
let s:code_set = split(s:codes, '\zs')
let s:symbol_code_map = {}


function! s:Init ()
    for l:idx in range(len(s:symbol_set))
        let s:symbol_code_map[s:symbol_set[l:idx]] = s:code_set[l:idx]
        let s:symbol_code_map[s:code_set[l:idx]] = s:symbol_set[l:idx]
    endfor
    let s:symbol_code_map['<space>'] = ' '
    let s:symbol_code_map[' '] = ' '
endfunction


function! s:Symbol2Code (symbol)
    let l:ret = ''
    for l:char in split(a:symbol, '\zs')
        let l:ret .= s:symbol_code_map[l:char]
    endfor
    return l:ret
endfunction


function! s:Handler (matchobj, trigger)
    if s:table == {}
        let s:table = phonetic_table#table()
    endif

    call ime#log('phonetic', a:matchobj)
    let l:symbol_str = a:matchobj[0] . s:symbol_code_map[a:trigger]
    call ime#log('phonetic', l:symbol_str)
    if l:symbol_str == ' '
        return []
    endif
    let l:result = get(s:table, s:Symbol2Code(l:symbol_str), [])
    return [l:symbol_str] + get(l:result, '', [])
endfunction


function! ime_phonetic#info ()
    call s:Init()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Phonetic input mode',
    \ 'pattern':  '\v(|['. s:symbols .']['. s:symbols .' ]*)$',
    \ 'handler': function('s:Handler'),
    \ 'trigger': split(s:codes, '\zs') + ['<space>'],
    \ }
endfunction
