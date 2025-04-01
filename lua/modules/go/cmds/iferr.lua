vim.api.nvim_create_user_command(
    'GoIfErr',
    'lua require("modules.go.features.iferr").add_iferr()',
    {
        nargs = 0,
    }
)
