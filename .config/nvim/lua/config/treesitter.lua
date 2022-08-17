require("nvim-treesitter.configs").setup {
  ensure_installed = { "c", "cpp", "lua", },
  sync_install = false,
  highlight = {
    enable = true,
    disable = { "c", "cpp", "java" }
  },
  playground = {
    enable = true,
  }
}

vim.cmd [[
  set foldmethod=expr
  set foldlevelstart=99
  set foldexpr=nvim_treesitter#foldexpr()

  highlight! cmakeTSVariable guifg=#81A2BE
]]
