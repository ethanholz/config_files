source $HOME/.config/nvim/config/plugins.vim
source $HOME/.config/nvim/config/ui.vim
source $HOME/.config/nvim/config/nerd_comm.vim
source $HOME/.config/nvim/config/coc_nvim.vim

" Added control-s remap to save current buffer
nnoremap <c-s> :w<CR>:Neoformat<CR>
inoremap <c-s> <Esc>:w<CR>:Neoformat<CR>
vnoremap <c-s> <Esc>:w<CR>:Neoformat<CR>

nnoremap <c-c> :q<CR>
