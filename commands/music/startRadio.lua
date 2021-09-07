local startRadio = {}
startRadio.name = "startRadio"
startRadio.description = "Starts simulator radio"
startRadio.link = "https://simulatorradio.stream/stream.mp3"
startRadio.state = false
startRadio.exec = function(message)

    local vChannel = message.member.voiceChannel
    if not vChannel then
        replyToMessage(message, "You are not connected to a channel")
        return
    end

    local connection = message.guild.connection
    if connection and startRadio.state == true then
        replyToMessage(message, "I am already connected to: "..connection.channel.name)
        return
    end

    commands.startRadio.state = true
    connection = vChannel:join()
    connection:setBitrate(128000)
    startRadio.routine = coroutine.create(function()
    connection:playFFmpeg(startRadio.link)
    end)

    coroutine.resume(startRadio.routine)
    replyToMessage(message, "Radio Started")
    --connection:playPCM(startRadio.link)
end

return startRadio