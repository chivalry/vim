set nocompatible              " be iMproved
filetype off                  " turn off while we load plugins

set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'chivalry/filemakervim'

call vundle#end()            " required
filetype plugin indent on    " required

"--------------------------------------------------------------------------------
" Application options

set statusline=\ %l/%L        " line x of y
set statusline+=\ [%p%%]      " percent through file
set statusline+=\ Col:%v      " column number
set statusline+=\ Buf:#%n     " buffer number
set statusline+=\ %y
set statusline+=\ %m    " modified flag
set statusline+=\ %r          " read-only flag
set statusline+=\ %f    " filename

let mapleader = "-"
let maplocalleader = "\\"

" Allows modified files to be hidden but remain in a buffer.
set hidden

set history=1000

" Commands for editing and executing the .vimrc file.
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"--------------------------------------------------------------------------------
" Text formatting

" Sources $VIMRUNTIME/syntax/syntax.vim to enable syntax highlighting.
syntax on

colorscheme Tomorrow/Tomorrow-Night-Bright

if has("gui_running")
  set guifont=Source\ Code\ Pro:h14
endif

"--------------------------------------------------------------------------------
" Display settings

" Show line numbers
set number

" Wraps long lines around by breaking words in the middle.
set wrap

" Changes wrap behavior to wrap on the contents of the breakat variable.
set linebreak

" Show invisible characters. Disable because it overrides linebreak. Perhaps
" later set list based on filetype, for example, only for markdown and plain
" text.
" set list

" What to show the invisibles as.
set listchars=tab:▸\ ,trail:·
" eol:¬,

" How will tabs work?
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"--------------------------------------------------------------------------------
" Search options

" Ignore case in searches unless a capital letter is included.
set ignorecase
set smartcase

" Show partial matches while typing in a search term.
set incsearch

" Highlight search results. Disabled until an easy way to remove highlights is found.
" set hlsearch

"--------------------------------------------------------------------------------
" Abbreviations

" Spelling corrections.
iabbrev adn and
iabbrev waht what
iabbrev tehn then

" Simple text snippets.
iabbrev @@ chivalry@mac.com
iabbrev sig Thanks,<cr>Chuck

"--------------------------------------------------------------------------------
" Mappings

" Indent and outdent.
nnoremap <d-[> <<
nnoremap <d-]> >>
vnoremap <d-[> <gv
vnoremap <d-]> >gv

" Navigate to beginning and end of current line.
nnoremap H 0
nnoremap L $

"--------------------------------------------------------------------------------
" Plugins

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"--------------------------------------------------------------------------------
" Autocommands

if has("autocmd")
  augroup vimrcgroup
    autocmd!
"   autocmd BufNewFile,BufRead * :execute "lcd " . expand("%:p:h")
  augroup END
endif

"--------------------------------------------------------------------------------
" Functions

function! SaveSession()
  execute "call mkdir(%:p:h/.vim)"
  execute "mksession! %:p:h/.vim/session.vim"
endfunction

function! RestoreSession()
  execute "source %:p:h/.vim/session.vim"
  if bufexists(1)
    for l in range(1, bufnr("$"))
      if bufwinnr(l) == -1
        execute "badd " . l
      endif
    endfor
  endif
endfunction

"--------------------------------------------------------------------------------
" Examples (didn't write, probably won't use, here for reference only)

" Capitalize the current word. From Learn Vimscript the Hard Way.
inoremap <c-u> <esc>viwUi
nnoremap <c-u> viwU

" Enclose the current word in quotes.
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop=' . &l:ts
    echon 'shiftwidth=' . &l:sw
    echon 'softtabstop=' . &l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  $s/\s\+$//e
  " Clean up: restore previous search history and cursor position.
  let @/=_s
  call cursor(l, c)
endfunction

if has("autocmd")
  augroup samples
    autocmd!
    autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
    autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()
  augroup END
endif
