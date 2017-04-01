let s:this_filename = expand('<sfile>')
let s:repo_root_path = fnamemodify(s:this_filename, ':h:h')
let s:testcase_path = s:repo_root_path . '/tests'


function! Log (...)
    call call(function('ime#log'), ['phonetic-test'] + a:000)
endfunction


function! SourceFile (file)
    execute 'source '. s:repo_root_path .'/'. a:file
endfunction


function! Main ()
    let l:testcases = split(globpath(s:testcase_path, 'test_*.vim'), '\n')
    for l:testcase in l:testcases
        if l:testcase == s:this_filename
            continue
        endif
        execute 'source '. l:testcase
    endfor
endfunction


call Main()
