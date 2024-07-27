--
--
--                                         
--                                                  88                                       
--                                                  88                                      
--  ,adPPYba,  ,      .               .             88                ,adPPYba,              
-- a8      88 a8      8a  8b,dPPYba,  8a    ,adPPYb,88   ,adPPYba,   a8      88   ,adPPYba,  
-- 88      88 88      88  88P'   "Y8  88   a8"    `Y88  a8P     88a  88      88  a8P     88a 
-- 88      88 88      88  88          88   8b       88  8PP      88  88      88  8PP      88 
-- "8b,   ,aa "8b    ,aa  88          88   "8a,   ,d88  "8b,   ,d8`  "8b,   ,aa  "8b,   ,d8` 
--  `"Ybbd888  `"Ybbd8"'  88          88    `"8bbdP"Y8   `"Ybbd8"'    `"Ybbd888   `"Ybbd8"'  
--         88                                                                88               
-- 		   88                                                        		 88              
--  `"Ybbd8"'                                                         `"Ybbd8"'               
-- 
-- 
--                                                
--                                            88  
--                                            88  
--                                            88  
-- 8b,dPPYba,   ,adPPYba, 8b,dPPYba,  ,adPPYb,88  
-- 88P'   `"8a a8P_____88 88P'   "Y8 a8"    `Y88  
-- 88       88 8PP""""""" 88         8b       88  
-- 88       88 "8b,   ,aa 88         "8a,   ,d88  
-- 88       88  `"Ybbd8"' 88          `"8bbdP"Y8  
--
--

-- Função para exibir a mensagem "Hello"
local function show_hello()
	-- Cria um novo buffer
	local buf = vim.api.nvim_create_buf(false, true)
	-- Define o buffer como o buffer atual
	vim.api.nvim_set_current_buf(buf)
	-- Configura o buffer para não ser salvo
	vim.bo[buf].buftype = 'nofile'
	vim.bo[buf].bufhidden = 'wipe'

	-- Texto ASCII art ou banner
	local lines = {
		"                                                  88                                                 ",
		"                                                  88                                                 ",
		"  ,adPPYba,  ,      .               .             88                ,adPPYba,                        ",
		" a8      88 a8      8a  8b,dPPYba,  8a    ,adPPYb,88   ,adPPYba,   a8      88   ,adPPYba,            ",
		" 88      88 88      88  88P'   \"Y8  88   a8\"    `Y88  a8P     88a  88      88  a8P     88a         ",
		" 88      88 88      88  88          88   8b       88  8PP      88  88      88  8PP      88           ",
		" \"8b,   ,aa \"8b    ,aa  88          88   \"8a,   ,d88  \"8b,   ,d8`  \"8b,   ,aa  \"8b,   ,d8`     ",
		"  `\"Ybbd888  `\"Ybbd8\"'  88          88    `\"8bbdP\"Y8   `\"Ybbd8\"'    `\"Ybbd888   `\"Ybbd8\"'  ",
		"         88                                                                88                        ",
		" 		 88                                                        		   88                        ",
		"  `\"Ybbd8\"'                                                         `\"Ybbd8\"'                    ",
		"",
		"",
		"								ASCII Character Codes:",
		"								",
		"								",
		"								n = ASCII 110",
		"								e = ASCII 101",
		"								r = ASCII 114",
		"								d = ASCII 100",
		"								",
		"								Capitalised:",
		"								",
		"								",
		"								N = ASCII 78",
		"								E = ASCII 69",
		"								R = ASCII 82",
		"								D = ASCII 68",
	}

	-- Obtém o tamanho da janela
	local width = vim.api.nvim_get_option("columns")
	local height = vim.api.nvim_get_option("lines")

	-- Calcula as posições iniciais para centralizar o texto
	local start_col = math.floor((width - #lines[1]) / 2)
	local start_row = math.floor((height - #lines) / 2)

	-- Insere linhas vazias acima do texto para centralizá-lo verticalmente
	for _ = 1, start_row do
		table.insert(lines, 1, "")
	end
	-- Insere o texto no buffer com o espaçamento correto
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Centraliza o texto horizontalmente
	for i, line in ipairs(lines) do
		lines[i] = string.rep(" ", start_col) .. line
	end

	-- Define o conteúdo do buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Define um destaque para as linhas em verde
	vim.cmd("highlight HelloText guifg=#40b863")
	for i = 0, #lines - 1 do
		vim.api.nvim_buf_add_highlight(buf, -1, "HelloText", i, 0, -1)
	end

	-- Desativa os números das linhas e a barra de status no buffer atual
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.cursorline = false

	vim.api.nvim_create_autocmd({"BufWinLeave", "BufUnload"}, {
		buffer = buf,
		callback = function()
			vim.cmd('set number relativenumber cursorline laststatus=0')
		end
	})
end

-- Função principal para decidir se deve mostrar o hello ou abrir arquivos
local function start_nvim()
    -- Verifica se o Neovim foi iniciado com argumentos
    if #vim.fn.argv() == 0 then
        show_hello()
    end
end

-- Configuração para decidir o que fazer na inicialização
vim.api.nvim_create_autocmd("VimEnter", {
    callback = start_nvim
})
