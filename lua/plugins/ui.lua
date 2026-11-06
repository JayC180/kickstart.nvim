return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'mocha',
      background = { light = 'latte', dark = 'mocha' },
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = false,
      styles = { comments = { 'italic' }, conditionals = { 'italic' } },
      integrations = {
        cmp = true,
        gitsigns = true,
        native_lsp = { enabled = true },
        treesitter = true,
        mini = { enabled = true },
      },
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  { 'nvchad/volt', lazy = true },
  { 'nvchad/menu', lazy = true },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {},
    config = function(_, opts)
      local which_key = require 'which-key'
      which_key.setup(opts)
      which_key.add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>x', group = 'Trouble' },
      }
    end,
  },
}
