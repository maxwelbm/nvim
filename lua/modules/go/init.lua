require('modules.go.cmds.health')
require('modules.go.cmds.format')
require('modules.go.cmds.tests')
require('modules.go.cmds.iferr')
require('modules.go.cmds.import')
require('modules.go.cmds.lint')
require('modules.go.cmds.import')
require('modules.go.cmds.quick_type')
require('modules.go.cmds.struct_tags')
require('modules.go.cmds.install')

-- Adiciona um autocmd que executa um command toda vez que um arquivo Go é salvo
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.go",
  callback = function()
    -- O command que você deseja executar
    vim.cmd("GoFormat")
  end,
})
