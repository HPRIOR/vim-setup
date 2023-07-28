local keymap = require("keymap")
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			diagnostics = {
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			},
			inlay_hints = {
				enabled = false,
			},
			capabilities = {},
			autoformat = true,
			servers = {
				-- servers defined here will be passed to the
				lua_ls = {
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
								path = vim.split(package.path, ";"),
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								},
							},
						},
					},
				},
			},
			setup = {},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local mason_lsp_config = require("mason-lspconfig")
			-- for winbar lsp help
			local navic = require("nvim-navic")

			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			}

			local lsp_capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			local on_attach = function(client, bufnr)
				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end
				keymap.bind_lsp(bufnr)
			end

			mason_lsp_config.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = on_attach,
						capabilities = lsp_capabilities,
						settings = opts.servers[server_name] and opts.servers[server_name].settings or {},
						handlers = handlers,
					})
				end,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
}
