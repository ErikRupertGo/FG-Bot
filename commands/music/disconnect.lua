local disconnect = {}
disconnect.name = "disconnect"
disconnect.description = "Disconnect from the connected channel"
disconnect.tag = "Music"
disconnect.exec = function(self, message)

    local connection = message.guild.connection
    if not connection then
        replyToMessage(message, "Seems like I already disconnected")
        commands.startRadio.state = false
        return
    end

    connection:close()
    replyToMessage(message, "Disconnected from: "..connection.channel.name)
    commands.startRadio.state = false

end

return disconnect