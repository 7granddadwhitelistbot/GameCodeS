local GuiService_upv_1 = game:GetService("GuiService")
local Players_upv_1 = game:GetService("Players")
local UserInputService_upv_1 = game:GetService("UserInputService")
local tbl_1 = {}
local tbl_upv_2 = {BodyVelocity = 1, BodyThrust = 16, RocketPropulsion = 64, BodyForce = 8, BodyAngularVelocity = 32, BodyPosition = 4, BodyGyro = 2}
local u1 = 0
local u2 = false
local tbl_upv_3 = {}
local tbl_upv_4 = {}
local tbl_upv_5 = {}
local function note(a1)
    --[[
      name: note
      line: 67
      upvalues:
        u1 (ref, index: 1)
    ]]
    u1 = bit32.bor(u1, a1)
end
local function watch(a1)
    --[[
      name: watch
      line: 71
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u1 (ref,  index: 2)
    ]]
    local function look_1(a2)
        --[[
          name: look
          line: 72
          upvalues:
            tbl_upv_2 (copy, index: 1)
            a1 (copy, index: 2)
            u1 (ref,  index: 3)
        ]]
        local v1 = tbl_upv_2[a2.ClassName]
        local Parent_1 = a2.Parent
        if not v1 or not Parent_1 or not Parent_1:IsA("BasePart") or Parent_1.Parent ~= a1 then
            return
        end
        u1 = bit32.bor(u1, v1)
    end
    for _, value_1 in a1:GetDescendants() do
        local v2 = tbl_upv_2[value_1.ClassName]
        local Parent_2 = value_1.Parent
        if not (v2) or not (Parent_2) then
            continue
        end
        local v3 = Parent_2:IsA("BasePart")
        if not (v3) then
            continue
        end
        if Parent_2.Parent == a1 then
            u1 = bit32.bor(u1, v2)
        end
    end
    a1.DescendantAdded:Connect(look_1)
end
function tbl_1.Note(a1)
    --[[
      name: Note
      line: 86
      upvalues:
        u1 (ref, index: 1)
    ]]
    u1 = bit32.bor(u1, a1)
end
function tbl_1.Watch(a1, a2)
    --[[
      name: Watch
      line: 91
      upvalues:
        tbl_upv_3 (copy, index: 1)
    ]]
    for key_1, value_2 in next, a1 do
        if type(value_2) == "function" then
            table.insert(tbl_upv_3, {t = a1, k = key_1, f = value_2, bit = a2})
        end
    end
end
local v4 = Random.new()
tbl_1.PROBE = {n = v4:NextNumber(2e+06, 9e+06), s = string.format("%x%x", v4:NextInteger(268435456, 2147483647), v4:NextInteger(268435456, 2147483647)), t = {}, v = Vector3.new(v4:NextNumber(2e+06, 9e+06), v4:NextNumber(2e+06, 9e+06), v4:NextNumber(2e+06, 9e+06))}
function tbl_1.Hooked(a1, ...)
    --[[
      name: Hooked
      line: 107
      upvalues:
        tbl_upv_4 (copy, index: 1)
    ]]
    table.insert(tbl_upv_4, {f = a1, args = table.pack(...)})
end
local function ours(a1)
    --[[
      name: ours
      line: 112
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    local v5 = tbl_upv_5[a1]
    local v6 = nil
    if v5 == nil then
        v6 = string.match(a1, "^([%w_]+)%.")
        local v7 = false
        local v8 = nil
        if v6 then
            local success_1, v9 = pcall(game.FindService, game, v6)
            v7, v8 = success_1, v9
        end
        v5 = v7 and (v8 ~= nil)
        tbl_upv_5[a1] = v5
    end
    return v5
end
function tbl_1.Caller(a1)
    --[[
      name: Caller
      line: 126
      upvalues:
        u1 (ref,  index: 1)
        tbl_upv_5 (copy, index: 2)
    ]]
    if not bit32.btest(u1, a1) then
        local v10, v11 = nil, nil
        for n_1 = 2, 12 do
            local v12 = debug.info(n_1, "s")
            if v12 == nil then
                return
            end
            if v12 == "[C]" then
                continue
            end
            local v13 = tbl_upv_5[v12]
            if v13 == nil then
                local v14 = string.match(v12, "^([%w_]+)%.")
                v10 = false
                v11 = nil
                if v14 then
                    local success_2, v15 = pcall(game.FindService, game, v14)
                    v10, v11 = success_2, v15
                end
                v13 = v10 and (v11 ~= nil)
                tbl_upv_5[v12] = v13
            end
            if v13 then
                continue
            end
            u1 = bit32.bor(u1, a1)
            return
        end
    end
end
function tbl_1.Take()
    --[[
      name: Take
      line: 143
      upvalues:
        tbl_upv_3 (copy, index: 1)
        u1 (ref,  index: 2)
        tbl_upv_4 (copy, index: 3)
    ]]
    for _, value_3 in tbl_upv_3 do
        if rawget(value_3.t, value_3.k) ~= value_3.f then
            u1 = bit32.bor(u1, value_3.bit)
        end
    end
    for _, value_4 in tbl_upv_4 do
        local success_3, v16 = pcall(value_4.f, table.unpack(value_4.args, 1, value_4.args.n))
        if not (success_3) or v16 ~= value_4.args[1] then
            u1 = bit32.bor(u1, 256)
        end
    end
    local v17 = u1
    u1 = 0
    return v17
end
function tbl_1.Start()
    --[[
      name: Start
      line: 160
      upvalues:
        u2 (ref,  index: 1)
        Players_upv_1 (copy, index: 2)
        watch (copy, index: 3)
        u1 (ref,  index: 4)
        GuiService_upv_1 (copy, index: 5)
        UserInputService_upv_1 (copy, index: 6)
    ]]
    if u2 then
        return
    end
    u2 = true
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    if LocalPlayer_upv_1.Character then
        task.spawn(watch, LocalPlayer_upv_1.Character)
    end
    LocalPlayer_upv_1.CharacterAdded:Connect(watch)
    require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Simulation")).OnForeignWrite(
        function()
            --[[
              line: 173
              upvalues:
                u1 (ref, index: 1)
            ]]
            u1 = bit32.bor(u1, 2048)
        end
    )
    if (GuiService_upv_1:IsTenFootInterface()) or (UserInputService_upv_1.VREnabled) then
        return
    end
    task.spawn(
        function()
            --[[
              line: 180
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                u1 (ref,  index: 2)
            ]]
            local tbl_6 = {LocalPlayer_upv_1:GetMouse()}
            local v18 = setmetatable(tbl_6, {__mode = "v"})
            tbl_6 = 0
            local v19 = math.huge
            repeat
                local v20 = setmetatable({newproxy(true)}, {__mode = "v"})
                repeat
                    task.wait()
                until v20[1] == nil
                if v18[1] ~= nil then
                    tbl_6 = tbl_6 + 1
                    v19 = math.min(v19, os.clock())
                end
                if v18[1] == nil then
                    break
                end
                if not (tbl_6 >= 3) then
                    continue
                end
            until os.clock() - v19 >= 20
            if v18[1] == nil then
                return
            end
            u1 = bit32.bor(u1, 4096)
            task.wait(10)
        end
    )
end
return tbl_1