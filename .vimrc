" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  filetype off

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " vim-go settings
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  " run :GoBuild or :GoTestCompile based on the go file
  function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
      call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
      call go#cmd#Build(0)
    endif
  endfunction
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" show line numbers
set number

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

let mapleader = ","
" make searches use normal regexes
nnoremap / /\v
vnoremap / /\v

" intelligent case-sensitive search
set ignorecase
set smartcase

" apply substitutions globally (:%s/foo/bar/g => :%s/foo/bar/)
" attach g again to replace on one line only
set gdefault

" highlight searches
set incsearch
set showmatch
set hlsearch

" quit highlighting
nnoremap <leader><space> :noh<cr>

" switch between braces with tab
nnoremap <tab> %
vnoremap <tab> %

" handle long lines
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=+1

" open a new vertical split and switch over to it
nnoremap <leader>w <C-w>v<C-w>l

" switch current directory to the one the file beeing edited resides in
nmap <silent> <Leader>cd :cd %:p:h<CR>

" NERDTree shortcut
nmap <silent> <c-n> :NERDTreeToggle<CR>

if (has("termguicolors"))
  set termguicolors
endif
autocmd vimenter * ++nested colorscheme gruvbox
set background=dark

" set shortcut for undotree
nnoremap <F6> :UndotreeToggle<CR>

" split below and to the right
set splitbelow
set splitright

" expand bp
abbreviate bp require 'pry'; binding.pry

" fzf shortcut
nnoremap <leader>f :FZF<CR>
nnoremap <leader>a :Rg<CR>
nnoremap <leader>A :Rg <C-R><C-W><CR>

" Enable fzf per-command history
let g:fzf_history_dir = '~/.local/share/fzf-history'

let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
" Use morhetz/gruvbox color theme in fzf
let $FZF_DEFAULT_OPTS='--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934'

" git shortcut
nnoremap <leader>g :Git<space>
