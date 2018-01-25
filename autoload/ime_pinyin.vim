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

    let l:pinyin_str = a:matchobj[0]

    " The single quote key only triggers the handler,
    " not insert any chars
    if a:trigger != ''''
        let l:pinyin_str .= a:trigger
    endif

    " No phonetic symbol given, just return it back
    if match(l:pinyin_str, '\v^ *$') != -1
        return [l:pinyin_str]
    endif

    let l:res = pinyin_utils#ParsePinyinStr(l:pinyin_str)
    let l:pinyin_list = l:res['pinyin']
    let l:code_list = l:res['code']
    let l:res = ime_phonetic_core#handler(l:code_list, a:trigger == '''')
    let l:pll = len(l:pinyin_list)
    return [join(l:pinyin_list, ' ')] + map(l:res,
                \ '{' .
                \ '"word": v:val[0] . join(l:pinyin_list[(l:pll - len(v:val[1])):], " "),' .
                \ '"abbr": v:val[0]' .
                \ '}')
endfunction


function! s:join_pinyin_list (pinyin_list)
    return join(a:pinyin_list, ' ')
endfunction


function! ime_pinyin#submode (switch)
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
    \ 'description': 'Pinyin input mode',
    \ 'pattern':  '\v%([a-zA-Z ]*)$',
    \ 'handler': function('ime_pinyin#handler'),
    \ 'trigger': split('abcdefghijklmnopqrstuvwxyz', '\zs'),
    \ 'submode':function('ime_pinyin#submode'),
    \ }
endfunction
