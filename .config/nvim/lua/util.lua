local M = {}

local function get_map_options(opts)
  return opts or { noremap = true, silent = true }
end

function M.map(modes, shortcut, command, opts)
  opts = get_map_options(opts)

  vim.keymap.set(modes, shortcut, command, opts)
end

function M.set_leader(key)
  vim.g.mapleader = key
  vim.g.maplocalleader = key

  M.map({ "n", "v" }, key, "<nop>")
end

function M.buf_map(bufnr, modes, shortcut, command, opts)
  opts = get_map_options(opts)
  opts.buffer = bufnr

  vim.keymap.set(modes, shortcut, command, opts)
end

function M.set_signs(signs)
  for sign, text in pairs(signs) do
    vim.fn.sign_define(sign, { texthl = sign, numhl = sign, text = text })
  end
end

function M.highlight(highlights)
  for group, properties in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, properties)
  end
end

return M
