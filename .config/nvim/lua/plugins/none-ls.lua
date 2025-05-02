return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.diagnostics.phpcs, -- PHP formatting linting
				null_ls.builtins.diagnostics.phpmd, -- PHP mess detector
				null_ls.builtins.diagnostics.phpstan, -- PHP Static analyzis
				null_ls.builtins.formatting.duster, -- Laravel formatting
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
