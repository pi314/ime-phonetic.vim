call SourceFile('autoload/phonetic_utils.vim')

call Log('[Test] Test_CodeList2SymbolStr() starts')
let s:testcases = [
    \ [[],                              ''],
    \ [['hk4'],                         'ㄘㄜˋ'],
    \ [['hk4', 'g4'],                   'ㄘㄜˋㄕˋ'],
    \ [['g ', 'hk4'],                   'ㄕ ㄘㄜˋ'],
    \ [['hk4', 'g4', '5j/ ', 'jp6'],    'ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ'],
    \ ]
for s:idx in range(len(s:testcases))
    call Log('Test case', s:idx)
    let v:errors = []
    let [s:data, s:result] = s:testcases[(s:idx)]
    call assert_equal(phonetic_utils#CodeList2SymbolStr(s:data), s:result)
    for s:msg in v:errors
        call Log(s:msg)
    endfor
    if len(v:errors) == 0
        call Log('Pass')
    endif
endfor
call Log('[Test] Test_CodeList2SymbolStr() ends')
