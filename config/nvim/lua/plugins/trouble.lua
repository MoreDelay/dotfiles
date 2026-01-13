return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>ct",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Trouble: toggle panel",
			},
			{
				"]t",
				"<cmd>Trouble diagnostics next<cr>",
				desc = "Trouble: next trouble",
			},
			{
				"[t",
				"<cmd>Trouble diagnostics prev<cr>",
				desc = "Trouble: previous trouble",
			},
		},
	},
}

-- vim: ts=2 sts=2 sw=2 et
