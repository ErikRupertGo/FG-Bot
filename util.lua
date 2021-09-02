--Ripped off from https://www.codegrepper.com/code-examples/lua/lua+split+string+into+table
function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
