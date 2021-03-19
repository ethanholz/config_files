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
source ~/.config/nvim/coc-config.vim
function! CocCurrentFunction()
	    return get(b:, 'coc_current_function', '')

endfunction

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
      \ }
colorscheme material
set noshowmode

" set colorcolumn=75

" C++ config
let g:cpp_class_decl_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
