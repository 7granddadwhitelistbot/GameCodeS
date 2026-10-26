local tbl_upv_1 = {}
tbl_upv_1.CODE_LEN = 6
tbl_upv_1.ALPHABET = "ABCDEFGHJKMNPQRSTUVWXYZ23456789"
tbl_upv_1.NAME_MAX = 28
tbl_upv_1.NAME_MIN = 3
tbl_upv_1.MAX_PLAYERS = 10
tbl_upv_1.TEAM_SIZE = 3
tbl_upv_1.MODES = {"3v3", "1v1"}
tbl_upv_1.DEFAULT_MODE = "3v3"
function tbl_upv_1.Mode(a1)
    --[[
      name: Mode
      line: 31
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if a1 ~= "1v1" then
        return tbl_upv_1.DEFAULT_MODE
    end
    return "1v1"
end
function tbl_upv_1.TeamSize(a1)
    --[[
      name: TeamSize
      line: 36
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if tbl_upv_1.Mode(a1) ~= "1v1" then
        return tbl_upv_1.TEAM_SIZE
    end
    return 1
end
function tbl_upv_1.ModeLabel(a1)
    --[[
      name: ModeLabel
      line: 41
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return string.upper(tbl_upv_1.Mode(a1))
end
tbl_upv_1.LIST_MAX = 40
tbl_upv_1.LIST_REFRESH = 5
tbl_upv_1.NO_REWARDS = "Custom matches don't give rewards"
local tbl_upv_2 = {}
for n_1 = 1, #tbl_upv_1.ALPHABET do
    tbl_upv_2[string.sub(tbl_upv_1.ALPHABET, n_1, n_1)] = true
end
function tbl_upv_1.CleanCode(a1)
    --[[
      name: CleanCode
      line: 64
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if type(a1) ~= "string" then
        return ""
    end
    local tbl_3 = {}
    for key_1 in string.gmatch(string.upper(string.sub(a1, 1, 64)), ".") do
        if not (tbl_upv_2[key_1]) then
            continue
        end
        table.insert(tbl_3, key_1)
        if tbl_upv_1.CODE_LEN <= #tbl_3 then
            break
        end
    end
    return table.concat(tbl_3)
end
function tbl_upv_1.ValidCode(a1)
    --[[
      name: ValidCode
      line: 81
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = tbl_upv_1.CleanCode(a1)
    if #v1 == tbl_upv_1.CODE_LEN and type(a1) == "string" and #a1 <= 64 then
        return v1
    end
    return nil
end
function tbl_upv_1.FormatCode(a1)
    --[[
      name: FormatCode
      line: 90
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if #a1 == tbl_upv_1.CODE_LEN then
        return string.sub(a1, 1, 3) .. " " .. string.sub(a1, 4)
    end
    return a1
end
function tbl_upv_1.CleanName(a1)
    --[[
      name: CleanName
      line: 99
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if type(a1) ~= "string" then
        return ""
    end
    local v2 = string.match(string.gsub(string.gsub(string.sub(a1, 1, 200), "[%c]", " "), "%s+", " "), "^%s*(.-)%s*$") or ""
    if utf8.len(v2) then
        if tbl_upv_1.NAME_MAX < utf8.len(v2) then
            local v3 = utf8.offset(v2, tbl_upv_1.NAME_MAX + 1) or (#v2 + 1)
            local v4 = string.sub(v2, 1, v3 - 1)
            local v5 = string.match(v4, "^(.-)%s*$") or v4
            v2 = v5
        end
        return v2
    end
    return ""
end
function tbl_upv_1.DefaultName(a1)
    --[[
      name: DefaultName
      line: 118
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v6 = tbl_upv_1.CleanName(a1 .. "'s match")
    if v6 == "" then
        return "Custom match"
    end
    return v6
end
function tbl_upv_1.Deal(a1, a2, a3)
    --[[
      name: Deal
      line: 129
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v7 = a2 or (Random.new())
    local v8 = a3 or (tbl_upv_1.TEAM_SIZE)
    local tbl_4 = {{}, {}}
    local tbl_5 = {}
    local tbl_6 = {}
    local v9 = nil
    for _, value_1 in a1 do
        local team_1 = value_1.team
        if team_1 == 1 or team_1 == 2 then
            if #tbl_4[team_1] < v8 then
                v9 = tbl_4[team_1]
            else
                v9 = tbl_5
            end
            table.insert(v9, value_1.id)
        end
        table.insert(tbl_6, value_1.id)
    end
    local tbl_7 = {}
    for key_2, value_2 in tbl_6 do
        if key_2 <= ((v8 * 2) - #tbl_4[1]) - #tbl_4[2] then
            v9 = tbl_7
        else
            v9 = tbl_5
        end
        table.insert(v9, value_2)
    end
    for n_2 = #tbl_7, 2, -1 do
        local v10 = v7:NextInteger(1, n_2)
        local v11 = tbl_7[n_2]
        tbl_7[n_2] = tbl_7[v10]
        tbl_7[v10] = v11
    end
    for _, value_3 in tbl_7 do
        if #tbl_4[2] < #tbl_4[1] then
            v9 = tbl_4[2]
        else
            v9 = tbl_4[1]
        end
        table.insert(v9, value_3)
    end
    return tbl_4[1], tbl_4[2], tbl_5
end
return tbl_upv_1