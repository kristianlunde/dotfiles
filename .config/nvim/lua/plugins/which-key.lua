return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Optional: your configuration here
    -- leave empty to use defaults
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
