" creates different highlight for TODO, DOING and DONE
" Authot: Isaac Lima
" Year: 2020

syn keyword VimwikiDone DONE
syn keyword VimwikiDoing DOING
syn keyword VimwikiHalted HALTED
hi def link VimwikiDone StatusLineTerm
hi def link VimwikiDoing MatchParen
hi def link VimwikiHalted Pmenu
