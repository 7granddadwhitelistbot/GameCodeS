local v1 = {
    LIST = {
        "Best of 5: win three rounds to take the match. One life per round.",
        "Arrows drop over distance: aim a little high on far targets.",
        "Headshots hit much harder. Aim for the head.",
        "Slide into cover, then jump out swinging.",
        "When the ring of fire closes in, fight in the middle or burn.",
        "Open LOADOUT and spend your gear points on any mix you like.",
        "Ammo is part of your loadout: bring enough arrows for the round.",
        "Heavy armor soaks damage but slows you down. Pick your trade-off.",
        "Hold block with the Iron Sword to soften hits from the front.",
        "Throwing knives: 5 per round. Make them count.",
        "Switch weapons any time from the hotbar.",
        "Stick with your team: two on one wins fights.",
        "Fireballs leave burning ground. Don't stand in it.",
        "Crossbows and muskets reload after every shot. Make it count."
    }
}
local v2 = 0

function v1.Next()
    --[[
      name: Next
      line: 25
      upvalues:
        v1 (copy, index: 1)
        v2 (ref,  index: 2)
    ]]
    local listLength = #v1.LIST
    local v4 = math.random(1, listLength)

    if v4 == v2 then
        v4 = v4 % listLength + 1
    end

    v2 = v4

    return v1.LIST[v4]
end

return v1