" Determine if normal YAML or Ansible YAML
" Language:         YAML (with Ansible)
" Maintainer:       Chase Colman <chase@colman.io>
" Latest Revision:  2013-12-06

fun! s:SelectAnsible()
  let fp = expand("%:p")
  let dir = expand("%:p:h")
  " Check if buffer is file under any directory of a 'roles' directory
  if fp =~ 'roles/.*\.yml$'
    set filetype=ansible
    return
  else
    " Check if subdirectories in buffer's directory match Ansible best practices
    let directories=glob(fnameescape(dir).'/{,.}*/', 1, 1)
    call map(directories, 'fnamemodify(v:val, ":h:t")')
    for dir in directories
      if dir =~ '\v^%(group_vars|host_vars|roles)$'
        set filetype=ansible
        return
      endif
    endfor
  endif
endfun
autocmd BufNewFile,BufRead *.yml  call s:SelectAnsible()
