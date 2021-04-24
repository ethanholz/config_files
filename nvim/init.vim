source ~/.config/nvim/plugs.vim
if has('nvim-0.5')
	source ~/.config/nvim/lspconfig.vim
else
	source ~/.config/nvim/coc-config.vim
endif
source ~/.config/nvim/lightline-config.vim
if (has("termguicolors"))
	set termguicolors
endif
let mapleader = ","
" Required:
filetype plugin indent on
syntax enable

colorscheme gruvbox
set background=dark
set noshowmode
set showtabline=2
set relativenumber
" set colorcolumn=75
" C++ config
let g:cpp_class_decl_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:floaterm_keymap_new = '<Leader>ft'
let g:floaterm_keymap_toggle = '<Leader>t'

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:codi#interpreters = {
		\ 'python': {
		    \ 'bin': 'python3',
		    \ 'prompt': '^\(>>>\|\.\.\.\) ',
		    \ },
		\ }
