local group = vim.api.nvim_create_augroup('jay-config', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  desc = 'Highlight yanked text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Neovim 0.12 ships parsers for the core filetypes used by this config.
-- Starting Tree-sitter directly avoids the incompatible nvim-treesitter branch split.
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  desc = 'Enable native Tree-sitter highlighting when a parser is available',
  pattern = { 'bash', 'c', 'diff', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
  callback = function(event)
    pcall(vim.treesitter.start, event.buf)
  end,
})
