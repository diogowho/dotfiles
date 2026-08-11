require("mason").setup()
require("mason-lspconfig").setup({
	automatic_enable = true,
	ensure_installed = {
		-- lsp servers
		"lua_ls",
		"astro",
		"bashls",
		"emmet_language_server",
		"cssls",
		"html",
		"jsonls",
		"just",
		"tailwindcss",
		"terraformls",
		"vimls",
		"vtsls",
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
