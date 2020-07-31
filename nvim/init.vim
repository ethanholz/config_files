source $HOME/.config/nvim/config/plugins.vim
source $HOME/.config/nvim/config/ui.vim
source $HOME/.config/nvim/config/nerd_comm.vim
source $HOME/.config/nvim/config/coc_nvim.vim
source $HOME/.config/nvim/config/cmake.vim

" Added control-s remap to save current buffer
nnoremap <c-s> :Neoformat<CR>:w<CR>
inoremap <c-s> <Esc>:Neoformat<CR>:w<CR>
vnoremap <c-s> <Esc>:Neoformat<CR>:w<CR>

nnoremap <c-c> :q<CR>

nnoremap <c-n> :NERDTreeToggle<CR>

" Added leader key
let mapleader=","
nnoremap <Leader>t :split term://fish<CR>:res 15<CR>
nnoremap <Leader>c :qa<CR>

