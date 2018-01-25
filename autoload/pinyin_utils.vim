function! s:log (...)
    call call(function('ime#log'), ['phonetic'] + a:000)
endfunction


function! s:Init ()
    let s:pinyin_comb = {} " {{{
    let s:pinyin_comb['a'] = '8'
    let s:pinyin_comb['ai'] = '9'
    let s:pinyin_comb['an'] = '0'
    let s:pinyin_comb['ang'] = ';'
    let s:pinyin_comb['ao'] = 'l'
    let s:pinyin_comb['ba'] = '18'
    let s:pinyin_comb['bai'] = '19'
    let s:pinyin_comb['ban'] = '10'
    let s:pinyin_comb['bang'] = '1;'
    let s:pinyin_comb['bao'] = '1l'
    let s:pinyin_comb['bei'] = '1o'
    let s:pinyin_comb['ben'] = '1p'
    let s:pinyin_comb['beng'] = '1/'
    let s:pinyin_comb['bi'] = '1u'
    let s:pinyin_comb['bian'] = '1u0'
    let s:pinyin_comb['biao'] = '1ul'
    let s:pinyin_comb['bie'] = '1u,'
    let s:pinyin_comb['bin'] = '1up'
    let s:pinyin_comb['bing'] = '1u/'
    let s:pinyin_comb['bo'] = '1i'
    let s:pinyin_comb['bu'] = '1j'
    let s:pinyin_comb['ca'] = 'h8'
    let s:pinyin_comb['cai'] = 'h9'
    let s:pinyin_comb['can'] = 'h0'
    let s:pinyin_comb['cang'] = 'h;'
    let s:pinyin_comb['cao'] = 'hl'
    let s:pinyin_comb['ce'] = 'hk'
    let s:pinyin_comb['cen'] = 'hp'
    let s:pinyin_comb['ceng'] = 'h/'
    let s:pinyin_comb['cha'] = 't8'
    let s:pinyin_comb['chai'] = 't9'
    let s:pinyin_comb['chan'] = 't0'
    let s:pinyin_comb['chang'] = 't;'
    let s:pinyin_comb['chao'] = 'tl'
    let s:pinyin_comb['che'] = 'tk'
    let s:pinyin_comb['chen'] = 'tp'
    let s:pinyin_comb['cheng'] = 't/'
    let s:pinyin_comb['chi'] = 't'
    let s:pinyin_comb['chong'] = 'tj/'
    let s:pinyin_comb['chou'] = 't.'
    let s:pinyin_comb['chu'] = 'tj'
    let s:pinyin_comb['chua'] = 'tj8'
    let s:pinyin_comb['chuai'] = 'tj9'
    let s:pinyin_comb['chuan'] = 'tj0'
    let s:pinyin_comb['chuang'] = 'tj;'
    let s:pinyin_comb['chui'] = 'tjo'
    let s:pinyin_comb['chun'] = 'tjp'
    let s:pinyin_comb['chuo'] = 'tji'
    let s:pinyin_comb['ci'] = 'h'
    let s:pinyin_comb['cong'] = 'hj/'
    let s:pinyin_comb['cou'] = 'h.'
    let s:pinyin_comb['cu'] = 'hj'
    let s:pinyin_comb['cuan'] = 'hj0'
    let s:pinyin_comb['cui'] = 'hjo'
    let s:pinyin_comb['cun'] = 'hjp'
    let s:pinyin_comb['cuo'] = 'hji'
    let s:pinyin_comb['da'] = '28'
    let s:pinyin_comb['dai'] = '29'
    let s:pinyin_comb['dan'] = '20'
    let s:pinyin_comb['dang'] = '2;'
    let s:pinyin_comb['dao'] = '2l'
    let s:pinyin_comb['de'] = '2k'
    let s:pinyin_comb['dei'] = '2o'
    let s:pinyin_comb['deng'] = '2/'
    let s:pinyin_comb['di'] = '2u'
    let s:pinyin_comb['dia'] = '2u8'
    let s:pinyin_comb['dian'] = '2u0'
    let s:pinyin_comb['diao'] = '2ul'
    let s:pinyin_comb['die'] = '2u,'
    let s:pinyin_comb['ding'] = '2u/'
    let s:pinyin_comb['diu'] = '2u.'
    let s:pinyin_comb['dong'] = '2j/'
    let s:pinyin_comb['dou'] = '2.'
    let s:pinyin_comb['du'] = '2j'
    let s:pinyin_comb['duan'] = '2j0'
    let s:pinyin_comb['dui'] = '2jo'
    let s:pinyin_comb['dun'] = '2jp'
    let s:pinyin_comb['duo'] = '2ji'
    let s:pinyin_comb['e'] = 'k'
    let s:pinyin_comb['ei'] = 'o'
    let s:pinyin_comb['en'] = 'p'
    let s:pinyin_comb['eng'] = '/'
    let s:pinyin_comb['er'] = '-'
    let s:pinyin_comb['fa'] = 'z8'
    let s:pinyin_comb['fan'] = 'z0'
    let s:pinyin_comb['fang'] = 'z;'
    let s:pinyin_comb['fei'] = 'zo'
    let s:pinyin_comb['fen'] = 'zp'
    let s:pinyin_comb['feng'] = 'z/'
    let s:pinyin_comb['fiao'] = 'zul'
    let s:pinyin_comb['fo'] = 'zi'
    let s:pinyin_comb['fou'] = 'z.'
    let s:pinyin_comb['fu'] = 'zj'
    let s:pinyin_comb['ga'] = 'e8'
    let s:pinyin_comb['gai'] = 'e9'
    let s:pinyin_comb['gan'] = 'e0'
    let s:pinyin_comb['gang'] = 'e;'
    let s:pinyin_comb['gao'] = 'el'
    let s:pinyin_comb['ge'] = 'ek'
    let s:pinyin_comb['gei'] = 'eo'
    let s:pinyin_comb['gen'] = 'ep'
    let s:pinyin_comb['geng'] = 'e/'
    let s:pinyin_comb['gong'] = 'ej/'
    let s:pinyin_comb['gou'] = 'e.'
    let s:pinyin_comb['gu'] = 'ej'
    let s:pinyin_comb['gua'] = 'ej8'
    let s:pinyin_comb['guai'] = 'ej9'
    let s:pinyin_comb['guan'] = 'ej0'
    let s:pinyin_comb['guang'] = 'ej;'
    let s:pinyin_comb['gui'] = 'ejo'
    let s:pinyin_comb['gun'] = 'ejp'
    let s:pinyin_comb['guo'] = 'eji'
    let s:pinyin_comb['ha'] = 'c8'
    let s:pinyin_comb['hai'] = 'c9'
    let s:pinyin_comb['han'] = 'c0'
    let s:pinyin_comb['hang'] = 'c;'
    let s:pinyin_comb['hao'] = 'cl'
    let s:pinyin_comb['he'] = 'ck'
    let s:pinyin_comb['hei'] = 'co'
    let s:pinyin_comb['hen'] = 'cp'
    let s:pinyin_comb['heng'] = 'c/'
    let s:pinyin_comb['hong'] = 'cj/'
    let s:pinyin_comb['hou'] = 'c.'
    let s:pinyin_comb['hu'] = 'cj'
    let s:pinyin_comb['hua'] = 'cj8'
    let s:pinyin_comb['huai'] = 'cj9'
    let s:pinyin_comb['huan'] = 'cj0'
    let s:pinyin_comb['huang'] = 'cj;'
    let s:pinyin_comb['hui'] = 'cjo'
    let s:pinyin_comb['hun'] = 'cjp'
    let s:pinyin_comb['huo'] = 'cji'
    let s:pinyin_comb['ji'] = 'ru'
    let s:pinyin_comb['jia'] = 'ru8'
    let s:pinyin_comb['jian'] = 'ru0'
    let s:pinyin_comb['jiang'] = 'ru;'
    let s:pinyin_comb['jiao'] = 'rul'
    let s:pinyin_comb['jie'] = 'ru,'
    let s:pinyin_comb['jin'] = 'rup'
    let s:pinyin_comb['jing'] = 'ru/'
    let s:pinyin_comb['jiong'] = 'rm/'
    let s:pinyin_comb['jiu'] = 'ru.'
    let s:pinyin_comb['ju'] = 'rm'
    let s:pinyin_comb['juan'] = 'rm0'
    let s:pinyin_comb['jue'] = 'rm,'
    let s:pinyin_comb['jun'] = 'rmp'
    let s:pinyin_comb['ka'] = 'd8'
    let s:pinyin_comb['kai'] = 'd9'
    let s:pinyin_comb['kan'] = 'd0'
    let s:pinyin_comb['kang'] = 'd;'
    let s:pinyin_comb['kao'] = 'dl'
    let s:pinyin_comb['ke'] = 'dk'
    let s:pinyin_comb['ken'] = 'dp'
    let s:pinyin_comb['keng'] = 'd/'
    let s:pinyin_comb['kong'] = 'dj/'
    let s:pinyin_comb['kou'] = 'd.'
    let s:pinyin_comb['ku'] = 'dj'
    let s:pinyin_comb['kua'] = 'dj8'
    let s:pinyin_comb['kuai'] = 'dj9'
    let s:pinyin_comb['kuan'] = 'dj0'
    let s:pinyin_comb['kuang'] = 'dj;'
    let s:pinyin_comb['kui'] = 'djo'
    let s:pinyin_comb['kun'] = 'djp'
    let s:pinyin_comb['kuo'] = 'dji'
    let s:pinyin_comb['la'] = 'x8'
    let s:pinyin_comb['lai'] = 'x9'
    let s:pinyin_comb['lan'] = 'x0'
    let s:pinyin_comb['lang'] = 'x;'
    let s:pinyin_comb['lao'] = 'xl'
    let s:pinyin_comb['le'] = 'xk'
    let s:pinyin_comb['lei'] = 'xo'
    let s:pinyin_comb['leng'] = 'x/'
    let s:pinyin_comb['li'] = 'xu'
    let s:pinyin_comb['lia'] = 'xu8'
    let s:pinyin_comb['lian'] = 'xu0'
    let s:pinyin_comb['liang'] = 'xu;'
    let s:pinyin_comb['liao'] = 'xul'
    let s:pinyin_comb['lie'] = 'xu,'
    let s:pinyin_comb['lin'] = 'xup'
    let s:pinyin_comb['ling'] = 'xu/'
    let s:pinyin_comb['liu'] = 'xu.'
    let s:pinyin_comb['lo'] = 'xi'
    let s:pinyin_comb['long'] = 'xj/'
    let s:pinyin_comb['lou'] = 'x.'
    let s:pinyin_comb['lu'] = 'xj'
    let s:pinyin_comb['luan'] = 'xj0'
    let s:pinyin_comb['lun'] = 'xjp'
    let s:pinyin_comb['luo'] = 'xji'
    let s:pinyin_comb['lyuan'] = 'xm0'
    let s:pinyin_comb['lü'] = 'xm'
    let s:pinyin_comb['lüe'] = 'xm,'
    let s:pinyin_comb['ma'] = 'a8'
    let s:pinyin_comb['mai'] = 'a9'
    let s:pinyin_comb['man'] = 'a0'
    let s:pinyin_comb['mang'] = 'a;'
    let s:pinyin_comb['mao'] = 'al'
    let s:pinyin_comb['me'] = 'ak'
    let s:pinyin_comb['mei'] = 'ao'
    let s:pinyin_comb['men'] = 'ap'
    let s:pinyin_comb['meng'] = 'a/'
    let s:pinyin_comb['mi'] = 'au'
    let s:pinyin_comb['mian'] = 'au0'
    let s:pinyin_comb['miao'] = 'aul'
    let s:pinyin_comb['mie'] = 'au,'
    let s:pinyin_comb['min'] = 'aup'
    let s:pinyin_comb['ming'] = 'au/'
    let s:pinyin_comb['miu'] = 'au.'
    let s:pinyin_comb['mo'] = 'ai'
    let s:pinyin_comb['mou'] = 'a.'
    let s:pinyin_comb['mu'] = 'aj'
    let s:pinyin_comb['na'] = 's8'
    let s:pinyin_comb['nai'] = 's9'
    let s:pinyin_comb['nan'] = 's0'
    let s:pinyin_comb['nang'] = 's;'
    let s:pinyin_comb['nao'] = 'sl'
    let s:pinyin_comb['ne'] = 'sk'
    let s:pinyin_comb['nei'] = 'so'
    let s:pinyin_comb['nen'] = 'sp'
    let s:pinyin_comb['neng'] = 's/'
    let s:pinyin_comb['ni'] = 'su'
    let s:pinyin_comb['nian'] = 'su0'
    let s:pinyin_comb['niang'] = 'su;'
    let s:pinyin_comb['niao'] = 'sul'
    let s:pinyin_comb['nie'] = 'su,'
    let s:pinyin_comb['nin'] = 'sup'
    let s:pinyin_comb['ning'] = 'su/'
    let s:pinyin_comb['niu'] = 'su.'
    let s:pinyin_comb['nong'] = 'sj/'
    let s:pinyin_comb['nou'] = 's.'
    let s:pinyin_comb['nu'] = 'sj'
    let s:pinyin_comb['nuan'] = 'sj0'
    let s:pinyin_comb['nuo'] = 'sji'
    let s:pinyin_comb['nü'] = 'sm'
    let s:pinyin_comb['nüe'] = 'sm,'
    let s:pinyin_comb['o'] = 'i'
    let s:pinyin_comb['ou'] = '.'
    let s:pinyin_comb['pa'] = 'q8'
    let s:pinyin_comb['pai'] = 'q9'
    let s:pinyin_comb['pan'] = 'q0'
    let s:pinyin_comb['pang'] = 'q;'
    let s:pinyin_comb['pao'] = 'ql'
    let s:pinyin_comb['pei'] = 'qo'
    let s:pinyin_comb['pen'] = 'qp'
    let s:pinyin_comb['peng'] = 'q/'
    let s:pinyin_comb['pi'] = 'qu'
    let s:pinyin_comb['pian'] = 'qu0'
    let s:pinyin_comb['piao'] = 'qul'
    let s:pinyin_comb['pie'] = 'qu,'
    let s:pinyin_comb['pin'] = 'qup'
    let s:pinyin_comb['ping'] = 'qu/'
    let s:pinyin_comb['po'] = 'qi'
    let s:pinyin_comb['pou'] = 'q.'
    let s:pinyin_comb['pu'] = 'qj'
    let s:pinyin_comb['qi'] = 'fu'
    let s:pinyin_comb['qia'] = 'fu8'
    let s:pinyin_comb['qian'] = 'fu0'
    let s:pinyin_comb['qiang'] = 'fu;'
    let s:pinyin_comb['qiao'] = 'ful'
    let s:pinyin_comb['qie'] = 'fu,'
    let s:pinyin_comb['qin'] = 'fup'
    let s:pinyin_comb['qing'] = 'fu/'
    let s:pinyin_comb['qiong'] = 'fm/'
    let s:pinyin_comb['qiu'] = 'fu.'
    let s:pinyin_comb['qu'] = 'fm'
    let s:pinyin_comb['quan'] = 'fm0'
    let s:pinyin_comb['que'] = 'fm,'
    let s:pinyin_comb['qun'] = 'fmp'
    let s:pinyin_comb['ran'] = 'b0'
    let s:pinyin_comb['rang'] = 'b;'
    let s:pinyin_comb['rao'] = 'bl'
    let s:pinyin_comb['re'] = 'bk'
    let s:pinyin_comb['ren'] = 'bp'
    let s:pinyin_comb['reng'] = 'b/'
    let s:pinyin_comb['ri'] = 'b'
    let s:pinyin_comb['rong'] = 'bj/'
    let s:pinyin_comb['rou'] = 'b.'
    let s:pinyin_comb['ru'] = 'bj'
    let s:pinyin_comb['ruan'] = 'bj0'
    let s:pinyin_comb['rui'] = 'bjo'
    let s:pinyin_comb['run'] = 'bjp'
    let s:pinyin_comb['ruo'] = 'bji'
    let s:pinyin_comb['sa'] = 'n8'
    let s:pinyin_comb['sai'] = 'n9'
    let s:pinyin_comb['san'] = 'n0'
    let s:pinyin_comb['sang'] = 'n;'
    let s:pinyin_comb['sao'] = 'nl'
    let s:pinyin_comb['se'] = 'nk'
    let s:pinyin_comb['sen'] = 'np'
    let s:pinyin_comb['seng'] = 'n/'
    let s:pinyin_comb['sha'] = 'g8'
    let s:pinyin_comb['shai'] = 'g9'
    let s:pinyin_comb['shan'] = 'g0'
    let s:pinyin_comb['shang'] = 'g;'
    let s:pinyin_comb['shao'] = 'gl'
    let s:pinyin_comb['she'] = 'gk'
    let s:pinyin_comb['shei'] = 'go'
    let s:pinyin_comb['shen'] = 'gp'
    let s:pinyin_comb['sheng'] = 'g/'
    let s:pinyin_comb['shi'] = 'g'
    let s:pinyin_comb['shou'] = 'g.'
    let s:pinyin_comb['shu'] = 'gj'
    let s:pinyin_comb['shua'] = 'gj8'
    let s:pinyin_comb['shuai'] = 'gj9'
    let s:pinyin_comb['shuan'] = 'gj0'
    let s:pinyin_comb['shuang'] = 'gj;'
    let s:pinyin_comb['shui'] = 'gjo'
    let s:pinyin_comb['shun'] = 'gjp'
    let s:pinyin_comb['shuo'] = 'gji'
    let s:pinyin_comb['si'] = 'n'
    let s:pinyin_comb['song'] = 'nj/'
    let s:pinyin_comb['sou'] = 'n.'
    let s:pinyin_comb['su'] = 'nj'
    let s:pinyin_comb['suan'] = 'nj0'
    let s:pinyin_comb['sui'] = 'njo'
    let s:pinyin_comb['sun'] = 'njp'
    let s:pinyin_comb['suo'] = 'nji'
    let s:pinyin_comb['ta'] = 'w8'
    let s:pinyin_comb['tai'] = 'w9'
    let s:pinyin_comb['tan'] = 'w0'
    let s:pinyin_comb['tang'] = 'w;'
    let s:pinyin_comb['tao'] = 'wl'
    let s:pinyin_comb['te'] = 'wk'
    let s:pinyin_comb['teng'] = 'w/'
    let s:pinyin_comb['ti'] = 'wu'
    let s:pinyin_comb['tian'] = 'wu0'
    let s:pinyin_comb['tiao'] = 'wul'
    let s:pinyin_comb['tie'] = 'wu,'
    let s:pinyin_comb['ting'] = 'wu/'
    let s:pinyin_comb['tong'] = 'wj/'
    let s:pinyin_comb['tou'] = 'w.'
    let s:pinyin_comb['tu'] = 'wj'
    let s:pinyin_comb['tuan'] = 'wj0'
    let s:pinyin_comb['tui'] = 'wjo'
    let s:pinyin_comb['tun'] = 'wjp'
    let s:pinyin_comb['tuo'] = 'wji'
    let s:pinyin_comb['wa'] = 'j8'
    let s:pinyin_comb['wai'] = 'j9'
    let s:pinyin_comb['wan'] = 'j0'
    let s:pinyin_comb['wang'] = 'j;'
    let s:pinyin_comb['wei'] = 'jo'
    let s:pinyin_comb['wen'] = 'jp'
    let s:pinyin_comb['weng'] = 'j/'
    let s:pinyin_comb['wo'] = 'ji'
    let s:pinyin_comb['wu'] = 'j'
    let s:pinyin_comb['xi'] = 'vu'
    let s:pinyin_comb['xia'] = 'vu8'
    let s:pinyin_comb['xian'] = 'vu0'
    let s:pinyin_comb['xiang'] = 'vu;'
    let s:pinyin_comb['xiao'] = 'vul'
    let s:pinyin_comb['xie'] = 'vu,'
    let s:pinyin_comb['xin'] = 'vup'
    let s:pinyin_comb['xing'] = 'vu/'
    let s:pinyin_comb['xiong'] = 'vm/'
    let s:pinyin_comb['xiu'] = 'vu.'
    let s:pinyin_comb['xu'] = 'vm'
    let s:pinyin_comb['xuan'] = 'vm0'
    let s:pinyin_comb['xue'] = 'vm,'
    let s:pinyin_comb['xun'] = 'vmp'
    let s:pinyin_comb['ya'] = 'u8'
    let s:pinyin_comb['yai'] = 'u9'
    let s:pinyin_comb['yan'] = 'u0'
    let s:pinyin_comb['yang'] = 'u;'
    let s:pinyin_comb['yao'] = 'ul'
    let s:pinyin_comb['ye'] = 'u,'
    let s:pinyin_comb['yi'] = 'u'
    let s:pinyin_comb['yin'] = 'up'
    let s:pinyin_comb['ying'] = 'u/'
    let s:pinyin_comb['yo'] = 'ui'
    let s:pinyin_comb['yong'] = 'm/'
    let s:pinyin_comb['you'] = 'u.'
    let s:pinyin_comb['yu'] = 'm'
    let s:pinyin_comb['yuan'] = 'm0'
    let s:pinyin_comb['yue'] = 'm,'
    let s:pinyin_comb['yun'] = 'mp'
    let s:pinyin_comb['za'] = 'y8'
    let s:pinyin_comb['zai'] = 'y9'
    let s:pinyin_comb['zan'] = 'y0'
    let s:pinyin_comb['zang'] = 'y;'
    let s:pinyin_comb['zao'] = 'yl'
    let s:pinyin_comb['ze'] = 'yk'
    let s:pinyin_comb['zei'] = 'yo'
    let s:pinyin_comb['zen'] = 'yp'
    let s:pinyin_comb['zeng'] = 'y/'
    let s:pinyin_comb['zha'] = '58'
    let s:pinyin_comb['zhai'] = '59'
    let s:pinyin_comb['zhan'] = '50'
    let s:pinyin_comb['zhang'] = '5;'
    let s:pinyin_comb['zhao'] = '5l'
    let s:pinyin_comb['zhe'] = '5k'
    let s:pinyin_comb['zhen'] = '5p'
    let s:pinyin_comb['zheng'] = '5/'
    let s:pinyin_comb['zhi'] = '5'
    let s:pinyin_comb['zhong'] = '5j/'
    let s:pinyin_comb['zhou'] = '5.'
    let s:pinyin_comb['zhu'] = '5j'
    let s:pinyin_comb['zhua'] = '5j8'
    let s:pinyin_comb['zhuai'] = '5j9'
    let s:pinyin_comb['zhuan'] = '5j0'
    let s:pinyin_comb['zhuang'] = '5j;'
    let s:pinyin_comb['zhui'] = '5jo'
    let s:pinyin_comb['zhun'] = '5jp'
    let s:pinyin_comb['zhuo'] = '5ji'
    let s:pinyin_comb['zi'] = 'y'
    let s:pinyin_comb['zong'] = 'yj/'
    let s:pinyin_comb['zou'] = 'y.'
    let s:pinyin_comb['zu'] = 'yj'
    let s:pinyin_comb['zuan'] = 'yj0'
    let s:pinyin_comb['zui'] = 'yjo'
    let s:pinyin_comb['zun'] = 'yjp'
    let s:pinyin_comb['zuo'] = 'yji'
    " }}}
endfunction


function! s:pinyin2code_choice(key)
    return sort(map(filter(keys(s:pinyin_comb), 'v:val =~# ''^'' . a:key'), 's:pinyin_comb[(v:val)]'))
endfunction


function! pinyin_utils#ParsePinyinStr (pinyin_str)
    if a:pinyin_str == ''
        return {'pinyin': [], 'code': []}
    endif

    try
        let l:char_list = split(a:pinyin_str, '\zs')
        let l:pinyin_list = []
        let l:code_list = []       " results
        let l:acc = ''          " one char result
        for l:char in l:char_list
            let l:key = l:acc . l:char
            if l:char == ' ' && l:acc != ''
                call add(l:pinyin_list, l:acc)
                call add(l:code_list, s:pinyin2code_choice(l:acc))
                let l:acc = ''
            elseif l:acc == '' || len(s:pinyin2code_choice(l:key))
                let l:acc = l:acc . l:char
            else
                call add(l:pinyin_list, l:acc)
                call add(l:code_list, s:pinyin2code_choice(l:acc))
                let l:acc = l:char
            endif
        endfor
        if l:acc != ''
            call add(l:pinyin_list, l:acc)
            call add(l:code_list, s:pinyin2code_choice(l:acc))
        endif
        return {'pinyin': (l:pinyin_list), 'code': (l:code_list)}
    catch
        call s:log('//', 'Cannot parse pinyin str: "'. a:pinyin_str .'"')
        call s:log('||', v:throwpoint)
        call s:log('\\', v:exception)
        return {'pinyin': [], 'code': []}
    endtry
endfunction


call s:Init()
