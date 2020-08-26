function! s:insert_gates()
    let l:gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    let ret = append(0, "#ifndef " . l:gatename . "_")
    let ret = append(1, "#define " . l:gatename . "_")
    let ret = append(2, "")
    let ret = append(3, "#endif /* !" . l:gatename . "_ */")
    normal! dd
    normal! k
endfunction
autocmd BufNewFile *.{h,hpp} call s:insert_gates()
