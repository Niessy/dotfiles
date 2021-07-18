-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- -- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
-- Packer can manage itself
use 'wbthomason/packer.nvim'

-- Simple plugins can be specified as strings
use '9mm/vim-closer'

  -- You can specify multiple plugins in a single call
  -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
use 'sheerun/vim-polyglot'
use 'JuliaEditorSupport/julia-vim'

use 'junegunn/vim-easy-align'
use 'tomtom/tcomment_vim'

use 'tpope/vim-fugitive'
use 'junegunn/gv.vim'
use 'godlygeek/tabular'

use 'norcalli/nvim-colorizer.lua'
use 'junegunn/rainbow_parentheses.vim'

use 'airblade/vim-rooter'

use 'justinmk/vim-sneak'

use 'vim-airline/vim-airline'
use 'vim-airline/vim-airline-themes'

use 'DanilaMihailov/beacon.nvim'

-- Post-install/update hook with neovim command
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
use 'nvim-treesitter/playground'

use 'neovim/nvim-lspconfig'
use 'hrsh7th/nvim-compe'

use 'nvim-lua/popup.nvim'
use 'nvim-lua/plenary.nvim'

use 'nvim-telescope/telescope.nvim'
use 'nvim-telescope/telescope-fzy-native.nvim'
use 'nvim-telescope/telescope-github.nvim'
use 'nvim-telescope/telescope-packer.nvim'

use 'RRethy/nvim-base16'

end)
