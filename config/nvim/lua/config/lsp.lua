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
			cargo = {
				features = "all",
				allTargets = true,
			},
			check = {
				command = "clippy",
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

-- wgsl_analyzer wants to support wesl at some point, but does not at the moment
-- vim.lsp.config("wgsl_analyzer", {
-- 	filetypes = { "wgsl", "wesl" },
-- })
vim.lsp.enable("wgsl_analyzer")

vim.lsp.enable("bashls")
vim.lsp.enable("glsl_analyzer")
vim.lsp.enable("tinymist")
vim.lsp.enable("ty")

-- Diagnostics
vim.diagnostic.config({ virtual_text = true })

-- vim: ts=2 sts=2 sw=2 et
