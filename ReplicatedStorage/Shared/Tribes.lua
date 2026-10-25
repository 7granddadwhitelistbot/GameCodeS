local tbl_upv_1 = {}
tbl_upv_1.MAX_MEMBERS = 30
tbl_upv_1.FOUND_LEVEL = 10
tbl_upv_1.TAG_MIN = 2
tbl_upv_1.TAG_MAX = 4
tbl_upv_1.NAME_MIN = 3
tbl_upv_1.NAME_MAX = 20
tbl_upv_1.LEAVE_COOLDOWN = 1200
tbl_upv_1.RENOWN_WIN = 3
tbl_upv_1.RENOWN_LOSS = 1
tbl_upv_1.STACK_MULT = {1, 1.5, 2}
tbl_upv_1.CHEST_TIERS = {40, 150, 400, 900, 1800}
tbl_upv_1.CHEST_MIN = 25
tbl_upv_1.CHEST_TERRITORY_MAX = 3
tbl_upv_1.WEEK_EPOCH = 345600
tbl_upv_1.WEEK_LENGTH = 604800
tbl_upv_1.JOIN_MODES = {"open", "request", "invite"}
tbl_upv_1.ICONS = {"wolf", "bear", "raven", "eagle", "serpent", "boar", "stag", "fox", "owl", "shark", "flame", "sun", "moon", "star", "bolt", "mountain", "wave", "tree", "crown", "swords", "axe", "bow", "shield", "gem", "lion", "dragon", "scorpion", "anchor", "bull", "octopus", "trident", "skull", "ram", "griffin", "claws"}
tbl_upv_1.COLORS = {
    Color3.fromRGB(40, 150, 255),
    Color3.fromRGB(90, 200, 255),
    Color3.fromRGB(40, 190, 170),
    Color3.fromRGB(64, 200, 100),
    Color3.fromRGB(160, 210, 60),
    Color3.fromRGB(255, 205, 50),
    Color3.fromRGB(240, 160, 40),
    Color3.fromRGB(255, 120, 40),
    Color3.fromRGB(235, 60, 60),
    Color3.fromRGB(180, 30, 60),
    Color3.fromRGB(255, 100, 170),
    Color3.fromRGB(210, 70, 200),
    Color3.fromRGB(140, 90, 230),
    Color3.fromRGB(80, 90, 220),
    Color3.fromRGB(30, 50, 120),
    Color3.fromRGB(30, 110, 60),
    Color3.fromRGB(140, 90, 50),
    Color3.fromRGB(210, 180, 120),
    Color3.fromRGB(90, 105, 125),
    Color3.fromRGB(40, 44, 52),
    Color3.fromRGB(170, 178, 190),
    Color3.fromRGB(110, 30, 40),
    Color3.fromRGB(120, 230, 180),
    Color3.fromRGB(180, 140, 255),
    Color3.fromRGB(246, 248, 252)
}
tbl_upv_1.WHITE = 25
function tbl_upv_1.Color(a1)
    --[[
      name: Color
      line: 73
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local COLORS_1 = tbl_upv_1.COLORS
    local v1
    if type(a1) ~= "number" then
        v1 = 1
    else
        v1 = a1
    end
    return COLORS_1[v1] or (tbl_upv_1.COLORS[1])
end
function tbl_upv_1.TextColor(a1)
    --[[
      name: TextColor
      line: 78
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v2 = tbl_upv_1.Color(a1)
    local _, v4, v3 = v2:ToHSV()
    if v3 < 0.62 then
        return (v2:Lerp(Color3.new(1, 1, 1), 0.45))
    end
    return v2
end
function tbl_upv_1.Renown(a1, a2)
    --[[
      name: Renown
      line: 84
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v4
    if a1 then
        v4 = tbl_upv_1.RENOWN_WIN
    else
        v4 = tbl_upv_1.RENOWN_LOSS
    end
    return (math.floor((v4 * tbl_upv_1.STACK_MULT[math.clamp(math.floor(a2), 1, 3)]) + 0.5))
end
function tbl_upv_1.ChestTier(a1)
    --[[
      name: ChestTier
      line: 90
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v5 = 0
    for key_1, value_1 in tbl_upv_1.CHEST_TIERS do
        if value_1 <= a1 then
            v5 = key_1
        end
    end
    return v5
end
function tbl_upv_1.WeekOf(a1)
    --[[
      name: WeekOf
      line: 100
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return (math.floor((a1 - tbl_upv_1.WEEK_EPOCH) / tbl_upv_1.WEEK_LENGTH))
end
function tbl_upv_1.WeekEndsAt(a1)
    --[[
      name: WeekEndsAt
      line: 104
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return tbl_upv_1.WEEK_EPOCH + ((a1 + 1) * tbl_upv_1.WEEK_LENGTH)
end
function tbl_upv_1.CleanTag(a1)
    --[[
      name: CleanTag
      line: 108
    ]]
    return string.upper(string.gsub(a1, "%s", ""))
end
function tbl_upv_1.ValidTag(a1)
    --[[
      name: ValidTag
      line: 112
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v6 = (tbl_upv_1.TAG_MIN <= #a1) and ((#a1 <= tbl_upv_1.TAG_MAX) and (string.match(a1, "^[A-Z0-9]+$") ~= nil))
    return v6
end
function tbl_upv_1.CleanName(a1)
    --[[
      name: CleanName
      line: 116
    ]]
    local v7 = string.gsub(a1, "%s+", " ")
    return string.match(v7, "^%s*(.-)%s*$") or v7
end
function tbl_upv_1.ValidName(a1)
    --[[
      name: ValidName
      line: 122
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if not (#a1 < tbl_upv_1.NAME_MIN) and not (tbl_upv_1.NAME_MAX < #a1) then
        local v8 = string.match(a1, "^[%w][%w '%.%-]*[%w%.']$") ~= nil
        return v8
    end
    return false
end
local tbl_upv_3 = {
    kicked = "You were kicked from that tribe recently. Ask them for an invite.",
    filtered = "That isn't allowed. Try something else.",
    no_request = "That request is gone.",
    min_level = "Your level is below that tribe's minimum.",
    not_found = "That tribe doesn't exist any more.",
    in_tribe = "Leave your tribe first.",
    busy = "One moment.",
    invites_full = "Your tribe has too many invites waiting.",
    lobby_only = "Do that from the lobby.",
    unavailable = "Tribes are unavailable right now. Try again soon.",
    bad_target = "You can't do that.",
    requests_full = "That tribe has too many requests waiting. Try again later.",
    not_member = "You're not in that tribe.",
    tag_taken = "That tag is taken.",
    target_in_tribe = "They're already in a tribe.",
    no_permission = "Your rank can't do that.",
    offline = "They're not in a lobby right now.",
    cooldown = "You left a tribe a moment ago. You can join another in a few minutes.",
    invite_only = "That tribe is invite only."
}
tbl_upv_3.level = ("Reach level %* to found a tribe."):format(tbl_upv_1.FOUND_LEVEL)
tbl_upv_3.bad_tag = ("Tags are %* to %* letters or numbers."):format(tbl_upv_1.TAG_MIN, tbl_upv_1.TAG_MAX)
tbl_upv_3.bad_name = ("Names are %* to %* letters, numbers or spaces."):format(tbl_upv_1.NAME_MIN, tbl_upv_1.NAME_MAX)
tbl_upv_3.full = ("That tribe is full (%* members)."):format(tbl_upv_1.MAX_MEMBERS)
function tbl_upv_1.Message(a1)
    --[[
      name: Message
      line: 156
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    return tbl_upv_3[a1] or "Something went wrong. Try again."
end
return tbl_upv_1