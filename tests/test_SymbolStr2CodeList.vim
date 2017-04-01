call SourceFile('autoload/phonetic_utils.vim')

call Log('[Test] Test_SymbolStr2CodeList() starts')
let s:testcases = [
    \ ['ㄘㄜˋ',                     ['hk4']],
    \ ['ㄘㄜˋㄕˋ',                  ['hk4', 'g4']],
    \ ['ㄕㄘㄜˋ',                   ['g', 'hk4']],
    \ ['ㄕㄘˋㄜ',                   ['g', 'h4', 'k']],
    \ ['ㄘㄜˋㄕˋㄓㄨㄥ ㄨㄣˊ',      ['hk4', 'g4', '5j/ ', 'jp6']],
    \ ['ㄉㄨ',                      ['2j']],
    \ ['ㄨㄉ',                      ['j', '2']],
    \ ['ㄓㄧ',                      ['5', 'u']],
    \ ]
for s:idx in range(len(s:testcases))
    call Log('Test case', s:idx)
    let v:errors = []
    let [s:data, s:result] = s:testcases[(s:idx)]
    call assert_equal(phonetic_utils#SymbolStr2CodeList(s:data), s:result)
    for s:msg in v:errors
        call Log(s:msg)
    endfor
    if len(v:errors) == 0
        call Log('Pass')
    endif
endfor
call Log('[Test] Test_SymbolStr2CodeList() ends')
