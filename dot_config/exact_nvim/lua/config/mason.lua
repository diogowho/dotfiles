require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = true,
	ensure_installed = {
		-- lsp servers
		"lua_ls",
		"astro",
		"denols",
		"bashls",
		"emmet_language_server",
		"cssls",
		"html",
		"jsonls",
		"just",
		"tailwindcss",
		"terraformls",
		"vimls",
		"yamlls",
		"gopls",

		-- formatters
		"prettier",
		"prettierd",
		"stylua",
		"shfmt",
		"yamlfmt",
	},
})
