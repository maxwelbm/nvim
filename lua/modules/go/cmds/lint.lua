
vim.api.nvim_create_user_command(
    'GoLint',
    'lua require("modules.go.features.lint").lint(<f-args>)',
    {
        nargs = '?',
        complete = function(arg_lead, cmd_line, cursor_pos)
            local prefix = arg_lead
            local _ = cmd_line
            local _ = cursor_pos
            local linters = require('go.lint').linters()
            return Match_prefix(linters, prefix)
        end,
    }
)
