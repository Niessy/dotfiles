call plug#begin('~/.local/share/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'JuliaEditorSupport/julia-vim'

Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tcomment_vim'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'godlygeek/tabular'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'airblade/vim-rooter'

Plug 'justinmk/vim-sneak'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'DanilaMihailov/beacon.nvim'

Plug 'lifepillar/vim-gruvbox8'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-github.nvim'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


let g:airline_theme='minimalist'

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
autocmd FileType * RainbowParentheses

set background=dark
colorscheme gruvbox8

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=200
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

lua << EOF
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = "🔍 ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {'node_modules'},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
EOF

lua require('telescope').load_extension('fzy_native')
lua require('telescope').load_extension('gh')

" Using lua functions
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({previewer = false})<cr>
nnoremap <leader>r <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>ht <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>hc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>ds <cmd>lua require('telescope.builtin').file_browser()<cr>

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

" autocmd Filetype csharp setlocal ts=4 sw=4 sts=0 expandtab
" autocmd Filetype julia setlocal ts=4 sw=4 sts=0 expandtab
" autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
" autocmd Filetype markdown setlocal ts=2 sw=2 sts=0 expandtab
" autocmd Filetype vimscript setlocal ts=2 sw=2 sts=0 expandtab
" autocmd Filetype json setlocal ts=2 sw=2 sts=0 expandtab
" autocmd Filetype vimscript setlocal ts=4 sw=4 sts=0 expandtab
" autocmd Filetype yaml setlocal ts=2 sw=2 sts=0 expandtab
" autocmd Filetype css setlocal ts=2 sw=2 sts=0 expandtab
" autocmd Filetype scss setlocal ts=2 sw=2 sts=0 expandtab
" autocmd Filetype sql setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype go setlocal ts=8 sw=8 sts=0 expandtab

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

set completeopt=menuone,noselect

" " hrsh7th/nvim-compe
" let g:compe = {}
" let g:compe.enabled = v:true
" let g:compe.autocomplete = v:true
" let g:compe.debug = v:false
" let g:compe.min_length = 1
" let g:compe.preselect = 'enable'
" let g:compe.throttle_time = 80
" let g:compe.source_timeout = 200
" let g:compe.incomplete_delay = 400
" let g:compe.max_abbr_width = 100
" let g:compe.max_kind_width = 100
" let g:compe.max_menu_width = 100
" let g:compe.documentation = v:true
"
" let g:compe.source = {}
" let g:compe.source.path = v:true
" let g:compe.source.buffer = v:true
" let g:compe.source.calc = v:true
" let g:compe.source.nvim_lsp = v:true
" let g:compe.source.nvim_lua = v:true
" let g:compe.source.vsnip = v:true
"
" inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   --ignore_installed = {"julia"},
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"   },
"   indent = {
"     enable = true,              -- false will disable the whole extension
"   },
" }
" EOF

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()



lua require'lspconfig'.gopls.setup{}
