function! s:log (...)
    call call(function('ime#log'), ['zhuyin'] + a:000)
endfunction


function! s:Init ()
    let s:zhuyin_comb = {} " {{{
    let s:zhuyin_comb['1u'] = 1
    let s:zhuyin_comb['1u,'] = 1
    let s:zhuyin_comb['1ul'] = 1
    let s:zhuyin_comb['1u0'] = 1
    let s:zhuyin_comb['1up'] = 1
    let s:zhuyin_comb['1u/'] = 1
    let s:zhuyin_comb['1j'] = 1
    let s:zhuyin_comb['18'] = 1
    let s:zhuyin_comb['1i'] = 1
    let s:zhuyin_comb['19'] = 1
    let s:zhuyin_comb['1o'] = 1
    let s:zhuyin_comb['1l'] = 1
    let s:zhuyin_comb['10'] = 1
    let s:zhuyin_comb['1p'] = 1
    let s:zhuyin_comb['1;'] = 1
    let s:zhuyin_comb['1/'] = 1
    let s:zhuyin_comb['qu'] = 1
    let s:zhuyin_comb['qu,'] = 1
    let s:zhuyin_comb['qul'] = 1
    let s:zhuyin_comb['qu0'] = 1
    let s:zhuyin_comb['qup'] = 1
    let s:zhuyin_comb['qu/'] = 1
    let s:zhuyin_comb['qj'] = 1
    let s:zhuyin_comb['q8'] = 1
    let s:zhuyin_comb['qi'] = 1
    let s:zhuyin_comb['q9'] = 1
    let s:zhuyin_comb['qo'] = 1
    let s:zhuyin_comb['ql'] = 1
    let s:zhuyin_comb['q.'] = 1
    let s:zhuyin_comb['q0'] = 1
    let s:zhuyin_comb['qp'] = 1
    let s:zhuyin_comb['q;'] = 1
    let s:zhuyin_comb['q/'] = 1
    let s:zhuyin_comb['au'] = 1
    let s:zhuyin_comb['au,'] = 1
    let s:zhuyin_comb['aul'] = 1
    let s:zhuyin_comb['au.'] = 1
    let s:zhuyin_comb['au0'] = 1
    let s:zhuyin_comb['aup'] = 1
    let s:zhuyin_comb['au/'] = 1
    let s:zhuyin_comb['aj'] = 1
    let s:zhuyin_comb['a8'] = 1
    let s:zhuyin_comb['ai'] = 1
    let s:zhuyin_comb['ak'] = 1
    let s:zhuyin_comb['a9'] = 1
    let s:zhuyin_comb['ao'] = 1
    let s:zhuyin_comb['al'] = 1
    let s:zhuyin_comb['a.'] = 1
    let s:zhuyin_comb['a0'] = 1
    let s:zhuyin_comb['ap'] = 1
    let s:zhuyin_comb['a;'] = 1
    let s:zhuyin_comb['a/'] = 1
    let s:zhuyin_comb['zj'] = 1
    let s:zhuyin_comb['z8'] = 1
    let s:zhuyin_comb['zi'] = 1
    let s:zhuyin_comb['zo'] = 1
    let s:zhuyin_comb['z.'] = 1
    let s:zhuyin_comb['z0'] = 1
    let s:zhuyin_comb['zp'] = 1
    let s:zhuyin_comb['z;'] = 1
    let s:zhuyin_comb['z/'] = 1
    let s:zhuyin_comb['2u'] = 1
    let s:zhuyin_comb['2u8'] = 1
    let s:zhuyin_comb['2u,'] = 1
    let s:zhuyin_comb['2ul'] = 1
    let s:zhuyin_comb['2u.'] = 1
    let s:zhuyin_comb['2u0'] = 1
    let s:zhuyin_comb['2u/'] = 1
    let s:zhuyin_comb['2j'] = 1
    let s:zhuyin_comb['2ji'] = 1
    let s:zhuyin_comb['2jo'] = 1
    let s:zhuyin_comb['2j0'] = 1
    let s:zhuyin_comb['2jp'] = 1
    let s:zhuyin_comb['2j/'] = 1
    let s:zhuyin_comb['28'] = 1
    let s:zhuyin_comb['2k'] = 1
    let s:zhuyin_comb['29'] = 1
    let s:zhuyin_comb['2o'] = 1
    let s:zhuyin_comb['2l'] = 1
    let s:zhuyin_comb['2.'] = 1
    let s:zhuyin_comb['20'] = 1
    let s:zhuyin_comb['2p'] = 1
    let s:zhuyin_comb['2;'] = 1
    let s:zhuyin_comb['2/'] = 1
    let s:zhuyin_comb['wu'] = 1
    let s:zhuyin_comb['wu,'] = 1
    let s:zhuyin_comb['wul'] = 1
    let s:zhuyin_comb['wu0'] = 1
    let s:zhuyin_comb['wu/'] = 1
    let s:zhuyin_comb['wj'] = 1
    let s:zhuyin_comb['wji'] = 1
    let s:zhuyin_comb['wjo'] = 1
    let s:zhuyin_comb['wj0'] = 1
    let s:zhuyin_comb['wjp'] = 1
    let s:zhuyin_comb['wj/'] = 1
    let s:zhuyin_comb['w8'] = 1
    let s:zhuyin_comb['wk'] = 1
    let s:zhuyin_comb['w9'] = 1
    let s:zhuyin_comb['wl'] = 1
    let s:zhuyin_comb['w.'] = 1
    let s:zhuyin_comb['w0'] = 1
    let s:zhuyin_comb['w;'] = 1
    let s:zhuyin_comb['w/'] = 1
    let s:zhuyin_comb['su'] = 1
    let s:zhuyin_comb['su8'] = 1
    let s:zhuyin_comb['su,'] = 1
    let s:zhuyin_comb['sul'] = 1
    let s:zhuyin_comb['su.'] = 1
    let s:zhuyin_comb['su0'] = 1
    let s:zhuyin_comb['sup'] = 1
    let s:zhuyin_comb['su;'] = 1
    let s:zhuyin_comb['su/'] = 1
    let s:zhuyin_comb['sj'] = 1
    let s:zhuyin_comb['sji'] = 1
    let s:zhuyin_comb['sj0'] = 1
    let s:zhuyin_comb['sj/'] = 1
    let s:zhuyin_comb['sm'] = 1
    let s:zhuyin_comb['sm,'] = 1
    let s:zhuyin_comb['s8'] = 1
    let s:zhuyin_comb['sk'] = 1
    let s:zhuyin_comb['s9'] = 1
    let s:zhuyin_comb['so'] = 1
    let s:zhuyin_comb['sl'] = 1
    let s:zhuyin_comb['s.'] = 1
    let s:zhuyin_comb['s0'] = 1
    let s:zhuyin_comb['sp'] = 1
    let s:zhuyin_comb['s;'] = 1
    let s:zhuyin_comb['s/'] = 1
    let s:zhuyin_comb['xu'] = 1
    let s:zhuyin_comb['xu8'] = 1
    let s:zhuyin_comb['xu,'] = 1
    let s:zhuyin_comb['xul'] = 1
    let s:zhuyin_comb['xu.'] = 1
    let s:zhuyin_comb['xu0'] = 1
    let s:zhuyin_comb['xup'] = 1
    let s:zhuyin_comb['xu;'] = 1
    let s:zhuyin_comb['xu/'] = 1
    let s:zhuyin_comb['xj'] = 1
    let s:zhuyin_comb['xji'] = 1
    let s:zhuyin_comb['xj0'] = 1
    let s:zhuyin_comb['xjp'] = 1
    let s:zhuyin_comb['xj/'] = 1
    let s:zhuyin_comb['xm'] = 1
    let s:zhuyin_comb['xm,'] = 1
    let s:zhuyin_comb['x8'] = 1
    let s:zhuyin_comb['xi'] = 1
    let s:zhuyin_comb['xk'] = 1
    let s:zhuyin_comb['x9'] = 1
    let s:zhuyin_comb['xo'] = 1
    let s:zhuyin_comb['xl'] = 1
    let s:zhuyin_comb['x.'] = 1
    let s:zhuyin_comb['x0'] = 1
    let s:zhuyin_comb['x;'] = 1
    let s:zhuyin_comb['x/'] = 1
    let s:zhuyin_comb['ej'] = 1
    let s:zhuyin_comb['ej8'] = 1
    let s:zhuyin_comb['eji'] = 1
    let s:zhuyin_comb['ej9'] = 1
    let s:zhuyin_comb['ejo'] = 1
    let s:zhuyin_comb['ej0'] = 1
    let s:zhuyin_comb['ejp'] = 1
    let s:zhuyin_comb['ej;'] = 1
    let s:zhuyin_comb['ej/'] = 1
    let s:zhuyin_comb['e8'] = 1
    let s:zhuyin_comb['ek'] = 1
    let s:zhuyin_comb['e9'] = 1
    let s:zhuyin_comb['eo'] = 1
    let s:zhuyin_comb['el'] = 1
    let s:zhuyin_comb['e.'] = 1
    let s:zhuyin_comb['e0'] = 1
    let s:zhuyin_comb['ep'] = 1
    let s:zhuyin_comb['e;'] = 1
    let s:zhuyin_comb['e/'] = 1
    let s:zhuyin_comb['dj'] = 1
    let s:zhuyin_comb['dj8'] = 1
    let s:zhuyin_comb['dji'] = 1
    let s:zhuyin_comb['dj9'] = 1
    let s:zhuyin_comb['djo'] = 1
    let s:zhuyin_comb['dj0'] = 1
    let s:zhuyin_comb['djp'] = 1
    let s:zhuyin_comb['dj;'] = 1
    let s:zhuyin_comb['dj/'] = 1
    let s:zhuyin_comb['d8'] = 1
    let s:zhuyin_comb['dk'] = 1
    let s:zhuyin_comb['d9'] = 1
    let s:zhuyin_comb['do'] = 1
    let s:zhuyin_comb['dl'] = 1
    let s:zhuyin_comb['d.'] = 1
    let s:zhuyin_comb['d0'] = 1
    let s:zhuyin_comb['dp'] = 1
    let s:zhuyin_comb['d;'] = 1
    let s:zhuyin_comb['d/'] = 1
    let s:zhuyin_comb['ca'] = 1
    let s:zhuyin_comb['cj'] = 1
    let s:zhuyin_comb['cj8'] = 1
    let s:zhuyin_comb['cji'] = 1
    let s:zhuyin_comb['cj9'] = 1
    let s:zhuyin_comb['cjo'] = 1
    let s:zhuyin_comb['cj0'] = 1
    let s:zhuyin_comb['cjp'] = 1
    let s:zhuyin_comb['cj;'] = 1
    let s:zhuyin_comb['cj/'] = 1
    let s:zhuyin_comb['c8'] = 1
    let s:zhuyin_comb['ck'] = 1
    let s:zhuyin_comb['c9'] = 1
    let s:zhuyin_comb['co'] = 1
    let s:zhuyin_comb['cl'] = 1
    let s:zhuyin_comb['c.'] = 1
    let s:zhuyin_comb['c0'] = 1
    let s:zhuyin_comb['cp'] = 1
    let s:zhuyin_comb['c;'] = 1
    let s:zhuyin_comb['c/'] = 1
    let s:zhuyin_comb['ru'] = 1
    let s:zhuyin_comb['ru8'] = 1
    let s:zhuyin_comb['ru,'] = 1
    let s:zhuyin_comb['rul'] = 1
    let s:zhuyin_comb['ru.'] = 1
    let s:zhuyin_comb['ru0'] = 1
    let s:zhuyin_comb['rup'] = 1
    let s:zhuyin_comb['ru;'] = 1
    let s:zhuyin_comb['ru/'] = 1
    let s:zhuyin_comb['rm'] = 1
    let s:zhuyin_comb['rm,'] = 1
    let s:zhuyin_comb['rm0'] = 1
    let s:zhuyin_comb['rmp'] = 1
    let s:zhuyin_comb['rm/'] = 1
    let s:zhuyin_comb['fu'] = 1
    let s:zhuyin_comb['fu8'] = 1
    let s:zhuyin_comb['fu,'] = 1
    let s:zhuyin_comb['ful'] = 1
    let s:zhuyin_comb['fu.'] = 1
    let s:zhuyin_comb['fu0'] = 1
    let s:zhuyin_comb['fup'] = 1
    let s:zhuyin_comb['fu;'] = 1
    let s:zhuyin_comb['fu/'] = 1
    let s:zhuyin_comb['fm'] = 1
    let s:zhuyin_comb['fm,'] = 1
    let s:zhuyin_comb['fm0'] = 1
    let s:zhuyin_comb['fmp'] = 1
    let s:zhuyin_comb['fm/'] = 1
    let s:zhuyin_comb['vu'] = 1
    let s:zhuyin_comb['vu8'] = 1
    let s:zhuyin_comb['vu,'] = 1
    let s:zhuyin_comb['vul'] = 1
    let s:zhuyin_comb['vu.'] = 1
    let s:zhuyin_comb['vu0'] = 1
    let s:zhuyin_comb['vup'] = 1
    let s:zhuyin_comb['vu;'] = 1
    let s:zhuyin_comb['vu/'] = 1
    let s:zhuyin_comb['vm'] = 1
    let s:zhuyin_comb['vm,'] = 1
    let s:zhuyin_comb['vm0'] = 1
    let s:zhuyin_comb['vmp'] = 1
    let s:zhuyin_comb['vm/'] = 1
    let s:zhuyin_comb['5'] = 1
    let s:zhuyin_comb['5j'] = 1
    let s:zhuyin_comb['5j8'] = 1
    let s:zhuyin_comb['5ji'] = 1
    let s:zhuyin_comb['5j9'] = 1
    let s:zhuyin_comb['5jo'] = 1
    let s:zhuyin_comb['5j0'] = 1
    let s:zhuyin_comb['5jp'] = 1
    let s:zhuyin_comb['5j;'] = 1
    let s:zhuyin_comb['5j/'] = 1
    let s:zhuyin_comb['58'] = 1
    let s:zhuyin_comb['5k'] = 1
    let s:zhuyin_comb['59'] = 1
    let s:zhuyin_comb['5o'] = 1
    let s:zhuyin_comb['5l'] = 1
    let s:zhuyin_comb['5.'] = 1
    let s:zhuyin_comb['50'] = 1
    let s:zhuyin_comb['5p'] = 1
    let s:zhuyin_comb['5;'] = 1
    let s:zhuyin_comb['5/'] = 1
    let s:zhuyin_comb['t'] = 1
    let s:zhuyin_comb['tj'] = 1
    let s:zhuyin_comb['tj8'] = 1
    let s:zhuyin_comb['tji'] = 1
    let s:zhuyin_comb['tj9'] = 1
    let s:zhuyin_comb['tjo'] = 1
    let s:zhuyin_comb['tj0'] = 1
    let s:zhuyin_comb['tjp'] = 1
    let s:zhuyin_comb['tj;'] = 1
    let s:zhuyin_comb['tj/'] = 1
    let s:zhuyin_comb['t8'] = 1
    let s:zhuyin_comb['tk'] = 1
    let s:zhuyin_comb['t9'] = 1
    let s:zhuyin_comb['tl'] = 1
    let s:zhuyin_comb['t.'] = 1
    let s:zhuyin_comb['t0'] = 1
    let s:zhuyin_comb['tp'] = 1
    let s:zhuyin_comb['t;'] = 1
    let s:zhuyin_comb['t/'] = 1
    let s:zhuyin_comb['g'] = 1
    let s:zhuyin_comb['gj'] = 1
    let s:zhuyin_comb['gj8'] = 1
    let s:zhuyin_comb['gji'] = 1
    let s:zhuyin_comb['gj9'] = 1
    let s:zhuyin_comb['gjo'] = 1
    let s:zhuyin_comb['gj0'] = 1
    let s:zhuyin_comb['gjp'] = 1
    let s:zhuyin_comb['gj;'] = 1
    let s:zhuyin_comb['g8'] = 1
    let s:zhuyin_comb['gk'] = 1
    let s:zhuyin_comb['g9'] = 1
    let s:zhuyin_comb['go'] = 1
    let s:zhuyin_comb['gl'] = 1
    let s:zhuyin_comb['g.'] = 1
    let s:zhuyin_comb['g0'] = 1
    let s:zhuyin_comb['gp'] = 1
    let s:zhuyin_comb['g;'] = 1
    let s:zhuyin_comb['g/'] = 1
    let s:zhuyin_comb['b'] = 1
    let s:zhuyin_comb['bj'] = 1
    let s:zhuyin_comb['bji'] = 1
    let s:zhuyin_comb['bjo'] = 1
    let s:zhuyin_comb['bj0'] = 1
    let s:zhuyin_comb['bjp'] = 1
    let s:zhuyin_comb['bj/'] = 1
    let s:zhuyin_comb['bk'] = 1
    let s:zhuyin_comb['bl'] = 1
    let s:zhuyin_comb['b.'] = 1
    let s:zhuyin_comb['b0'] = 1
    let s:zhuyin_comb['bp'] = 1
    let s:zhuyin_comb['b;'] = 1
    let s:zhuyin_comb['b/'] = 1
    let s:zhuyin_comb['y'] = 1
    let s:zhuyin_comb['yj'] = 1
    let s:zhuyin_comb['yji'] = 1
    let s:zhuyin_comb['yjo'] = 1
    let s:zhuyin_comb['yj0'] = 1
    let s:zhuyin_comb['yjp'] = 1
    let s:zhuyin_comb['yj/'] = 1
    let s:zhuyin_comb['y8'] = 1
    let s:zhuyin_comb['yk'] = 1
    let s:zhuyin_comb['y9'] = 1
    let s:zhuyin_comb['yo'] = 1
    let s:zhuyin_comb['yl'] = 1
    let s:zhuyin_comb['y.'] = 1
    let s:zhuyin_comb['y0'] = 1
    let s:zhuyin_comb['yp'] = 1
    let s:zhuyin_comb['y;'] = 1
    let s:zhuyin_comb['y/'] = 1
    let s:zhuyin_comb['h'] = 1
    let s:zhuyin_comb['hj'] = 1
    let s:zhuyin_comb['hji'] = 1
    let s:zhuyin_comb['hjo'] = 1
    let s:zhuyin_comb['hj0'] = 1
    let s:zhuyin_comb['hjp'] = 1
    let s:zhuyin_comb['hj/'] = 1
    let s:zhuyin_comb['h8'] = 1
    let s:zhuyin_comb['hk'] = 1
    let s:zhuyin_comb['h9'] = 1
    let s:zhuyin_comb['hl'] = 1
    let s:zhuyin_comb['h.'] = 1
    let s:zhuyin_comb['h0'] = 1
    let s:zhuyin_comb['hp'] = 1
    let s:zhuyin_comb['h;'] = 1
    let s:zhuyin_comb['h/'] = 1
    let s:zhuyin_comb['n'] = 1
    let s:zhuyin_comb['nj'] = 1
    let s:zhuyin_comb['nji'] = 1
    let s:zhuyin_comb['njo'] = 1
    let s:zhuyin_comb['nj0'] = 1
    let s:zhuyin_comb['njp'] = 1
    let s:zhuyin_comb['nj/'] = 1
    let s:zhuyin_comb['n8'] = 1
    let s:zhuyin_comb['nk'] = 1
    let s:zhuyin_comb['n9'] = 1
    let s:zhuyin_comb['nl'] = 1
    let s:zhuyin_comb['n.'] = 1
    let s:zhuyin_comb['n0'] = 1
    let s:zhuyin_comb['np'] = 1
    let s:zhuyin_comb['n;'] = 1
    let s:zhuyin_comb['n/'] = 1
    let s:zhuyin_comb['u'] = 1
    let s:zhuyin_comb['u8'] = 1
    let s:zhuyin_comb['ui'] = 1
    let s:zhuyin_comb['u,'] = 1
    let s:zhuyin_comb['ul'] = 1
    let s:zhuyin_comb['u.'] = 1
    let s:zhuyin_comb['u0'] = 1
    let s:zhuyin_comb['up'] = 1
    let s:zhuyin_comb['u;'] = 1
    let s:zhuyin_comb['u/'] = 1
    let s:zhuyin_comb['j'] = 1
    let s:zhuyin_comb['j8'] = 1
    let s:zhuyin_comb['ji'] = 1
    let s:zhuyin_comb['j9'] = 1
    let s:zhuyin_comb['jo'] = 1
    let s:zhuyin_comb['j0'] = 1
    let s:zhuyin_comb['jp'] = 1
    let s:zhuyin_comb['j;'] = 1
    let s:zhuyin_comb['j/'] = 1
    let s:zhuyin_comb['m'] = 1
    let s:zhuyin_comb['m,'] = 1
    let s:zhuyin_comb['m0'] = 1
    let s:zhuyin_comb['mp'] = 1
    let s:zhuyin_comb['m/'] = 1
    let s:zhuyin_comb['8'] = 1
    let s:zhuyin_comb['i'] = 1
    let s:zhuyin_comb['k'] = 1
    let s:zhuyin_comb['9'] = 1
    let s:zhuyin_comb['o'] = 1
    let s:zhuyin_comb['l'] = 1
    let s:zhuyin_comb['.'] = 1
    let s:zhuyin_comb['0'] = 1
    let s:zhuyin_comb['p'] = 1
    let s:zhuyin_comb[';'] = 1
    let s:zhuyin_comb['/'] = 1
    let s:zhuyin_comb['-'] = 1
    " }}}

    let s:symbols = 'ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦˇˋˊ˙'
    let s:codes = '1qaz2wsxedcrfv5tgbyhnujm8ik,9ol.0p;/-3467'
    let s:symbol_set = split(s:symbols, '\zs')
    let s:code_set = split(s:codes, '\zs')
    let s:zhuyin_code_map = {}

    for l:idx in range(len(s:symbol_set))
        let s:zhuyin_code_map[s:symbol_set[l:idx]] = s:code_set[l:idx]
        let s:zhuyin_code_map[s:code_set[l:idx]] = s:symbol_set[l:idx]
    endfor
    let s:zhuyin_code_map[' '] = ' '
endfunction


function! zhuyin_utils#symbols ()
    return s:symbols
endfunction


function! zhuyin_utils#code_set ()
    return s:code_set
endfunction


function! zhuyin_utils#ZhuyinStr2CodeList (zhuyin_str) " {{{
    if a:zhuyin_str == ''
        return []
    elseif a:zhuyin_str =~ '\v^[ ˊˇˋ˙]*$'
        return []
    endif

    try
        if a:zhuyin_str !~ '\v^[0-9a-z,./; -]*$'
            let l:code_list = map(split(a:zhuyin_str, '\zs'), 's:zhuyin_code_map[v:val]')
        else
            call s:log('Zhuyin string detected')
            let l:code_list = split(a:zhuyin_str, '\zs')
        endif

        let l:result = []       " results
        let l:acc = ''          " one char result
        for l:code in l:code_list
            if l:acc == '' || has_key(s:zhuyin_comb, l:acc . l:code)
                let l:acc = l:acc . l:code
            else
                if l:code =~ '\v[3467 ]'
                    call add(l:result, l:acc . l:code)
                    let l:acc = ''
                else
                    call add(l:result, l:acc)
                    let l:acc = l:code
                endif
            endif
        endfor
        if l:acc != '' && l:acc !~ '\v[3467 ]'
            call add(l:result, l:acc)
        endif
        return l:result
    catch
        call s:log('//', 'Cannot parse zhuyin str: "'. a:zhuyin_str .'"')
        call s:log('||', v:throwpoint)
        call s:log('\\', v:exception)
        return []
    endtry
endfunction " }}}


function! zhuyin_utils#key_to_code (key)
    return s:zhuyin_code_map[(a:key)]
endfunction


function! zhuyin_utils#CodeList2ZhuyinStr (code_list)
    return join(map(split(join(a:code_list, ''), '\zs'), 's:zhuyin_code_map[v:val]'), '')
endfunction


call s:Init()
