--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		-- helper function to set key bindings
		local map = function(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- display signature for the function call you are currently in
		map("i", "<C-s>", vim.lsp.buf.signature_help, "show signature")
		map("n", "<C-s>", vim.lsp.buf.signature_help, "show signature")

		-- local builtin = require("telescope.builtin")
		local fzf = require("fzf-lua")

		map("n", "gd", fzf.lsp_definitions, "[G]oto [D]efinition")
		map("n", "gr", fzf.lsp_references, "[G]oto [R]eferences")
		map("n", "gI", fzf.lsp_implementations, "[G]oto [I]mplementation")
		map("n", "<leader>D", fzf.lsp_typedefs, "Type [D]efinition")
		map("n", "<leader>ds", fzf.lsp_document_symbols, "[D]ocument [S]ymbols")
		map("n", "<leader>ws", fzf.lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
		map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("n", "<leader>ci", fzf.lsp_incoming_calls, "[C]ode [I]ncoming Calls")
		map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
		map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detack", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- Native Autocompletion
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, event.buf) then
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })
		end

		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("n", "<leader>ch", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[C]ode [H]ints")
		end
	end,
})
-- vim: ts=2 sts=2 sw=2 et
