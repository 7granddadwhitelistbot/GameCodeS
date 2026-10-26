local Players_upv_1 = game:GetService("Players")
local UserInputService_upv_1 = game:GetService("UserInputService")
local tbl_1 = {}
local tbl_upv_2 = {BodyVelocity = 1, BodyThrust = 16, RocketPropulsion = 64, BodyForce = 8, BodyAngularVelocity = 32, BodyPosition = 4, BodyGyro = 2}
local tbl_upv_3 = {}
for _, value_1 in {"ButtonA", "ButtonB", "ButtonX", "ButtonY"} do
    tbl_upv_3[Enum.KeyCode[value_1]] = true
end
local u1 = 0
local u2 = false
local function note(a1)
    --[[
      name: note
      line: 41
      upvalues:
        u1 (ref, index: 1)
    ]]
    u1 = bit32.bor(u1, a1)
end
local function watch(a1)
    --[[
      name: watch
      line: 45
      upvalues:
        tbl_upv_2 (copy, index: 1)
        u1 (ref,  index: 2)
    ]]
    local function look_1(a2)
        --[[
          name: look
          line: 46
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
    for _, value_2 in a1:GetDescendants() do
        local v2 = tbl_upv_2[value_2.ClassName]
        local Parent_2 = value_2.Parent
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
      line: 60
      upvalues:
        u1 (ref, index: 1)
    ]]
    u1 = bit32.bor(u1, a1)
end
function tbl_1.Take()
    --[[
      name: Take
      line: 65
      upvalues:
        u1 (ref, index: 1)
    ]]
    local v4 = u1
    u1 = 0
    return v4
end
function tbl_1.Start()
    --[[
      name: Start
      line: 71
      upvalues:
        u2 (ref,  index: 1)
        Players_upv_1 (copy, index: 2)
        watch (copy, index: 3)
        UserInputService_upv_1 (copy, index: 4)
        tbl_upv_3 (copy, index: 5)
        u1 (ref,  index: 6)
    ]]
    if u2 then
        return
    end
    u2 = true
    local LocalPlayer_1 = Players_upv_1.LocalPlayer
    if LocalPlayer_1.Character then
        task.spawn(watch, LocalPlayer_1.Character)
    end
    LocalPlayer_1.CharacterAdded:Connect(watch)
    UserInputService_upv_1.InputBegan:Connect(
        function(a1)
            --[[
              line: 81
              upvalues:
                tbl_upv_3 (copy, index: 1)
                u1 (ref,  index: 2)
            ]]
            if a1.UserInputType ~= Enum.UserInputType.Keyboard or not tbl_upv_3[a1.KeyCode] then
                return
            end
            u1 = bit32.bor(u1, 128)
        end
    )
end
return tbl_1