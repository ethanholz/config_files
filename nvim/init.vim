call plug#begin(stdpath('config') . '/plugged')
Plug 'preservim/nerdcommenter'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'vim-airline/vim-airline'
call plug#end()

set number

" Start theme
if (has("termguicolors"))
	 set termguicolors
endif
syntax enable
colorscheme shades_of_purple
let g:shades_of_purple_airline = 1
let g:airline_theme='shades_of_purple'

" Start airline config
let g:airline_powerline_fonts = 1

" Start nerdcommenter config
" " Maps CTRL-/ to comment (For some reason, terminals output C-_ when C-/ is
" " pressed)
nmap <C-_> <Plug>NERDCommenterToggle
"
" " Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
"
" " Align line-wise comment delimiters flush left instead of following code
" " indentation
let g:NERDDefaultAlign = 'left'
"
" " Allows for commenting of empty lines
let g:NERDCommentEmptyLines = 1
"
" " Trims trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"
" " Has NERDCommenter check all selected lines' comment status
let g:NERDToggleCheckAllLines = 1
"
" " End nerdcommenter config
