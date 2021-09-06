local team = {}

team.name = "team"
team.description = "Scramble teams for games"
local maps = {"Ascent", "Split", "Bind", "Haven", "Breeze", "Icebox", "Fracture"}
team.exec = function(message)

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
    end

    
    local temp = {"Team 1:\t\t\t\t\t\t\t\t\tTeam 2:"}

    for i = 1, cap / 2 do 
        table.insert(temp, "<@"..team1[i].id..">\t\t\t\t\t<@"..team2[i].id..">")
        --message:reply(team1[i].name.."          "..team[i].name)
    end

    if extra then
        --print ("Extra: " .. extra.name)
        table.insert(temp, "\nExtra: <@".. extra.id .. ">")
    else
        --print ("No spectators")
        table.insert(temp, "\nNo spectators")
    end

    table.insert(temp, "Map: "..maps[math.random(#maps)])
    --Map
    local returnString = table.concat(temp, "\n")

    message:reply(returnString)
end
return team