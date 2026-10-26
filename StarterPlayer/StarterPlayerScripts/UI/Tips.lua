local tbl_upv_1 = {}
tbl_upv_1.LIST = {
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
local u1 = 0
function tbl_upv_1.Next()
    --[[
      name: Next
      line: 25
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u1 (ref,  index: 2)
    ]]
    local v1 = #tbl_upv_1.LIST
    local v2 = math.random(1, v1)
    if v2 == u1 then
        v2 = v2 % v1 + 1
    end
    u1 = v2
    return tbl_upv_1.LIST[v2]
end
return tbl_upv_1