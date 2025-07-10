return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
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
