local concertMode = {}
concertMode.name = "concertMode"
concertMode.description = [[Makes the author the only one who can sing/talk in a channel]]
concertMode.tag = "General"
concertMode.on = false
concertMode.userid = nil
concertMode.channel = nil

concertMode.exec = function(self, message)
    local args = Split(message.content, " ")
    local member = message.guild:getMember(message.author.id)

    if args[2] == "enable" then

        if self.on then
            replyToMessage(message, "Concert Mode is already on at: "..self.channel.name.."\nDisable concert mode first before changing channel")
            return
        end

        if member.voiceChannel == nil then
            replyToMessage(message, "You are not connected to a channel")
            return
        end

        self.userid = message.author.id
        self.channel = member.voiceChannel
        self.on = true

        --Muting already connected Users
        local joinedMembers = member.voiceChannel.connectedMembers
        for k, v in pairs(joinedMembers) do
            if v.user.id ~= self.userid then
                v:mute()
            end
        end
        
        replyToMessage(message, "Concert Mode enabled; Connected to: "..self.channel.name)
        
    elseif args[2] == "disable" then

        if message.author.id ~= self.userid then 
            replyToMessage(message, "You are not the MC")
            return
        end

        self.userid = nil
        self.channel = nil
        self.on = false

        --Unmuting already connected Users
        local joinedMembers = member.voiceChannel.connectedMembers

        for k, v in pairs(joinedMembers) do
            if v.user.id ~= self.userid then
                v:unmute()
            end
        end
        
        replyToMessage(message, "Concert Mode disabled")

    elseif args[2] == "who" then
        if concertMode.userid == nil then
            replyToMessage(message, "No user selected")
            return
        end
            replyToMessage(message, "<@"..self.userid.."> is the MC of "..self.channel.name)
    else
        replyToMessage(message, self.on)
    end
 
end

return setmetatable(concertMode, {__index = self})