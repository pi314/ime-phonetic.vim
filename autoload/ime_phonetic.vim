let s:table = {}


function! s:Handler (matchobj, trigger)
    if s:table == {}
        let s:table = phonetic_table#table()
    endif

    return s:table[a:trigger]

    call ime#log('phonetic', a:matchobj)
    if a:trigger == '<space>'
        return get(s:table, a:matchobj[0], [])
    else
        return get(s:table, a:matchobj[0] . a:trigger, [])
    endif
endfunction


function! ime_phonetic#info ()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Phonetic input mode',
    \ 'pattern':  '\v(%(\w|\d|[/;,.-])*)$',
    \ 'handler': function('s:Handler'),
    \ 'trigger': split('1234567890abcdefghijklmnopqrstuvwxyz-;,./', '\zs'),
    \ }
endfunction
