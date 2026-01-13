return {

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- Use `opts = {}` to force a plugin to be loaded.
	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function()
				local gitsigns = require("gitsigns")

				vim.keymap.set("n", "<leader>gl", gitsigns.blame, { desc = "[G]it B[L]ame" })

				-- working with hunks
				vim.keymap.set("n", "]h", function()
					gitsigns.nav_hunk("next")
				end, { desc = "Next Git hunk" })

				vim.keymap.set("n", "[h", function()
					gitsigns.nav_hunk("prev")
				end, { desc = "Previous Git hunk" })

				vim.keymap.set("n", "<leader>hq", function()
					gitsigns.setqflist(0, { open = false })
				end, { desc = "[H]unk [Q]uicklist (current file)" })

				vim.keymap.set("n", "<leader>hQ", function()
					gitsigns.setqflist("all", { open = false })
				end, { desc = "[H]unk [Q]uicklist (all files)" })

				vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk [S]tage (toggle)" })
				vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })
			end,
		},
	},

	-- Useful plugin to show you pending keybinds.
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").add({
				{ "<leader>b", group = "De[B]ug" },
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>cf", group = "[C]ode [F]ormat" },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>h", group = "[H]unk" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
			})
		end,
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
			-- - gsaiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - gsd'   - [S]urround [D]elete [']quotes
			-- - gsr)'  - [S]urround [R]eplace [)] [']
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

	-- make all "[#" and "]#" commands repeatable with ";" and ","
	{
		"mawkler/demicolon.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {},
	},
}
-- vim: ts=2 sts=2 sw=2 et
