"--------------------------------------------------------------------------------
" Application options

" No need for vi compatibility
set nocompatible

set statusline=%f             " filename
set statusline+=\ %m          " modified flag
set statusline+=\ %r          " read-only flag
set statusline+=\ Line:%l/%L  " line x of y
set statusline+=\ [%p%%]      " percent through file
set statusline+=\ Col:%v      " column number
set statusline+=\ Buf:#%n     " buffer number

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

" Turn on file type detection.
" According to the :h filetype, turning this on will load $VIMRUNTIME/filetype.vim,
" which defines autocommands for BufNewFile and BufRead.
" Runs indent.vim in "runtimepath", which enables the loading of the indent file for
" specific file types.
" Runs ftplugin.vim in "runtimepath", which enables the loading of a filetype's plugin.
" TODO: Read the files associated with this command.
filetype indent plugin on

"--------------------------------------------------------------------------------
" Display settings

" Show line numbers
set number

" Wraps long lines around by breaking words in the middle.
set wrap

" Changes wrap behavior to wrap on the contents of the breakat variable.
set linebreak

" Show invisible characters.
set list

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
  autocmd bufNewFile,BufRead *.rss,*.atom setfiletype xml
  autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()
endif
