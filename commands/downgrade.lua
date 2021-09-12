local downgrade = {}
downgrade.name = "downgrade"
downgrade.description = "Removes the everyone role from specified user"
downgrade.tag ="Power"

function downgrade:exec(message)
    local args = Split(message.content, " ")
    local guild = message.guild
    if #args == 1 then
        replyToMessage(message, "No user specified")
        return
    end

    replyToMessage(message, "Downgrading User(s)...")

    local role = guild:getRole('760002551461707806')

    for k, v in pairs(message.mentionedUsers) do
        member = message.guild:getMember(v.id)
        if message.guild:getMember(message.author.id):hasRole(role) then
            member:removeRole('760002551461707806')
        else
            replyToMessage(message, "You don't have the role yourself")
            return
        end
    end
    
    replyToMessage(message, "User(s) have been downgraded")
end

return downgrade