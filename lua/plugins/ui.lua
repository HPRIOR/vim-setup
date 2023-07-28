return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"danilamihailov/beacon.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	-- better vim.ui
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	-- Better `vim.notify()`
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
	},
	-- ui components
	{ "MunifTanjim/nui.nvim", lazy = true },
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local icons = require("config").icons()
			-- local Util = require("lazyvim.util")

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "alpha" } },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						}
					},
					lualine_x = {
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
						},
					},
					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},
					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "neo-tree", "lazy" },
			}
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{
				"<leader>t",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Explorer NeoTree (root dir)",
			},
		},
		dependencies = {
			"s1n7ax/nvim-window-picker",
			name = "window-picker",
			event = "VeryLazy",
			version = "2.*",
			config = function()
				require("window-picker").setup()
			end,
		},
	},
	-- {
	-- 	"fgheng/winbar.nvim",
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = true,
	-- 	opts = {
	-- 		enabled = true,
	-- 		show_file_path = true,
	-- 		show_symbols = true,
	--
	-- 		exclude_filetype = {
	-- 			"help",
	-- 			"startify",
	-- 			"dashboard",
	-- 			"packer",
	-- 			"neogitstatus",
	-- 			"NvimTree",
	-- 			"Trouble",
	-- 			"alpha",
	-- 			"lir",
	-- 			"Outline",
	-- 			"spectre_panel",
	-- 			"toggleterm",
	-- 			"qf",
	-- 		},
	-- 	},
	-- },
	{
		"SmiteshP/nvim-navic",
		lazy = true,
		opts = function()
			return {
				separator = " ",
				highlight = true,
				depth_limit = 5,
                icons = require("config").icons().kinds,
			}
		end,
	},
}
