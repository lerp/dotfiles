local map = vim.api.nvim_set_keymap
local buf_map = vim.api.nvim_buf_set_keymap
local M = {}

local function get_map_options(opts)
  return opts or { noremap = true, silent = true }
end

local function get_map_modes(modes)
  if type(modes) == 'string' then
    return { modes }
  end

  return modes
end

function M.map(modes, shortcut, command, opts)
  opts = get_map_options(opts)
  modes = get_map_modes(modes)

  for _, mode in ipairs(modes) do
    map(mode, shortcut, command, opts)
  end
end

function M.nmap(shortcut, command, opts)
  M.map('n', shortcut, command, opts)
end

function M.imap(shortcut, command, opts)
  M.map('i', shortcut, command, opts)
end

function M.vmap(shortcut, command, opts)
  M.map('v', shortcut, command, opts)
end

function M.buf_map(bufnr, modes, shortcut, command, opts)
  opts = get_map_options(opts)
  modes = get_map_modes(modes)

  for _, mode in ipairs(modes) do
    buf_map(bufnr, mode, shortcut, command, opts)
  end
end

function M.buf_nmap(bufnr, shortcut, command, opts)
  M.buf_map(bufnr, 'n', shortcut, command, opts)
end

function M.set_options(options)
  for key, value in pairs(options) do
    vim.o[key] = value
  end
end

function M.append_options(options)
  for key, value in pairs(options) do
    vim.opt[key]:append(value)
  end
end

return M
