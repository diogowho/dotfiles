require("catppuccin").setup({
	flavour = "auto",
	transparent_background = true,
	float = {
		transparent = true,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
	},
	integrations = {
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "undercurl" },
				hints = { "undercurl" },
				warnings = { "undercurl" },
				information = { "undercurl" },
			},
		},
		lsp_trouble = true,
		gitsigns = true,
		telescope = {
			enabled = true,
		},
		mini = {
			enabled = true,
		},
		navic = {
			enabled = true,
			custom_bg = "NONE",
		},
	},
})

vim.cmd.colorscheme("catppuccin-nvim")
vim.cmd("highlight PmenuSel blend=0")
