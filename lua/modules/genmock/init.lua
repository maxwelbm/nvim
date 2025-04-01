vim.api.nvim_create_user_command('GenMock', function()
    local filename = vim.fn.expand('%:p')
    local directory = vim.fn.expand('%:p:h'):match("([^/\\]+)$")
    local command = 'mockgen -source=' .. filename .. ' -destination=' .. filename:gsub('.go$', '_mock.go') .. ' -package ' .. directory

    vim.fn.system(command)
    print('Mock gerado para ' .. filename .. ' no pacote ' .. directory)
end, {})


vim.api.nvim_set_keymap('n', '<space>gm', ':GenMock<CR>', { noremap = true, silent = true })
