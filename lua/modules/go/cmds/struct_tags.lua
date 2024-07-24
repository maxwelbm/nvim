vim.api.nvim_create_user_command(
    'GoAddTags',
    'lua require("modules.go.features.struct_tag").add_tags({<line1>, <line2>, <count>, <f-args>})',
    {
        nargs = '*',
        range = true,
    }
)

vim.api.nvim_create_user_command(
    'GoRemoveTags',
    'lua require("modules.go.features.struct_tag").remove_tags({<line1>, <line2>, <count>, <f-args>})',
    {
        nargs = '*',
        range = true,
    }
)

vim.api.nvim_create_user_command(
    'GoClearTags',
    'lua require("modules.go.features.struct_tag").clear_tags({<line1>, <line2>, <count>, <f-args>})',
    {
        nargs = '*',
        range = true,
    }
)

-- struct tag options
vim.api.nvim_create_user_command(
    'GoAddTagOptions',
    'lua require("modules.go.features.struct_tag").add_options({<line1>, <line2>, <count>, <f-args>})',
    {
        nargs = '*',
        range = true,
    }
)

vim.api.nvim_create_user_command(
    'GoRemoveTagOptions',
    'lua require("modules.go.features.struct_tag").remove_options({<line1>, <line2>, <count>, <f-args>})',
    {
        nargs = '*',
        range = true,
    }
)

vim.api.nvim_create_user_command(
    'GoClearTagOptions',
    'lua require("modules.go.features.struct_tag").clear_options({<line1>, <line2>, <count>, <f-args>})',
    {
        nargs = '*',
        range = true,
    }
)
