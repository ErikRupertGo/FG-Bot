local pauseRadio = {}
pauseRadio.name = "pauseRadio"
pauseRadio.description = "Pauses simulator radio"
pauseRadio.exec = function(message)

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

    connection:pauseStream()
    replyToMessage(message, "Radio Paused")
end

return pauseRadio