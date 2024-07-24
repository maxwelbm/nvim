vim.api.nvim_create_user_command(
    'GoGet', -- go get
    'lua require("modules.go.features.import").get(<f-args>)',
    {
        nargs = 1,
    }
)

vim.api.nvim_create_user_command(
    'GoImport',
    'lua require("modules.go.features.import").import(<f-args>)',
    {
        nargs = 1,
    }
)
