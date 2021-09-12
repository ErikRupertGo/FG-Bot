local upgrade = {}
upgrade.name = "upgrade"
upgrade.description = "Gives the mentioned user the everyone role"
upgrade.tag = "Power"

function upgrade:exec(message)
    local args = Split(message.content, " ")
    local guild = message.guild
    if #args == 1 then
        replyToMessage(message, "No user specified")
        return
    end

    replyToMessage(message, "Upgrading User(s)...")

    local role = guild:getRole('760002551461707806')

    for k, v in pairs(message.mentionedUsers) do
        member = message.guild:getMember(v.id)
        if message.guild:getMember(message.author.id):hasRole(role) then
            member:addRole('760002551461707806')
        else
            replyToMessage(message, "You don't have the role yourself")
            return
        end
    end

    replyToMessage(message, "User(s) have been upgraded")
end

return upgrade