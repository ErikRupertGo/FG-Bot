local intro = {
    "Sorry I can't come",
    "Please forgive my absence",
    "This is going to sound crazy but,",
    "Get this:",
    "I can't go because",
    "I know you're going to hate me but,",
    "I was minding my own business, and BOOM!",
    "I feel trrible but,",
    "I regretfully cannot attend,",
    "This is going to sound like an excuse but,"
}

local scapeGoat = {
    "my nephew",
    "the ghost of Hitler",
    "the Pope",
    "my ex",
    "a high school marching band",
    "Dan Rather",
    "a sad clown",
    "the kid from Air Bud",
    "a professional cricket team",
    "my Tinder date",
    "Brendan"
}

local delay = {
    "just shit the bed",
    "died in front of me",
    "won't stop telling me knock knock jokes",
    "is having a nervous breakdown",
    "gave me syphilis",
    "poured lemonade in my gas tank",
    "stabbed me",
    "found my box of human teeth",
    "stole my bicycle",
    "posted my nudes on Instagram"
}

local reason = {}
reason.name = "reason"
reason.description = "Gives a very convincing reason"

function reason:exec(message)
    replyToMessage(message, intro[math.random(#intro)].." "..scapeGoat[math.random(#scapeGoat)].." "..delay[math.random(#delay)])
end

return setmetatable(reason, {__index = self})