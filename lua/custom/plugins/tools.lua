return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      'lewis6991/gitsigns.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require('neo-tree').setup {
        close_if_last_window = true,
        sources = { 'filesystem', 'git_status' },
        window = {
          width = 30,
          mappings = {
            ['h'] = 'close_node',
            ['l'] = 'open',
          },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
          },
        },
        git_status = {
          enabled = true,
          -- symbols = { added = '+', modified = 'o', removed = '-' },
        },
      }
    end,
  },
  -- {
  --   'neovim/nvim-lspconfig', -- REQUIRED: for native Neovim LSP integration
  --   lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
  --   dependencies = {
  --     -- main one
  --     { 'ms-jpq/coq_nvim', branch = 'coq' },
  --
  --     -- 9000+ Snippets
  --     { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
  --
  --     -- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
  --     -- Need to **configure separately**
  --     { 'ms-jpq/coq.thirdparty', branch = '3p' },
  --     -- - shell repl
  --     -- - nvim lua api
  --     -- - scientific calculator
  --     -- - comment banner
  --     -- - etc
  --   },
  --
  --   init = function()
  --     vim.g.coq_settings = {
  --       auto_start = true, -- if you want to start COQ at startup
  --       -- Your COQ settings here
  --     }
  --   end,
  --   config = function()
  --     -- Your LSP settings here
  --   end,
  -- },
}
