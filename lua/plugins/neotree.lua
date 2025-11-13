-- Pattern for identifying the Neo-tree buffer
-- Reusable variable makes it easy to change in the future
local neo_tree_pattern = "neo%-tree"

-- Function to find a Neo-tree window
-- Returns window ID if Neo-tree is open, nil otherwise
local function find_window()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local buf_name = vim.api.nvim_buf_get_name(buf)
		if buf_name:match(neo_tree_pattern) then
			return win
		end
	end
	-- If Neo-tree window not found, will return nil
	return nil
end

-- Toggle Neo-tree open/close

local function toggle_neotree()
	local neo_win = find_window()
	if neo_win then
		vim.cmd("Neotree close")
	else
		vim.cmd("Neotree filesystem reveal left")
	end
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim", -- asta trebuie să fie prezent
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		--	vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left<CR>")
		--:	vim.keymap.set("n", "<leader>N", ":Neotree close")

		vim.keymap.set("n", "<leader>n", toggle_neotree, { noremap = true, silent = true })

		-- Auto-close Neo-tree when entering a regular file buffer
		vim.api.nvim_create_autocmd("InsertEnter", {
			callback = function()
				local buf_name = vim.api.nvim_buf_get_name(0)
				-- Skip if the buffer is Neo-tree itself
				if buf_name:match(neo_tree_pattern) then
					return
				end

				-- Close Neo-tree if it is open
				local neo_win = find_window()
				if neo_win then
					vim.cmd("Neotree close")
				end
			end,
		})
	end,
}
