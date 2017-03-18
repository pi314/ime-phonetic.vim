let s:table = {}
let s:symbols = split('ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦˇˋˊ˙', '\zs')
let s:sounds = split('1qaz2wsxedcrfv5tgbyhnujm8ik,9ol.0p;/-3467', '\zs')
let s:symbol_sound_map = {}


function! s:Init ()
    for l:idx in range(len(s:symbols))
        let s:symbol_sound_map[s:symbols[l:idx]] = s:sounds[l:idx]
        let s:symbol_sound_map[s:sounds[l:idx]] = s:symbols[l:idx]
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
    return [l:symbol_str]
endfunction


function! ime_phonetic#info ()
    call s:Init()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Phonetic input mode',
    \ 'pattern':  '\v(|[^ ][ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦˇˋˊ˙ ]*)$',
    \ 'handler': function('s:Handler'),
    \ 'trigger': split('1234567890abcdefghijklmnopqrstuvwxyz-;,./', '\zs') + ['<space>'],
    \ }
endfunction
