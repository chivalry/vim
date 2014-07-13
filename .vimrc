set nocompatible              " be iMproved

if has('python')
  filetype off                  " turn off while we load plugins

  " Note that a major changed made by Vundle is to edit the runtimepath to
  " include all plugin directories
  set runtimepath+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Plugin 'gmarik/Vundle.vim'

  Plugin 'SirVer/ultisnips'
  Plugin 'honza/vim-snippets'

  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-repeat'

  Plugin 'godlygeek/tabular'

  Plugin 'altercation/vim-colors-solarized'

  Plugin 'chivalry/filemaker.vim'

  Plugin 'mklabs/vim-markdown-helpfile'

  call vundle#end()            " required
endif

if has('autocmd')
  filetype plugin indent on    " required
endif

"--------------------------------------------------------------------------------
" Application options

set statusline=\ %l/%L        " line x of y
set statusline+=\ [%p%%]      " percent through file
set statusline+=\ Col:%v      " column number
set statusline+=\ Buf:#%n     " buffer number
set statusline+=\ Char:%b
set statusline+=\ %y          " filetype
set statusline+=\ %m          " modified flag
set statusline+=\ %r          " read-only flag
set statusline+=\ %f          " filename

let mapleader = "-"
let maplocalleader = "\\"

" Allows modified files to be hidden but remain in a buffer.
set hidden

set history=1000

" Commands for editing and executing the .vimrc file.
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Commands for editing the .bash_profile.
nnoremap <leader>bv :split ~/.bash_profile<cr>

" tell Vim to always put a status line in, even if there is only one
" window
set laststatus=2

" When the page starts to scroll, keep the cursor 4 lines from
" the top and 4 lines from the bottom
set scrolloff=4

nnoremap <leader>ll :ls!<cr>

"--------------------------------------------------------------------------------
" Text formatting

" Sources $VIMRUNTIME/syntax/syntax.vim to enable syntax highlighting.
syntax on

let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="high"    "default value is normal
let g:solarized_hitrail=1    "default value is 0
syntax enable
set background=dark
colorscheme solarized

if has("gui_running")
  set guifont=Source\ Code\ Pro:h16
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
set hlsearch

" Turn off the search highlighting automatically by pressing <esc>
nnoremap <esc> :nohlsearch<return><esc>

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

nnoremap <leader>ew :edit <c-r>=expand("%:p:h")."/"<cr>
nnoremap <leader>sw :split <c-r>=expand("%:p:h")."/"<cr>
nnoremap <leader>vw :vsplit <c-r>=expand("%:p:h")."/"<cr>
nnoremap <leader>tw :tabedit <c-r>=expand("%:p:h")."/"<cr>

nnoremap <leader>fm :set filetype=fmfalc

nnoremap <c-left>   <c-w>h
nnoremap <c-down>   <c-w>j
nnoremap <c-up>     <c-w>k
nnoremap <c-right>  <c-w>l

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

nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"--------------------------------------------------------------------------------
" Plugins

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"

"--------------------------------------------------------------------------------
" Autocommands

if has("autocmd")
  augroup vimrcgroup
    autocmd!
    autocmd BufNewFile,BufRead * :execute "lcd " . expand("%:p:h")
    autocmd BufWritePost .vimrc source $MYVIMRC
    autocmd BufNewFile,BufRead *.md set filetype=markdown
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
    autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()
  augroup END
endif
