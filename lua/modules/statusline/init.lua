vim.o.cmdheight = 0

-- function for create the statusline
function statusline()
	local mode = vim.api.nvim_get_mode().mode
	local mode_map = {
		n = 'NORMAL',
		i = 'INSERT',
		v = 'VISUAL',
		[''] = 'V-BLOCK',
		['V'] = 'V-LINE',
		c = 'COMMAND',
		t = 'TERMINAL'
	}
	local mode_text = mode_map[mode] or mode

	local filename = vim.fn.expand('%:t') -- filename current 
	local extension = vim.fn.fnamemodify(filename, ':e')
	if extension == '' then
		extension = ''
	else
		-- Capitalize the first letter of the exestension 
		extension = extension:sub(1,1):upper() .. extension:sub(2):lower()
	end

	local line = vim.fn.line('.') -- line current
	local col = vim.fn.col('.') -- column current

	return string.format('%%=%d:%d %s %s ', line, col, mode_text, extension)
end

-- setup of the status line
vim.o.statusline = '%!v:lua.statusline()'
