set number
set splitbelow
set splitright
" Start theme
if (has("termguicolors"))
	 set termguicolors
endif

syntax enable
:set mouse=a
colorscheme shades_of_purple
let g:shades_of_purple_airline = 1
let g:airline_theme='shades_of_purple'

" Start airline config
let g:airline_powerline_fonts = 1

