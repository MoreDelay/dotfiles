require('mason').setup({})

local lsp = require('lsp-zero')

require('mason-lspconfig').setup({
	handlers = {
		lsp.default_setup,
		lua_ls = function()
			local lua_opts = lsp.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		end,
	},
})
