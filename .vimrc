" 行番号を表示
set number
" インクリメンタル検索 (検索ワードの最初の文字を入力した時点で検索が開始)
set incsearch
" 検索結果をハイライト表示
set hlsearch
" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells
" 対応する括弧やブレースを表示
set showmatch matchtime=1
" ステータス行を常に表示
set laststatus=2
" ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set showcmd
" コマンドラインの履歴を10000件保存する
set history=10000 
" シンタックスハイライト
syntax enable
" コメントの色をDarkCyanにする
hi Comment ctermfg=DarkCyan
" タブキー押下時に挿入される文字幅を指定
set softtabstop=2
" ファイル内にあるタブ文字の表示幅
set tabstop=2
" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~
" カーソルラインを表示
set cursorline
" better 'smartindent'
filetype plugin indent on
" タブの幅をスペース2 つ分にする
set tabstop=2
" '>'でインデント時に、スペース2 つ分を使う
set shiftwidth=2
" タブ押下時にスペース2 つ分を使う
set expandtab

" キーの置換
inoremap <silent> jf <ESC>
nnoremap <silent> gj gg
nnoremap <silent> gk G

" 編集箇所のカーソルを記憶
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif
