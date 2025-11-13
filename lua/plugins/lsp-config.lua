return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },

	config = function()
		-- Activate servers
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local servers = { "lua_ls", "ts_ls", "jdtls" }
		for _, name in ipairs(servers) do
			vim.lsp.config(name, {
				capabilities = capabilities,
			})
		end

		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		vim.keymap.set("n", "<F4>", vim.lsp.buf.format, {})
		vim.keymap.set("n", "gr", vim.lsp.buf.rename, {})
		vim.keymap.set("n", "gu", vim.lsp.buf.references, {})

		-- Diagnostics
		vim.diagnostic.config({
			virtual_lines = { current_line = true },
			virtual_text = true,
			signs = true,
			underline = true,
		})
		vim.lsp.config("lua_ls", {
			filetypes = { "lua" },
			root_markers = {
				".luarc.json",
				".luarc.jsonc",
				".luacheckrc",
				".stylua.toml",
				"stylua.toml",
				"selene.toml",
				"selene.yml",
				".git",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("data") .. "/lazy/blink.cmp/lua",
				},
			},
		})
	end,
}
