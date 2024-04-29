return {
  "tpope/vim-eunuch",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  "nvim-tree/nvim-web-devicons",
  "equalsraf/neovim-gui-shim",

  {
    "seblj/nvim-tabline",
    opts = {},
  },

  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  {
    "natecraddock/sessions.nvim",
    dependencies = {
      "natecraddock/workspaces.nvim",
    },
    opts = {},
    config = function()
      local sessions = require("sessions")

      sessions.setup {
        events = { "VimLeavePre" },
        session_filepath = vim.fn.stdpath("data") .. "sessions",
      }

      require("workspaces").setup {
        hooks = {
          open = function()
            sessions.load(nil, { silent = true })
          end
        }
      }
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}
