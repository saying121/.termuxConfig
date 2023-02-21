scriptencoding utf-8
if system('uname --kernel-release | grep -c WSL')>=1
    let g:bracey_browser_command = 'msedge.exe'
endif
" 理论上不用加判断，但是不加会跟markdown preview冲突
if &filetype==#'html'
    nnoremap <buffer> <silent><c-p> :Bracey<cr>
    nnoremap <buffer> <silent><c-n> :BraceyStop<cr>
endif
