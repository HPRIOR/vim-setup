local gl = require("galaxyline")
local colors = {
    bg = "#252526", fg = "#ffffff",
    yellow = "#ffaf00",
    dark_yellow = "#D7BA7D",
    yelloworrange = "#d,7ba7d",
    cyan = "#4EC9B0",
    green = "#619955",
    bluegreen = "#4ec9b0",
    light_green = "#B5CEA8",
    string_orange = "#CE9178",
    orange = "#FF8800",
    purple = "#C586C0",
    magenta = "#D16D9E",
    grey = "#858585",
    blue = "#0a7aca",
    vivid_blue = "#4FC1FF",
    light_blue = "#5CB6F8",
    red = "#f44747",
    error_red = "#F44747",
    info_yellow = "#FFCC66",
    pink = "#c586c0"
}
local condition = require("galaxyline.condition")
local gls = gl.section
gl.short_line_list = {"NvimTree", "vista", "dbui"}

gls.left[1] = {
		FirstElement = {
			provider = function()
				return ' '
			end,
			highlight = { colors.bg, colors.bg },
		},
	}
gls.left[2] = {
    ViMode = {
        provider = function()
            -- auto change color according the vim mode
            local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.purple,
                V = colors.purple,
                c = colors.magenta,
                no = colors.blue,
                s = colors.orange,
                S = colors.orange,
                ic = colors.yellow,
                R = colors.red,
                Rv = colors.red,
                cv = colors.blue,
                ce = colors.blue,
                r = colors.cyan,
                rm = colors.cyan,
                ["r?"] = colors.cyan,
                ["!"] = colors.blue,
                t = colors.blue
            }
            vim.api.nvim_command(
                mode_color[vim.fn.mode()] and "hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()] or ""
            )
            return "▊ "
        end,
        highlight = {colors.red, colors.bg}
    }
}
print(vim.fn.getbufvar(0, "ts"))
vim.fn.getbufvar(0, "ts")

gls.left[3] = {
		GitIcon = {
			provider = function()
				return ''
			end,
			condition = condition.check_git_workspace,
			separator = ' ',
			separator_highlight = { colors.bg, colors.bg },
			highlight = { colors.pink, colors.bg },
		},
	}

	gls.left[4] = {
		GitBranch = {
			provider = 'GitBranch',
			condition = condition.check_git_workspace,
			separator = ' ',
			separator_highlight = { colors.bg, colors.bg },
			highlight = { colors.pink, colors.bg },
		},
	}

	gls.left[5] = {
		ShowLspClient = {
			provider = 'GetLspClient',
			condition = function()
				local tbl = { ['dashboard']= true, [''] = true }
				if tbl[vim.bo.filetype] then
					return false
				end
				return true
			end,
			separator = ' ',
			separator_highlight = { colors.bg, colors.bg },
			highlight = { colors.bluegreen, colors.bg },
		},
	}

	gls.left[6] = {
		DiagnosticError = {
			provider = 'DiagnosticError',
			icon = ' ',
			highlight = { colors.red, colors.bg },
		},
	}
	gls.left[7] = {
		DiagnosticWarn = {
			provider = 'DiagnosticWarn',
			icon = ' ',
			highlight = { colors.yellow, colors.bg },
		},
	}

	gls.left[8] = {
		DiagnosticHint = {
			provider = 'DiagnosticHint',
			icon = ' ',
			highlight = { colors.pink, colors.bg },
		},
	}

	gls.left[9] = {
		DiagnosticInfo = {
			provider = 'DiagnosticInfo',
			icon = ' ',
			highlight = { colors.lightblue, colors.bg },
		},
	}

gls.right[1] = {
		FileSize = {
			provider = 'FileSize',
			condition = condition.buffer_not_empty,
			highlight = { colors.fg, colors.bg },
		},
	}

	gls.right[2] = {
		LineInfo = {
			provider = 'LineColumn',
			highlight = { colors.fg, colors.bg },
		},
	}

	gls.right[3] = {
		PerCent = {
			provider = 'LinePercent',
			highlight = { colors.fg, colors.bg },
		},
	}

	gls.right[4] = {
		FileEncode = {
			provider = 'FileEncode',
			condition = condition.hide_in_width,
			separator = ' ',
			separator_highlight = { colors.bg, colors.bg },
			highlight = { colors.fg, colors.bg },
		},
	}

	gls.right[5] = {
		FileFormat = {
			provider = 'FileFormat',
			condition = condition.hide_in_width,
			separator = ' ',
			separator_highlight = { colors.bg, colors.bg },
			highlight = { colors.fg, colors.bg },
		},
	}

	gls.right[6] = {
		FileIcon = {
			provider = 'FileIcon',
			condition = condition.buffer_not_empty,
			separator = ' ',
			separator_highlight = { colors.bg, colors.bg },
			-- highlight = { require('galaxyline.fileinfo').get_file_icon_color, colors.bg },
		},
	}

	gls.right[7] = {
		FileName = {
			provider = 'FileName',
			condition = condition.buffer_not_empty,
			highlight = { colors.green, colors.bg },
		},
	}

	gls.short_line_left[1] = {
		BufferType = {
			provider = 'FileTypeName',
			highlight = { colors.blue, colors.bg, 'bold' },
		},
	}

	gls.short_line_left[2] = {
		SFileName = {
			provider = 'SFileName',
			condition = condition.buffer_not_empty,
			highlight = { colors.bg, colors.bg },
		},
	}

	gls.short_line_right[1] = {
		BufferIcon = {
			provider = 'BufferIcon',
			highlight = { colors.bg, colors.bg },
		},
	}
