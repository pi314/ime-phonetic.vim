let s:punctuation_state = 0


function! ime_phonetic#handler (matchobj, trigger)
    if s:punctuation_state
        let s:punctuation_state = 0
        call ime#icon('phonetic', '[注]')
        return [get({
        \ ',': '，',
        \ '.': '。',
        \ ':': '：',
        \ }, a:trigger, '')]
    endif

    return ime_phonetic_core#handler(a:matchobj, a:trigger)
endfunction


function ime_phonetic#submode (switch)
    if a:switch == '' || s:punctuation_state == 1
        let s:punctuation_state = 0
        call ime#icon('phonetic', '[注]')
    elseif s:punctuation_state == 0
        let s:punctuation_state = 1
        call ime#icon('phonetic', '[，]')
    endif
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
