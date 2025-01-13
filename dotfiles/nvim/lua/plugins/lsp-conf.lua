return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.nil_ls.setup({ capabilities = capabilities })
			lspconfig.tinymist.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
		end,
	},
}
