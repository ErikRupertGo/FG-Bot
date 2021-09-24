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

math.randomseed(os.time())
local mutedUsers = {}
--guildCollection = {}

client:on('ready', function()
	commands.help:update()
	commands.lua.extra.client = client
	--guildCollection = getJSONObject()
	print("Bot is now online!")
end)

client:on('voiceChannelJoin', function(member, channel)

	-- Concert Mode
	if commands.concertMode.on and channel.id ~= '890946244430663720' then
		if commands.concertMode.channel == channel and member.user.id ~= commands.concertMode.userid then
			member:mute()
		end

		if member.muted and commands.concertMode.channel ~= channel then
			member:unmute()
		end
	end

	-- Lock Channel
	if commands.lockChannel.state then
		-- Kicks strangers
		if not existsInArray(commands.lockChannel.lockedMembers, member) and channel == commands.lockChannel.voiceChannel then
			member:setVoiceChannel()
		-- On the lockdown list, bring member back
		elseif existsInArray(commands.lockChannel.lockedMembers, member) and channel ~= commands.lockChannel.voiceChannel then
			member:setVoiceChannel(commands.lockChannel.voiceChannel)
		end
	end

	-- OnlyBots Voice Channel
	if channel.id == '890946244430663720' and not member.user.bot then
		mutedUsers[member.id] = true
		member:mute()
	end

	if channel.id ~= '890946244430663720' and not member.user.bot then
		if mutedUsers[member.id] then
			member:unmute()
			mutedUsers[member.id] = false
		end
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

	if commands.lua.extra.protectMe then
		if member.user == client.owner and member.muted then
			member:unmute()
		end
	end

end)

client:on('messageCreate', function(message)
	--if message.author ~= client.owner then return end
	if not message.guild then return end
	if message.author.bot then return end

	if message.content:lower():find("bruh") then 
		local member = message.member
		local voiceChannel = member.voiceChannel
		local guildConnection = message.guild.connection
		if voiceChannel and not voiceChannel.connection and not commands.startRadio.state and not guildConnection then
			local fn = coroutine.wrap(function()
				connection = voiceChannel:join()
				if connection then
					connection:playFFmpeg("./voice_clips/bruh.mp3")
					connection:close()
				end
			end)
			
			pcall(fn)
		end
	end

	if string.find(message.content, "wanna die") then message:reply("same") end

	if Split(message.content, " ")[1] == "!p" then
		message:reply("ulol tangina mo anong play play ka diyan")
	end

	local args = Split(message.content, " ")

	if not string.find(args[1], commands.prefix.currentPrefix) then return end
    local cmd = string.sub(args[1], #commands.prefix.currentPrefix + 1)

	if commands[cmd] == nil then return end

	local status, error = pcall(commands[cmd].exec, commands[cmd], message, message.content)
	if status == false then message:reply("```"..error.."```") end

end)

client:run("Bot "..token)