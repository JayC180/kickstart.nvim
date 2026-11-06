local servers = {
  bashls = {},
  clangd = {},
  cssls = {},
  gopls = {},
  html = {},
  jdtls = {},
  lua_ls = {
    settings = { Lua = { completion = { callSnippet = 'Replace' } } },
  },
  pyright = {},
  ts_ls = {},
}

return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = { { path = 'luvit-meta/library', words = { 'vim%.uv' } } },
    },
    dependencies = { { 'Bilal2453/luvit-meta', lazy = true } },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.diagnostic.config {
        virtual_text = true,
        float = { border = 'rounded', source = 'always' },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      }
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror' })

      local attach_group = vim.api.nvim_create_augroup('jay-lsp-attach', { clear = true })
      local highlight_group = vim.api.nvim_create_augroup('jay-lsp-highlight', { clear = true })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = attach_group,
        callback = function(event)
          local map = function(keys, action, desc)
            vim.keymap.set('n', keys, action, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local telescope = require 'telescope.builtin'
          map('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
          map('gr', telescope.lsp_references, '[G]oto [R]eferences')
          map('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', telescope.lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method 'textDocument/documentHighlight' then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.clear_references,
            })
          end
          if client and client:supports_method 'textDocument/inlayHint' then
            map('<leader>th', function()
              local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = attach_group,
        callback = function(event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = highlight_group, buffer = event.buf }
        end,
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local server_names = vim.tbl_keys(servers)
      table.sort(server_names)
      require('mason-lspconfig').setup {
        ensure_installed = server_names,
        automatic_enable = false,
      }
      require('mason-tool-installer').setup {
        ensure_installed = { 'rust-analyzer', 'stylua' },
      }
      for name, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end
    end,
  },
}
