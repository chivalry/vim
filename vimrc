"--------------------------------------------------------------------------------
" Basic Settings

set nocompatible               " We don't need vi compatibility
filetype plugin indent on      " Detect the filetype on file open, load the plugin and indent
                               " files for that filetype
set number                     " Show line numbers
set wrap                       " Wrap long lines
set linebreak                  " Only wrap at break characters, not mid-word
set textwidth=0                " Don't insert newline when line of text gets too long
set wrapmargin=0               " Check if this is needed for desired functionality
set listchars=tab:▸-\ ,trail:· " The characters to display for whitespace
set list                       " Show the listchars as defined above

set tabstop=4                  " Display 4 spaces for tabs in text
set shiftwidth=4               " Auto-indent uses 4 spaces
set softtabstop=4              " Insert 4 spaces when pressing the tab key
set expandtab                  " Use spaces when pressing the tab key

set cursorline                 " Highlight the line with the cursor

set ignorecase                 " Ignore case when performing a search
set smartcase                  " Unless there's a capital letter in the search
set incsearch                  " Highlight search results while typing the search
set hlsearch                   " Highlight all matches for a search, <ESC> has a map that turns
                               " this off when pressed

set statusline=\ %l/%L         " line x of y
set statusline+=\ [%p%%]       " percent through file
set statusline+=\ Col:%v       " column number
set statusline+=\ Buf:#%n      " buffer number
set statusline+=\ Char:%b
set statusline+=\ %m           " modified flag
set statusline+=\ %r           " read-only flag
set statusline+=%#identifier#
set statusline+=\ %t           " filename
set statusline+=%#statement#
set statusline+=\ %y           " filetype

set laststatus=2               " Always show the status line

let mapleader = "-"            " Use dash as <Leader> key
let maplocalleader = "\\"      " Use backslash as the <LocalLeader> key

set hidden                     " Hide current buffer when opening a new one even if it has
                               " unsaved changes
set history=1000               " Keep very long history of commands
set scrolloff=4                " Keep the cursor 4 lines from the edges of the window

set autoread                   " Just read the buffer's file if it was changed outside vim

set background=dark            " May not need this
if has("gui_running")
    set guifont=Menlo:h16
else
    syntax enable              " CL Vim doesn't have syntax highlighting without this
endif
colorscheme afterglow

set backupdir=/tmp//           " Keep backups, temp files and undo files in the global tmp
set directory=/tmp//           " directory
set undodir=/tmp//

"--------------------------------------------------------------------------------
" Autocommands

if has("autocmd")
  augroup vimgroup
    autocmd!
    autocmd BufWritePost *vimrc source $MYVIMRC " I don't think this is working

    autocmd BufNewFile,BufRead *.md set filetype=markdown
    autocmd BufNewFile,BufRead *.html set filetype=htmldjango
  augroup END
endif

"--------------------------------------------------------------------------------
" Mappings

nnoremap <Leader><SPACE> :nohlsearch<CR>

" Use Cmd-[ and Cmd-] for indenting editing
nnoremap <D-[> <<
nnoremap <D-]> >>
vnoremap <D-[> <gv
vnoremap <D-]> >gv

" Open splits
nnoremap <Leader>ew :edit <C-r>=expand("%:p:h")."/"<CR>
nnoremap <Leader>sw :split <C-r>=expand("%:p:h")."/"<CR>
nnoremap <Leader>vw :vsplit <C-r>=expand("%:p:h")."/"<CR>
nnoremap <Leader>tw :tabedit <C-r>=expand("%:p:h")."/"<CR>

" Navigate splits
nnoremap <C-left>   <C-w>h
nnoremap <C-down>   <C-w>j
nnoremap <C-up>     <C-w>k
nnoremap <C-right>  <C-w>l

" Movement keys take wrapped lines into account
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk
nnoremap $ g$
vnoremap $ g$
nnoremap 0 g0
vnoremap 0 g0
nnoremap ^ g^
vnoremap ^ g^
