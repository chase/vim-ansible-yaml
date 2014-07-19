" Vim syntax file
" Language:  YAML (YAML Ain't Markup Language)
" Maintainer:Chase Colman <chase@colman.io>
" Author:	   Igor Vergeichik <iverg@mail.ru>
" Author:    Nikolai Weibull <now@bitwi.se>
" Sponsor:   Tom Sawyer <transfire@gmail.com>
" Latest Revision: 2014-06-28

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'yaml'
endif

let s:cpo_save = &cpo
set cpo&vim
setl re=0

" Allows keyword matches containing -
setl iskeyword+=-

syn keyword yamlTodo            contained TODO FIXME XXX NOTE

syn region  yamlDocumentHeader  start='---' end='$' contains=yamlDirective
syn match   yamlDocumentEnd     '\.\.\.'
syn match   yamlDirective       contained '%[^:]\+:.\+'

syn region  yamlComment         display oneline start='\%(^\|\s\)#' end='$'
                                \ contains=yamlTodo,@Spell
syn match   yamlNodeProperty    "!\%(![^\\^%     ]\+\|[^!][^:/   ]*\)"
syn match   yamlAnchor          "&.\+"
syn match   yamlAlias           "\*.\+"
syn match   yamlDelimiter       "[-,:]\s*" containedin=yamlKey

syn match   yamlBlock           "[\[\]\{\}>|]"
syn match   yamlOperator        '[?+-]'
syn region  yamlMapping        start='\w\+\%(\s*\w\+\)*\s*\ze:' end='$' keepend oneline contains=yamlKey
syn match   yamlScalar         '\%(\W*\w\+\)\{2,}' contained
syn match   yamlValue          transparent '\w\+\s*$' contained
      \ contains=yamlInteger,yamlFloating,yamlNumber,yamlBoolean,yamlConstant,yamlNull,yamlTime
syn match   yamlKey            '\w\+\%(\s*\w\+\)*\s*:' contained nextgroup=yamlScalar,yamlValue

" Predefined data types

" Yaml Integer type
syn match   yamlInteger	        "\<[-+]\?\(0\|[1-9][0-9,]*\)\>" contained
syn match   yamlInteger	        "\<[-+]\?0[xX][0-9a-fA-F,]\+\>" contained

" floating point number
syn match   yamlFloating		"\<\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\>" contained
syn match   yamlFloating		"\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>" contained
syn match   yamlFloating		"\<\d\+e[-+]\=\d\+[fl]\=\>" contained
syn match   yamlFloating		"\<\(([+-]\?inf)\)\|\((NaN)\)\>" contained
syn match   yamlNumber      '\<[+-]\=\d\+\%(\.\d\+\%([eE][+-]\=\d\+\)\=\)\=\>' contained
syn match   yamlNumber      '\<0\o\+\>' contained
syn match   yamlNumber      '\<0x\x\+\>' contained
syn match   yamlNumber      '\<([+-]\=[iI]nf)\>' contained

" Boolean
syn keyword yamlBoolean         true True TRUE false False FALSE yes Yes YES no No NO on On ON off Off OFF contained
syn match   yamlBoolean         ":.*\zs\W[+-]\(\W\|$\)" contained

syn match   yamlConstant        '\<[~yn]\>' contained

" Null
syn keyword yamlNull            null Null NULL nil Nil NIL contained
syn match   yamlNull            "\W[~]\(\W\|$\)" contained

syn match   yamlTimestamp       '\d\d\d\d-\%(1[0-2]\|\d\)-\%(3[0-2]\|2\d\|1\d\|\d\)\%( \%([01]\d\|2[0-3]\):[0-5]\d:[0-5]\d.\d\d [+-]\%([01]\d\|2[0-3]\):[0-5]\d\|t\%([01]\d\|2[0-3]\):[0-5]\d:[0-5]\d.\d\d[+-]\%([01]\d\|2[0-3]\):[0-5]\d\|T\%([01]\d\|2[0-3]\):[0-5]\d:[0-5]\d.\dZ\)\=' containedin=yamlScalar

" Single and double quoted scalars
syn region  yamlString	        oneline start="'" end="'" skip="\\'"
                                \ contains=yamlSingleEscape
syn region  yamlString	        oneline start='"' end='"' skip='\\"'
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
syn match   yamlEscape          display '\\\%(\r\n\|[\r\n]\)'
syn match   yamlSingleEscape    contained display +''+

syn match   yamlAnchor	"&\S\+"
syn match   yamlAlias	"*\S\+"
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

let &cpo = s:cpo_save
unlet s:cpo_save

if main_syntax == "yaml"
  unlet main_syntax
endif
