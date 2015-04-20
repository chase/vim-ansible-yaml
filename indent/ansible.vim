" Vim indent file
" Language:        YAML (with Ansible)
" Maintainer:      Benji Fisher, Ph.D. <benji@FisherFam.org>
" Author:          Chase Colman <chase@colman.io>
" Version:         1.0
" Latest Revision: 2014-11-18
" URL:             https://github.com/chase/vim-ansible-yaml

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

setlocal sw=2 ts=2 sts=2 et
setlocal indentexpr=GetAnsibleIndent(v:lnum)
setlocal indentkeys=!^Fo,O,0#,<:>,-
setlocal nosmartindent

" Only define the function once.
if exists('*GetAnsibleIndent')
  finish
endif

" Check whether the user has set g:ansible_options["ignore_blank_lines"].
let s:ignore_blanks = !exists('g:ansible_options["ignore_blank_lines"]')
      \ || g:ansible_options["ignore_blank_lines"]

" Indent list entries with extra &sw?
let s:indent_list_entries = get(g:ansible_options, 'indent_list_entries', 1)


" Patterns used internally.
let s:pat_comment = '\v^\s*#'
let s:pat_dict_start = '\v^\s*[^:-]+:\s*$'
let s:pat_dict_item = '\v^\s*[^:-]+:\s*\S'
let s:pat_list_item = '\v^\s*-(\s|$)'


function s:get_prev_with_min_indent(lnum, pattern, ...)
  let lnum = a:lnum
  let minindent = a:0 ? a:1 : indent(a:lnum)
  while 1
    " XXX: does it make sense to handle s:ignore_blanks here?
    let lnum = s:ignore_blanks ? prevnonblank(lnum - 1) : lnum - 1
    if lnum == 0
      return 0
    endif
    if indent(lnum) > minindent
      continue
    endif
    if getline(lnum) =~ a:pattern
      return lnum
    endif
    " Decrease min indent, when there was a non-matching/-empty line.
    if getline(lnum) != ''
      let minindent -= &sw
    endif
  endwhile
  return 0
endfunction


" Get the start of the previous/current list.
function s:get_indent_for_li(lnum)
  let prevlnum = s:get_prev_with_min_indent(a:lnum, s:pat_list_item.'|'.s:pat_dict_start)
  if prevlnum > 0
    if getline(prevlnum) =~ s:pat_dict_start
      " Found the start of a (possible) list.
      return indent(prevlnum) + (s:indent_list_entries * &sw)
    endif
    " Found a list entry point.
    return indent(prevlnum)
  endif
  return -1
endfunction


function GetAnsibleIndent(lnum)
  let prevlnum = s:ignore_blanks ? prevnonblank(a:lnum - 1) : a:lnum - 1
  if prevlnum == 0
    return 0
  endif

  let curline = getline(a:lnum)
  let prevline = getline(prevlnum)
  let previndent = indent(prevlnum)
  let increase = previndent + &sw

  " Do not align comments.
  if prevline =~ s:pat_comment
      return previndent

  " Handle "dict:".
  elseif prevline =~ s:pat_dict_start
    if getline(a:lnum) =~ s:pat_list_item && !s:indent_list_entries
      return previndent
    endif
    return increase

  " Handle list-items.
  elseif getline(a:lnum) =~ s:pat_list_item
    return s:get_indent_for_li(a:lnum)

  " Align "foo:".
  " elseif getline(a:lnum) =~ '\v^\s*[^:-]+:\s*\S'
  elseif curline =~ '\v^\s*[^:-]+:(\s|$)'
      let l = s:get_prev_with_min_indent(a:lnum, s:pat_dict_item.'|'.s:pat_list_item.'|'.s:pat_dict_start)
      if l > 0
        let indent = indent(l)
        if getline(l) =~ s:pat_list_item
          " Special case: aligned to list item, needs to be indented.
          let indent += &sw
        endif
        return indent
      endif
    " Fallback
    return previndent

  elseif prevline =~ s:pat_list_item
    return increase

  elseif curline =~ s:pat_comment
      return -1

  " Fallback: align to previous line.
  else
    return previndent
  endif
endfunction
