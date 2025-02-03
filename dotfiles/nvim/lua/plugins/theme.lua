return {
	-- Themes -------------------------------------
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				theme = "catppuccin",
			})
			vim.cmd("colorscheme catppuccin")
		end,
	},
	----------------------------------------------

	-- Transparent -------------------------------
	{
		"xiyaowong/transparent.nvim",
	},
	---------------------------------------------

	-- Status Line ------------------------------
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"xiyaowong/transparent.nvim",
			"catppuccin/nvim",
		},
		config = function()
			local catppuccin = require("catppuccin.palettes").get_palette("mocha")
			local bubbles_theme = {
				normal = {
					a = { fg = catppuccin.base, bg = catppuccin.mauve },
					b = { fg = catppuccin.text, bg = catppuccin.surface0 },
					c = { fg = catppuccin.text, bg = "NONE" },
				},
				insert = { a = { fg = catppuccin.base, bg = catppuccin.blue } },
				visual = { a = { fg = catppuccin.base, bg = catppuccin.green } },
				replace = { a = { fg = catppuccin.base, bg = catppuccin.red } },
				inactive = {
					a = { fg = catppuccin.blue, bg = catppuccin.mantle },
					b = { fg = catppuccin.surface1, bg = catppuccin.mantle },
					c = { fg = catppuccin.overlay0, bg = "NONE" },
				},
			}

			-- Función para mostrar el estado del LSP
			local function lsp_status()
				local bufnr = vim.api.nvim_get_current_buf()
				local diagnostics = vim.diagnostic.get(bufnr)
				local errors = 0
				local warnings = 0
				local info = 0
				local hints = 0

				for _, diagnostic in ipairs(diagnostics) do
					if diagnostic.severity == vim.diagnostic.severity.ERROR then
						errors = errors + 1
					elseif diagnostic.severity == vim.diagnostic.severity.WARN then
						warnings = warnings + 1
					elseif diagnostic.severity == vim.diagnostic.severity.INFO then
						info = info + 1
					elseif diagnostic.severity == vim.diagnostic.severity.HINT then
						hints = hints + 1
					end
				end

				local status = {}
				if errors > 0 then
					table.insert(status, string.format("%%#LspDiagnosticsError# %d", errors))
				end
				if warnings > 0 then
					table.insert(status, string.format("%%#LspDiagnosticsWarning# %d", warnings))
				end
				if info > 0 then
					table.insert(status, string.format("%%#LspDiagnosticsInformation# %d", info))
				end
				if hints > 0 then
					table.insert(status, string.format("%%#LspDiagnosticsHint# %d", hints))
				end

				return table.concat(status, " ")
			end

			-- Configurar los colores para los diagnósticos
			vim.api.nvim_set_hl(0, "LspDiagnosticsError", { fg = catppuccin.red, bg = "NONE" })
			vim.api.nvim_set_hl(0, "LspDiagnosticsWarning", { fg = catppuccin.yellow, bg = "NONE" })
			vim.api.nvim_set_hl(0, "LspDiagnosticsInformation", { fg = catppuccin.blue, bg = "NONE" })
			vim.api.nvim_set_hl(0, "LspDiagnosticsHint", { fg = catppuccin.green, bg = "NONE" })

			-- Configuración de lualine
			require("lualine").setup({
				options = {
					theme = bubbles_theme,
					component_separators = "",
					section_separators = { left = "", right = "" },
					globalstatus = true,
				},
				sections = {
					lualine_a = {
						{
							"mode",
							separator = { left = "", right = "" },
							left_padding = 0,
							right_padding = 0,
							color = function()
								local mode_colors = {
									n = { bg = catppuccin.blue, fg = catppuccin.base },
									i = { bg = catppuccin.green, fg = catppuccin.base },
									v = { bg = catppuccin.mauve, fg = catppuccin.base },
									r = { bg = catppuccin.red, fg = catppuccin.base },
								}
								return mode_colors[vim.fn.mode()] or { bg = catppuccin.surface0, fg = catppuccin.text }
							end,
						},
					},

					lualine_b = {
						{
							"filename",
							separator = { left = "", right = "" },
							left_padding = 0,
							right_padding = 0,
							color = { bg = catppuccin.surface0, fg = catppuccin.text },
						},
						{
							lsp_status,
							separator = { left = "", right = "" },
							left_padding = 2,
							right_padding = 2,
							color = { bg = catppuccin.surface1, fg = catppuccin.text },
						},
					},
					lualine_c = {
						{
							color = { bg = "NONE", fg = "NONE" },
						},
					},
					lualine_x = {
						{
							color = { bg = "NONE", fg = "NONE" },
						},
					},
					lualine_z = {
						{
							"branch",
							separator = { left = "", right = "" },
							left_padding = 0,
							right_padding = 0,
							color = { bg = catppuccin.pink, fg = catppuccin.surface0 },
						},
						{
							function()
								local recording = vim.fn.reg_recording()
								if recording ~= "" then
									return "Rec " .. recording -- Icono y registro
								end
								return ""
							end,
							cond = function()
								return vim.fn.reg_recording() ~= ""
							end, -- Solo mostrar si está grabando
							separator = { left = "", right = "" },
							left_padding = 2,
							right_padding = 2,
							color = { bg = catppuccin.red, fg = catppuccin.surface0 },
						},
					},
					lualine_y = {},
				},
				inactive_sections = {
					lualine_a = {
						{
							"filename",
							separator = { left = "", right = "" },
							left_padding = 2,
							right_padding = 2,
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {
						{
							"location",
							separator = { left = "", right = "" },
							left_padding = 2,
							right_padding = 2,
						},
					},
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
	---------------------------------------------
}
