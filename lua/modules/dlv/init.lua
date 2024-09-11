vim.api.nvim_create_user_command(
  'GoToggleBreakpoint',
  function(opts)
    local file = vim.fn.expand('%:p')
    local line = vim.fn.line('.')
    local args = opts.fargs

    -- Chama a função toggleBreakpoint com os argumentos fornecidos
    require("modules.dlv.dlv").toggleBreakpoint(file, line, unpack(args))
  end,
  { nargs = '*', bang = true }
)

vim.api.nvim_create_user_command(
  'GoDebug',
  function(opts)
    -- O valor do bang pode ser obtido a partir de opts.bang
    local bang = opts.bang == 1  -- Em Lua, bang é 1 se o usuário usou !, caso contrário é 0
    local args = opts.fargs      -- Argumentos passados ao comando

    -- Chama a função debug com os argumentos apropriados
    require("modules.dlv.dlv").debug(bang, unpack(args))
  end,
  { nargs = '*', bang = true }
)

vim.api.nvim_create_user_command(
  'GoDebugExec',
  function(opts)
    -- O valor do bang pode ser obtido a partir de opts.bang
    local bang = opts.bang == 1  -- Em Lua, bang é 1 se o usuário usou !, caso contrário é 0
    local args = opts.fargs      -- Argumentos passados ao comando

    -- Chama a função debug com os argumentos apropriados
    require("modules.dlv.dlv").debugexec(bang, unpack(args))
  end,
  { nargs = '*', bang = true }
)

vim.api.nvim_create_user_command(
  'GoDebugTest',
  function(opts)
    -- O valor do bang pode ser obtido a partir de opts.bang
    local bang = opts.bang == 1  -- Em Lua, bang é 1 se o usuário usou !, caso contrário é 0
    local args = opts.fargs      -- Argumentos passados ao comando

    -- Chama a função debugtest com os argumentos apropriados
    require("modules.dlv.dlv").debugtest(bang, unpack(args))
  end,
  { nargs = '*', bang = true }
)

vim.keymap.set("n", "<leader>gbp", "<cmd>GoToggleBreakpoint<cr>", { desc = '[space|gbp] pin breakpoint in current line' })
vim.keymap.set("n", "<leader>gdg", "<cmd>GoDebug<cr>", { desc = '[space|gdg] exec delve mode debug to main.go' })
vim.keymap.set("n", "<leader>gde", "<cmd>GoDebugExec<cr>", { desc = '[space|gde] execute delve in exec mode passing arguments to inform for binary' })
vim.keymap.set("n", "<leader>gdt", "<cmd>GoDebugTest<cr>", { desc = '[space|gdt] execute delve in test mode'  })
