" Vim indent file
" Language:         YAML (with Ansible)
" Maintainer:       Chase Colman <chase@colman.io>
" Latest Revision:  2013-12-05

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

setlocal autoindent sw=2 ts=2 sts=2 et
setlocal indentexpr=GetYamlIndent()
setlocal indentkeys=o,O,*<Return>,!^F

function! GetYamlIndent()
  let prevlnum = v:lnum - 1
  if prevlnum == 0
    return 0
  endif
  let prevline = substitute(getline(prevlnum),'\s\+$','','')

  let indent = indent(prevlnum)
  let increase = indent + &sw

  if prevline =~ ':$'
    return increase
  elseif prevline =~ '^\s*-$'
    return increase
  elseif prevline =~ '^\s*-\s\+[^:]\+:.\+$'
    return increase
  else
    return indent
  endif
endfunction
