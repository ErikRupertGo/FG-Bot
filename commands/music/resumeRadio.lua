local resumeRadio = {}
resumeRadio.name = "resumeRadio"
resumeRadio.description = "Resumes the radio, if paused"
resumeRadio.exec = function(message)

    if not commands.startRadio.state then
        replyToMessage(message, "Radio is not online")
        return
    end

    local connection = message.guild.connection
    if not connection then
        replyToMessage(message, "Seems like I got disconnected")
        commands.startRadio.state = false
        return
    end

    connection:resumeStream()
    replyToMessage(message, "Radio Resumed")
end

return resumeRadio