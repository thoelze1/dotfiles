" This must be first, because it changes other options as a side effect.
set nocompatible

" Colors!
syntax on
colorscheme dracula

" Show line numbers
set number

" Differentiate tabs from spaces, highlight trailing spaces
set listchars=tab:>\ ,trail:_
set list

" Keep cursor vertically centered
set scrolloff=20

" Display tabs correctly
set tabstop=8

" show the cursor position all the time
set ruler

" relegate backups to hidden dir
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" stay at line
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" indentation rules
set autoindent
set smartindent
