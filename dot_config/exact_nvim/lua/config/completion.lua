vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
vim.opt.pumheight = 12
vim.opt.pumwidth = 28
vim.opt.pummaxwidth = 60
vim.opt.pumblend = 0
vim.opt.pumborder = "rounded"

vim.keymap.set("i", "<C-Space>", function()
	vim.lsp.completion.get()
end, { desc = "Trigger LSP completion" })

vim.keymap.set("i", "<Tab>", function()
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true, desc = "Next completion item" })

vim.keymap.set("i", "<S-Tab>", function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true, desc = "Previous completion item" })

vim.api.nvim_create_autocmd("CompleteChanged", {
	group = vim.api.nvim_create_augroup("native_completion_preview", { clear = true }),
	callback = function()
		vim.schedule(function()
			local preview = vim.fn.complete_info({ "preview_winid" }).preview_winid
			if not preview or preview == 0 or not vim.api.nvim_win_is_valid(preview) then
				return
			end

			pcall(vim.api.nvim_win_set_config, preview, {
				border = "rounded",
				title = " Documentation ",
				title_pos = "center",
			})
			vim.wo[preview].winblend = 0
			vim.wo[preview].winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder"
			vim.wo[preview].wrap = true
			vim.wo[preview].linebreak = true
			vim.wo[preview].breakindent = true
		end)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("native_lsp_completion", { clear = true }),
	callback = function(event)
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
		if not client:supports_method("textDocument/completion") then
			return
		end

		local provider = client.server_capabilities.completionProvider
		local trigger_characters = provider.triggerCharacters or {}
		for char = 32, 126 do
			local character = string.char(char)
			if not vim.tbl_contains(trigger_characters, character) then
				table.insert(trigger_characters, character)
			end
		end
		provider.triggerCharacters = trigger_characters

		vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
	end,
})
