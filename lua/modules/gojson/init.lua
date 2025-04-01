-- Função para transformar JSON em struct usando gojson
local function json_to_go()
  -- Obter o texto selecionado visualmente
  local start_pos = vim.fn.getpos("'<") -- Início da seleção
  local end_pos = vim.fn.getpos("'>")   -- Fim da seleção

  -- Extrair o texto selecionado
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
  local json_input = table.concat(lines, "\n")

  -- Executar o comando `gojson` no texto selecionado
  local handle = io.popen("echo '" .. json_input .. "' | gojson")
  local output = handle:read("*a")
  handle:close()

  vim.api.nvim_buf_set_lines(0, start_pos[2] - 1, end_pos[2], false, vim.split(output, "\n"))
end

vim.api.nvim_create_user_command("Gojson", json_to_go, { range = true })
