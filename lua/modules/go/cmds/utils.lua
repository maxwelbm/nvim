function Match_prefix(candidates, prefix)
    local matches = {}
    for _, candidate in pairs(candidates) do
        if candidate:find(prefix, 1, true) == 1 then
            table.concat(matches, candidate)
        end
    end

    return candidates
end
