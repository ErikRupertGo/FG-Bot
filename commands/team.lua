local team = {}

team.name = "team"
team.description = "Scramble teams for games"
local maps = {"Ascent", "Split", "Bind", "Haven", "Breeze", "Icebox", "Fracture"}
team.exec = function(self, message)
    message.channel:broadcastTyping();
    local mentionedUsers = message.mentionedUsers:toArray()
    local team1 = {}
    local team2 = {}
    local cap = #mentionedUsers

    local extra = nil
    
    if #mentionedUsers % 2 ~= 0 then
        local rand = math.random(#mentionedUsers)
        extra = mentionedUsers[rand]
        cap = cap - 1
        table.remove(mentionedUsers, rand)
    end 

    -- Team 1
    for i = 1, cap / 2 do
        local num = math.random(#mentionedUsers)
        local temp = mentionedUsers[num]
        table.insert(team1, i, temp)

        table.remove(mentionedUsers, num, temp)
    end

    -- Team 2
    for i = 1, cap / 2 do
        local num = math.random(#mentionedUsers)
        local temp = mentionedUsers[num]
        table.insert(team2, i, temp)

        table.remove(mentionedUsers, num, temp)
    end

    local temp = {}
    for i = 1, cap / 2 do 
        table.insert(temp, "<@"..team1[i].id..">")
    end
    local team1Concat = table.concat(temp, "\n")

    local temp = {}
    for i = 1, cap / 2 do 
        table.insert(temp, "<@"..team2[i].id..">")
    end
    local team2Concat = table.concat(temp, "\n")

    local description = nil

    if extra then
        description = "Spectator: <@"..extra.id..">\nMap: **"..maps[math.random(#maps)].."**"
    else
        description = "No Spectators\nMap: **"..maps[math.random(#maps)].."**"
    end
    
    message.channel:send {
        reference = {message = message},

        embed = {
          Title = "Team Scramble",
          description = description,
          fields = {
            {name = "Team 1", value = team1Concat, inline = true},
            {name = "Team 2", value = team2Concat, inline = true},
                    },
          author = {name = "Valorant Teams", icon_url = 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn.publish0x.com%2Fprod%2Ffs%2Fimages%2F6ac0ff5feb2e723eaa18dace82b96ab9aca5ed93038ad2d739f3d58132cc3bed.png&f=1&nofb=1'}
                    }
                        }
                        
            
end
return team