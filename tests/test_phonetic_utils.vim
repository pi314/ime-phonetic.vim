UTSuite phonetic_utils
let s:test_func = 'phonetic_utils#SymbolStr2CodeList'

function! s:Test_SymbolStr2CodeList()
    let s:testee = function('phonetic_utils#SymbolStr2CodeList')
    AssertEquals(s:testee('ㄘㄜˋ'),                    ['hk4'])
    AssertEquals(s:testee('ㄘㄜˋㄕˋ'),                 ['hk4', 'g4'])
    AssertEquals(s:testee('ㄕㄘㄜˋ'),                  ['g', 'hk4'])
    AssertEquals(s:testee('ㄕㄘˋㄜ'),                  ['g', 'h4', 'k'])
    AssertEquals(s:testee('ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ'),     ['hk4', 'g4', '5j/ ', 'jp6'])
    AssertEquals(s:testee('ㄉㄨ'),                     ['2j'])
    AssertEquals(s:testee('ㄨㄉ'),                     ['j', '2'])
    AssertEquals(s:testee('ㄓㄧ'),                     ['5', 'u'])
endfunction


function! s:Test_CodeList2SymbolStr()
    let s:testee = function('phonetic_utils#CodeList2SymbolStr')
    AssertEquals(s:testee([]), '')
    AssertEquals(s:testee(['hk4']),                         'ㄘㄜˋ')
    AssertEquals(s:testee(['hk4', 'g4']),                   'ㄘㄜˋㄕˋ')
    AssertEquals(s:testee(['g ', 'hk4']),                   'ㄕ ㄘㄜˋ')
    AssertEquals(s:testee(['hk4', 'g4', '5j/ ', 'jp6']),    'ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ')
endfunction
