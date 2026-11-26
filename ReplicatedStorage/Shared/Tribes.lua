local v1 = {
    MAX_MEMBERS = 30,
    FOUND_LEVEL = 10,
    TAG_MIN = 2,
    TAG_MAX = 4,
    NAME_MIN = 3,
    NAME_MAX = 20,
    LEAVE_COOLDOWN = 1200,
    RENOWN_WIN = 3,
    RENOWN_LOSS = 1,
    STACK_MULT = {1, 1.5, 2},
    CHEST_TIERS = {40, 150, 400, 900, 1800},
    CHEST_MIN = 25,
    CHEST_TERRITORY_MAX = 3,
    WEEK_EPOCH = 345600,
    WEEK_LENGTH = 604800,
    JOIN_MODES = {"open", "request", "invite"},
    ICONS = {"wolf", "bear", "raven", "eagle", "serpent", "boar", "stag", "fox", "owl", "shark", "flame", "sun", "moon", "star", "bolt", "mountain", "wave", "tree", "crown", "swords", "axe", "bow", "shield", "gem", "lion", "dragon", "scorpion", "anchor", "bull", "octopus", "trident", "skull", "ram", "griffin", "claws"}
}
local colors = {
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
    (Color3.fromRGB(30, 110, 60)),
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
v1.COLORS = colors
v1.WHITE = 25

function v1.Color(a3)
    --[[
      name: Color
      line: 73
      upvalues:
        v1 (copy, index: 1)
    ]]
    local colorKey
    local colors = v1.COLORS

    if type(a3) ~= "number" then
        colorKey = 1
    else
        colorKey = a3
    end

    return colors[colorKey] or v1.COLORS[1]
end

function v1.TextColor(a6)
    --[[
      name: TextColor
      line: 78
      upvalues:
        v1 (copy, index: 1)
    ]]
    local startValue = v1.Color(a6)
    local _, _, v10 = startValue:ToHSV()

    if v10 < 0.62 then
        return (startValue:Lerp(Color3.new(1, 1, 1), 0.45))
    end

    return startValue
end

function v1.Renown(a11, a12: number)
    --[[
      name: Renown
      line: 84
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v13 = if a11 then v1.RENOWN_WIN else v1.RENOWN_LOSS
    return (math.floor((v13 * v1.STACK_MULT[math.clamp(math.floor(a12), 1, 3)]) + 0.5))
end

function v1.ChestTier(a14)
    --[[
      name: ChestTier
      line: 90
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v15 = 0

    for v16, chestTier in v1.CHEST_TIERS do
        if chestTier <= a14 then
            v15 = v16
        end
    end

    return v15
end

function v1.WeekOf(a18)
    --[[
      name: WeekOf
      line: 100
      upvalues:
        v1 (copy, index: 1)
    ]]
    return (math.floor((a18 - v1.WEEK_EPOCH) / v1.WEEK_LENGTH))
end

function v1.WeekEndsAt(a19)
    --[[
      name: WeekEndsAt
      line: 104
      upvalues:
        v1 (copy, index: 1)
    ]]
    return v1.WEEK_EPOCH + ((a19 + 1) * v1.WEEK_LENGTH)
end

function v1.CleanTag(text: string)
    --[[
      name: CleanTag
      line: 108
    ]]
    return string.upper((string.gsub(text, "%s", "")))
end

function v1.ValidTag(text: string)
    --[[
      name: ValidTag
      line: 112
      upvalues:
        v1 (copy, index: 1)
    ]]
    local textLength = #text
    return v1.TAG_MIN <= textLength and #text <= v1.TAG_MAX and string.match(text, "^[A-Z0-9]+$") ~= nil
end

function v1.CleanName(text: string)
    --[[
      name: CleanName
      line: 116
    ]]
    local text2 = string.gsub(text, "%s+", " ")
    return string.match(text2, "^%s*(.-)%s*$") or text2
end

function v1.ValidName(text: string)
    --[[
      name: ValidName
      line: 122
      upvalues:
        v1 (copy, index: 1)
    ]]
    if not (#text < v1.NAME_MIN) then
        local textLength = #text

        if not (v1.NAME_MAX < textLength) then
            return string.match(text, "^[%w][%w '%.%-]*[%w%.']$") ~= nil
        end
    end

    return false
end

local v27 = {
    filtered = "That isn't allowed. Try something else.",
    tag_taken = "That tag is taken.",
    in_tribe = "Leave your tribe first.",
    cooldown = "You left a tribe a moment ago. You can join another in a few minutes.",
    not_found = "That tribe doesn't exist any more.",
    min_level = "Your level is below that tribe's minimum.",
    invite_only = "That tribe is invite only.",
    kicked = "You were kicked from that tribe recently. Ask them for an invite.",
    requests_full = "That tribe has too many requests waiting. Try again later.",
    invites_full = "Your tribe has too many invites waiting.",
    not_member = "You're not in that tribe.",
    no_permission = "Your rank can't do that.",
    no_request = "That request is gone.",
    target_in_tribe = "They're already in a tribe.",
    bad_target = "You can't do that.",
    unavailable = "Tribes are unavailable right now. Try again soon.",
    busy = "One moment.",
    lobby_only = "Do that from the lobby.",
    offline = "They're not in a lobby right now.",
    level = `Reach level {v1.FOUND_LEVEL} to found a tribe.`,
    bad_tag = `Tags are {v1.TAG_MIN} to {v1.TAG_MAX} letters or numbers.`,
    bad_name = `Names are {v1.NAME_MIN} to {v1.NAME_MAX} letters, numbers or spaces.`,
    full = `That tribe is full ({v1.MAX_MEMBERS} members).`
}

function v1.Message(key)
    --[[
      name: Message
      line: 156
      upvalues:
        v27 (copy, index: 1)
    ]]
    return v27[key] or "Something went wrong. Try again."
end

return v1