" Determine if normal YAML or Ansible YAML
" Language:        YAML (with Ansible)
" Maintainer:      Benji Fisher, Ph.D. <benji@FisherFam.org>
" Author:          Chase Colman <chase@colman.io>
" Version:         1.0
" Latest Revision: 2014-11-10
" URL:             https://github.com/chase/vim-ansible-yaml

autocmd BufNewFile,BufRead *.yml  call s:SelectAnsible()

fun! s:SelectAnsible()
  let fp = expand("<afile>:p")
  let dir = expand("<afile>:p:h")

  " Check if buffer is file under any directory of a 'roles' directory
  if fp =~ '/roles/.*\.yml$'
    set filetype=ansible
    return
  endif

  " Check if subdirectories in buffer's directory match Ansible best practices
  if v:version < 704
    let directories=split(glob(fnameescape(dir) . '/{,.}*/', 1), '\n')
  else
    let directories=glob(fnameescape(dir) . '/{,.}*/', 1, 1)
  endif

  call map(directories, 'fnamemodify(v:val, ":h:t")')

  for dir in directories
    if dir =~ '\v^%(group_vars|host_vars|roles)$'
      set filetype=ansible
      return
    endif
  endfor
endfun
