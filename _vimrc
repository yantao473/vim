set diffexpr=MyDiff()

function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

""""""""""""""""""""""""""""""""""""""""""""""
"General
""""""""""""""""""""""""""""""""""""""""""""""
"set guifont
" set guifont=Consolas:h13:cANSI
" set guifont=DejaVu\ Sans\ Mono:h13:cANSI
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13:cANSI

"Get out of VI's compatible mode.
set nocp

"set folding method
" set fdm=marker 

"set how many lines of history VIM to remember
set history=400

" delete utf-8 BOM 
set nobomb
" charset settings
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,gbk,gb18030,cp936,big5,euc-jp,euc-kr,euc-cn,latin1

"Enable filetype plugin
filetype plugin on
filetype indent on

"Set mapleader
let mapleader=","
let g:mapleader=","

" Auto change directory
" set autochdir

"Set auto read when a file is changed from the outside
set ar

"Set the mose enabled all the time
set mouse=a

"Fast edit vimrc
function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction
map <silent> <leader>ee :call SwitchToBuf("D:/Vim/_vimrc")<cr>

"When _vimrc is edited, reload it
autocmd! bufwritepost _vimrc source D:/Vim/_vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERD_commener
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDSpaceDelims = 1
let NERDCompactSexyComs=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"NERD tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>ne :NERDTree<cr>
map <silent> <leader>nc :NERDTreeClose<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"BufExplorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0 " Do not show default help
let g:bufExplorerShowRelativePath=1 " Show relative paths. 
let g:bufExplorerSortBy='mru' " Sort by most recently used. 
let g:bufExplorerSplitRight=0 " Split left. 
let g:bufExplorerSplitVertical=1 " Split vertically. 
let g:bufExplorerSplitVertSize = 30 " Split width 
let g:bufExplorerUseCurrentWindow=1 " Open in new window. 
autocmd BufWinEnter \[Buf\ List\] setl nonumber

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Avoid clearing hilight definition in plugins
if !exists("g:vimrc_loaded")
    syntax enable

    " color scheme
    if has("gui_running")
        set guioptions-=T
        set guioptions-=m
        set guioptions-=L
        set guioptions-=r
    endif " has
        colorscheme darkblue_my
endif " exists(...)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimTweak
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Alpha Window
map <silent> <leader>aw :call libcallnr("vimtweak.dll","SetAlpha",215)<cr>
map <silent> <leader>aW :call libcallnr("vimtweak.dll","SetAlpha",255)<cr>

"Maximized Window
map <silent> <leader>mw :call libcallnr("vimtweak.dll","EnableMaximize",1)<cr>
map <silent> <leader>mW :call libcallnr("vimtweak.dll","EnableMaximize",0)<cr>

"TopMost Window
map <silent> <leader>ta :call libcallnr("vimtweak.dll","EnableTopMost",1)<cr>
map <silent> <leader>tA :call libcallnr("vimtweak.dll","EnableTopMost",0)<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos

nmap <silent> <leader>fd :se ff=dos<cr>
nmap <silent> <leader>fu :se ff=unix<cr>

"Smart way to move btw. windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wmnu

"Always show current position
set ru

"The commandbar is 2 high
set ch=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Set backspace
set backspace=eol,start,indent

"set whichwrap+=<,>,h,l
set ww+=<,>

"Increach search
set is

"Highlight search things
set hls

"Set magic on
set magic

"No sound on errors.
set noeb
set novb
set t_vb=

"show matching bracets
set sm

"How many tenths of a second to blink
set mat=2

""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""
set laststatus=2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <silent> <leader>cd :cd %:p:h<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobk
set nowb
"set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set foldenable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set et
set sw=4

au FileType html,python,vim,javascript,c,php setl shiftwidth=4
au FileType html,python,vim,java,c,javascript,php setl tabstop=4
au FileType txt setl lbr
au FileType txt setl tw=78

set smarttab

""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""
" Auto indent
" set ai

" Smart indet
" set si

" C-style indeting
" set cindent
autocmd FileType c,cpp :set cindent

" Wrap lines
set nowrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Complete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" options
set completeopt=menu
set complete-=u
set complete-=i

" Enable syntax
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
                \ if &omnifunc == ""  |
                \ setlocal omnifunc=syntaxcomplete#Complete |
                \ endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""
" Vim section
"""""""""""""""""""""""""""""""
autocmd FileType vim set nofen
autocmd FileType vim map <buffer> <leader><space> :w!<cr>:source %<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast grep
nmap <silent> <leader>lv :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>
vmap <silent> <leader>lv :lv /<c-r>=<sid>GetVisualSelection()<cr>/ %<cr>:lw<cr>

" Fast diff
cmap @vd vertical diffsplit 
set diffopt+=vertical

"Remove the Windows ^M
noremap <silent> <leader>dm mmHmn:%s/<C-V><cr>//ge<cr>'nzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Check PHP Syntax using makeprg
"""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CheckPHPSyntax()
    if &filetype != 'php'
        echohl WarningMsg | echo 'This is not a PHP file !' | echohl None
        return
    endif
    setlocal makeprg=php\ -l\ -n\ -d\ html_errors=off\ %
    setlocal errorformat=%m\ in\ %f\ on\ line\ %l
    echohl WarningMsg | echo 'Syntax checking output:' | echohl None
    if &modified == 1
        silent write
    endif
    silent make
    clist
endfunction

au filetype php map <F5> :call CheckPHPSyntax()<CR>
au filetype php imap <F5> <ESC>:call CheckPHPSyntax()<CR>

"************************ for neocomplcache  **********************"
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_quick_match = 1
let g:neocomplcache_min_syntax_length = 2

" Enable omni completion. 
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS 
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags 
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS 
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete 
" autocmd FileType javascript set dictionary+=$VIM/vimfiles/vundle/javascript.dict
"************************ for neocomplcache  **********************"
"***************************start airline******************************"
" let g:airline_theme="luna" 
let g:airline_theme="powerlineish" 

"这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1   

" 打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#show_close_button = 1
" let g:airline#extensions#tabline#close_symbol = 'X'

" let g:airline#extensions#branch#enabled = 1
" let g:airline#extensions#branch#empty_message = ''

"设置切换Buffer快捷键"
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>

" 关闭状态显示空白符号计数"
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

"***************************end airline******************************

" jsx config
" let g:jsx_ext_required = 0
" let g:jsx_pragma_required = 1

" for check javascript syntax
" au filetype javascript map <F2> <ESC> :JSHint<CR>


" install  git clone https://github.com/gmarik/Vundle.vim.git
set rtp+=$VIM/vimfiles/vundle/Vundle.vim
let path=$VIM.'/vimfiles/vundle'
call vundle#begin(path)
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'genutils'
Plugin 'fugitive.vim'
Plugin 'Emmet.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-scripts/matchit.zip'
Plugin 'Shougo/neocomplcache'
Plugin 'pathogen.vim'
call vundle#end()
