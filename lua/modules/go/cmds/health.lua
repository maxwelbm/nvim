vim.api.nvim_create_user_command(
    'GoHealthCheck',
    function()
    	require('modules.go.features.health').check()
    end,
    { nargs = 0 }
)
