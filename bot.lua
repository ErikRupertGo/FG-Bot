local discordia = require('discordia')
local client = discordia.Client()
local commands = require ("commands")
discordia.extensions()
require("util")


local token = 'ODgxNDA4OTgyODAyMTE2NjE4.YSsaFQ.qIeqEH_meezByohRETo-yQ379-E'

client:on('ready', function()
	print("Bot is now online!")
end)

client:on('voiceChannelJoin', function(member, channel)
	print(member.name.." Joined " .. channel.name)
end)

client:on('voiceChannelLeave', function(member, channel)
	print(member.name.." Left " .. channel.name)
end)

client:on('messageCreate', function(message)
	--[[if message.content == prefix..'test' then
		message.channel:send('tangina mo')
	end
	--]]
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


	if isCommand(message) then
		if Split(message.content, ' ')[1] == prefix..commands.help.name then
			commands.help.exec(message)
		elseif Split(message.content, ' ')[1] == prefix..commands.upgrade.name then
			commands.upgrade.exec(message)
		elseif Split(message.content, ' ')[1] == prefix..commands.concertMode.name then
			commands.concertMode.exec(message)
		elseif Split(message.content, ' ')[1] == prefix..commands.prefix.name then
			commands.prefix.exec(message)
		elseif Split(message.content, ' ')[1] == prefix..commands.donate.name then
			commands.donate.exec(message)
		end
	end
	
	--[[
	if argument[1] == prefix..'upgrade' then
		print("test")
		message.channel:send(arguments[2])
	end]]--

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
