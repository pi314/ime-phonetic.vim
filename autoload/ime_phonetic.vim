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

    let l:symbol_str = a:matchobj[0]

    " The single quote key only triggers the handler,
    " not insert any chars
    if a:trigger != ''''
        let l:symbol_str .= phonetic_utils#key_to_code(a:trigger)
    endif

    " No phonetic symbol given, just return it back
    if match(l:symbol_str, '\v^ *$') != -1
        return [l:symbol_str]
    endif

    let l:code_list = phonetic_utils#SymbolStr2CodeList(l:symbol_str)
    return [l:symbol_str] + ime_phonetic_core#handler(l:code_list, a:trigger == '''')
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
