" mercury

" set background=dark
set number
set is
set cindent
set expandtab
set tabstop=4
set shiftwidth=4
set mouse=a
set splitright

call plug#begin('~/.vim/plugged')

Plug 'https://github.com/NLKNguyen/papercolor-theme'

call plug#end()

set t_Co=256
set background=dark
colorscheme PaperColor

tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
vnoremap <C-c> :w !xclip -sel c<CR><CR>
vnoremap <C-v> :r !xclip -sel c -o<CR>
