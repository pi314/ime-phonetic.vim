let s:this_filename = expand('<sfile>')
let s:repo_root_path = fnamemodify(s:this_filename, ':h:h')
let s:testcase_path = s:repo_root_path . '/tests'


function! Log (...)
    call call(function('ime#log'), ['phonetic-test'] + a:000)
endfunction


function! AssertEqual (func, params, exp_val)
    let v:errors = []
    let l:result = call(function(a:func), a:params)
    let l:arg_str = substitute(string(a:params), '\v^\[(.*)\]$', '\1', '')
    if l:result == a:exp_val
        call append('$', '  [pass] '. a:func .'('. l:arg_str .') == '. string(a:exp_val))
    else
        call append('$', '  [fail] Test function: '. a:func)
        call append('$', '         Argument: '. l:arg_str)
        call append('$', '         Result:   '. string(l:result))
        call append('$', '         Expected: '. string(a:exp_val))
    endif
endfunction


function! SourceFile (file)
    execute 'source '. s:repo_root_path .'/'. a:file
endfunction


function! Main ()
    let l:testcases = split(globpath(s:testcase_path, 'test_*.vim'), '\n')
    tabedit
    setlocal buftype=nofile
    file Testing
    call setline('$', 'Test cases:')
    call append('$', '')

    for l:testcase in l:testcases
        if l:testcase == s:this_filename
            continue
        endif
        call append('$', l:testcase)
        execute 'source '. l:testcase
        call append('$', '')
    endfor
endfunction


call Main()
