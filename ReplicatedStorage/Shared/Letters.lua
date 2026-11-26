local v1 = {ID_PATTERN = "^[%w%-_]+$", MAX_ID = 40, REACTABLE = 8, LIST = {{id = "welcome-2026-09-28", date = "2026-09-28", author = 22641473, heading = "Welcome to Tribes", signature = "— SnickTrix", reactions = true, body = {"If you're reading this, you're here very early. This is my new team based PvP game. It's based on my Minecraft gamemode from 2016.", "I'm updating the game everyday. The meta will be changing often..", "GLHF"}}}}
local v2 = {}
local v3 = {}
local count = 0

for _, v6 in v1.LIST do
    assert((type(v6.id) == "string" and #v6.id <= v1.MAX_ID and string.match(v6.id, v1.ID_PATTERN)), "bad letter id")
    assert(v2[v6.id] == nil, "duplicate letter id " .. v6.id)
    v2[v6.id] = v6

    if v6.reactions ~= false and count < v1.REACTABLE then
        v3[v6.id] = true
        count += 1
    end
end

function v1.Current()
    --[[
      name: Current
      line: 62
      upvalues:
        v1 (copy, index: 1)
    ]]
    return v1.LIST[1]
end

function v1.Get(key)
    --[[
      name: Get
      line: 66
      upvalues:
        v2 (copy, index: 1)
    ]]
    if type(key) ~= "string" then
        return nil
    end

    return v2[key]
end

function v1.CanReact(key)
    --[[
      name: CanReact
      line: 71
      upvalues:
        v3 (copy, index: 1)
    ]]
    return type(key) == "string" and v3[key] == true
end

function v1.ReactableIds()
    --[[
      name: ReactableIds
      line: 76
      upvalues:
        v1 (copy, index: 1)
        v3 (copy, index: 2)
    ]]
    local v9 = {}

    for _, v11 in v1.LIST do
        if v3[v11.id] then
            table.insert(v9, v11.id)
        end
    end

    return v9
end

function v1.IsIdShape(text: string)
    --[[
      name: IsIdShape
      line: 87
      upvalues:
        v1 (copy, index: 1)
    ]]
    return type(text) == "string"
        and 0 < #text
        and #text <= v1.MAX_ID
        and string.match(text, v1.ID_PATTERN) ~= nil
end

return v1