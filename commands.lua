require("util")
commands = {}

commands.help = {}
commands.help.name = "help"
commands.help.description = [[Gives you this info.]];
commands.help.concatString = nil
function commands.help.update()
    local temp = {}
    
    for k, v in pairs(commands) do 
        table.insert(temp, v.name.." - "..v.description)
    end

    commands.help.concatString = table.concat(temp, "\n")

end

function commands.help.exec(message)
    message:reply(commands.help.concatString.."\n\nBot made by Chad Thundercock with the power of lua, luvit, and Discordia")
end

commands.upgrade = {}
commands.upgrade.name = "upgrade"
commands.upgrade.description = "Gives the mentioned user the everyone role"

function commands.upgrade.exec(message)
    local args = Split(message.content, " ")
    local guild = message.guild
    if #args == 1 then
        message.channel:send("No user specified")
        return
    end

    message.channel:send("Upgrading User(s)...")

    local role = guild:getRole('760002551461707806')

    for k, v in pairs(message.mentionedUsers) do
        member = message.guild:getMember(v.id)
        if message.guild:getMember(message.author.id):hasRole(role) then
            member:addRole('760002551461707806')
        else
            message:reply("You don't have the role yourself")
            return
        end
    end

    message:reply("User(s) have been upgraded")
end

commands.downgrade = {}
commands.downgrade.name = "downgrade"
commands.downgrade.description = "Removes the everyone role from specified user"

function commands.downgrade.exec(message)
    local args = Split(message.content, " ")
    local guild = message.guild
    if #args == 1 then
        message.channel:send("No user specified")
        return
    end

    message.channel:send("Downgrading User(s)...")

    local role = guild:getRole('760002551461707806')

    for k, v in pairs(message.mentionedUsers) do
        member = message.guild:getMember(v.id)
        if message.guild:getMember(message.author.id):hasRole(role) then
            member:removeRole('760002551461707806')
        else
            message:reply("You don't have the role yourself")
            return
        end
    end
    
    message:reply("User(s) have been downgraded")
end

commands.concertMode = {}
commands.concertMode.name = "concertMode"
commands.concertMode.description = [[Makes the author the only one who can sing/talk in a channel]]
commands.concertMode.on = false
commands.concertMode.userid = nil
commands.concertMode.channel = nil

commands.concertMode.exec = function(message)
    local args = Split(message.content, " ")
    local member = message.guild:getMember(message.author.id)

    if args[2] == "enable" then

        if commands.concertMode.on then
            message.channel:send("Concert Mode is already on at: "..commands.concertMode.channel.name.."\nDisable concert mode first before changing channel")
            return
        end

        if member.voiceChannel == nil then
            message.channel:send("You are not connected to a channel")
            return
        end

        commands.concertMode.userid = message.author.id
        commands.concertMode.channel = member.voiceChannel
        commands.concertMode.on = true

        --Muting already connected Users
        local joinedMembers = member.voiceChannel.connectedMembers
        for k, v in pairs(joinedMembers) do
            if v.user.id ~= commands.concertMode.userid then
                v:mute()
            end
        end
        
        message.channel:send("Concert Mode enabled; Connected to: "..commands.concertMode.channel.name)
        
    elseif args[2] == "disable" then

        if message.author.id ~= commands.concertMode.userid then 
            message:reply("You are not the MC") 
            return
        end

        commands.concertMode.userid = nil
        commands.concertMode.channel = nil
        commands.concertMode.on = false

        --Unmuting already connected Users
        local joinedMembers = member.voiceChannel.connectedMembers

        for k, v in pairs(joinedMembers) do
            if v.user.id ~= commands.concertMode.userid then
                v:unmute()
            end
        end
        
        message.channel:send("Concert Mode disabled")

    elseif args[2] == "who" then
        if commands.concertMode.userid == nil then
            message.channel:send("No user selected")
            return
        end
            message.channel:send("<@"..commands.concertMode.userid.."> is the MC of "..commands.concertMode.channel.name)
    else
        message.channel:send(commands.concertMode.on)
    end
 
end

commands.prefix = {}
commands.prefix.name = "prefix"
commands.prefix.description = [[Changes the prefix of the bot]]
commands.prefix.currentPrefix = "="
function commands.prefix.exec(message)
    local args = Split(message.content, " ")
    if args[2] == nil then
        message.channel:send("No prefix specified")
        return
    end
    commands.prefix.currentPrefix = args[2]
    message.channel:send("Prefix changed to "..commands.prefix.currentPrefix)
end

commands.donate = {}
commands.donate.name = "donate"
commands.donate.description = [[Donates to the owner]]
function commands.donate.exec(message)
    message.channel:send("Please send some money over at: paypal.me/KoolieAid \n GCASH: 09777708608; PayMaya(Better): 09777708608")
end

commands.lua = require("/commands/luaExec")
commands.lockChannel = require("/commands/lockChannel")

return commands