" Ansible/YAML filetype plugin
" Language:     YAML (with Ansible)
" Maintainer:   Benji Fisher, Ph.D. <benji@FisherFam.org>
" Version:	1.0
" Last Change:	Mon 10 Nov 2014
" URL:		http://FIXME

" Only do this when not done yet for this buffer.
if exists("b:did_ftplugin")
  finish
endif

" Avoid problems if running in 'compatible' mode.
let s:save_cpo = &cpo
set cpo&vim

let b:undo_ftplugin = "setl comments< commentstring<"

setlocal comments=:#
setlocal commentstring=#\ %s

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:sts=2:sw=2:
