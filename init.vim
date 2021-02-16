call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'uarun/vim-protobuf'
Plug 'lifepillar/pgsql.vim'
Plug 'JuliaEditorSupport/julia-vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tcomment_vim'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'godlygeek/tabular'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'kdheepak/JuliaFormatter.vim'
" Plug 'plasticboy/vim-markdown'
"
Plug 'airblade/vim-rooter'

Plug 'justinmk/vim-sneak'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'DanilaMihailov/beacon.nvim'

Plug 'lifepillar/vim-gruvbox8'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


let g:deoplete#enable_at_startup = 1

let g:airline_theme='minimalist'

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
autocmd FileType * RainbowParentheses

set termguicolors
" highlight Normal guibg=none guifg=none

" set background=light
set background=dark
colorscheme gruvbox8

set relativenumber

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" set timeoutlen=100

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Escapes
inoremap jj <Esc>

set hidden
set number
set mouse=a
set clipboard^=unnamedplus

" no backups / swapfiles
set noswapfile
set nobackup

set inccommand=nosplit

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

"
" FZF
"

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

" Hide statusline of terminal buffer
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
			\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.85, 'height': 0.85, 'yoffset':0.5, 'xoffset': 0.5, 'border': 'sharp' } }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" .git,.mypy_cache,node_modules,vendor

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <silent><C-p> :Files<CR>
nnoremap <silent><Leader>b :Buffers<CR>
nnoremap <silent><Leader>l :Lines<CR>
nnoremap <silent><Leader>h :nohlsearch<CR>
map <silent><Leader>r :RG<CR>

" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-l> <plug>(fzf-complete-line)
inoremap <F10> ~

" comment
map <silent><Leader>c :TComment<CR>

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
autocmd Filetype vimscript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype json setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype vimscript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype css setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype scss setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype sql setlocal ts=2 sw=2 sts=0 expandtab

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

" => resize splits when vim is resized
autocmd VimResized * wincmd =

" auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC source %

let g:sneak#label = 1
" smartcase
let g:sneak#use_ic_scs = 1

" immediately move tot the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#s_next = 1

" remap so I can use , and ; with f and t
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;

" Change the sneak colors
highlight Sneak guifg=black guibg=#5BC5EA ctermfg=black ctermbg=cyan
highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

" " Cool prompts
let g:sneak#prompt = '🕵'
let g:sneak#prompt = '🔎'
"

augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

