" my vimrc
" there are many like it
" but this one is mine


" heavily based on:
" - nvie's vimrc - https://github.com/nvie/vimrc


" Initializers
call pathogen#infect()

" Vim settings!
set nocompatible                " I'm only doing this because nvie told me to. (jk.)
" let mapleader = '<SPACE>'
set t_Co=256
let $NEWRUNTIMEPATH='/usr/share/vim/vim73'
set runtimepath^=$NEWRUNTIMEPATH

" Syntax
syntax on
filetype plugin indent on

" Editing behavior
set showmode                    " always show what mode we're currently editing in
set expandtab                   " go to space (tabs)
set nowrap                      " don't wrap lines
set tabstop=4                   " 4 spaces in a tab
set shiftwidth=4                " 4 spaces when shifting text
set softtabstop=4               " same deal
set autoindent                  " autoindent and don't you ever forget
set copyindent                  " copy the previous indentation on autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set number                      " we want numbers, WE WANT NUMBERS
set showmatch                   " parenthetical
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set ignorecase                  " ignore the case
set smartcase                   " search query lowercase, case-insensitive. otherwise, case-sensitive (that's smart!)
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=7                 " keep 7 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
set nolist                      " don't show invisible characters
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>

" Visual configuration
set foldenable                  " enable folding
set foldcolumn=0                " no fadecolumn
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=0            " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()
" }}}

set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window
set cmdheight=2                 " use a status bar that is 2 rows high



" Vim behavior
" |- layouts
set hidden                      " hide buffers instead of closing them
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers

" |- history and storage
set history=1000                " 1000 history
set undolevels=1000             " 1000 undo
set undofile                    " keep a persistent backup file
set undodir=~/.vim/.undo,~/tmp,/tmp
set nobackup                    " don't keep backup files. thanks but no thanks
set noswapfile                  " don't keep swap files. thanks but no thanks
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers

" |- terminal interaction
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep
set nomodeline                  " disable mode lines

" |- interaction
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info
set cursorline                  " underline the current line, for quick orientation

" Editing
syntax on
set background=light
colorscheme github
" colorscheme solarized
" call togglebg#map("<Space>tog")       " go ahead and map F5 to togglebg
call togglebg#map(":tog")       " go ahead and map F5 to togglebg

" Editing shortcuts
nnoremap ; :
" nnoremap <SPACE> :
map <Tab>n :NERDTreeToggle<CR>
" map <Tab>p :PeepOpen<CR>
" map <F5> :PeepOpen<CR>
map <Tab>b :BufExplorer<CR>
map <Tab>y :YRGetElem<CR>
map <Tab>u :GundoToggle<CR>
map <left> :bp<CR>
map <right> :bn<CR>
" map <up> :PeepOpen<CR>
map <up> :FufFileWithCurrentBufferDir
map <Tab>f :FufFileWithCurrentBufferDir
Map <F5> :FufFileWithCurrentBufferDir
map <down> :NERDTreeToggle<CR>

" disallow arrow keys
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" shift dd deletes the line without adding it to the yank stack
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" quickly yank to the end of the line
nmap Y y$

" quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>
inoremap jk <Esc>

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Folding
" nnoremap <Space> za
" vnoremap <Space> za

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit on opening files from the tree
let NERDTreeQuitOnOpen=1

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directories and a double click to open
" files
let NERDTreeMouseMode=2

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$' ]


" Additional appearance
set guifont=Inconsolata:h18

" gvim

if has("gui_running")
    " Remove toolbar, left scrollbar and right scrollbar
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
endif
