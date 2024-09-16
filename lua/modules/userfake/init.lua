local function random_function_name()
    local chars = "abcdefghijklmnopqrstuvwxyz"
    local name = "func "
    for _ = 1, math.random(5, 10) do
        local index = math.random(1, #chars)
        name = name .. chars:sub(index, index)
    end
    return name .. "()"
end

-- Control variable for pausing and resuming the process
local is_running = true

local function simulate_typing_and_deleting()
    local func_name = random_function_name()

    -- Simular a exclusão da função
    local function delete_text(remaining)
        if remaining > 0 then
            vim.cmd("normal! x")
            vim.cmd("redraw")
            vim.defer_fn(function()
                delete_text(remaining - 1) -- delete next char
            end, 100) -- 100ms delay
        elseif is_running then
            vim.defer_fn(simulate_typing_and_deleting, 1000)
        end
    end

    -- Simular a digitação da função
    local function type_text(index)
        if index <= #func_name then
            vim.api.nvim_put({ func_name:sub(index, index) }, "c", true, true)
            vim.cmd("redraw")
            vim.defer_fn(function()
                type_text(index + 1) -- Chama a próxima letra
            end, 100) -- Atraso de 100ms
        else
            -- Quando a função for completamente digitada, comece a deletar
            vim.defer_fn(function()
                delete_text(#func_name) -- Começa a deletar após 1 segundo
            end, 1000)
        end
    end

    -- Inicia a simulação de digitação
    type_text(1)
end

-- Função para pausar o loop
local function pause()
    is_running = false
end

-- Função para retomar o loop
local function resume()
    if not is_running then
        is_running = true
        simulate_typing_and_deleting() -- Reinicia o processo
    end
end

-- Crie os atalhos para executar, pausar e retomar a simulação
vim.keymap.set("n", "<leader>fk", simulate_typing_and_deleting, { desc = '[leader] + fk para simular digitação de função' })
vim.keymap.set("n", "<leader>fp", pause, { desc = '[leader] + fp para pausar a simulação' })
vim.keymap.set("n", "<leader>fr", resume, { desc = '[leader] + fr para retomar a simulação' })

