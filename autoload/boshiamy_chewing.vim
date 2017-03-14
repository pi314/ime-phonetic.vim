let s:table = {}


function! s:Handler (matchobj, trigger)
    if s:table == {}
        let s:table = chewing_table#table()
    endif

    call boshiamy#log('ext-chewing', a:matchobj)
    if a:trigger == '<space>'
        return get(s:table, a:matchobj[0], [])
    else
        return get(s:table, a:matchobj[0] . a:trigger, [])
    endif
endfunction


function! boshiamy_chewing#info ()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Chewing mode',
    \ 'pattern':  '\v(%(\w|\d|[/;,.-])*)$',
    \ 'handler': function('s:Handler'),
    \ 'trigger': ['3', '4', '6', '7', '<space>'],
    \ }
endfunction
