function! s:log (...)
    call call(function('ime#log'), ['zhuyin'] + a:000)
endfunction


let s:punctuation_state = 0


function! s:Init () " {{{
    let s:zhuyin_comb = {} " {{{
    let s:zhuyin_comb['ㄅㄚ'] = '18'
    let s:zhuyin_comb['ㄅㄛ'] = '1i'
    let s:zhuyin_comb['ㄅㄞ'] = '19'
    let s:zhuyin_comb['ㄅㄟ'] = '1o'
    let s:zhuyin_comb['ㄅㄠ'] = '1l'
    let s:zhuyin_comb['ㄅㄢ'] = '10'
    let s:zhuyin_comb['ㄅㄣ'] = '1p'
    let s:zhuyin_comb['ㄅㄤ'] = '1;'
    let s:zhuyin_comb['ㄅㄥ'] = '1/'
    let s:zhuyin_comb['ㄅㄧ'] = '1u'
    let s:zhuyin_comb['ㄅㄧㄝ'] = '1u,'
    let s:zhuyin_comb['ㄅㄧㄠ'] = '1ul'
    let s:zhuyin_comb['ㄅㄧㄢ'] = '1u0'
    let s:zhuyin_comb['ㄅㄧㄣ'] = '1up'
    let s:zhuyin_comb['ㄅㄧㄥ'] = '1u/'
    let s:zhuyin_comb['ㄅㄨ'] = '1j'
    let s:zhuyin_comb['ㄆㄚ'] = 'q8'
    let s:zhuyin_comb['ㄆㄛ'] = 'qi'
    let s:zhuyin_comb['ㄆㄞ'] = 'q9'
    let s:zhuyin_comb['ㄆㄟ'] = 'qo'
    let s:zhuyin_comb['ㄆㄠ'] = 'ql'
    let s:zhuyin_comb['ㄆㄡ'] = 'q.'
    let s:zhuyin_comb['ㄆㄢ'] = 'q0'
    let s:zhuyin_comb['ㄆㄣ'] = 'qp'
    let s:zhuyin_comb['ㄆㄤ'] = 'q;'
    let s:zhuyin_comb['ㄆㄥ'] = 'q/'
    let s:zhuyin_comb['ㄆㄧ'] = 'qu'
    let s:zhuyin_comb['ㄆㄧㄝ'] = 'qu,'
    let s:zhuyin_comb['ㄆㄧㄠ'] = 'qul'
    let s:zhuyin_comb['ㄆㄧㄢ'] = 'qu0'
    let s:zhuyin_comb['ㄆㄧㄣ'] = 'qup'
    let s:zhuyin_comb['ㄆㄧㄥ'] = 'qu/'
    let s:zhuyin_comb['ㄆㄨ'] = 'qj'
    let s:zhuyin_comb['ㄇㄚ'] = 'a8'
    let s:zhuyin_comb['ㄇㄛ'] = 'ai'
    let s:zhuyin_comb['ㄇㄜ'] = 'ak'
    let s:zhuyin_comb['ㄇㄞ'] = 'a9'
    let s:zhuyin_comb['ㄇㄟ'] = 'ao'
    let s:zhuyin_comb['ㄇㄠ'] = 'al'
    let s:zhuyin_comb['ㄇㄡ'] = 'a.'
    let s:zhuyin_comb['ㄇㄢ'] = 'a0'
    let s:zhuyin_comb['ㄇㄣ'] = 'ap'
    let s:zhuyin_comb['ㄇㄤ'] = 'a;'
    let s:zhuyin_comb['ㄇㄥ'] = 'a/'
    let s:zhuyin_comb['ㄇㄧ'] = 'au'
    let s:zhuyin_comb['ㄇㄧㄝ'] = 'au,'
    let s:zhuyin_comb['ㄇㄧㄠ'] = 'aul'
    let s:zhuyin_comb['ㄇㄧㄡ'] = 'au.'
    let s:zhuyin_comb['ㄇㄧㄢ'] = 'au0'
    let s:zhuyin_comb['ㄇㄧㄣ'] = 'aup'
    let s:zhuyin_comb['ㄇㄧㄥ'] = 'au/'
    let s:zhuyin_comb['ㄇㄨ'] = 'aj'
    let s:zhuyin_comb['ㄈㄚ'] = 'z8'
    let s:zhuyin_comb['ㄈㄛ'] = 'zi'
    let s:zhuyin_comb['ㄈㄟ'] = 'zo'
    let s:zhuyin_comb['ㄈㄡ'] = 'z.'
    let s:zhuyin_comb['ㄈㄢ'] = 'z0'
    let s:zhuyin_comb['ㄈㄣ'] = 'zp'
    let s:zhuyin_comb['ㄈㄤ'] = 'z;'
    let s:zhuyin_comb['ㄈㄥ'] = 'z/'
    let s:zhuyin_comb['ㄈㄨ'] = 'zj'
    let s:zhuyin_comb['ㄉㄚ'] = '28'
    let s:zhuyin_comb['ㄉㄜ'] = '2k'
    let s:zhuyin_comb['ㄉㄞ'] = '29'
    let s:zhuyin_comb['ㄉㄟ'] = '2o'
    let s:zhuyin_comb['ㄉㄠ'] = '2l'
    let s:zhuyin_comb['ㄉㄡ'] = '2.'
    let s:zhuyin_comb['ㄉㄢ'] = '20'
    let s:zhuyin_comb['ㄉㄣ'] = '2p'
    let s:zhuyin_comb['ㄉㄤ'] = '2;'
    let s:zhuyin_comb['ㄉㄥ'] = '2/'
    let s:zhuyin_comb['ㄉㄧ'] = '2u'
    let s:zhuyin_comb['ㄉㄧㄚ'] = '2u8'
    let s:zhuyin_comb['ㄉㄧㄝ'] = '2u,'
    let s:zhuyin_comb['ㄉㄧㄠ'] = '2ul'
    let s:zhuyin_comb['ㄉㄧㄡ'] = '2u.'
    let s:zhuyin_comb['ㄉㄧㄢ'] = '2u0'
    let s:zhuyin_comb['ㄉㄧㄥ'] = '2u/'
    let s:zhuyin_comb['ㄉㄨ'] = '2j'
    let s:zhuyin_comb['ㄉㄨㄛ'] = '2ji'
    let s:zhuyin_comb['ㄉㄨㄟ'] = '2jo'
    let s:zhuyin_comb['ㄉㄨㄢ'] = '2j0'
    let s:zhuyin_comb['ㄉㄨㄣ'] = '2jp'
    let s:zhuyin_comb['ㄉㄨㄥ'] = '2j/'
    let s:zhuyin_comb['ㄊㄚ'] = 'w8'
    let s:zhuyin_comb['ㄊㄜ'] = 'wk'
    let s:zhuyin_comb['ㄊㄞ'] = 'w9'
    let s:zhuyin_comb['ㄊㄠ'] = 'wl'
    let s:zhuyin_comb['ㄊㄡ'] = 'w.'
    let s:zhuyin_comb['ㄊㄢ'] = 'w0'
    let s:zhuyin_comb['ㄊㄤ'] = 'w;'
    let s:zhuyin_comb['ㄊㄥ'] = 'w/'
    let s:zhuyin_comb['ㄊㄧ'] = 'wu'
    let s:zhuyin_comb['ㄊㄧㄝ'] = 'wu,'
    let s:zhuyin_comb['ㄊㄧㄠ'] = 'wul'
    let s:zhuyin_comb['ㄊㄧㄢ'] = 'wu0'
    let s:zhuyin_comb['ㄊㄧㄥ'] = 'wu/'
    let s:zhuyin_comb['ㄊㄨ'] = 'wj'
    let s:zhuyin_comb['ㄊㄨㄛ'] = 'wji'
    let s:zhuyin_comb['ㄊㄨㄟ'] = 'wjo'
    let s:zhuyin_comb['ㄊㄨㄢ'] = 'wj0'
    let s:zhuyin_comb['ㄊㄨㄣ'] = 'wjp'
    let s:zhuyin_comb['ㄊㄨㄥ'] = 'wj/'
    let s:zhuyin_comb['ㄋㄚ'] = 's8'
    let s:zhuyin_comb['ㄋㄜ'] = 'sk'
    let s:zhuyin_comb['ㄋㄞ'] = 's9'
    let s:zhuyin_comb['ㄋㄟ'] = 'so'
    let s:zhuyin_comb['ㄋㄠ'] = 'sl'
    let s:zhuyin_comb['ㄋㄡ'] = 's.'
    let s:zhuyin_comb['ㄋㄢ'] = 's0'
    let s:zhuyin_comb['ㄋㄣ'] = 'sp'
    let s:zhuyin_comb['ㄋㄤ'] = 's;'
    let s:zhuyin_comb['ㄋㄥ'] = 's/'
    let s:zhuyin_comb['ㄋㄧ'] = 'su'
    let s:zhuyin_comb['ㄋㄧㄚ'] = 'su8'
    let s:zhuyin_comb['ㄋㄧㄝ'] = 'su,'
    let s:zhuyin_comb['ㄋㄧㄠ'] = 'sul'
    let s:zhuyin_comb['ㄋㄧㄡ'] = 'su.'
    let s:zhuyin_comb['ㄋㄧㄢ'] = 'su0'
    let s:zhuyin_comb['ㄋㄧㄣ'] = 'sup'
    let s:zhuyin_comb['ㄋㄧㄤ'] = 'su;'
    let s:zhuyin_comb['ㄋㄧㄥ'] = 'su/'
    let s:zhuyin_comb['ㄋㄨ'] = 'sj'
    let s:zhuyin_comb['ㄋㄨㄛ'] = 'sji'
    let s:zhuyin_comb['ㄋㄨㄢ'] = 'sj0'
    let s:zhuyin_comb['ㄋㄨㄥ'] = 'sj/'
    let s:zhuyin_comb['ㄋㄩ'] = 'sm'
    let s:zhuyin_comb['ㄋㄩㄝ'] = 'sm,'
    let s:zhuyin_comb['ㄌㄚ'] = 'x8'
    let s:zhuyin_comb['ㄌㄛ'] = 'xi'
    let s:zhuyin_comb['ㄌㄜ'] = 'xk'
    let s:zhuyin_comb['ㄌㄞ'] = 'x9'
    let s:zhuyin_comb['ㄌㄟ'] = 'xo'
    let s:zhuyin_comb['ㄌㄠ'] = 'xl'
    let s:zhuyin_comb['ㄌㄡ'] = 'x.'
    let s:zhuyin_comb['ㄌㄢ'] = 'x0'
    let s:zhuyin_comb['ㄌㄤ'] = 'x;'
    let s:zhuyin_comb['ㄌㄥ'] = 'x/'
    let s:zhuyin_comb['ㄌㄧ'] = 'xu'
    let s:zhuyin_comb['ㄌㄧㄚ'] = 'xu8'
    let s:zhuyin_comb['ㄌㄧㄝ'] = 'xu,'
    let s:zhuyin_comb['ㄌㄧㄠ'] = 'xul'
    let s:zhuyin_comb['ㄌㄧㄡ'] = 'xu.'
    let s:zhuyin_comb['ㄌㄧㄢ'] = 'xu0'
    let s:zhuyin_comb['ㄌㄧㄣ'] = 'xup'
    let s:zhuyin_comb['ㄌㄧㄤ'] = 'xu;'
    let s:zhuyin_comb['ㄌㄧㄥ'] = 'xu/'
    let s:zhuyin_comb['ㄌㄨ'] = 'xj'
    let s:zhuyin_comb['ㄌㄨㄛ'] = 'xji'
    let s:zhuyin_comb['ㄌㄨㄢ'] = 'xj0'
    let s:zhuyin_comb['ㄌㄨㄣ'] = 'xjp'
    let s:zhuyin_comb['ㄌㄨㄥ'] = 'xj/'
    let s:zhuyin_comb['ㄌㄩ'] = 'xm'
    let s:zhuyin_comb['ㄌㄩㄝ'] = 'xm,'
    let s:zhuyin_comb['ㄍㄚ'] = 'e8'
    let s:zhuyin_comb['ㄍㄜ'] = 'ek'
    let s:zhuyin_comb['ㄍㄞ'] = 'e9'
    let s:zhuyin_comb['ㄍㄟ'] = 'eo'
    let s:zhuyin_comb['ㄍㄠ'] = 'el'
    let s:zhuyin_comb['ㄍㄡ'] = 'e.'
    let s:zhuyin_comb['ㄍㄢ'] = 'e0'
    let s:zhuyin_comb['ㄍㄣ'] = 'ep'
    let s:zhuyin_comb['ㄍㄤ'] = 'e;'
    let s:zhuyin_comb['ㄍㄥ'] = 'e/'
    let s:zhuyin_comb['ㄍㄨ'] = 'ej'
    let s:zhuyin_comb['ㄍㄨㄚ'] = 'ej8'
    let s:zhuyin_comb['ㄍㄨㄛ'] = 'eji'
    let s:zhuyin_comb['ㄍㄨㄞ'] = 'ej9'
    let s:zhuyin_comb['ㄍㄨㄟ'] = 'ejo'
    let s:zhuyin_comb['ㄍㄨㄢ'] = 'ej0'
    let s:zhuyin_comb['ㄍㄨㄣ'] = 'ejp'
    let s:zhuyin_comb['ㄍㄨㄤ'] = 'ej;'
    let s:zhuyin_comb['ㄍㄨㄥ'] = 'ej/'
    let s:zhuyin_comb['ㄎㄚ'] = 'd8'
    let s:zhuyin_comb['ㄎㄜ'] = 'dk'
    let s:zhuyin_comb['ㄎㄞ'] = 'd9'
    let s:zhuyin_comb['ㄎㄟ'] = 'do'
    let s:zhuyin_comb['ㄎㄠ'] = 'dl'
    let s:zhuyin_comb['ㄎㄡ'] = 'd.'
    let s:zhuyin_comb['ㄎㄢ'] = 'd0'
    let s:zhuyin_comb['ㄎㄣ'] = 'dp'
    let s:zhuyin_comb['ㄎㄤ'] = 'd;'
    let s:zhuyin_comb['ㄎㄥ'] = 'd/'
    let s:zhuyin_comb['ㄎㄨ'] = 'dj'
    let s:zhuyin_comb['ㄎㄨㄚ'] = 'dj8'
    let s:zhuyin_comb['ㄎㄨㄛ'] = 'dji'
    let s:zhuyin_comb['ㄎㄨㄞ'] = 'dj9'
    let s:zhuyin_comb['ㄎㄨㄟ'] = 'djo'
    let s:zhuyin_comb['ㄎㄨㄢ'] = 'dj0'
    let s:zhuyin_comb['ㄎㄨㄣ'] = 'djp'
    let s:zhuyin_comb['ㄎㄨㄤ'] = 'dj;'
    let s:zhuyin_comb['ㄎㄨㄥ'] = 'dj/'
    let s:zhuyin_comb['ㄏㄇ'] = 'ca'
    let s:zhuyin_comb['ㄏㄚ'] = 'c8'
    let s:zhuyin_comb['ㄏㄜ'] = 'ck'
    let s:zhuyin_comb['ㄏㄞ'] = 'c9'
    let s:zhuyin_comb['ㄏㄟ'] = 'co'
    let s:zhuyin_comb['ㄏㄠ'] = 'cl'
    let s:zhuyin_comb['ㄏㄡ'] = 'c.'
    let s:zhuyin_comb['ㄏㄢ'] = 'c0'
    let s:zhuyin_comb['ㄏㄣ'] = 'cp'
    let s:zhuyin_comb['ㄏㄤ'] = 'c;'
    let s:zhuyin_comb['ㄏㄥ'] = 'c/'
    let s:zhuyin_comb['ㄏㄨ'] = 'cj'
    let s:zhuyin_comb['ㄏㄨㄚ'] = 'cj8'
    let s:zhuyin_comb['ㄏㄨㄛ'] = 'cji'
    let s:zhuyin_comb['ㄏㄨㄞ'] = 'cj9'
    let s:zhuyin_comb['ㄏㄨㄟ'] = 'cjo'
    let s:zhuyin_comb['ㄏㄨㄢ'] = 'cj0'
    let s:zhuyin_comb['ㄏㄨㄣ'] = 'cjp'
    let s:zhuyin_comb['ㄏㄨㄤ'] = 'cj;'
    let s:zhuyin_comb['ㄏㄨㄥ'] = 'cj/'
    let s:zhuyin_comb['ㄐㄧ'] = 'ru'
    let s:zhuyin_comb['ㄐㄧㄚ'] = 'ru8'
    let s:zhuyin_comb['ㄐㄧㄝ'] = 'ru,'
    let s:zhuyin_comb['ㄐㄧㄠ'] = 'rul'
    let s:zhuyin_comb['ㄐㄧㄡ'] = 'ru.'
    let s:zhuyin_comb['ㄐㄧㄢ'] = 'ru0'
    let s:zhuyin_comb['ㄐㄧㄣ'] = 'rup'
    let s:zhuyin_comb['ㄐㄧㄤ'] = 'ru;'
    let s:zhuyin_comb['ㄐㄧㄥ'] = 'ru/'
    let s:zhuyin_comb['ㄐㄩ'] = 'rm'
    let s:zhuyin_comb['ㄐㄩㄝ'] = 'rm,'
    let s:zhuyin_comb['ㄐㄩㄢ'] = 'rm0'
    let s:zhuyin_comb['ㄐㄩㄣ'] = 'rmp'
    let s:zhuyin_comb['ㄐㄩㄥ'] = 'rm/'
    let s:zhuyin_comb['ㄑㄧ'] = 'fu'
    let s:zhuyin_comb['ㄑㄧㄚ'] = 'fu8'
    let s:zhuyin_comb['ㄑㄧㄝ'] = 'fu,'
    let s:zhuyin_comb['ㄑㄧㄠ'] = 'ful'
    let s:zhuyin_comb['ㄑㄧㄡ'] = 'fu.'
    let s:zhuyin_comb['ㄑㄧㄢ'] = 'fu0'
    let s:zhuyin_comb['ㄑㄧㄣ'] = 'fup'
    let s:zhuyin_comb['ㄑㄧㄤ'] = 'fu;'
    let s:zhuyin_comb['ㄑㄧㄥ'] = 'fu/'
    let s:zhuyin_comb['ㄑㄩ'] = 'fm'
    let s:zhuyin_comb['ㄑㄩㄝ'] = 'fm,'
    let s:zhuyin_comb['ㄑㄩㄢ'] = 'fm0'
    let s:zhuyin_comb['ㄑㄩㄣ'] = 'fmp'
    let s:zhuyin_comb['ㄑㄩㄥ'] = 'fm/'
    let s:zhuyin_comb['ㄒㄧ'] = 'vu'
    let s:zhuyin_comb['ㄒㄧㄚ'] = 'vu8'
    let s:zhuyin_comb['ㄒㄧㄝ'] = 'vu,'
    let s:zhuyin_comb['ㄒㄧㄠ'] = 'vul'
    let s:zhuyin_comb['ㄒㄧㄡ'] = 'vu.'
    let s:zhuyin_comb['ㄒㄧㄢ'] = 'vu0'
    let s:zhuyin_comb['ㄒㄧㄣ'] = 'vup'
    let s:zhuyin_comb['ㄒㄧㄤ'] = 'vu;'
    let s:zhuyin_comb['ㄒㄧㄥ'] = 'vu/'
    let s:zhuyin_comb['ㄒㄩ'] = 'vm'
    let s:zhuyin_comb['ㄒㄩㄝ'] = 'vm,'
    let s:zhuyin_comb['ㄒㄩㄢ'] = 'vm0'
    let s:zhuyin_comb['ㄒㄩㄣ'] = 'vmp'
    let s:zhuyin_comb['ㄒㄩㄥ'] = 'vm/'
    let s:zhuyin_comb['ㄓ'] = '5'
    let s:zhuyin_comb['ㄓㄚ'] = '58'
    let s:zhuyin_comb['ㄓㄜ'] = '5k'
    let s:zhuyin_comb['ㄓㄞ'] = '59'
    let s:zhuyin_comb['ㄓㄟ'] = '5o'
    let s:zhuyin_comb['ㄓㄠ'] = '5l'
    let s:zhuyin_comb['ㄓㄡ'] = '5.'
    let s:zhuyin_comb['ㄓㄢ'] = '50'
    let s:zhuyin_comb['ㄓㄣ'] = '5p'
    let s:zhuyin_comb['ㄓㄤ'] = '5;'
    let s:zhuyin_comb['ㄓㄥ'] = '5/'
    let s:zhuyin_comb['ㄓㄨ'] = '5j'
    let s:zhuyin_comb['ㄓㄨㄚ'] = '5j8'
    let s:zhuyin_comb['ㄓㄨㄛ'] = '5ji'
    let s:zhuyin_comb['ㄓㄨㄞ'] = '5j9'
    let s:zhuyin_comb['ㄓㄨㄟ'] = '5jo'
    let s:zhuyin_comb['ㄓㄨㄢ'] = '5j0'
    let s:zhuyin_comb['ㄓㄨㄣ'] = '5jp'
    let s:zhuyin_comb['ㄓㄨㄤ'] = '5j;'
    let s:zhuyin_comb['ㄓㄨㄥ'] = '5j/'
    let s:zhuyin_comb['ㄔ'] = 't'
    let s:zhuyin_comb['ㄔㄚ'] = 't8'
    let s:zhuyin_comb['ㄔㄜ'] = 'tk'
    let s:zhuyin_comb['ㄔㄞ'] = 't9'
    let s:zhuyin_comb['ㄔㄠ'] = 'tl'
    let s:zhuyin_comb['ㄔㄡ'] = 't.'
    let s:zhuyin_comb['ㄔㄢ'] = 't0'
    let s:zhuyin_comb['ㄔㄣ'] = 'tp'
    let s:zhuyin_comb['ㄔㄤ'] = 't;'
    let s:zhuyin_comb['ㄔㄥ'] = 't/'
    let s:zhuyin_comb['ㄔㄨ'] = 'tj'
    let s:zhuyin_comb['ㄔㄨㄚ'] = 'tj8'
    let s:zhuyin_comb['ㄔㄨㄛ'] = 'tji'
    let s:zhuyin_comb['ㄔㄨㄞ'] = 'tj9'
    let s:zhuyin_comb['ㄔㄨㄟ'] = 'tjo'
    let s:zhuyin_comb['ㄔㄨㄢ'] = 'tj0'
    let s:zhuyin_comb['ㄔㄨㄣ'] = 'tjp'
    let s:zhuyin_comb['ㄔㄨㄤ'] = 'tj;'
    let s:zhuyin_comb['ㄔㄨㄥ'] = 'tj/'
    let s:zhuyin_comb['ㄕ'] = 'g'
    let s:zhuyin_comb['ㄕㄚ'] = 'g8'
    let s:zhuyin_comb['ㄕㄜ'] = 'gk'
    let s:zhuyin_comb['ㄕㄞ'] = 'g9'
    let s:zhuyin_comb['ㄕㄟ'] = 'go'
    let s:zhuyin_comb['ㄕㄠ'] = 'gl'
    let s:zhuyin_comb['ㄕㄡ'] = 'g.'
    let s:zhuyin_comb['ㄕㄢ'] = 'g0'
    let s:zhuyin_comb['ㄕㄣ'] = 'gp'
    let s:zhuyin_comb['ㄕㄤ'] = 'g;'
    let s:zhuyin_comb['ㄕㄥ'] = 'g/'
    let s:zhuyin_comb['ㄕㄨ'] = 'gj'
    let s:zhuyin_comb['ㄕㄨㄚ'] = 'gj8'
    let s:zhuyin_comb['ㄕㄨㄛ'] = 'gji'
    let s:zhuyin_comb['ㄕㄨㄞ'] = 'gj9'
    let s:zhuyin_comb['ㄕㄨㄟ'] = 'gjo'
    let s:zhuyin_comb['ㄕㄨㄢ'] = 'gj0'
    let s:zhuyin_comb['ㄕㄨㄣ'] = 'gjp'
    let s:zhuyin_comb['ㄕㄨㄤ'] = 'gj;'
    let s:zhuyin_comb['ㄖ'] = 'b'
    let s:zhuyin_comb['ㄖㄜ'] = 'bk'
    let s:zhuyin_comb['ㄖㄠ'] = 'bl'
    let s:zhuyin_comb['ㄖㄡ'] = 'b.'
    let s:zhuyin_comb['ㄖㄢ'] = 'b0'
    let s:zhuyin_comb['ㄖㄣ'] = 'bp'
    let s:zhuyin_comb['ㄖㄤ'] = 'b;'
    let s:zhuyin_comb['ㄖㄥ'] = 'b/'
    let s:zhuyin_comb['ㄖㄨ'] = 'bj'
    let s:zhuyin_comb['ㄖㄨㄛ'] = 'bji'
    let s:zhuyin_comb['ㄖㄨㄟ'] = 'bjo'
    let s:zhuyin_comb['ㄖㄨㄢ'] = 'bj0'
    let s:zhuyin_comb['ㄖㄨㄣ'] = 'bjp'
    let s:zhuyin_comb['ㄖㄨㄥ'] = 'bj/'
    let s:zhuyin_comb['ㄗ'] = 'y'
    let s:zhuyin_comb['ㄗㄚ'] = 'y8'
    let s:zhuyin_comb['ㄗㄜ'] = 'yk'
    let s:zhuyin_comb['ㄗㄞ'] = 'y9'
    let s:zhuyin_comb['ㄗㄟ'] = 'yo'
    let s:zhuyin_comb['ㄗㄠ'] = 'yl'
    let s:zhuyin_comb['ㄗㄡ'] = 'y.'
    let s:zhuyin_comb['ㄗㄢ'] = 'y0'
    let s:zhuyin_comb['ㄗㄣ'] = 'yp'
    let s:zhuyin_comb['ㄗㄤ'] = 'y;'
    let s:zhuyin_comb['ㄗㄥ'] = 'y/'
    let s:zhuyin_comb['ㄗㄨ'] = 'yj'
    let s:zhuyin_comb['ㄗㄨㄛ'] = 'yji'
    let s:zhuyin_comb['ㄗㄨㄟ'] = 'yjo'
    let s:zhuyin_comb['ㄗㄨㄢ'] = 'yj0'
    let s:zhuyin_comb['ㄗㄨㄣ'] = 'yjp'
    let s:zhuyin_comb['ㄗㄨㄥ'] = 'yj/'
    let s:zhuyin_comb['ㄘ'] = 'h'
    let s:zhuyin_comb['ㄘㄚ'] = 'h8'
    let s:zhuyin_comb['ㄘㄜ'] = 'hk'
    let s:zhuyin_comb['ㄘㄞ'] = 'h9'
    let s:zhuyin_comb['ㄘㄠ'] = 'hl'
    let s:zhuyin_comb['ㄘㄡ'] = 'h.'
    let s:zhuyin_comb['ㄘㄢ'] = 'h0'
    let s:zhuyin_comb['ㄘㄣ'] = 'hp'
    let s:zhuyin_comb['ㄘㄤ'] = 'h;'
    let s:zhuyin_comb['ㄘㄥ'] = 'h/'
    let s:zhuyin_comb['ㄘㄨ'] = 'hj'
    let s:zhuyin_comb['ㄘㄨㄛ'] = 'hji'
    let s:zhuyin_comb['ㄘㄨㄟ'] = 'hjo'
    let s:zhuyin_comb['ㄘㄨㄢ'] = 'hj0'
    let s:zhuyin_comb['ㄘㄨㄣ'] = 'hjp'
    let s:zhuyin_comb['ㄘㄨㄥ'] = 'hj/'
    let s:zhuyin_comb['ㄙ'] = 'n'
    let s:zhuyin_comb['ㄙㄚ'] = 'n8'
    let s:zhuyin_comb['ㄙㄜ'] = 'nk'
    let s:zhuyin_comb['ㄙㄞ'] = 'n9'
    let s:zhuyin_comb['ㄙㄠ'] = 'nl'
    let s:zhuyin_comb['ㄙㄡ'] = 'n.'
    let s:zhuyin_comb['ㄙㄢ'] = 'n0'
    let s:zhuyin_comb['ㄙㄣ'] = 'np'
    let s:zhuyin_comb['ㄙㄤ'] = 'n;'
    let s:zhuyin_comb['ㄙㄥ'] = 'n/'
    let s:zhuyin_comb['ㄙㄨ'] = 'nj'
    let s:zhuyin_comb['ㄙㄨㄛ'] = 'nji'
    let s:zhuyin_comb['ㄙㄨㄟ'] = 'njo'
    let s:zhuyin_comb['ㄙㄨㄢ'] = 'nj0'
    let s:zhuyin_comb['ㄙㄨㄣ'] = 'njp'
    let s:zhuyin_comb['ㄙㄨㄥ'] = 'nj/'
    let s:zhuyin_comb['ㄚ'] = '8'
    let s:zhuyin_comb['ㄛ'] = 'i'
    let s:zhuyin_comb['ㄜ'] = 'k'
    let s:zhuyin_comb['ㄝ'] = ','
    let s:zhuyin_comb['ㄞ'] = '9'
    let s:zhuyin_comb['ㄟ'] = 'o'
    let s:zhuyin_comb['ㄠ'] = 'l'
    let s:zhuyin_comb['ㄡ'] = '.'
    let s:zhuyin_comb['ㄢ'] = '0'
    let s:zhuyin_comb['ㄣ'] = 'p'
    let s:zhuyin_comb['ㄤ'] = ';'
    let s:zhuyin_comb['ㄥ'] = '/'
    let s:zhuyin_comb['ㄦ'] = '-'
    let s:zhuyin_comb['ㄧ'] = 'u'
    let s:zhuyin_comb['ㄧㄚ'] = 'u8'
    let s:zhuyin_comb['ㄧㄛ'] = 'ui'
    let s:zhuyin_comb['ㄧㄝ'] = 'u,'
    let s:zhuyin_comb['ㄧㄠ'] = 'ul'
    let s:zhuyin_comb['ㄧㄡ'] = 'u.'
    let s:zhuyin_comb['ㄧㄢ'] = 'u0'
    let s:zhuyin_comb['ㄧㄣ'] = 'up'
    let s:zhuyin_comb['ㄧㄤ'] = 'u;'
    let s:zhuyin_comb['ㄧㄥ'] = 'u/'
    let s:zhuyin_comb['ㄨ'] = 'j'
    let s:zhuyin_comb['ㄨㄚ'] = 'j8'
    let s:zhuyin_comb['ㄨㄛ'] = 'ji'
    let s:zhuyin_comb['ㄨㄞ'] = 'j9'
    let s:zhuyin_comb['ㄨㄟ'] = 'jo'
    let s:zhuyin_comb['ㄨㄢ'] = 'j0'
    let s:zhuyin_comb['ㄨㄣ'] = 'jp'
    let s:zhuyin_comb['ㄨㄤ'] = 'j;'
    let s:zhuyin_comb['ㄨㄥ'] = 'j/'
    let s:zhuyin_comb['ㄩ'] = 'm'
    let s:zhuyin_comb['ㄩㄝ'] = 'm,'
    let s:zhuyin_comb['ㄩㄢ'] = 'm0'
    let s:zhuyin_comb['ㄩㄣ'] = 'mp'
    let s:zhuyin_comb['ㄩㄥ'] = 'm/'
    " }}}

    let s:symbols = 'ㄅㄆㄇㄈㄉㄊㄋㄌㄍㄎㄏㄐㄑㄒㄓㄔㄕㄖㄗㄘㄙㄧㄨㄩㄚㄛㄜㄝㄞㄟㄠㄡㄢㄣㄤㄥㄦˇˋˊ˙'
    let s:codes = '1qaz2wsxedcrfv5tgbyhnujm8ik,9ol.0p;/-3467'
    let s:symbol_set = split(s:symbols, '\zs')
    let s:code_set = split(s:codes, '\zs')
    let s:zhuyin2code = {}

    for l:idx in range(len(s:symbol_set))
        let s:zhuyin2code[s:symbol_set[l:idx]] = s:code_set[l:idx]
        let s:zhuyin2code[s:code_set[l:idx]] = s:symbol_set[l:idx]
    endfor
    let s:zhuyin2code[' '] = ' '

    let s:zhuyin_sound2code = {}
    let s:zhuyin_sound2code['ˇ'] = '3'
    let s:zhuyin_sound2code['ˋ'] = '4'
    let s:zhuyin_sound2code['ˊ'] = '6'
    let s:zhuyin_sound2code['˙'] = '7'
    let s:zhuyin_sound2code[' '] = ' '
    let s:zhuyin_sound2code[''] = ''
endfunction " }}}


function! s:zhuyin2code_choice (key, sound) " {{{
    if has_key(s:zhuyin_comb, a:key)
        return s:zhuyin_comb[(a:key)] . s:zhuyin_sound2code[(a:sound)]
    endif
    let l:key_len = strlen(a:key)
    return sort(map(
                \ filter(
                    \ keys(s:zhuyin_comb),
                    \ 'strpart(v:val, 0, l:key_len) == a:key'
                \ ),
                \ 's:zhuyin_comb[(v:val)] . s:zhuyin_sound2code[(a:sound)]'
            \ ))
endfunction " }}}


function! ime_zhuyin#ParseZhuyinStr (zhuyin_str) " {{{
    if a:zhuyin_str == ''
        return {'zhuyin': [], 'code': []}
    elseif a:zhuyin_str =~# '\v^[ ˊˇˋ˙]*$'
        return {'zhuyin': [], 'code': []}
    endif

    try
        let l:char_list = split(a:zhuyin_str, '\zs')
        let l:zhuyin_list = []
        let l:code_list = []
        let l:acc = ''
        for l:char in l:char_list
            let l:key = l:acc . l:char
            if l:char =~# '\v[ ˊˇˋ˙]' && l:acc != ''
                call add(l:zhuyin_list, l:key)
                call add(l:code_list, s:zhuyin2code_choice(l:acc, l:char))
                let l:acc = ''
            elseif l:acc == '' || len(s:zhuyin2code_choice(l:key, ''))
                let l:acc = l:acc . l:char
            else
                call add(l:zhuyin_list, l:acc)
                call add(l:code_list, s:zhuyin2code_choice(l:acc, ''))
                let l:acc = l:char
            endif
        endfor
        if l:acc != '' && l:acc !~ '\v[ ˊˇˋ˙]'
            call add(l:zhuyin_list, l:acc)
            call add(l:code_list, s:zhuyin2code_choice(l:acc, ''))
        endif
        return {'zhuyin': (l:zhuyin_list), 'code': (l:code_list)}
    catch
        call s:log('//', 'Cannot parse zhuyin str: "'. a:zhuyin_str .'"')
        call s:log('||', v:throwpoint)
        call s:log('\\', v:exception)
        return {'zhuyin': [], 'code': []}
    endtry
endfunction " }}}


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
        let l:zhuyin_str .= s:zhuyin2code[(a:trigger)]
    endif

    " No phonetic symbol given, just return it back
    if match(l:zhuyin_str, '\v^ *$') != -1
        return [l:zhuyin_str]
    endif

    let l:res = ime_zhuyin#ParseZhuyinStr(l:zhuyin_str)
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


function ime_zhuyin#menu (...)
    if a:0 == 0
        let s:punctuation_state = 1 - s:punctuation_state
    elseif a:1 == ''
        let s:punctuation_state = 0
    endif

    if s:punctuation_state == 0
        call ime#icon('zhuyin', '[注]')
    else
        call ime#icon('zhuyin', '[，]')
    endif
endfunction


function! ime_zhuyin#info ()
    return {
    \ 'type': 'standalone',
    \ 'icon': '[注]',
    \ 'description': 'Zhuyin input mode',
    \ 'pattern':  '\v%(|:|['. s:symbols .']['. s:symbols .' ]*)$',
    \ 'handler': function('ime_zhuyin#handler'),
    \ 'trigger': s:code_set + [' ', '''', ':'],
    \ 'menu': function('ime_zhuyin#menu'),
    \ }
endfunction


call s:Init()
