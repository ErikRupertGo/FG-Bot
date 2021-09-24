local help = {}
help.name = "help"
help.description = [[Gives you this info.]];
help.tag = "General"
help.concatString = nil
help.general = ""
help.music = ""
help.others = ""
function help:update()
    local temp = {}
    
    for k, v in pairs(commands) do 
        table.insert(temp, v.name.." - "..v.description)
    end

    self.concatString = table.concat(temp, "\n")

    local generalTable = {}
    local musicTable = {}
    local powerTable = {}
    local othersTable = {}

    -- Coverting to Table
    for k, v in pairs(commands) do
        if v.tag == "General" then
            table.insert(generalTable, v.name)
        elseif v.tag == "Music" then
            table.insert(musicTable, v.name)
        elseif v.tag == "Power" then
            table.insert(powerTable, v.name)
        else
            table.insert(othersTable, v.name)
        end
    end

    -- Concatenating to strings
    self.general = table.concat(generalTable, ", ")
    self.music = table.concat(musicTable, ", ")
    self.power = table.concat(powerTable, ", ")
    self.others = table.concat(othersTable, ", ")

end

function help:exec(message)

    local args = Split(message.content, " ")

    if #args ~= 1 then
        if commands[args[2]] == nil then
            replyToMessage(message, "No such command exists!")
            return
        end
        replyToMessage(message, commands[args[2]].name.."\t-\t "..commands[args[2]].description)
        return
    end

    message:reply {
      embed = {
        Title = "Help Menu",
        description = "Bot made by Chad Thundercock with the power of **Lua**, **Luvit**, and **Discordia**",
        fields = {
          {name = "General", value = self.general},
          {name = "Music", value = self.music},
          {name = "Power", value = self.power},
          {name = "Others", value = self.others}
        },
        author = {name = message.client.user.name, icon_url = message.client.user.avatarURL}
              },
        reference = {message = message}
    }
end

return setmetatable(help, {__index = self})