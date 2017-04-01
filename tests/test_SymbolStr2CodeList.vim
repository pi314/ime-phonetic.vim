call SourceFile('autoload/phonetic_utils.vim')

let s:test_func = 'phonetic_utils#SymbolStr2CodeList'

call AssertEqual(s:test_func, ['ㄘㄜˋ'],                    ['hk4'])
call AssertEqual(s:test_func, ['ㄘㄜˋㄕˋ'],                 ['hk4', 'g4'])
call AssertEqual(s:test_func, ['ㄕㄘㄜˋ'],                  ['g', 'hk4'])
call AssertEqual(s:test_func, ['ㄕㄘˋㄜ'],                  ['g', 'h4', 'k'])
call AssertEqual(s:test_func, ['ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ'],     ['hk4', 'g4', '5j/ ', 'jp6'])
call AssertEqual(s:test_func, ['ㄉㄨ'],                     ['2j'])
call AssertEqual(s:test_func, ['ㄨㄉ'],                     ['j', '2'])
call AssertEqual(s:test_func, ['ㄓㄧ'],                     ['5', 'u'])
call AssertEqual(s:test_func, ['ㄓㄧ'],                     [])
