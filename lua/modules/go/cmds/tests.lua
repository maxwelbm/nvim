vim.api.nvim_create_user_command(
    'GoTest', -- go test
    'lua require("modules.go.features.test").test()',
    {
        nargs = 0,
    }
)

vim.api.nvim_create_user_command(
    'GoTestAll',
    'lua require("modules.go.features.test").test_all()',
    {
        nargs = 0,
    }
)

vim.api.nvim_create_user_command(
    'GoTestFunc',
    'lua require("modules.go.features.test").test_func()',
    {
        nargs = 0,
    }
)

vim.api.nvim_create_user_command(
    'GoTestFile',
    'lua require("modules.go.features.test").test_file()',
    {
        nargs = 0,
    }
)

vim.api.nvim_create_user_command(
    'GoTestName',
    'lua require("modules.go.features.test").test_name()',
    {
        nargs = 0,
    }
)

vim.api.nvim_create_user_command(
    'GoTestOpen',
    'lua require("modules.go.features.test").test_open(<f-args>)',
    {
        nargs = '?',
        complete = 'command',
    }
)

vim.api.nvim_create_user_command(
    'GoToTest', -- alias of GoTestOpen
    'lua require("modules.go.features.test").test_open(<f-args>)',
    {
        nargs = '?',
        complete = 'command',
    }
)

vim.api.nvim_create_user_command(
    'GoAddTest',
    'lua require("modules.go.features.gotests").add_test()',
    {
        nargs = 0,
    }
)
