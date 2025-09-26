return {
  {
    "tpope/vim-dadbod",
    lazy = true,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIFindBuffer", "DBUIRenameBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = function() 
      vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle Dadbod-UI" })

      -- Run current line
      vim.keymap.set("n", "<leader>r", ":.DB<CR>", { desc = "Run current line as SQL" })

      -- Run visual selection
      vim.keymap.set("v", "<leader>r", ":DB<CR>", { desc = "Run selection as SQL" })


    end
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "tpope/vim-dadbod" },
  },
}
