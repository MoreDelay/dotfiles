return {

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- Use `opts = {}` to force a plugin to be loaded.
	--  This is equivalent to:
	--    require('Comment').setup({})
	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
	--    require('gitsigns').setup({ ... })
	--
	-- See `:help gitsigns` to understand what the configuration keys do
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				local map = function(mode, keys, func, desc)
					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
				end
				map("n", "<leader>gb", gitsigns.blame, "[G]it [B]lame")
			end,
		},
	},

	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--  event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `config` key, the configuration only runs
	-- after the plugin has been loaded:
	--  config = function() ... end

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").add({
				{ "<leader>b", group = "De[B]ug" },
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
			})
		end,
	},

	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin

	{ -- Autoformat
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
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available from the list
				-- javascript = { { "prettierd", "prettier", stop_after_first = true } },
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

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			local spec_pair = require("mini.ai").gen_spec.pair
			require("mini.ai").setup({
				custom_textobjects = {
					["|"] = spec_pair("|", "|", { type = "non-balanced" }),
				},
				n_lines = 500,
			})

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			-- see :h MiniSurround.config
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup({
				mappings = {
					add = "gsa",
					delete = "gsd",
					replace = "gsr",
					find = "gsf",
					find_left = "gsF",
					highlight = "gsh",
					update_n_lines = "gsn",

					suffix_last = "N",
					suffix_next = "n",
				},

				search_method = "cover_or_next",
			})

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},

	-- switch between tmux and nvim windows easily with the same key bindings
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateRight",
			"TmuxNavigateUp",
			"TmuxNavigateDown",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		},
	},

	-- show identation and scope guide lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			scope = { show_start = false, show_end = false },
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
