vim.o.lazyredraw = true         -- Reduz o redrawing
vim.o.synmaxcol = 240           -- Limita o máximo de colunas de sintaxe
vim.o.timeoutlen = 500          -- Reduz o tempo de timeout

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.cursorline = true
vim.wo.cursorlineopt = 'screenline'
-- vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#2e3440', blend = 10 })  -- Altere a cor de fundo e o blend conforme preferir

vim.o.splitright = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Define o marcador na coluna 100
-- vim.wo.colorcolumn = '80'
-- vim.opt.colorcolumn = "80,100"
-- Personalize a cor da coluna do marcador
-- vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#2e3440', blend = 10 })

vim.wo.colorcolumn = '80'


-- OR

-- Define a largura máxima para a quebra automática de linha
vim.o.textwidth = 120

-- Ativa o wrap para visualização de linhas longas
vim.wo.wrap = true


-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true 

-- local columns = { 80, 120 } -- Coloque os números das colunas limit desejadas aqui
-- -- Define as colunas de limit
-- vim.wo.colorcolumn = table.concat(columns, ',')
-- vim.opt.colorcolumn = "80,100"
-- vim.opt.colorcolumn = "80"

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.tabstop = 4      -- Cada caractere de tabulação será equivalente a 4 espaços
vim.o.shiftwidth = 4   -- O número de espaços para indentação será 4
vim.o.expandtab = true -- Sempre substituir tabs por espaços
-- vim.o.autoindent = true -- Mantém a indentação da linha anterior
-- vim.o.smartindent = true -- Habilita indentação inteligente baseado na sintaxe do código


vim.o.ignorecase = false
vim.o.smartcase = false

-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--   pattern = "*",
--   command = "retab! 4",
-- })

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- NOTE: First, some plugins that don't require any configuration

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            'folke/neodev.nvim',
        },
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
			'neovim/nvim-lspconfig',  -- se você estiver usando LSP
			-- outros complementos necessários

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim',       opts = {} },

    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '▊' },
                change = { text = '▊' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },

                -- add = { text = '│' },
                -- change = { text = '│' },
                -- delete = { text = '_' },
                -- topdelete = { text = '‾' },
                -- changedelete = { text = '~' },

                -- add = { text = '+' },
                -- change = { text = '~' },
                -- delete = { text = '_' },
                -- topdelete = { text = '‾' },
                -- changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Preview git hunk' })

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ 'n', 'v' }, ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
                vim.keymap.set({ 'n', 'v' }, '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
            end,
            current_line_blame = true,
            current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
        },
    },
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
    },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    { 'terrortylor/nvim-comment' },
    -- { "NTBBloodbath/doom-one.nvim",
    --     setup = function()
    --         vim.g.doom_one_transparent_background = true -- TODO: enable transparent not work
    --     end,
    --     config = function()
    --     vim.cmd.colorscheme("doom-one")
    --     end,
    -- },
    -- { 'navarasu/onedark.nvim' },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { 'nvim-tree/nvim-tree.lua' },
    { 'nvim-tree/nvim-web-devicons' },
    -- { 'maxwelbm/nvim-go' },
    -- { 'andweeb/presence.nvim' },
    -- {
    --     'IogaMaster/neocord',
    --     event = "VeryLazy"
    -- },
    -- { 'rafaelsq/nvim-goc.lua' },
}, {})

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "vertical",
        layout_config = {
            horizontal = {
                mirror = false,
            },
            vertical = {
                mirror = false,
            },
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        path_display = {},
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        -- borderchars = { '', '', '', '', '', '', '', '' },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')



-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = 'Search [G]it [S]status' })

vim.keymap.set('n', '<leader>ff', function()
    require('telescope.builtin').find_files({ hidden = true })
end, { desc = '[S]search [F]files' })

vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[S]search current [W]word' })

vim.keymap.set('n', '<leader>sg', function()
    require('telescope.builtin').live_grep({ hidden = true })
end, { desc = '[S]search by [G]grep' })

vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]search [D]siagnostics' })
vim.keymap.set('n', '<leader>e', "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", { desc = '[D]siagnostics' })

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

-- Função para reiniciar o LSP e o autocompletar
function RestartLSPAndAutocomplete()
    for _, client in pairs(vim.lsp.get_active_clients()) do
        vim.lsp.stop_client(client.id)
    end
    vim.cmd('LspStart')
    require('cmp').setup {} -- Reinicializa o cmp (nvim-cmp)
end

-- Mapeia uma tecla de atalho para reiniciar o LSP e autocompletar
vim.api.nvim_set_keymap('n', '<leader>rl', '<cmd>lua RestartLSPAndAutocomplete()<CR>', { noremap = true, silent = true })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    modules = {},
    sync_install = true,
    ignore_install = {},
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'rust', 'go', 'lua', 'python', 'ruby', 'php', 'javascript', 'typescript', 'vim' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

local signs = { Error = "▊", Warn = "▊", Hint = "▊", Info = "▊" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            virtual_text = false,
            signs = true,
            update_in_insert = false,
            underline = true,
        }
    )

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Função para reiniciar automaticamente o LSP se ele quebrar
local function restart_lsp_on_failure()
    if #vim.lsp.get_active_clients() == 0 then
        vim.defer_fn(function()
            for _, client in ipairs(vim.lsp.get_active_clients()) do
                vim.lsp.stop_client(client.id)
                require('lspconfig')[client.name].setup{
                    on_attach = on_attach,
                    capabilities = capabilities,
                }
                vim.cmd("LspStart " .. client.name)
            end
        end, 100)
    end
end

-- Configuração do AutoCmd para detectar e reiniciar o LSP automaticamente em caso de falha
vim.api.nvim_create_autocmd({"BufEnter", "CursorHold"}, {
    callback = restart_lsp_on_failure
})

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end
}

require'lspconfig'.terraformls.setup{}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'

local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
    },
}

vim.keymap.set("n", "<leader>h", "<c-w>h", { desc = "window: Focus left" })
vim.keymap.set("n", "<leader>l", "<c-w>l", { desc = "window: Focus right" })
vim.keymap.set("n", "<leader>j", "<c-w>j", { desc = "window: Focus down" })
vim.keymap.set("n", "<leader>k", "<c-w>k", { desc = "window: Focus up" })
vim.keymap.set("t", "<leader>h", "<C-\\><C-N><C-w>h", { desc = "window: Focus left" })
vim.keymap.set("t", "<leader>l", "<C-\\><C-N><C-w>l", { desc = "window: Focus right" })
vim.keymap.set("t", "<leader>j", "<C-\\><C-N><C-w>j", { desc = "window: Focus down" })
vim.keymap.set("t", "<leader>k", "<C-\\><C-N><C-w>k", { desc = "window: Focus up" })

vim.api.nvim_set_keymap('n', '<C-h>', ':vertical resize -2<CR>', { desc = "", noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':vertical resize +2<CR>', { desc = "", noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-k>', ':resize -2<CR>', { desc = "", noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':resize +2<CR>', { desc = "", noremap = true, silent = true })

require('nvim_comment').setup({
    marker_padding = true,                -- Linters prefer comment and line to have a space in between markers
    comment_empty = true,                 -- should comment out empty or whitespace only lines
    comment_empty_trim_whitespace = true, -- trim empty comment whitespace
    create_mappings = true,               -- Should key mappings be created
    line_mapping = "cl",                  -- Normal mode mapping left hand side
    operator_mapping = "c",               -- Visual/Operator mapping left hand side
    hook = nil                            -- Hook function to call before commenting takes place
})

require("ibl").setup {
    indent = { char = '│' },
}

vim.keymap.set("n", "<leader>df", "<cmd>vertical Git diff %<cr>", { desc = '[space|df] opens a git diff vertically' })
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = '[space|q] quit from all' })

vim.keymap.set("n", "<leader>gf", "<cmd>GoTestFunc<cr>", { desc = '[space|gf] executable test go all test functions' })
vim.keymap.set("n", "<leader>gt", "<cmd>GoTestFile<cr>", { desc = '[space|gt] executable test go all file' })

-- require("modules.bootstrap")
-- require("modules.hello.hello")
require("modules.go")
require("modules.theme")
require("modules.statusline")
require("modules.userfake")
require("modules.nvim-tree")
require("modules.dlv")
require("modules.genmock")

-- if set, when we switch between buffers, it will not split more than once. It will switch to the existing buffer instead
vim.opt.switchbuf = 'useopen'

local goc = require("modules.gocover")
goc.setup({ verticalSplit = false })  -- default to horizontal


vim.keymap.set('n', '<Leader>gcf', goc.Coverage, {silent=true})       -- run for the whole File
vim.keymap.set('n', '<Leader>gct', goc.CoverageFunc, {silent=true})   -- run only for a specific Test unit
vim.keymap.set('n', '<Leader>gcc', goc.ClearCoverage, {silent=true})  -- clear coverage highlights


vim.api.nvim_create_user_command('CoverageFile', function() goc.Coverage() end, {})
vim.api.nvim_create_user_command('CoverageTest', function() goc.CoverageFunc() end, {})
vim.api.nvim_create_user_command('CoverageClear', function() goc.ClearCoverage() end, {})

-- If you need custom arguments, you can supply an array as in the example below.
-- vim.keymap.set('n', '<Leader>gcf', function() goc.Coverage({ "-race", "-count=1" }) end, {silent=true})
-- vim.keymap.set('n', '<Leader>gct', function() goc.CoverageFunc({ "-race", "-count=1" }) end, {silent=true})

vim.keymap.set('n', ']a', goc.Alternate, {silent=true})
vim.keymap.set('n', '[a', goc.AlternateSplit, {silent=true})          -- set verticalSplit=true for vertical

cf = function(testCurrentFunction)
  local cb = function(path, index)
    if path then

      -- `xdg-open|open` command performs the same function as double-clicking on the file.
      -- change from `xdg-open` to `open` on MacOSx
      vim.cmd(":silent exec \"!xdg-open file://" .. path .. "\\\\#file" .. index .. "\"")
    end
  end

  if testCurrentFunction then
    goc.CoverageFunc(nil, cb, 0)
  else
    goc.Coverage(nil, cb)
  end
end

-- If you want to open it in your browser, you can use the commands below.
-- You need to create a callback function to configure which command to use to open the HTML.
-- On Linux, `xdg-open` is generally used, on MacOSx it's just `open`.
vim.keymap.set('n', '<leader>gca', cf, {silent=true})
vim.keymap.set('n', '<Leader>gcb', function() cf(true) end, {silent=true})

-- default colors
-- vim.api.nvim_set_hl(0, 'GocNormal', {link='Comment'})
-- vim.api.nvim_set_hl(0, 'GocCovered', {link='String'})
-- vim.api.nvim_set_hl(0, 'GocUncovered', {link='Error'})
-- require("modules.settings")

-- vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#282c34', blend = 10 })
-- vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#282c34', blend = 10 })  -- Altere a cor de fundo e o blend conforme preferir
