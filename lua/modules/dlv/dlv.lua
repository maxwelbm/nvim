if vim.g.godebug_breakpoints == nil then
  vim.g.godebug_breakpoints = {}
end

-- make cache base path overridable
if vim.g.godebug_cache_path == nil then
  -- this will probably suck for people using windows ...
  vim.g.godebug_cache_path = vim.fn.expand("$HOME") .. "/.cache/" .. vim.v.progname .. "/vim-godebug"
end

-- make sure cache base path exists
vim.fn.mkdir(vim.g.godebug_cache_path, "p")

-- create a reasonably unique breakpoints file path per vim instance
vim.g.godebug_breakpoints_file = vim.g.godebug_cache_path .. "/" .. vim.fn.getpid() .. vim.fn.localtime()


local godebug = {}

function godebug.toggleBreakpoint(file, line, ...)
  -- Compose the breakpoint for delve:
  -- Example: break /home/user/path/to/go/file.go:23
  local breakpoint = "break " .. file .. ":" .. line
  local breakpoints = vim.g.godebug_breakpoints or {}

  -- Define the sign for the gutter
  -- Define o grupo de destaque 'GobreakpointSign' com caractere vermelho e fundo transparente
  vim.api.nvim_set_hl(0, 'GobreakpointSign', { fg = '#BE5046', bg = 'NONE' })

  -- vim.fn.sign_define('gobreakpoint', { text = '◉', texthl = 'Search' })
  vim.fn.sign_define('gobreakpoint', { text = '◉', texthl = 'GobreakpointSign' })

  --  If the line isn't already in the list, add it.
  --  Otherwise remove it from the list.
  local i = vim.fn.index(breakpoints, breakpoint)
  if i == -1 then
     -- Adicionar o breakpoint à lista
    table.insert(breakpoints, breakpoint)
    vim.g.godebug_breakpoints = breakpoints

    -- Colocar o sinal
    vim.api.nvim_command('sign place ' .. line .. ' line=' .. line .. ' name=gobreakpoint file=' .. file)
  else
    -- Remover o breakpoint da lista
    table.remove(breakpoints, i)
    vim.g.godebug_breakpoints = breakpoints

    -- Remover o sinal
    vim.api.nvim_command('sign unplace ' .. line .. ' file=' .. file)
  end
end

function godebug.writeBreakpointsFile(...)
  local breakpoints = vim.g.godebug_breakpoints or {}
  -- local args = { ... }

  -- Adiciona "continue" à lista de breakpoints
  table.insert(breakpoints, "continue")

  -- Define o caminho do arquivo para onde escrever os breakpoints
  local breakpoints_file = vim.g.godebug_breakpoints_file

  -- Escreve os breakpoints no arquivo
  vim.fn.writefile(breakpoints, breakpoints_file)
end

function godebug.deleteBreakpointsFile(...)
  local breakpoints_file = vim.g.godebug_breakpoints_file

  -- Verifica se o arquivo é legível
  if vim.fn.filereadable(breakpoints_file) == 1 then
    -- Deleta o arquivo
    vim.fn.delete(breakpoints_file)
  end
end

function godebug.debug(bang, ...)
  -- Chama a função para escrever os breakpoints no arquivo
  godebug.writeBreakpointsFile()

  -- Constrói o comando para o terminal
  local breakpoints_file = vim.g.godebug_breakpoints_file
  local command = { "dlv", "debug", "--init=" .. breakpoints_file }

  -- Adiciona argumentos extras, se houver
  local args = { ... }
  for _, arg in ipairs(args) do
    table.insert(command, arg)
  end

  -- Converte a tabela de comandos em uma string
  local command_str = table.concat(command, " ")

  vim.cmd('vsp')  -- Abre um terminal vertical
  vim.cmd('terminal')  -- Abre o terminal
  vim.fn.feedkeys("i" .. command_str .. "; exit\n")
end


function godebug.debugexec(bang, ...)
  -- Chama a função para escrever os breakpoints no arquivo
  godebug.writeBreakpointsFile()

  -- Constrói o comando para o terminal
  local breakpoints_file = vim.g.godebug_breakpoints_file
  local command = { "dlv", "exec", "--init=" .. breakpoints_file, "--" }

  -- Adiciona argumentos extras, se houver
  local args = { ... }
  -- Verifica se há argumentos
  if #args == 0 then
    print("Erro: Nenhum argumento foi passado. Você precisa fornecer o path do binario que deseja executar")
    return  -- Interrompe a execução do código se não houver argumentos
  end

  for _, arg in ipairs(args) do
    table.insert(command, arg)
  end

  -- Converte a tabela de comandos em uma string
  local command_str = table.concat(command, " ")

  vim.cmd('vsp')  -- Abre um terminal vertical
  vim.cmd('terminal')  -- Abre o terminal
  vim.fn.feedkeys("i" .. command_str .. "; exit\n")
end

function godebug.debugtest(bang, ...)
  -- Chama a função para escrever os breakpoints no arquivo
  godebug.writeBreakpointsFile()

  -- Constrói o comando para o terminal
  local breakpoints_file = vim.g.godebug_breakpoints_file
  local command = { "dlv", "test", "--init=" .. breakpoints_file }

  -- Adiciona argumentos extras, se houver
  local args = { ... }
  for _, arg in ipairs(args) do
    table.insert(command, arg)
  end

  -- Converte a tabela de comandos em uma string
  local command_str = table.concat(command, " ")

  local file_dir = vim.fn.expand('%:p:h')  -- Pega o diretório do arquivo atual

  vim.cmd('vsp')  -- Abre um terminal vertical
  vim.cmd('terminal')  -- Abre o terminal
  vim.fn.feedkeys("i cd " .. file_dir .. " && ".. command_str .. "; exit\n")
end

return godebug
