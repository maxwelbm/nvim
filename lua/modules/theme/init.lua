-- Configure a status line como transparente
-- vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', fg = '#848b98' }) -- Ajuste a cor de fg conforme o gosto
-- vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE', fg = '#5c6370' }) -- Linha de status de janelas inativas

require("catppuccin").setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha, auto
    background = { -- :h background
        light = "latte",
        -- dark = "mocha", dark = "frappe",
    },
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    },
})

vim.cmd.colorscheme "catppuccin"
