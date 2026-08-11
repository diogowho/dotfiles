require("cord").setup({
	display = {
		theme = "catppuccin",
		flavor = "accent",
	},
})

require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 100,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%d-%m-%Y> - <summary>",
})

local navic = require("nvim-navic")
navic.setup({
	separator = " › ",
	highlight = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client.server_capabilities.documentSymbolProvider then
			navic.attach(client, event.buf)
		end
		vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
	end,
})

local neogit = require("neogit")
vim.keymap.set("n", "<leader>gg", neogit.open, { noremap = true, desc = "Open Neogit UI" })
