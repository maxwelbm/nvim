print "setup font"


local cmd_ls_font = "fc-list | grep JetBrainsMono"
local file = io.popen(cmd_ls_font)

-- verifica se a table file é nil se for vai seguir a instalacao se não já vai para o fluxo
if file ~= nil then
    local output = file:read('*a')
    file:close()

    if output ~= "" then
        return
    end
end
