local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', install_path })
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'vim-scripts/vim-gradle'

  -- use '~/workspace/android.nvim/'

  use {
    'w0ng/vim-hybrid',
    config = [[require('config.hybrid')]]
  }

  use {
    'kyazdani42/nvim-web-devicons',
    config = function() require('nvim-web-devicons').setup() end,
  }

  use {
    'nvim-lualine/lualine.nvim',
    config = [[require('config.lualine')]]
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[require('config.treesitter')]],
  }

  use {
    'nvim-treesitter/playground',
    requires = 'nvim-treesitter/nvim-treesitter',
  }

  use {
    'editorconfig/editorconfig-vim',
    config = [[vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}]]
  }

  use {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'info',
        auto_session_suppress_dirs = { '~/', '~/workspace' }
      }
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
  }

  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }

  -- Navigation
  use {
    'phaazon/hop.nvim',
    branch = 'v1',
    config = [[require('config.hop')]],
    after = 'vim-hybrid',
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kelly-lin/telescope-ag',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = [[require('config.telescope')]],
    after = 'vim-hybrid',
  }

  -- Diffs
  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = [[require('config.diffview')]],
    after = 'vim-hybrid',
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
    },
    config = [[require('config.cmp')]],
    after = 'vim-hybrid',
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    requires = 'williamboman/nvim-lsp-installer',
    after = 'nvim-cmp',
    config = [[require('config.lsp')]],
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = [[require('config.null-ls')]],
  }

  use 'mfussenegger/nvim-dap'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
