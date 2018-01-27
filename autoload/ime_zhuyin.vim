let s:punctuation_state = 0


function! s:log (...)
    call call(function('ime#log'), ['zhuyin'] + a:000)
endfunction


function! ime_zhuyin#handler (matchobj, trigger)
    if s:punctuation_state
        let s:punctuation_state = 0
        call ime#icon('zhuyin', '[注]')
        return [get({
        \ ',': '，',
        \ '.': '。',
        \ ':': '：',
        \ }, a:trigger, '')]
    endif

    let l:zhuyin_str = a:matchobj[0]

    " The single quote key only triggers the handler,
    " not insert any chars
    if a:trigger != ''''
        let l:zhuyin_str .= zhuyin_utils#key_to_code(a:trigger)
    endif

    " No phonetic symbol given, just return it back
    if match(l:zhuyin_str, '\v^ *$') != -1
        return [l:zhuyin_str]
    endif

    let l:res = zhuyin_utils#ParseZhuyinStr(l:zhuyin_str)
    let l:zhuyin_list = l:res['zhuyin']
    let l:code_list = l:res['code']
    let l:res = ime_phonetic_core#handler(l:code_list, a:trigger == '''')
    let l:zll = len(l:zhuyin_list)
    return [join(l:zhuyin_list, '')] + map(l:res,
                \ '{' .
                \ '"word": v:val[0] . join(l:zhuyin_list[(l:zll - len(v:val[1])):], ""),' .
                \ '"abbr": v:val[0]' .
                \ '}')
endfunction


function ime_zhuyin#submode (switch)
    if a:switch == '' || s:punctuation_state == 1
        let s:punctuation_state = 0
        call ime#icon('phonetic', '[注]')
    elseif s:punctuation_state == 0
        let s:punctuation_state = 1
        call ime#icon('phonetic', '[，]')
    endif
endfunction


function! ime_zhuyin#info ()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Zhuyin input mode',
    \ 'pattern':  '\v%(|:|['. zhuyin_utils#symbols() .']['. zhuyin_utils#symbols() .' ]*)$',
    \ 'handler': function('ime_zhuyin#handler'),
    \ 'trigger': zhuyin_utils#code_set() + [' ', '''', ':'],
    \ 'submode':function('ime_zhuyin#submode'),
    \ }
endfunction
