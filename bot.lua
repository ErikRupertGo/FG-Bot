discordia = require('discordia')
client = discordia.Client()
local clock = discordia.Clock()
commands = require ("commands")
discordia.extensions()
require("util")

local tokenFile = io.open("token", "r")
io.input(tokenFile)
local token = io.read()
io.close(tokenFile)

client:on('ready', function()
	commands.help.update()
	commands.lua.extra.client = client
	print("Bot is now online!")
end)

client:on('voiceChannelJoin', function(member, channel)
	--print(member.name.." Joined " .. channel.name)

	if commands.concertMode.on and (commands.concertMode.channel == channel) and (member.user.id ~= commands.concertMode.userid) then
		member:mute()
	end

	if member.muted and commands.concertMode.on and commands.concertMode.channel ~= channel then
		member:unmute()
	end

end)

client:on('voiceChannelLeave', function(member, channel)
-- empty
end)

client:on('voiceUpdate', function(member)
	--temp fix lmao
	if commands.concertMode.on and member.voiceChannel == commands.concertMode.channel and member.user.id ~= commands.concertMode.userid then
		member:mute()
	end

end)

client:on('messageCreate', function(message)

	if not message.guild then return end


	if string.find(message.content, "wanna die") then message:reply("same") end

	--[[
	if ((message.author.id ~= '881408982802116618') and (message.author.id ~= '343613515220647957')) then
		message:reply('ingay amp')
	elseif message.author.id == '343613515220647957' and not isCommand(message) then
		message:reply('tahimik amp')
	end]]

	if Split(message.content, " ")[1] == "!p" then
		message:reply("ulol tangina mo anong play play ka diyan")
	end

	local status, error;

	local function exec(k, message)
		commands[k].exec(message, message.content)
	end

	local args = Split(message.content, " ")

	if isCommand(message) then
		for k, v in pairs(commands) do
			if args[1] == commands.prefix.currentPrefix..commands[k].name then
					status, error = pcall(exec, k, message)
			end
		end
	end

	if status == false then message:reply("```"..error.."```") end
end)

function isCommand(message)
	local args = Split(message.content, ' ')

	for key, val in pairs(commands) do
		if string.find(args[1], commands.prefix.currentPrefix..commands[key].name) then
			return true
		end
	end
	return false
end

client:run("Bot "..token)