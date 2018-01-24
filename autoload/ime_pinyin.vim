let s:punctuation_state = 0


function! s:log (...)
    call call(function('ime#log'), ['phonetic'] + a:000)
endfunction


function! ime_pinyin#handler (matchobj, trigger)
    if s:punctuation_state
        let s:punctuation_state = 0
        call ime#icon('phonetic', '[拼]')
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
        let l:symbol_str .= zhuyin_utils#key_to_code(a:trigger)
    endif

    " No phonetic symbol given, just return it back
    if match(l:symbol_str, '\v^ *$') != -1
        return [l:symbol_str]
    endif

    let l:code_list = zhuyin_utils#ZhuyinStr2CodeList(l:symbol_str)
    let l:res = ime_phonetic_core#handler(l:code_list, a:trigger == '''')
    return [l:symbol_str] + map(l:res, 'v:val[0] . zhuyin_utils#CodeList2ZhuyinStr(v:val[1])')
endfunction


function ime_pinyin#submode (switch)
    if a:switch == '' || s:punctuation_state == 1
        let s:punctuation_state = 0
        call ime#icon('phonetic', '[拼]')
    elseif s:punctuation_state == 0
        let s:punctuation_state = 1
        call ime#icon('phonetic', '[，]')
    endif
endfunction


function! ime_pinyin#info ()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[拼]',
    \ 'description': 'Phonetic input mode',
    \ 'pattern':  '\v%([a-zA-Z ]*)$',
    \ 'handler': function('ime_pinyin#handler'),
    \ 'trigger': zhuyin_utils#code_set() + [' ', '''', ':'],
    \ 'submode':function('ime_pinyin#submode'),
    \ }
endfunction
