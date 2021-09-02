require("util")
local commands = {}

commands.help = {}
commands.help.name = "help"
commands.help.description = [[Gives you this info. Bot created by Chad Thundercock.]];

function commands.help.exec(message)
    for k, v in pairs(commands) do
        message.channel:send(commands[k].name.."    "..commands[k].description)
    end
end

commands.upgrade = {}
commands.upgrade.name = "upgrade"
commands.upgrade.description = "Gives the mentioned user the everyone role \n does nothing yet"

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
commands.downgrade.description = "Removes the everyone role from specified user \n does nothing yet"

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
        else
            commands.concertMode.userid = message.author.id
            
            commands.concertMode.channel = member.voiceChannel
            
            commands.concertMode.on = true
            message.channel:send("Concert Mode enabled; Connected to: "..commands.concertMode.channel.name)
        end
    elseif args[2] == "disable" then
        commands.concertMode.userid = nil
        commands.concertMode.on = false
        message.channel:send("Concert Mode disabled")
    elseif args[2] == "who" then
        if commands.concertMode.userid == nil then
            message.channel:send("No user selected")
        else
            message.channel:send("<@"..commands.concertMode.userid.."> is the MC of "..commands.concertMode.channel.name)
        end
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
    commands.prefix.currentPrefix = args[2]
    message.channel:send("Prefix changed to "..commands.prefix.currentPrefix)
end

commands.donate = {}
commands.donate.name = "donate"
commands.donate.description = [[Donates to the owner]]
function commands.donate.exec(message)
    message.channel:send("Please send some money over at: paypal.me/KoolieAid \n GCASH: 09777708608; PayMaya(Better): 09777708608")
end

--[[Debug
for k, v in pairs(commands) do
    for iK, iV in pairs(commands[k]) do
        print(iK, iV)
    end
end

print()
print()
print(commands.help.name)]]
return commands