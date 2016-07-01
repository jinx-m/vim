
"---------------------------
" Start Neobundle Settings.
"---------------------------

"行番号の表示
set number
set cursorline
" 改行時に前の行のインデントを継続する
set autoindent
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

set backspace=indent,eol,start
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
 
" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"

NeoBundle 'vim-scripts/javacomplete'

"NERDTree"
NeoBundle 'scrooloose/nerdtree'

"neocomplete"
NeoBundle 'Shougo/neocomplete.vim'

" シングルクオートとダブルクオートの入れ替え等
 NeoBundle 'tpope/vim-surround'
"vim-easy-align"
 NeoBundle 'junegunn/vim-easy-align'



 if has('lua')
	   NeoBundleLazy 'Shougo/neocomplete.vim', {
	       \ 'depends' : 'Shougo/vimproc',
	       \ 'autoload' : { 'insert' : 1,}
	       \ }
   endif

call neobundle#end()

"コメントのON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'

" Required:
filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------

set nocompatible               " be iMproved
 filetype off                   " required!

 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 Bundle 'gmarik/vundle'

 " My Bundles here:
 "
 " original repos on github
 Bundle 'tpope/vim-fugitive'
 Bundle 'Lokaltog/vim-easymotion'
 Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
 Bundle 'tpope/vim-rails.git'
 " vim-scripts repos
 Bundle 'L9'
 Bundle 'FuzzyFinder'
 " non github repos
 Bundle 'git://git.wincent.com/command-t.git'
 " git repos on your local machine (ie. when working on your own plugin)
 Bundle 'file:///Users/gmarik/path/to/plugin'
 " ...

 filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..

 Bundle 'altercation/vim-colors-solarized'

 syntax enable
 set background=dark
 colorscheme solarized

 " タブを表示するときの幅
 set tabstop=4
 " " タブを挿入するときの幅
  set shiftwidth=4
 " " タブをタブとして扱う(スペースに展開しない)
  set noexpandtab
 " " 
  set softtabstop=0

	"[JAVA] :Makeでコンパイル
	autocmd FileType java :command! Makejava call s:Makejava()
	function! s:Makejava()
	    :w
	    let path = expand("%")
	    let syn = "javac ".path
	    let dpath = split(path,".java$")
	    let ret = system(syn)
	    if ret == ""
	        :echo "=======\r\nCompile Success"
	    else
	        :echo "=======\r\nCompile Failure\r\n".ret 
	    endif
	endfunction
	
	"[JAVA] :Doでコンパイル後のファイルを実行 
	autocmd FileType java :command! Dojava call s:Dojava()
	function! s:Dojava()
	    let path = expand("%")
	    let dpath = split(path,".java$")
	    let syn = "java ".dpath[0]
	    let ret = system(syn)
	    :echo "=======\r\n実行結果:\r\n".ret
	endfunction
	
	"[JAVA] :Exeでコンパイルしてから実行
	autocmd FileType java :command! Exejava call s:Javac()
	function! s:Javac()
	    :w
	    let path = expand("%")
	    let syn = "javac ".path
	    let dpath = split(path,".java$")
	    let ret = system(syn)
	    if ret == ""
	        :echo "=======\r\nCompile Success"
	        let syn = "java ".dpath[0]
	        let ret = system(syn)
	        :echo "=======\r\n実行結果:\r\n".ret
	    else
	        :echo "=======\r\nCompile Failure\r\n".ret
	    endif
	endfunction


autocmd FileType java :setlocal omnifunc=javacomplete#Complete
autocmd FileType java :setlocal completefunc=javacomplete#CompleteParamsInfo


    " Start interactive EasyAlign in visual mode (e.g. vip)
    vmap (EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. aip)
    nmap a (EasyAlign)



" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'


" }}}

inoremap ( ()<ESC>i
inoremap <expr> ) ClosePair(')')
inoremap { {}<ESC>i
inoremap <expr> } ClosePair('}')
inoremap [ []<ESC>i
inoremap <expr> ] ClosePair(']')
" pair close checker.
" from othree vimrc ( http://github.com/othree/rc/blob/master/osx/.vimrc )
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
"
