return {
	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"mason-org/mason.nvim", -- install tools with :Mason
		config = function()
			require("mason").setup()
		end,
	},
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	{ "j-hui/fidget.nvim", opts = {} }, -- lsp diagnostics
	"neovim/nvim-lspconfig", -- default configurations so we can just enable vim.lsp.enable(...)
}
-- vim: ts=2 sts=2 sw=2 et
