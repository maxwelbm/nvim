vim.api.nvim_create_user_command(
    'GoQuickType',
    'lua require("modules.go.features.quick_type").quick_type(<count>, <f-args>)',
    {
        nargs = '*',
        complete = 'file',
    }
)
