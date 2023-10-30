return {
	{
		"Shatur/neovim-ayu",
		event = "VimEnter",
		config = function()
			local colors, is_mirage = require "ayu.colors", false
			colors.generate(is_mirage)
			require("ayu").setup {
				mirage = is_mirage,
				overrides = function()
					return {
						["@function"] = { bold = true, fg = colors.func },
						["@function.builtin"] = { bold = true, fg = colors.accent },
						FloatBorder = { bg = colors.panel_border, fg = colors.guide_normal },
						GitSignsAddLn = { link = "DiffAdd" },
						Keyword = { italic = false, fg = colors.keyword },
						LineNr = { fg = colors.comment },
						NormalFloat = { bg = colors.panel_border },
						PmenuSel = { bg = colors.selection_bg, fg = "NONE" },
						TelescopeBorder = { fg = colors.selection_inactive },
						TelescopePreviewBorder = { bg = colors.panel_border, fg = colors.panel_border },
						TelescopePreviewNormal = { bg = colors.panel_border },
						TelescopePromptBorder = { fg = colors.line, bg = colors.line },
						TelescopePromptNormal = { bg = colors.line },
						TelescopeResultsBorder = { fg = colors.panel_shadow, bg = colors.panel_shadow },
						TelescopeResultsNormal = { fg = colors.fg, bg = colors.panel_shadow },
						TelescopeTitle = { fg = colors.ui, bold = true },
					}
				end,
			}
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		event = "VimEnter",
		-- build = [[
		--   cp extras/*.conf ~/.config/kitty/themes/
		--   cd extras/;
		--   for THEME in alacritty*; do
		--     DASHED=$(echo "$THEME" | sed 's/alacritty_//' | awk '{ sub("_","-"); print $1 }');
		--     cp "$THEME" ~/.config/alacritty/themes/"$DASHED";
		--   done
		--   cd ../;
		--   ]],
		opts = {
			compile = true,
			functionStyle = { bold = true },
			keywordStyle = { italic = false, bold = false },
			transparent = require("user.config").transparent,
			theme = "wave",
			background = { dark = "wave", light = "lotus" }, --wave dragon
			colors = {
				theme = { all = { ui = { bg_gutter = "none" } } },
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					Boolean = { bold = false },
					IndentBlanklineChar = { fg = theme.ui.bg_p2 },
					IndentBlanklineContextChar = { fg = theme.ui.whitespace },
					MatchParen = { bg = theme.ui.bg_p1 },
					MatchWord = { bg = theme.ui.bg_p1 },
					MoreMsg = { bg = "NONE" },
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeSelection = { bg = theme.ui.bg_p2 },
					TelescopeSelectionCaret = { bg = theme.ui.bg_p2 },
					TelescopeTitle = { fg = theme.ui.special, bold = true },
				}
			end,
		},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		event = "VimEnter",
		opts = {
			dark_variant = "main", --- @usage 'main' | 'moon'
			dim_nc_background = false,
			disable_background = require("user.config").transparent,
			disable_float_background = false,
			highlight_groups = {
				["@function"] = { bold = true, fg = "rose" },
				["@function.builtin"] = { bold = true, fg = "love" },
				["@method"] = { bold = true, fg = "iris" },
				["@parameter"] = { fg = "iris", italic = false },
				["@property"] = { fg = "foam", italic = false },
				["@variable"] = { italic = false },
				FloatBorder = { bg = "surface", fg = "highlight_med" },
				IndentBlanklineChar = { fg = "highlight_med" },
				IndentBlanklineContextChar = { fg = "subtle" },
				Keyword = { fg = "pine", italic = false },
				MatchParen = { bg = "muted", blend = 30 },
				MatchWord = { bg = "muted", blend = 30 },
				Pmenu = { bg = "surface", fg = nil },
				PmenuSel = { bg = "highlight_med", fg = nil },
				TelescopePreviewBorder = { bg = "nc", fg = "nc" },
				TelescopePreviewNormal = { bg = "nc" },
				TelescopePromptBorder = { fg = "overlay", bg = "overlay" },
				TelescopePromptNormal = { bg = "overlay" },
				TelescopeResultsBorder = { fg = "surface", bg = "surface" },
				TelescopeResultsNormal = { bg = "surface" },
				TelescopeTitle = { fg = "rose", bold = true },
			},
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		event = "VimEnter",
		opts = {
			transparent_background = require("user.config").transparent,
			styles = {
				comments = { "italic" },
				functions = { "bold" },
				keywords = {},
				conditionals = {},
			},
			custom_highlights = function(colors)
				return {
					["@parameter"] = { style = {} },
					["@tag.attribute"] = { style = {} },
					["@tag.attribute.tsx"] = { fg = colors.sapphire, style = {} },
					FloatBorder = { bg = colors.mantle, fg = colors.surface1 },
					HarpoonWindow = { bg = colors.mantle },
					IndentBlanklineContextChar = { fg = colors.overlay1 },
					MatchParen = { bg = colors.surface0, fg = colors.pink },
					MatchWord = { bg = colors.surface0 },
					NormalFloat = { bg = colors.mantle },
					Pmenu = { bg = colors.mantle },
					PmenuSel = { fg = "NONE" },
					TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
					TelescopePreviewNormal = { bg = colors.crust },
					TelescopePromptBorder = { fg = colors.surface0, bg = colors.surface0 },
					TelescopePromptNormal = { bg = colors.surface0 },
					TelescopeResultsBorder = { fg = colors.mantle, bg = colors.mantle },
					TelescopeResultsNormal = { fg = colors.text, bg = colors.mantle },
					TelescopeSelection = { bg = colors.surface0, style = {} },
					TelescopeSelectionCaret = { bg = colors.surface0 },
					TelescopeTitle = { fg = colors.lavender, style = { "bold" } },
					Visual = { style = {} },
				}
			end,
			integrations = {
				cmp = true,
				dap = { enabled = true, enable_ui = true },
				gitsigns = true,
				harpoon = true,
				leap = true,
				markdown = true,
				mason = true,
				nvimtree = true,
				telescope = true,
				treesitter = true,
				treesitter_context = false,
				notifier = true,
				vimwiki = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						information = { "underline" },
						warnings = { "underline" },
					},
				},
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		event = "VimEnter",
		-- build = [[
		--   cd extras/alacritty/;
		--   for THEME in tokyonight*; do
		--     DASHED=$(echo "$THEME" | awk '{ sub("_","-",$1); print $1 }');
		--     cp "$THEME" ~/.config/alacritty/themes/"$DASHED";
		--   done
		--   cd ../;
		--
		--   ]],
		opts = {
			style = "night", --  `storm`, `moon`, `night` and `day`
			transparent = require("user.config").transparent,
			day_brightness = 0.0,
			styles = {
				comments = { italic = true },
				functions = {},
				keywords = { italic = false },
				sidebars = "normal",
				variables = {},
			},
			on_highlights = function(hl, c)
				hl["@function"] = { bold = true, fg = c.blue }
				hl.DiagnosticUnderlineError = { undercurl = nil, underline = true }
				hl.DiagnosticUnderlineHint = { undercurl = nil, underline = true }
				hl.DiagnosticUnderlineInfo = { undercurl = nil, underline = true }
				hl.DiagnosticUnderlineWarn = { undercurl = nil, underline = true }
				hl.FloatBorder = { fg = c.fg_gutter, bg = c.bg_float }
				hl.IndentBlanklineChar = { fg = c.bg_highlight }
				hl.IndentBlanklineContextChar = { fg = c.dark3 }
				hl.LeapBackdrop = {}
				-- hl.LeapLabelPrimary = { bg = c.magenta2, fg = c.bg }
				-- hl.LeapLabelPrimary = { bg = c.magenta2, fg = c.bg }
				-- hl.LeapLabelSecondary = { bg = c.green1, fg = c.bg }
				hl.TelescopePreviewBorder = { bg = c.bg_dark, fg = c.bg_dark }
				hl.TelescopePreviewNormal = { bg = c.bg_dark }
				hl.TelescopePromptBorder = { bg = c.terminal_black, fg = c.terminal_black }
				hl.TelescopePromptCounter = { fg = c.fg_dark }
				hl.TelescopePromptNormal = { bg = c.terminal_black }
				hl.TelescopeResultsBorder = { fg = c.bg_highlight, bg = c.bg_highlight }
				hl.TelescopeResultsNormal = { bg = c.bg_highlight }
				hl.TelescopeSelection = { bg = c.terminal_black }
				hl.TelescopeSelectionCaret = { bg = c.terminal_black }
				hl.TelescopeTitle = { fg = c.fg, bold = true }
			end,
		},
	},
	--[[ {
		"mcchrish/zenbones.nvim",
		config = function()
			vim.g.bones_compat = 1
			require("user.utils").kitty.simple_name "zenbones"
			require("user.utils").kitty.simple_name "neobones"
			require("user.utils").kitty.simple_name "seoulbones"
			require("user.utils").kitty.simple_name "zenwritten"
			require("user.utils").kitty.map_colorscheme_with_kitty =
				vim.tbl_extend("force", require("user.utils").kitty.map_colorscheme_with_kitty, {
					rosebones = { kitty_dark_theme = "Rosé Pine", kitty_light_theme = "Rosé Pine Dawn" },
					tokyobones = { kitty_dark_theme = "Tokyo Night Moon", kitty_light_theme = "Tokyo Night Day" },
					vimbones = { kitty_dark_theme = "", kitty_light_theme = "vimbones" },
					duckbones = { kitty_dark_theme = "duckbones", kitty_light_theme = "" },
					kanagawabones = { kitty_dark_theme = "kanagawabones", kitty_light_theme = "" },
					nordbones = { kitty_dark_theme = "Nord", kitty_light_theme = "" },
					forestbones = {
						kitty_dark_theme = "Everforest Dark Hard",
						kitty_light_theme = "Everforest Light Medium",
					},
					zenburned = { kitty_dark_theme = "zenburned", kitty_light_theme = "" },
				})
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = "General",
				callback = function()
					local colors = vim.g.colors_name
					local set_hl = vim.api.nvim_set_hl
					if colors:match ".*bones" or colors == "zenwritten" or colors == "zenburned" then
						set_hl(0, "Function", { bold = true })
						set_hl(0, "Number", {})
						set_hl(0, "Constant", {})
						set_hl(0, "String", {})
						set_hl(0, "NormalFloat", { link = "Normal" })
					end
				end,
				desc = ".*bones highlight adjustment",
			})
		end,
	}, ]]
	{
		"bluz71/vim-nightfly-colors",
		event = "VimEnter",
		-- build = [[
		--   cp extras/kitty-theme.conf ~/.config/kitty/themes/nightfly.conf
		--   cp extras/alacritty.yml ~/.config/alacritty/themes/nightfly.yml
		--   ]],
		dependencies = {
			{
				"bluz71/vim-moonfly-colors",
				-- build = [[
				--     cp extras/kitty-theme.conf ~/.config/kitty/themes/moonfly.conf
				--     cp extras/alacritty.yml ~/.config/alacritty/themes/moonfly.yml
				--     ]],
			},
		},
		config = function()
			vim.g.nightflyWinSeparator = 2
			vim.g.nightflyNormalFloat = false
			vim.g.nightflyTransparent = require("user.config").transparent
			vim.g.nightflyVirtualTextColor = false
			vim.g.moonflyWinSeparator = 2
			vim.g.moonflyNormalFloat = false
			vim.g.moonflyTransparent = require("user.config").transparent
			vim.g.moonflyVirtualTextColor = true
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = "General",
				callback = function()
					local colors = vim.g.colors_name
					local set_hl = function(name, val)
						vim.api.nvim_set_hl(0, name, val)
					end
					local function get_color_from_hl(name)
						return {
							bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(name)), "bg"),
							fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(name)), "fg"),
						}
					end
					if colors == "nightfly" or colors == "moonfly" then
						local normal_float = get_color_from_hl "NormalFloat"
						local float_border = get_color_from_hl "FloatBorder"
						set_hl("FloatBorder", { bg = normal_float.bg, fg = float_border.fg })
						set_hl("CursorLineNr", { bg = "NONE", fg = get_color_from_hl("CursorLineNr").fg })
					end
					if colors == "nightfly" then
						local darkest = get_color_from_hl "ColorColumn"
						local dark = get_color_from_hl "NightflyDeepBlue"
						local lighter_dark = get_color_from_hl "NightflyCelloBlue"
						local white = get_color_from_hl "NightflyWhite"
						local pickle_blue = get_color_from_hl "NightflyPickleBlue"
						local grey_blue = get_color_from_hl "NightflyGreyBlue"
						set_hl("IndentBlanklineContextChar", { fg = pickle_blue.fg })
						set_hl("TelescopePreviewBorder", { bg = darkest.bg, fg = darkest.bg })
						set_hl("TelescopePreviewNormal", { bg = darkest.bg })
						set_hl("TelescopePromptBorder", { bg = lighter_dark.fg, fg = lighter_dark.fg })
						set_hl("TelescopePromptCounter", { fg = grey_blue.fg })
						set_hl("TelescopePromptNormal", { bg = lighter_dark.fg })
						set_hl("TelescopeResultsBorder", { fg = dark.fg, bg = dark.fg })
						set_hl("TelescopeResultsNormal", { bg = dark.fg })
						set_hl("TelescopeSelection", { bg = lighter_dark.fg })
						set_hl("TelescopeSelectionCaret", { bg = lighter_dark.fg })
						set_hl("TelescopeTitle", { fg = white.fg, bold = true })
					elseif colors == "moonfly" then
						local darkest = get_color_from_hl "ColorColumn"
						local dark = get_color_from_hl "MoonflyGrey246Line"
						local lighter_dark = get_color_from_hl "MoonflyGrey236"
						local white = get_color_from_hl "MoonflyWhite"
						local grey237 = get_color_from_hl "MoonflyGrey237"
						local line_nr = get_color_from_hl "LineNr"
						set_hl("IndentBlanklineContextChar", { fg = grey237.fg })
						set_hl("TelescopePreviewBorder", { bg = darkest.bg, fg = darkest.bg })
						set_hl("TelescopePreviewNormal", { bg = darkest.bg })
						set_hl("TelescopePromptBorder", { bg = lighter_dark.fg, fg = lighter_dark.fg })
						set_hl("TelescopePromptCounter", { fg = line_nr.fg })
						set_hl("TelescopePromptNormal", { bg = lighter_dark.fg })
						set_hl("TelescopeResultsBorder", { fg = dark.bg, bg = dark.bg })
						set_hl("TelescopeResultsNormal", { bg = dark.bg })
						set_hl("TelescopeSelection", { bg = lighter_dark.fg })
						set_hl("TelescopeSelectionCaret", { bg = lighter_dark.fg })
						set_hl("TelescopeTitle", { fg = white.fg, bold = true })
					end
				end,
				desc = ".*fly highlight adjustment",
			})
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		-- build = [[
		--     cd extra/;
		--     for DIR in *fox; do
		--         cd "$DIR";
		--         cp *.conf ~/.config/kitty/themes/"$DIR".conf;
		--         cp *.yml ~/.config/alacritty/themes/"$DIR".yml;
		--         cd ../;
		--     done
		--   ]],
		event = "VimEnter",
		opts = {
			groups = {
				all = {
					DiagnosticUnderlineError = { style = "underline" },
					DiagnosticUnderlineHint = { style = "underline" },
					DiagnosticUnderlineInfo = { style = "underline" },
					DiagnosticUnderlineWarn = { style = "underline" },
					FloatBorder = { bg = "palette.bg0", fg = "palette.fg3" },
					IndentBlanklineContextChar = { fg = "palette.fg3" },
					LeapBackdrop = { fg = "NONE" },
					TelescopeMatching = { bg = "palette.sel1" },
					TelescopePreviewBorder = { fg = "palette.bg0", bg = "palette.bg0" },
					TelescopePreviewNormal = { bg = "palette.bg0" },
					TelescopePromptBorder = { fg = "palette.bg3", bg = "palette.bg3" },
					TelescopePromptCounter = { fg = "palette.comment" },
					TelescopePromptNormal = { bg = "palette.bg3" },
					TelescopeResultsBorder = { fg = "palette.bg2", bg = "palette.bg2" },
					TelescopeResultsNormal = { fg = "palette.fg0", bg = "palette.bg2" },
					TelescopeSelection = { bg = "palette.bg1" },
					TelescopeSelectionCaret = { bg = "palette.bg1" },
					TelescopeTitle = { fg = "palette.fg3", style = "bold" },
				},
			},
			options = {
				-- Compiled file's destination location
				compile_path = vim.fn.stdpath "cache" .. "/nightfox",
				compile_file_suffix = "_compiled", -- Compiled file suffix
				transparent = require("user.config").transparent, -- Disable setting background
				terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				dim_inactive = false, -- Non focused panes set to alternative background
				module_default = true, -- Default enable value for modules
				modules = {
					neotree = { enable = false },
					telescope = { enable = false },
				},
				styles = { -- Style to be applied to different syntax groups
					comments = "italic", -- Value is any valid attr-list value `:help attr-list`
					conditionals = "bold",
					constants = "NONE",
					functions = "bold",
					keywords = "bold",
					numbers = "NONE",
					operators = "bold",
					strings = "NONE",
					types = "NONE",
					variables = "NONE",
				},
				inverse = { -- Inverse highlight for different types
					match_paren = false,
					search = false,
					visual = false,
				},
			},
		},
	},
}
