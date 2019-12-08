call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tcomment_vim'
" Plug 'justinmk/vim-sneak'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'godlygeek/tabular'

" Colorscehmes
Plug 'andreypopp/vim-colors-plain'

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'neovim/nvim-lsp'

Plug 'uarun/vim-protobuf'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'norcalli/nvim-colorizer.lua'

" Plug 'zxqfl/tabnine-vim'

" Plug 'plasticboy/vim-markdown'


call plug#end()

let g:coc_global_extensions = [
\  'coc-emoji',
\  'coc-git',
\  'coc-pairs',
\  'coc-eslint',
\  'coc-prettier',
\  'coc-css',
\  'coc-json',
\  'coc-python',
\  'coc-yaml',
\  'coc-rls',
\  'coc-elixir',
\  'coc-sql',
\  'coc-gitignore',
\]

set termguicolors

set background=dark
colo plain

set relativenumber

lua require("colorizer")

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Escapes
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kj <Esc>
inoremap JJ <Esc>
inoremap JK <Esc>
inoremap KJ <Esc>

set hidden
set number
set mouse=a
set clipboard^=unnamedplus
" set clipboard^=unnamed

" no backups / swapfiles
set noswapfile
set nobackup

let mapleader=","
nnoremap ; :
vnoremap ; :
" Go to the start of the actual line
nnoremap 0 ^
" Make Y behave like other capital commands.  Hat-tip
" http://vimbits.com/bits/11
nnoremap Y y$
" selections easier
onoremap p i(
onoremap is i"
onoremap cb i{
onoremap sb i[
vnoremap > >gv
vnoremap < <gv

map <silent> j gj
map <silent> k gk

" Navigation splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
nnoremap <silent><C-p> :Files<CR>
nnoremap <silent><Leader>b :Buffers<CR>
nnoremap <silent><Leader>l :Lines<CR>
nnoremap <silent><Leader>h :nohlsearch<CR>

let g:fzf_layout = { 'down': '~40%' }
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '20split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:rg_command = 'rg -i --column --line-number --fixed-strings --no-ignore -g "!{.git,node_modules,vendor}/*" '

map <silent><Leader>c :TComment<CR>
map <silent><Leader>r :Rg<CR>

" Moving inside tmux/vim
function! TmuxMove(direction)
    let wnr = winnr()
    silent! execute 'wincmd ' . a:direction
    " If the winnr is still the same after we moved, it is the last pane
    if wnr == winnr()
        call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
    end
endfunction
nnoremap <silent> <c-h> :call TmuxMove('h')<cr>
nnoremap <silent> <c-j> :call TmuxMove('j')<cr>
nnoremap <silent> <c-k> :call TmuxMove('k')<cr>
nnoremap <silent> <c-l> :call TmuxMove('l')<cr>

autocmd Filetype csharp setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype julia setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype markdown setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype vimscript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype json setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype vimscript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=0 expandtab

if has('persistent_undo')
    " define a path to store persistent undo files.
    let target_path = expand('~/.config/nvim/undo/')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif
    " point Vim to the defined undo directory.
    let &undodir = target_path
    " finally, enable undo persistence.
    set undofile
endif

" reload file if it has changed on disk
set autoread
au FocusGained * silent! :checktime

nmap <silent> <Leader>d <Plug>(coc-definition)
nmap <silent> <Leader>t <Plug>(coc-type-definition)
" nmap <silent> <Leader>i <Plug>(coc-implementation)
nmap <silent> <Leader>f <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> F2 <Plug>(coc-rename)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

lua require("navigation")
" map the Terminal function in the lua module to some shortcuts
" nnoremap <silent> <leader>kh :lua Terminal(1)<cr>
" nnoremap <silent> <leader>kj :lua Terminal(2)<cr>
" nnoremap <silent> <leader>kk :lua Terminal(3)<cr>
" nnoremap <silent> <leader>kl :lua Terminal(4)<cr>

" => resize splits when vim is resized
autocmd VimResized * wincmd =

" let g:sneak#label = 1
