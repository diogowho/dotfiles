vim.lsp.config("*", {
	root_markers = { ".git" },
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})

local servers = {
	astro = {},

	emmet_language_server = {
		filetypes = {
			"vue",
			"astro",
			"css",
			"html",
		},
	},

	jsonls = {
		settings = {
			json = {
				validate = { enable = true },
				schemas = {
					{
						fileMatch = { "package.json" },
						url = "https://www.schemastore.org/package.json",
					},
					{
						fileMatch = { "tsconfig*.json" },
						url = "https://www.schemastore.org/tsconfig.json",
					},
				},
			},
		},
	},

	just = {},

	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				hint = { enable = true },
			},
		},
	},

	nil_ls = {
		cmd = { "nil" },
		settings = {
			["nil"] = {
				formatting = {
					command = { "nixfmt" },
				},
				diagnostics = {
					bindingEndHintMinLines = 2,
				},
				nix = { maxMemoryMB = nil },
			},
		},
	},

	nixd = {},

	rust_analyzer = {},

	tailwindcss = {
		filetypes = {
			"vue",
			"astro",
			"javascriptreact",
			"typescriptreact",
			"html",
			"css",
		},
	},

	vtsls = {},

	yamlls = {
		settings = {
			yaml = {
				completion = true,
				validate = true,
				suggest = {
					parentSkeletonSelectedFirst = true,
				},
				schemas = {
					["https://www.schemastore.org/github-workflow.json"] = ".github/workflows/*",
					["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml,yaml}",
				},
			},
			redhat = {
				telemetry = {
					enable = false,
				},
			},
		},
	},
}
for server, config in pairs(servers) do
	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
	},
})

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "LSP Hover Documentation" })
