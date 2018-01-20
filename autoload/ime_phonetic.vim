function! ime_phonetic#handler (matchobj, trigger)
    return ime_phonetic_core#handler(a:matchobj, a:trigger)
endfunction


function ime_phonetic#submode (switch)
    call ime_phonetic_core#submode (a:switch)
endfunction


function! ime_phonetic#info ()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Phonetic input mode',
    \ 'pattern':  '\v%(|:|['. phonetic_utils#symbols() .']['. phonetic_utils#symbols() .' ]*)$',
    \ 'handler': function('ime_phonetic#handler'),
    \ 'trigger': phonetic_utils#code_set() + [' ', '''', ':'],
    \ 'submode':function('ime_phonetic#submode'),
    \ }
endfunction


if !exists('g:ime_phonetic_cache_size') ||
            \ type(g:ime_phonetic_cache_size) != type(0)
    let g:ime_phonetic_cache_size = 1000
endif
