local stopRadio = {}
stopRadio.name = "stopRadio"
stopRadio.description = "Stops the radio"
stopRadio.tag = "Music"
stopRadio.exec = function(self, message)

    if not commands.startRadio.state then
        replyToMessage(message, "Radio is already offline")
        return
    end

    local connection = message.guild.connection
    if not connection then
        replyToMessage(message, "Seems like I already disconnected")
        commands.startRadio.state = false
        return
    end

    connection:stopStream()
    replyToMessage(message, "Stopped the radio")
    commands.startRadio.state = false
end

return stopRadio