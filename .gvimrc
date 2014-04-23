set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif
endif

set guifont=Ubuntu\ Mono\ 12

colorscheme Mustang

"correct syntax highlighting sign column
highlight clear SignColumn

"let guifontpp_size_increment=2
"let guifontpp_smaller_font_map="<C-p>"
"let guifontpp_larger_font_map="<C-+>"
"let guifontpp_original_font_map="<C-=>"
