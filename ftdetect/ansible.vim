" Determine if normal YAML or Ansible YAML
" Language:         YAML (with Ansible)
" Maintainer:       Chase Colman <chase@colman.io>
" Latest Revision:  2013-12-09

fun! s:SetupAnsible()
  set filetype=ansible
  set comments=:#
  set commentstring=#\ %s
endfun

fun! s:SelectAnsible()
  let fp = expand("%:p")
  let dir = expand("%:p:h")
  " Check if buffer is file under any directory of a 'roles' directory
  if fp =~ 'roles/.*\.yml$'
    call s:SetupAnsible()
    return
  else
    " Check if subdirectories in buffer's directory match Ansible best practices
    if v:version < 704
      let directories=split(glob(fnameescape(dir).'/{,.}*/', 1), '\n')
    else
      let directories=glob(fnameescape(dir).'/{,.}*/', 1, 1)
    endif
    call map(directories, 'fnamemodify(v:val, ":h:t")')
    for dir in directories
      if dir =~ '\v^%(group_vars|host_vars|roles)$'
        call s:SetupAnsible()
        return
      endif
    endfor
  endif
endfun
autocmd BufNewFile,BufRead *.yml  call s:SelectAnsible()
