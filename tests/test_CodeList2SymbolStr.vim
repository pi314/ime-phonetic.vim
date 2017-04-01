call SourceFile('autoload/phonetic_utils.vim')

let s:test_func = 'phonetic_utils#CodeList2SymbolStr'

call AssertEqual(s:test_func, [[]], '')
call AssertEqual(s:test_func, [['hk4']],                         'ㄘㄜˋ')
call AssertEqual(s:test_func, [['hk4', 'g4']],                   'ㄘㄜˋㄕˋ')
call AssertEqual(s:test_func, [['g ', 'hk4']],                   'ㄕ ㄘㄜˋ')
call AssertEqual(s:test_func, [['hk4', 'g4', '5j/ ', 'jp6']],    'ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ')
