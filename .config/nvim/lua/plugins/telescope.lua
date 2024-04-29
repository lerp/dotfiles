return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<C-P>",     "<cmd>Telescope find_files<CR>" },
      { "<leader>b", "<cmd>Telescope buffers<CR>" },
      { "gr",        "<cmd>Telescope lsp_references<CR>" },
      { "gd",        "<cmd>Telescope lsp_definitions<CR>" },
      { "vd",        "<cmd>Telescope lsp_definitions jump_type=vsplit reuse_win=true<CR>" },
      { "<leader>v", "<cmd>Telescope lsp_document_symbols<CR>" },
      { "<leader>d", "<cmd>Telescope diagnostics bufnr=0<CR>" },
      { "<leader>D", "<cmd>Telescope diagnostics<CR>" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ["<ESC>"] = actions.close,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        },
      }

      require("util").highlight {
        TelescopeNormal         = { fg = "#B0BEC5", bg = "#212121", },
        TelescopePromptBorder   = { fg = "#343434", bg = "#212121", },
        TelescopeResultsBorder  = { fg = "#343434", bg = "#212121", },
        TelescopePreviewBorder  = { fg = "#343434", bg = "#212121", },
        TelescopeSelectionCaret = { fg = "#C792EA", },
        TelescopeSelection      = { fg = "#C792EA", bg = "#323232", },
        TelescopeMatching       = { fg = "#89DDFF", },
      }
    end,
  },
  {
    "kelly-lin/telescope-ag",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Ag",
    config = function()
      require('telescope-ag').setup {}
      require('telescope').load_extension('ag')
    end
  }
}
