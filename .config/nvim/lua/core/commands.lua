-- custom global options
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.formatting_enabled = true
end, { bang = true })

vim.api.nvim_create_user_command('FormatDisable', function()
  vim.b.formatting_enabled = false
end, { bang = true })

-- Create parent directorys on saving
local ok, Path = pcall(require, 'plenary.path')

if ok then
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup('directory_save', { clear = true }),
    callback = function()
      Path:new(vim.fn.expand('%:h')):mkdir()
    end
  })
end

-- Abbreviations
vim.cmd [[
  inoreabbrev namesapce namespace
  inoreabbrev tempalte template
  inoreabbrev vnvoa vnova
  inoreabbrev tpyename typename
  inoreabbrev pubilc public
]]

-- Legacy autocmds that need converting
vim.cmd [[
" Make all parent directories and save the file
augroup FileCommands
  autocmd!

  " Change the title string to just the file name
  autocmd BufEnter * let &titlestring = expand("%:t")

  " Save whenever focus is lost
  autocmd BufLeave,FocusLost * silent! update
augroup END

augroup autoread_load
  au!
  au FocusGained,BufEnter * silent! checktime
augroup end

" C++

augroup filetype_cpp
  autocmd!

  " Use tabs instead of spaces in makefiles
  autocmd FileType make setlocal noexpandtab

  nnoremap <leader>ets vi{:s/\v(case )(.*::)?(.*):/& return "\3";<CR>
augroup END
]]
