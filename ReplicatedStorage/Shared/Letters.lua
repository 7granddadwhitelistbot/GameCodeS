local tbl_upv_1 = {}
tbl_upv_1.ID_PATTERN = "^[%w%-_]+$"
tbl_upv_1.MAX_ID = 40
tbl_upv_1.REACTABLE = 8
tbl_upv_1.LIST = {{heading = "Welcome to Tribes", reactions = true, signature = "\226\128\148 SnickTrix", id = "welcome-2026-09-28", author = 22641473, date = "2026-09-28", body = {"If you're reading this, you're here very early. This is my new team based PvP game. It's based on my Minecraft gamemode from 2016.", "I'm updating the game everyday. The meta will be changing often..", "GLHF"}}}
local tbl_upv_2 = {}
local tbl_upv_3 = {}
local v1 = 0
for _, value_1 in tbl_upv_1.LIST do
    local v2 = (type(value_1.id) == "string") and ((#value_1.id <= tbl_upv_1.MAX_ID) and (string.match(value_1.id, tbl_upv_1.ID_PATTERN)))
    assert(v2, "bad letter id")
    assert(tbl_upv_2[value_1.id] == nil, "duplicate letter id " .. value_1.id)
    tbl_upv_2[value_1.id] = value_1
    if value_1.reactions == false then
        continue
    end
    if v1 < tbl_upv_1.REACTABLE then
        tbl_upv_3[value_1.id] = true
        v1 = v1 + 1
    end
end
function tbl_upv_1.Current()
    --[[
      name: Current
      line: 62
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return tbl_upv_1.LIST[1]
end
function tbl_upv_1.Get(a1)
    --[[
      name: Get
      line: 66
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if type(a1) ~= "string" then
        return nil
    end
    return tbl_upv_2[a1]
end
function tbl_upv_1.CanReact(a1)
    --[[
      name: CanReact
      line: 71
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    local v3 = (type(a1) == "string") and (tbl_upv_3[a1] == true)
    return v3
end
function tbl_upv_1.ReactableIds()
    --[[
      name: ReactableIds
      line: 76
      upvalues:
        tbl_upv_1 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    local tbl_4 = {}
    for _, value_2 in tbl_upv_1.LIST do
        if tbl_upv_3[value_2.id] then
            table.insert(tbl_4, value_2.id)
        end
    end
    return tbl_4
end
function tbl_upv_1.IsIdShape(a1)
    --[[
      name: IsIdShape
      line: 87
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v4 = (type(a1) == "string") and ((#a1 > 0) and ((#a1 <= tbl_upv_1.MAX_ID) and (string.match(a1, tbl_upv_1.ID_PATTERN) ~= nil)))
    return v4
end
return tbl_upv_1