local nick = {}

nick.name = "nick"
nick.description = "Changes the nickname of the mentioned user"
nick.exec = function(message)

    local member = message.guild:getMember(message.author.id)
    local guild = message.guild
    local args = Split(message.content, " ")

    local mentionedU = message.mentionedUsers
    local mentionedMem = guild:getMember(mentionedU.first.id)
    
    if #mentionedU == 0 then
        message:reply("Please include a user")
        return
    end

    if mentionedMem == guild.owner then
        message:reply("The mentioned user is the owner of the server, means I can't change their nickname")
        return
    end

    local oldNick = mentionedMem.nickname
    local newNickTab = {}
    local newNick = nil
    for i = 3, #args do
        table.insert(newNickTab, args[i])
    end
    newNick = table.concat(newNickTab, " ")
    mentionedMem:setNickname(newNick)

    if oldNick then
        message:reply(oldNick.."'s nickname changed to "..newNick) 
    else 
        if #newNick == 0 then
            message:reply(mentionedMem.name.."'s nickname has been reset")
        else
            message:reply(oldNick.."'s nickname has been changed to "..newNick)
        end
    end
end

return nick