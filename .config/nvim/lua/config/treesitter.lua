require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'lua', 'comment', },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    disable = { 'c', 'cpp', 'java' },
  },
  playground = {
    enable = true,
  }
}

-- require "nvim-treesitter.highlight".set_custom_captures {
--   ["constant.nullptr"] = "number",
-- }
