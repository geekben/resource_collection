"================================冷宫==================================
"
" traversing text using hjkl in insert mode
" imap <C-H> <LEFT>
" imap <C-J> <DOWN>
" imap <C-K> <UP>
" imap <C-L> <RIGHT>

"" 输入一个字符时，如果下一个字符也是括号，则删除它，避免出现重复字符
"function! RemoveNextDoubleChar(char)
"    let l:line = getline(".")
"    let l:next_char = l:line[col(".")] " 取得当前光标后一个字符
"
"    if a:char == l:next_char
"        execute "normal! l"
"    else
"        execute "normal! i" . a:char . ""
"    end
"endfunction

"inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
"inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
"inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a
"inoremap > <ESC>:call RemoveNextDoubleChar('>')<CR>a

"function! RemovePairs()
"    let l:line = getline(".")
"    let l:previous_char = l:line[col(".")-1] " 取得当前光标前一个字符
"
"    if index(["(", "[", "{", "<"], l:previous_char) != -1
"        let l:original_pos = getpos(".")
"        execute "normal %"
"        let l:new_pos = getpos(".")
"
"        " 如果没有匹配的右括号
"        if l:original_pos == l:new_pos
"            execute "normal! a\<BS>"
"            return
"        end
"
"        let l:line2 = getline(".")
"        if len(l:line2) == col(".")
"            " 如果右括号是当前行最后一个字符
"            execute "normal! v%xa"
"        else
"            " 如果右括号不是当前行最后一个字符
"            execute "normal! v%xi"
"        end
"
"    else
"        execute "normal! a\<BS>"
"    end
"endfunction
"" 用退格键删除一个左括号时同时删除对应的右括号
"inoremap <BS> <ESC>:call RemovePairs()<CR>a

"execute pathogen#infect()
syntax on
filetype plugin indent on

" pydiction config
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'

"let g:pydiction_menu_height = 20

"语法高亮度显示
"  syntax on
"去掉有关vi一致性模式，避免以前版本的一些bug和局限
  set nocompatible
"显示行号
  set number
"检测文件的类型
  filetype on
"记录历史的行数
  set history=1000
"背景使用黑色
  set background=dark
"vim使用自动对起，也就是把当前行的对起格式应用到下一行
  set autoindent
"依据上面的对起格式，智能的选择对起方式，对于类似C语言编
  set smartindent
"设置Windows风格的C/C++自动缩进,第一行设置tab键为4个空格，第二行设置当行之间交错时使用4个空格
  set tabstop=4
  set shiftwidth=4
  set expandtab
"for both CSS and HTML, use genuine tab characters for indentation, to make
"files a few bytes smaller:
  autocmd FileType html,css set expandtab tabstop=2

"设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号
  set showmatch
"去除vim的GUI版本中的toolbar
  set guioptions-=T
"在编辑过程中，在右下角显示光标位置的状态行
  set ruler
"默认情况下，寻找匹配是高亮度显示的，该设置关闭高亮显示
  set nohls
"使用此设置会快速找到答案，当你找要匹配的单词时，别忘记回车
  set incsearch
"如果没有下列行，加上吧
  if &term=="xterm"
  set t_Co=8
  set t_Sb=^[[4%dm
  set t_Sf=^[[3%dm
  endif

" cscope and hot-key maps
  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
  cs add cscope.out

" mouse related:
"  set mouse=a

" auto-matching brackets
  inoremap ( ()<LEFT>
  inoremap [ []<LEFT>
  inoremap { {}<LEFT>


" mapping ctrl-l to delete
  imap <C-l> <DEL>

autocmd FileType c setlocal foldmethod=syntax
autocmd FileType python setlocal foldmethod=syntax

" paste setting
set pastetoggle=<F2>
" auto set paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
