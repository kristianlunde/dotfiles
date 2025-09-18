-- ~/.config/nvim/lua/plugins/lsp-config.lua
return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      auto_install = true,
      ensure_installed = { "lua_ls", "ts_ls", "html", "solargraph", "intelephense" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- define configs (no .setup)
      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.config("html", { capabilities = capabilities })
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })
      vim.lsp.config("intelephense", { capabilities = capabilities })

      -- enable servers
      for _, name in ipairs({ "ts_ls", "solargraph", "html", "lua_ls", "intelephense" }) do
        vim.lsp.enable(name)
      end

      -- keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>gc", ":cclose<CR>", { desc = "Close quickfix list" })
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, {})
    end,
  },
}

