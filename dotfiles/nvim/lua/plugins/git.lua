return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
		end,
	},
	{
		"tpope/vim-fugitive",
		-- Se carga solo si estamos en un repositorio Git
		cond = function()
			return vim.fn.isdirectory(".git") == 1
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- Requiere plenary.nvim, carga cuando se ejecuta uno de los comandos
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
		-- Se carga solo si estamos en un repositorio Git
		cond = function()
			return vim.fn.isdirectory(".git") == 1
		end,
	},
}
