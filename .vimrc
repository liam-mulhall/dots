" Persistent status line.
set laststatus=2

" Enable syntax highlighting.
syntax enable

" Show line numbers.
set number

" Show cursor line.
set cursorline

" Show column at 80 characters.
set colorcolumn=80

" Highlight search items.
set hlsearch

" On pressing tab, insert 2 spaces.
set expandtab

" Show existing tab with 2 spaces width.
set tabstop=2
set softtabstop=2

" When indenting with '>', use 2 spaces width.
set shiftwidth=2

" Use spellcheck by default.
set spell
set spelllang=en_us

" Set color scheme to Dracula.
packadd! dracula
colorscheme dracula

" Since we have Lightline installed, don't show "-- INSERT --".
set noshowmode

" Set Lightline color scheme to Dracula.
let g:lightline = {
  \ 'colorscheme': 'dracula',
  \ }
