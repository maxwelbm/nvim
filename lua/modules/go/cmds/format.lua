vim.api.nvim_create_user_command(
    'GoFormat',
    'lua require("modules.go.features.format").format(<f-args>)',
    {
        nargs = '?',
        complete = function(arg_lead, cmd_line, cursor_pos)
            local prefix = arg_lead
            local _ = cmd_line
            local _ = cursor_pos
            local formatters = require('modules.go.features.format').formatters()
            return Match_prefix(formatters, prefix)
        end,
    }
)
