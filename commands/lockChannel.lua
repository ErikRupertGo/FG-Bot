local lockChannel = {}

lockChannel.name = "lockChannel"
lockChannel.description = "Locks the people already inside the channel. No one goes out, no one comes in."
lockChannel.tag = "Power"
lockChannel.state = false
lockChannel.voiceChannel = nil
lockChannel.lockedMembers = {}

lockChannel.exec = function(self, message)

    local args = Split(message.content, " ")
    local member = message.guild:getMember(message.author.id)
    local voiceChannel = member.voiceChannel

    if #args ~= 1 then
        if args[2] == "who" then
            if not lockChannel.voiceChannel then return replyToMessage(message, "No channel is locked") end
            replyToMessage(message, lockChannel.voiceChannel.name.." is locked.")
            return
        end
    end

    -- Switcherino

    -- If already on
    if lockChannel.state then 

        -- If author is not on the list
        if not existsInArray(lockChannel.lockedMembers, member) then 
            replyToMessage(message, "You are not permitted to do this command")
            return
        end

        replyToMessage(message, "Channel \""..lockChannel.voiceChannel.name.."\" __unlocked__")
        lockChannel.voiceChannel = nil 
        lockChannel.lockedMembers = {}
    else
        if not voiceChannel then 
            replyToMessage(message, "You are not in a voice channel")
            return
        end
    
        voiceChannel.connectedMembers:forEach(function(member)
            table.insert(lockChannel.lockedMembers, member)
        end)
        lockChannel.voiceChannel = voiceChannel
        replyToMessage(message, "Channel \""..lockChannel.voiceChannel.name.."\" __locked__")
    end
    -- Switch
    lockChannel.state = not lockChannel.state


end

return lockChannel