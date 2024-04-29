return {
  "tpope/vim-fugitive",

  {
    "sindrets/diffview.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>fh", "<cmd>DiffviewFileHistory %<cr>" },
      { "<leader>cd", "<cmd>DiffviewClose<cr>" },
    }
  },
}
