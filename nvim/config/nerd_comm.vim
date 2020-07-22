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
