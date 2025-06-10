-- ~/.config/nvim/lua/plugins/llm.lua
return {
  'huggingface/llm.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    vim.g.current_llm_model = os.getenv("OLLAMA_MODEL") or "mistral"

     require("llm").setup({
      backend = "ollama",
      model = vim.g.current_llm_model,
      url = "http://localhost:11434", 
    })

    function ToggleLLMModel()
      if vim.g.current_llm_model == "mistral" then
        vim.g.current_llm_model = "deepseek-coder"
      else
        vim.g.current_llm_model = "mistral"
      end
      print("Switched LLM model to: " .. vim.g.current_llm_model)
      require("llm").setup({
        backend = "ollama",
        model = vim.g.current_llm_model,
      })
    end

    require("llm").setup({
      backend = "ollama",
      model = vim.g.current_llm_model,
    })

    vim.api.nvim_set_keymap("v", "<leader>ai", ":LLMChat<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>ms", ":lua ToggleLLMModel()<CR>", { noremap = true, silent = true })
  end,
}
