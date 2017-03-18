let s:table = {}

let s:symbols = 'ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦˇˋˊ˙'
let s:sounds = '1qaz2wsxedcrfv5tgbyhnujm8ik,9ol.0p;/-3467'

let s:symbol_set = split(s:symbols, '\zs')
let s:sound_set = split(s:sounds, '\zs')
let s:symbol_sound_map = {}


function! s:Init ()
    for l:idx in range(len(s:symbol_set))
        let s:symbol_sound_map[s:symbol_set[l:idx]] = s:sound_set[l:idx]
        let s:symbol_sound_map[s:sound_set[l:idx]] = s:symbol_set[l:idx]
    endfor
    let s:symbol_sound_map['<space>'] = ' '
    let s:symbol_sound_map[' '] = ' '
endfunction


function! s:Symbol2Sound (symbol)
    let l:ret = ''
    for l:char in split(a:symbol, '\zs')
        let l:ret .= s:symbol_sound_map[l:char]
    endfor
    return l:ret
endfunction


function! s:Handler (matchobj, trigger)
    if s:table == {}
        let s:table = phonetic_table#table()
    endif

    let l:symbol_str = a:matchobj[0] . s:symbol_sound_map[a:trigger]
    if l:symbol_str == ' '
        return []
    endif
    return [l:symbol_str] + get(s:table, s:Symbol2Sound(l:symbol_str), [])
endfunction


function! ime_phonetic#info ()
    call s:Init()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Phonetic input mode',
    \ 'pattern':  '\v(|['. s:symbols .']['. s:symbols .' ]*)$',
    \ 'handler': function('s:Handler'),
    \ 'trigger': split(s:sounds, '\zs') + ['<space>'],
    \ }
endfunction
