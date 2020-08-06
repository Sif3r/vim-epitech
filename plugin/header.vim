let s:comType = {
            \ 'c': {'s': '/*', 'c': '** ', 'e': '*/'},
            \ 'css': {'s': '/*', 'c': '** ', 'e': '*/'},
            \ 'cpp': {'s': '/*', 'c': '** ', 'e': '*/'},
            \ 'pov': {'s': '//', 'c': '// ', 'e': '//'},
            \ 'java': {'s': '//', 'c': '// ', 'e': '//'},
            \ 'latex': {'s': '%%', 'c': '%% ', 'e': '%%'},
            \ 'lisp': {'s': ';;', 'c': ';; ', 'e': ';;'},
            \ 'xdefault': {'s': '!!', 'c': '!! ', 'e': '!!'},
            \ 'pascal': {'s': '{ ', 'c': '   ', 'e': '}'},
            \ 'make': {'s': '##', 'c': '## ', 'e': '##'},
            \ 'text': {'s': '##', 'c': '## ', 'e': '##'},
            \ 'fundamental': {'s': '  ', 'c': '   ', 'e': '  '},
            \ 'html': {'s': '<!--', 'c': '  -- ', 'e': '-->'},
            \ 'php': {'s': '#!/usr/bin/env php\n<?php', 'c': '** ', 'e': '*/'},
            \ 'sscript': {'s': '#!/usr/bin/env bash', 'c': '## ', 'e': '##'},
            \ 'perl': {'s': '#!/usr/bin/env perl', 'c': '## ', 'e': '##'},
            \ 'python': {'s': '#!/usr/bin/env python3', 'c': '## ', 'e': '##'},
            \ 'ruby': {'s': '#!/usr/bin/env ruby', 'c': '## ', 'e': '##'},
            \ 'node': {'s': '#!/usr/bin/env node', 'c': '** ', 'e': '*/'},
            \ 'haskell': {'s': '{-', 'c': '-- ', 'e': '-}'},
            \}


function! s:Take_project_name()
    call inputsave()
    let s:name = input("Type project name (RETURN to confirm): ")
    call inputrestore()
    if s:name == ''
        "take the name of the git repo
        silent! !git rev-parse --is-inside-work-tree
        if v:shell_error == 0
            let s:name = fnamemodify(system("git rev-parse --show-toplevel | tr -d '\\n'"), ':t')
        else
            "take the name of the current folder
            let s:name = expand("%:p:h:t")
        endif
        redraw
    endif
    return s:name
endfunction

function! s:File_description()
    call inputsave()
    let s:name = input("Type short file description (RETURN to confirm): ")
    call inputrestore()
    if s:name == ''
        "take the filename
        let s:name = fnamemodify(expand('%s'),':t')
    endif
    return s:name
endfunction

function! s:Script_file_header(project_name, file_descr, scom, ccom, ecom)
    let ret = append(0, s:scom)
    let ret = append(1, s:ccom)
    let ret = append(2, s:ccom . "EPITECH PROJECT, " . strftime("%Y"))
    let ret = append(3, s:ccom . s:project_name)
    let ret = append(4, s:ccom . "File description:")
    let ret = append(5, s:ccom . s:file_descr)
    let ret = append(6, s:ecom)
    let ret = append(7, '')
endfunction

function! s:Header_file(project_name, file_descr, scom, ccom, ecom)
    let ret = append(0, s:scom)
    let ret = append(1, s:ccom . "EPITECH PROJECT, " . strftime("%Y"))
    let ret = append(2, s:ccom . s:project_name)
    let ret = append(3, s:ccom . "File description:")
    let ret = append(4, s:ccom . s:file_descr)
    let ret = append(5, s:ecom)
    let ret = append(6, '')
endfunction

function! s:Epi_header()
    let s:project_name = s:Take_project_name()
    let s:file_descr = s:File_description()
    let s:scom = s:comType[&filetype]['s']
    let s:ccom = s:comType[&filetype]['c']
    let s:ecom = s:comType[&filetype]['e']

    if s:scom[0] == '#' && s:scom[1] == '!'
        call s:Script_file_header(s:project_name, s:file_descr, s:scom, s:ccom, s:ecom)
    else
        call s:Header_file(s:project_name, s:file_descr, s:scom, s:ccom, s:ecom)
    endif
endfunction
command! EpiHeader call s:Epi_header()
