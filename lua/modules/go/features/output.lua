local M = {}

local vim = vim

function M.show_info(prefix, msg)
	vim.api.nvim_echo({ { prefix }, { ' ' .. msg } }, true, {})
end

function M.show_success(prefix, msg)
	local succ = 'Success'
	if msg ~= nil then
		succ = msg
	end
	vim.api.nvim_echo({ { prefix, 'Function' }, { ' ' .. succ } }, true, {})
end

function M.show_error(prefix, msg)
	vim.api.nvim_echo({ { prefix, 'ErrorMsg' }, { ' ' .. msg } }, true, {})
end

function M.show_warning(prefix, msg)
	vim.api.nvim_echo(
		{ { prefix, 'WarningMsg' }, { ' ' .. msg } },
		true,
		{}
	)
end

function M.vsplit_job_result(results, opts)
    -- Cria um novo buffer
    local buf_nr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf_nr, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buf_nr, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buf_nr, 'filetype', opts.filetype)
    vim.api.nvim_buf_set_lines(buf_nr, 0, -1, true, results)
    vim.api.nvim_buf_set_option(buf_nr, 'modifiable', true)

    -- Abre uma nova janela vsplit
    vim.cmd('vsplit')
    local win_id = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win_id, buf_nr)

    -- Configurações adicionais da janela
    vim.api.nvim_win_set_option(win_id, 'wrap', false)
    vim.api.nvim_buf_set_option(buf_nr, 'modifiable', false)
    vim.api.nvim_buf_set_keymap(
        buf_nr,
        'n',
        'q',
        ':q!<cr>',
        { noremap = true, silent = true }
    )
end

return M
