local discordia = require('discordia')
local client = discordia.Client()
local clock = discordia.Clock()
local commands = require ("commands")
discordia.extensions()
require("util")


local token = 'ODgxNDA4OTgyODAyMTE2NjE4.YSsaFQ.qIeqEH_meezByohRETo-yQ379-E'

client:on('ready', function()
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
	prefix = commands.prefix.currentPrefix

	--[[
	if ((message.author.id ~= '881408982802116618') and (message.author.id ~= '343613515220647957')) then
		message:reply('ingay amp')
	elseif message.author.id == '343613515220647957' and not isCommand(message) then
		message:reply('tahimik amp')
	end]]

	if Split(message.content, " ")[1] == "!p" then
		message:reply("ulol tangina mo anong play play ka diyan")
	end

	local args = Split(message.content, " ")

	if isCommand(message) then
		for k, v in pairs(commands) do
			if args[1] == prefix..commands[k].name then
				commands[k].exec(message)
			end
		end
	end

end)

function isCommand(message)
	local args = Split(message.content, ' ')

	for oKey, oVal in pairs(commands) do
		for key, val in pairs(commands[oKey]) do
			if string.find(args[1], prefix..commands[oKey].name) then
				return true
			end
		end
	end
	return false
end

client:run("Bot "..token)
