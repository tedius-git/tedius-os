return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		tag = "0.1.8",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					-- Configuración de la ventana de previsualización
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.75, -- Reducido de 0.95
						height = 0.75, -- Reducido de 0.95
						preview_cutoff = 120,
						horizontal = {
							preview_width = 0.6,
						},
					},

					-- Configuración de colores
					color_devicons = true,

					-- Configuración de bordes
					border = true,
					-- Configuración de la barra de resultados
					results_title = false,

					-- Configuración de ordenamiento
					sorting_strategy = "descending",

					-- Configuración de la previsualización de archivos
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			-- Configuración de keymaps
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>bf", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set("n", "<leader>ob", builtin.buffers, {})
			vim.keymap.set("n", "<leader>gs", builtin.grep_string, {})
			vim.keymap.set("n", "<leader>ch", builtin.command_history, {})
			vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
			vim.keymap.set("n", "<leader>bs", builtin.treesitter, {})
			vim.keymap.set("n", "<leader>tc", function()
				vim.cmd("Telescope builtin")
			end, { desc = "Find all Telescope options" })
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({
					cwd = vim.fn.stdpath("config"),
					prompt_title = "< Neovim Config Files >",
					hidden = true,
				})
			end, { desc = "Find Neovim config files" })

			-- Configuración de colores personalizados
			vim.cmd([[
                highlight TelescopeBorder guifg=#8a7aa1
                highlight TelescopePromptBorder guifg=#8a7aa1
                highlight TelescopeResultsBorder guifg=#8a7aa1
                highlight TelescopePreviewBorder guifg=#8a7aa1
            ]])
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
}
