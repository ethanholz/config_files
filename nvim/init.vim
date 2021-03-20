"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/ethan/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/ethan/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/home/ethan/.cache/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('Rigellute/shades-of-purple.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('neoclide/coc.nvim', { 'merged': 0 })
call dein#add('kaicataldo/material.vim', { 'branch': 'main' })
call dein#add('octol/vim-cpp-enhanced-highlight')
call dein#add('tpope/vim-commentary')
call dein#add('tpope/vim-fugitive')
call dein#add('voldikss/vim-floaterm')	
call dein#add('cdelledonne/vim-cmake')
call dein#add('mengelbrecht/lightline-bufferline')
call dein#add('ryanoasis/vim-devicons')
" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
if (has("termguicolors"))
	set termguicolors
endif
let mapleader = ","
source ~/.config/nvim/coc-config.vim

let g:material_theme_style='darker'
let g:lightline = {
      \ 'colorscheme': 'material',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
colorscheme material
set noshowmode
set showtabline=2
set relativenumber
let g:lightline#bufferline#enable_devicons = 1
" set colorcolumn=75

" C++ config
let g:cpp_class_decl_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cmake_link_compile_commands = 1


let g:floaterm_keymap_new = '<Leader>ft'
let g:floaterm_keymap_toggle = '<Leader>t'
