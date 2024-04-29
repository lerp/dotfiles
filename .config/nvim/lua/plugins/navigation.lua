return {
  {
    "stevearc/oil.nvim",
    opts = {},
    keys = {
      { "<leader>F", "<cmd>Oil --float<cr>" },
    },
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    keys = {
      { "<leader>j", "<cmd>HopWord<CR>" },
    },
    config = function()
      require("hop").setup {
        keys = "etovxqpdygfblzhckisuran",
      }

      require("util").highlight {
        HopNextKey  = { bold = true, fg = "#FF9800" },
        HopNextKey1 = { bold = true, fg = "#C792EA" },
        HopNextKey2 = { fg = "#82AAFF" },
        HopUnmatched = { link = "Comment" },
      }
    end,
  },
}
