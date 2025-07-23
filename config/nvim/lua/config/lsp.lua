vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", ".git" },
	settings = {
		["rust-analyzer"] = {
			hover = {
				memoryLayout = {
					niches = true,
				},
			},
		},
	},
})
vim.lsp.enable("rust_analyzer")

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--experimental-modules-support",
		-- "--log=verbose",
	},
	filetypes = { "cpp", "c" },
	root_markers = { "compile_commands.json", "CMakeLists.txt" },
})
vim.lsp.enable("clangd")

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
})
vim.lsp.enable("lua_ls")

vim.lsp.enable("bashls")
vim.lsp.enable("glsl_analyzer")
vim.lsp.enable("wgsl_analyzer")

-- vim: ts=2 sts=2 sw=2 et
