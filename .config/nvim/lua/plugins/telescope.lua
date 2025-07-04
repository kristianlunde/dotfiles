return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
      vim.api.nvim_set_keymap("n", "<Leader>fr", ":Telescope oldfiles<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<Leader>fm", ":Telescope lsp_document_symbols<CR>", { noremap = true, silent = true})
      require("telescope").load_extension("ui-select")
    end,
  },
}
        
