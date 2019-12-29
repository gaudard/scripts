:syntax on
set mouse-=a
set foldmethod=marker
set foldmarker=--------------------------------,################################
:nnoremap <F5> "=strftime("%c")<CR>PA --
:inoremap <F5> <C-R>=strftime("%c")<CR> --
:nnoremap <F6> ATARGET -- POINTS -- STATUS<CR>--------------------------------<CR><CR><CR><CR><CR>################################<CR>
:inoremap <F6> TARGET -- POINTS -- STATUS<CR>--------------------------------<CR><CR><CR><CR><CR>################################<CR>
:nnoremap <F9> za
:inoremap <F9> <ESC>za
