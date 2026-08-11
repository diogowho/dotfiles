require("formatter").setup({
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },
		sh = { require("formatter.filetypes.sh").shfmt },
		typescript = { require("formatter.filetypes.typescript").prettierd },
		astro = { require("formatter.filetypes.typescript").prettierd },
		javascript = { require("formatter.filetypes.javascript").prettierd },
		json = { require("formatter.filetypes.json").prettierd },
		html = { require("formatter.filetypes.html").prettierd },
		terraform = { require("formatter.filetypes.terraform").terraformfmt },
		yaml = { require("formatter.filetypes.yaml").yamlfmt },
		go = { require("formatter.filetypes.go").gofmt },
	},
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
