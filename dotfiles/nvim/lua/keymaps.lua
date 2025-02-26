local map = vim.api.nvim_set_keymap
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', opts)
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', opts)
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', opts)
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', opts)
map("n", "<F7>", ":set spell!<CR>", opts)
map("n", "<C-W>h", ":leftabove vsplit<CR>", opts)
map("n", "<C-W>j", ":belowright split<CR>", opts)
map("n", "<C-W>k", ":aboveleft split<CR>", opts)
map("n", "<C-W>l", ":rightbelow vsplit<CR>", opts)
map("n", "<leader>w", ":w<CR>", { desc = "Guardar archivo" })
map("n", "<leader>q", ":q<CR>", { desc = "Cerrar buffer y ventana" })
map("n", "<leader>x", ":qa<CR>", { desc = "Salir de Neovim" })
map("n", "<C-Down>", ":resize +2<CR>", { noremap = true, silent = true })
map("n", "<C-Up>", ":resize -2<CR>", { noremap = true, silent = true })
map("n", "<C-Right>", ":vertical resize -2<CR>", { noremap = true, silent = true })
map("n", "<C-Left>", ":vertical resize +2<CR>", { noremap = true, silent = true })

set("n", "{d", vim.diagnostic.goto_prev)
set("n", "}d", vim.diagnostic.goto_next)
set("n", "<A-}>", "<cmd>cnext<CR>")
set("n", "<A-{>", "<cmd>cprev<CR>")
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])
set({ "n", "v" }, "<leader>d", [["_d]])
set("n", "<leader>re", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "<leader>ln", function()
	local number = vim.wo.number
	local relativenumber = vim.wo.relativenumber

	if number and relativenumber then
		vim.wo.number = false
		vim.wo.relativenumber = false
	else
		vim.wo.number = true
		vim.wo.relativenumber = true
	end
end, { desc = "Alternar entre number y relativenumber" })
