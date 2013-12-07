" Vim syntax file
" Language:         YAML (with Ansible)
" Maintainer:       Chase Colman <chase@colman.io>
" Latest Revision:  2013-12-05

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'ansible'
endif

" Load YAML syntax
runtime! syntax/yaml.vim
unlet b:current_syntax

syn case match

syn cluster ansibleMappingKey contains=yamlBlockMappingKey,yamlFlowMappingKey

syn keyword ansibleRepeat with_items with_nested with_fileglob with_together with_subelements with_sequence with_random_choice until retries delay
      \with_first_found with_lines with_indexed_items with_flattened  contained containedin=@ansibleMappingKey
syn keyword ansibleConditional when changed_when  contained containedin=@ansibleMappingKey

" TODO: Implement Jinja2 template highlighting for when and interpolated strings

if version >= 508 || !exist("did_ansible_syn")
  if version < 508
    let did_ansible_syn = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink ansibleInterVariable Special
  HiLink ansibleConstant Function
  HiLink ansibleConditional Statement
  HiLink ansibleRepeat Repeat

  delcommand HiLink
endif

let b:current_syntax = 'ansible'

if main_syntax == 'ansible'
  unlet main_syntax
endif
