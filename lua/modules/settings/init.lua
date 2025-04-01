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
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#2e3440', blend = 10 })  -- Altere a cor de fundo e o blend conforme preferir

vim.o.splitright = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Define o marcador na coluna 100
-- vim.wo.colorcolumn = '100'
vim.opt.colorcolumn = "80,100"
-- Personalize a cor da coluna do marcador
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#2e3440', blend = 10 })

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
vim.o.clipboard = 'unnamedplus'

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

-- tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4
