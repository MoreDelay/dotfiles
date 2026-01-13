return {
	-- Autoformat
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
			{
				"<leader>cft",
				function()
					vim.g.disable_autoformat = not vim.g.disable_autoformat
					local msg = "Autoformat: " .. (vim.g.disable_autoformat and "disabled" or "enabled")
					vim.api.nvim_echo({ { msg, "ModeMsg" } }, false, {})
				end,
				mode = "",
				desc = "[C]ode [F]ormat [T]oggle on save",
			},
			{
				"<leader>cfr",
				function()
					vim.g.rust_nightly_fmt = not vim.g.rust_nightly_fmt
					local msg = "Rustfmt: " .. (vim.g.rust_nightly_fmt and "nightly" or "stable")
					vim.api.nvim_echo({ { msg, "ModeMsg" } }, false, {})
				end,
				mode = "",
				desc = "[C]ode [F]ormat [R]ust Nightly",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = false }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_fallback = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- rust = { "rustfmt" },
				rust = function()
					if vim.g.rust_nightly_fmt then
						return { "rustfmt_nightly" }
					else
						return { "rustfmt" }
					end
				end,
				cpp = { "clang-format" },
				typst = { "typstyle" },
			},
			formatters = {
				rustfmt_nightly = {
					command = "rustfmt",
					args = { "+nightly" },
					stdin = true,
				},
			},
		},
	},
}

-- vim: ts=2 sts=2 sw=2 et
