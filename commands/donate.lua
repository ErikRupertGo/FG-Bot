local donate = {}
donate.name = "donate"
donate.description = [[Donates to the owner]]
function donate:exec(message)
    replyToMessage(message, "Please send some money over at: https://www.paypal.com/paypalme/KoolieAid\nGCASH: 09777708608; PayMaya(Better): 09777708608")
end

return donate