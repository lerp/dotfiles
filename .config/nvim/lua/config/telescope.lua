local nmap = require('util').nmap
local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<ESC>'] = actions.close,
      },
    },
    file_ignore_patterns = {
      'build.*/.*',
      'env.*/.*',
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    }
  },
}

telescope.load_extension('fzf')
telescope.load_extension('ag')

nmap('<C-P>', '<cmd>Telescope find_files<CR>')
nmap('<leader>b', '<cmd>Telescope buffers<CR>')
nmap('gr', '<cmd>Telescope lsp_references<CR>')
nmap('gd', '<cmd>Telescope lsp_definitions<CR>')
nmap('<leader>v', '<cmd>Telescope lsp_document_symbols<CR>')
nmap('<leader>d', '<cmd>Telescope diagnostics bufnr=0<CR>')
nmap('<leader>D', '<cmd>Telescope diagnostics<CR>')

vim.cmd [[
  highlight! TelescopeNormal guifg=#B0BEC5 guibg=#212121
  highlight! TelescopePromptBorder guifg=#343434 guibg=#212121
  highlight! TelescopeResultsBorder guifg=#343434 guibg=#212121
  highlight! TelescopePreviewBorder guifg=#343434 guibg=#212121
  highlight! TelescopeSelectionCaret guifg=#C792EA
  highlight! TelescopeSelection guifg=#C792EA guibg=#323232
  highlight! TelescopeMatching guifg=#89DDFF
]]
