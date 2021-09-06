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

    mentionedMem:setNickname(args[3])
end

return nick