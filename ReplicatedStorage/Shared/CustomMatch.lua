local v1 = {CODE_LEN = 6, ALPHABET = "ABCDEFGHJKMNPQRSTUVWXYZ23456789", NAME_MAX = 28, NAME_MIN = 3, MAX_PLAYERS = 10, TEAM_SIZE = 3, MODES = {"3v3", "1v1"}, DEFAULT_MODE = "3v3"}

function v1.Mode(a2)
    --[[
      name: Mode
      line: 31
      upvalues:
        v1 (copy, index: 1)
    ]]
    if a2 == "1v1" then
        return "1v1"
    end

    return v1.DEFAULT_MODE
end

function v1.TeamSize(a3)
    --[[
      name: TeamSize
      line: 36
      upvalues:
        v1 (copy, index: 1)
    ]]
    if v1.Mode(a3) == "1v1" then
        return 1
    end

    return v1.TEAM_SIZE
end

function v1.ModeLabel(a4)
    --[[
      name: ModeLabel
      line: 41
      upvalues:
        v1 (copy, index: 1)
    ]]
    return string.upper(v1.Mode(a4))
end

v1.LIST_MAX = 40
v1.LIST_REFRESH = 5
v1.NO_REWARDS = "Custom matches don't give rewards"
local v5 = {}

for index = 1, #v1.ALPHABET do
    v5[string.sub(v1.ALPHABET, index, index)] = true
end

function v1.CleanCode(text: string)
    --[[
      name: CleanCode
      line: 64
      upvalues:
        v5 (copy, index: 1)
        v1 (copy, index: 2)
    ]]
    if type(text) ~= "string" then
        return ""
    end

    local parts = {}

    for v9 in string.gmatch(string.upper((string.sub(text, 1, 64))), ".") do
        if v5[v9] then
            table.insert(parts, v9)
            local partCount = #parts

            if v1.CODE_LEN <= partCount then
                break
            end
        end
    end

    return table.concat(parts)
end

function v1.ValidCode(a11)
    --[[
      name: ValidCode
      line: 81
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v12 = v1.CleanCode(a11)

    if #v12 == v1.CODE_LEN and type(a11) == "string" and #a11 <= 64 then
        return v12
    end

    return nil
end

function v1.FormatCode(text: string)
    --[[
      name: FormatCode
      line: 90
      upvalues:
        v1 (copy, index: 1)
    ]]
    if #text ~= v1.CODE_LEN then
        return text
    end

    return string.sub(text, 1, 3) .. " " .. string.sub(text, 4)
end

function v1.CleanName(text: string)
    --[[
      name: CleanName
      line: 99
      upvalues:
        v1 (copy, index: 1)
    ]]
    if type(text) ~= "string" then
        return ""
    end

    local substring = string.sub(text, 1, 200)
    local text2 = string.gsub(substring, "[%c]", " ")
    local text3 = string.gsub(text2, "%s+", " ")
    local text4 = string.match(text3, "^%s*(.-)%s*$") or ""

    if not utf8.len(text4) then
        return ""
    end

    local length = utf8.len(text4)

    if v1.NAME_MAX < length then
        local v20 = utf8.offset(text4, v1.NAME_MAX + 1) or #text4 + 1
        local substring2 = string.sub(text4, 1, v20 - 1)
        text4 = string.match(substring2, "^(.-)%s*$") or substring2
    end

    return text4
end

function v1.DefaultName(a22)
    --[[
      name: DefaultName
      line: 118
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v23 = v1.CleanName(a22 .. "'s match")

    if v23 ~= "" then
        return v23
    end

    return "Custom match"
end

function v1.Deal(a24, a25, a26)
    --[[
      name: Deal
      line: 129
      upvalues:
        v1 (copy, index: 1)
    ]]
    local v27 = a25 or Random.new()
    local v28 = a26 or v1.TEAM_SIZE
    local v29 = {{}, {}}
    local v30 = {}
    local v31 = {}

    for _, v33 in a24 do
        local team = v33.team

        if team == 1 or team == 2 then
            local v35 = if #v29[team] < v28 then v29[team] else v30
            table.insert(v35, v33.id)
        else
            table.insert(v31, v33.id)
        end
    end

    local v36 = (v28 * 2) - #v29[1] - #v29[2]
    local v37 = {}

    for v38, v39 in v31 do
        local v40 = if v38 <= v36 then v37 else v30
        table.insert(v40, v39)
    end

    for index = #v37, 2, -1 do
        local v42 = v27:NextInteger(1, index)
        v37[index], v37[v42] = v37[v42], v37[index]
    end

    for _, v44 in v37 do
        local v45 = if #v29[2] < #v29[1] then v29[2] else v29[1]
        table.insert(v45, v44)
    end

    return v29[1], v29[2], v30
end

return v1