" Vim syntax file
" Language:  YAML (YAML Ain't Markup Language)
" Maintainer:Chase Colman <chase@colman.io>
" Author:	   Igor Vergeichik <iverg@mail.ru>
" Author:    Nikolai Weibull <now@bitwi.se>
" Sponsor:   Tom Sawyer <transfire@gmail.com>
" Latest Revision: 2013-12-06

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'yaml'
endif

syn keyword yamlTodo            contained TODO FIXME XXX NOTE

syn region  yamlDocumentHeader  start='---' end='$' contains=yamlDirective
syn match   yamlDocumentEnd     '\.\.\.'
syn match   yamlDirective       contained '%[^:]\+:.\+'

syn region  yamlComment         display oneline start='\%(^\|\s\)#' end='$'
                                \ contains=yamlTodo,@Spell
"syn region yamlMapping	        start="\w+:\s*\w+" end="$"
                                \ contains=yamlKey,yamlValue
syn match   yamlNodeProperty    "!\%(![^\\^%     ]\+\|[^!][^:/   ]*\)"
syn match   yamlAnchor          "&.\+"
syn match   yamlAlias           "\*.\+"
syn match   yamlDelimiter       "[-,:]"
syn match   yamlBlock           "[\[\]\{\}>|]"
syn match   yamlOperator        '[?+-]'
syn match   yamlKey             '\w\+\(\s\+\w\+\)*\ze\s*:'
syn match   yamlScalar          '\(\(|\|>\)\s*\n*\r*\)\@<=\(\s\+\).*\n*\r*\(\(\3\).*\n\)*'

" Predefined data types

" Yaml Integer type
syn match   yamlInteger	        display "[-+]\?\(0\|[1-9][0-9,]*\)"
syn match   yamlInteger	        display "[-+]\?0[xX][0-9a-fA-F,]\+"

" floating point number
syn match   yamlFloating		display "\<\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match   yamlFloating		display "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match   yamlFloating		display "\<\d\+e[-+]\=\d\+[fl]\=\>"
syn match   yamlFloating		display "\(([+-]\?inf)\)\|\((NaN)\)"
" TODO: sexagecimal and fixed (20:30.15 and 1,230.15)
syn match   yamlNumber          display
                                \ '\<[+-]\=\d\+\%(\.\d\+\%([eE][+-]\=\d\+\)\=\)\='
syn match   yamlNumber          display '0\o\+'
syn match   yamlNumber          display '0x\x\+'
syn match   yamlNumber          display '([+-]\=[iI]nf)'

" Boolean
syn keyword yamlBoolean         true True TRUE false False FALSE yes Yes YES no No NO on On ON off Off OFF
syn match   yamlBoolean         ":.*\zs\W[+-]\(\W\|$\)"

syn match   yamlConstant        '\<[~yn]\>'

" Null
syn keyword yamlNull            null Null NULL nil Nil NIL
syn match   yamlNull            "\W[~]\(\W\|$\)"

syn match   yamlTime            "\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d.\?Z"
syn match   yamlTime            "\d\d\d\d-\d\d-\d\dt\d\d:\d\d:\d\d.\d\d-\d\d:\d\d"
syn match   yamlTime            "\d\d\d\d-\d\d-\d\d\s\d\d:\d\d:\d\d.\d\d\s-\d\d:\d\d"
syn match   yamlTimestamp       '\d\d\d\d-\%(1[0-2]\|\d\)-\%(3[0-2]\|2\d\|1\d\|\d\)\%( \%([01]\d\|2[0-3]\):[0-5]\d:[0-5]\d.\d\d [+-]\%([01]\d\|2[0-3]\):[0-5]\d\|t\%([01]\d\|2[0-3]\):[0-5]\d:[0-5]\d.\d\d[+-]\%([01]\d\|2[0-3]\):[0-5]\d\|T\%([01]\d\|2[0-3]\):[0-5]\d:[0-5]\d.\dZ\)\='

" Single and double quoted scalars
syn region  yamlString	        start="'" end="'" skip="\\'"
                                \ contains=yamlSingleEscape
syn region  yamlString	        start='"' end='"' skip='\\"' 
                                \ contains=yamlEscape

" Escaped symbols
" every charater preceeded with slash is escaped one
syn match   yamlEscape		    "\\."
" 2,4 and 8-digit escapes
syn match   yamlEscape		    "\\\(x\x\{2\}\|u\x\{4\}\|U\x\{8\}\)"
syn match   yamlEscape          contained display +\\[\\"abefnrtv^0_ NLP]+
syn match   yamlEscape          contained display '\\x\x\{2}'
syn match   yamlEscape          contained display '\\u\x\{4}'
syn match   yamlEscape          contained display '\\U\x\{8}'
" TODO: how do we get 0x85, 0x2028, and 0x2029 into this?
syn match   yamlEscape          display '\\\%(\r\n\|[\r\n]\)'
syn match   yamlSingleEscape    contained display +''+

syn match   yamlKey		        "\w\+\ze\s*:"
syn match   yamlType		    "![^\s]\+\s\@="

if version >= 508 || !exist("did_yaml_syn")
  if version < 508
    let did_yaml_syn = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink yamlKey		        Identifier
  HiLink yamlType	        Type
  HiLink yamlInteger	        Number
  HiLink yamlFloating        Float
  HiLink yamlNumber          Number
  HiLink yamlEscape	        Special
  HiLink yamlSingleEscape    SpecialChar
  HiLink yamlComment	        Comment
  HiLink yamlBlock	        Operator
  HiLink yamlDelimiter	    Delimiter
  HiLink yamlString	        String
  HiLink yamlBoolean	        Boolean
  HiLink yamlNull	        Boolean
  HiLink yamlTime	        String
  HiLink yamlTodo            Todo
  HiLink yamlDocumentHeader  PreProc
  HiLink yamlDocumentEnd     PreProc
  HiLink yamlDirective       Keyword
  HiLink yamlNodeProperty    Type
  HiLink yamlAnchor          Type
  HiLink yamlAlias           Type
  HiLink yamlOperator        Operator
  HiLink yamlScalar          String
  HiLink yamlConstant        Constant
  HiLink yamlTimestamp       Number

  delcommand HiLink
endif

let b:current_syntax = "yaml"

if main_syntax == "yaml"
  unlet main_syntax
endif
