call plug#begin()
if has('nvim-0.5')
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/completion-nvim'
else
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
Plug 'itchyny/lightline.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'voldikss/vim-floaterm'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'farmergreg/vim-lastplace'
Plug 'junegunn/fzf'
Plug 'morhetz/gruvbox'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'metakirby5/codi.vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()