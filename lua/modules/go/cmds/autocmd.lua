local opt = require('modules.go.features.config').options
local group = vim.api.nvim_create_augroup('nvim_go', { clear = true })

vim.api.nvim_clear_autocmds({
    buffer = vim.api.nvim_get_current_buf(),
    group = group,
})

if opt.auto_format then
    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        group = group,
        pattern = '*.go',
        command = 'GoFormat',
    })
end

if opt.auto_lint then
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = group,
        pattern = '<buffer>',
        command = 'GoLint',
    })
end
