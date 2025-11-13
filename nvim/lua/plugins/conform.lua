return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				java = { "google-java-format" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				-- I recommend these options. See :help conform.format for details.
				lsp_format = "fallback",
				timeout_ms = 500,
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				conform.format({ bufnr = args.buf })
			end,
		})

		vim.keymap.set("n", "<leader>gf", function()
			conform.format({ async = true, lsp_fallback = true, timeout_ms = 500 })
		end, { desc = "Format current buffer" })

		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
