local voiceClip = {}

voiceClip.name = "voiceClip"
voiceClip.description = "Transmits audio clip from \'voice_clips\' folder. Message me if you want to add more"

function voiceClip:exec(message)
    local args = Split(message.content, " ")
    local member = message.guild:getMember(message.author.id)
    local voiceChannel = member.voiceChannel

    if #args == 1 then
        replyToMessage(message, "No arguments were passed")
        return
    end

    if not voiceChannel then 
        replyToMessage(message, "You are not in a voice channel")
        return
    end

    connection = voiceChannel:join()
    connection:playFFmpeg("./voice_clips/"..args[2])
    connection:close()

end


return voiceClip