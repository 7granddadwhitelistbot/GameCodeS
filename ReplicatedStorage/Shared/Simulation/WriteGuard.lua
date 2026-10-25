local RunService_upv_1 = game:GetService("RunService")
local tbl_1 = {}
local tbl_upv_2 = {atPreSimulation = 0, checks = 0, atRenderStart = 0, violations = 0, atRenderEnd = 0, rollbacks = 0, attributes = 0, cframe = 0, atPreAnimation = 0, velocity = 0}
local tbl_upv_3 = {}
local u1 = false
local function sameCF(a1, a2)
    --[[
      name: sameCF
      line: 42
    ]]
    if (a1.Position - a2.Position).Magnitude > 1e-04 then
        return false
    end
    return ((a1.XVector - a2.XVector).Magnitude <= 1e-04) and ((a1.YVector - a2.YVector).Magnitude <= 1e-04)
end
function tbl_1.Start(a1)
    --[[
      name: Start
      line: 49
      upvalues:
        u1 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        tbl_upv_3 (copy, index: 4)
    ]]
    if (u1) or not RunService_upv_1:IsStudio() then
        return
    end
    if RunService_upv_1:IsClient() then
        u1 = true
        local u2 = nil
        local u3 = nil
        local u4 = nil
        local u5 = nil
        local tbl_upv_4 = {}
        local function record()
            --[[
              name: record
              line: 60
              upvalues:
                a1 (copy, index: 1)
                u2 (ref,  index: 2)
                u3 (ref,  index: 3)
                u4 (ref,  index: 4)
                u5 (ref,  index: 5)
                tbl_upv_4 (copy, index: 6)
            ]]
            local Character_1 = a1.Character
            local v1 = Character_1 and (Character_1:FindFirstChild("HumanoidRootPart"))
            if (v1) and (v1:IsA("BasePart")) then
                local CFrame_1 = v1.CFrame
                local AssemblyLinearVelocity_1 = v1.AssemblyLinearVelocity
                local v2 = v1:GetAttributes()
                u2 = v1
                u3 = CFrame_1
                u4 = AssemblyLinearVelocity_1
                u5 = v2
            else
                u2 = nil
                u3 = nil
                u4 = nil
                u5 = nil
            end
            table.clear(tbl_upv_4)
        end
        local function flag(a2, a3, a4)
            --[[
              name: flag
              line: 71
              upvalues:
                tbl_upv_2 (copy, index: 1)
                tbl_upv_3 (copy, index: 2)
            ]]
            tbl_upv_2.violations = tbl_upv_2.violations + 1
            tbl_upv_2[a3] = tbl_upv_2[a3] + 1
            local v3 = "at" .. a2
            tbl_upv_2[v3] = tbl_upv_2[v3] + 1
            if not (#tbl_upv_3 < 30) then
                return
            end
            table.insert(tbl_upv_3, string.format("%.2f %s %s %s", os.clock(), a2, a3, a4))
            if not (#tbl_upv_3 <= 5) then
                return
            end
            warn((("[WriteGuard] the predicted root changed outside the simulation (%*, %*): %*"):format(a2, a3, a4)))
        end
        local function check(a5)
            --[[
              name: check
              line: 83
              upvalues:
                u2 (ref,  index: 1)
                u3 (ref,  index: 2)
                u4 (ref,  index: 3)
                u5 (ref,  index: 4)
                tbl_upv_4 (copy, index: 5)
                a1 (copy, index: 6)
                tbl_upv_2 (copy, index: 7)
                flag (copy, index: 8)
            ]]
            local v4 = u4
            local v5 = u5
            if not u2 or not u3 or not v4 or not v5 or tbl_upv_4[a5] then
                return
            end
            local Character_2 = a1.Character
            if not Character_2 or u2.Parent ~= Character_2 then
                return
            end
            tbl_upv_2.checks = tbl_upv_2.checks + 1
            local CFrame_2 = u2.CFrame
            local v6
            if (CFrame_2.Position - u3.Position).Magnitude > 1e-04 then
                v6 = false
            else
                v6 = ((CFrame_2.XVector - u3.XVector).Magnitude <= 1e-04) and ((CFrame_2.YVector - u3.YVector).Magnitude <= 1e-04)
            end
            if v6 then
                local AssemblyLinearVelocity_2 = u2.AssemblyLinearVelocity
                if (AssemblyLinearVelocity_2 - u4).Magnitude > 1e-04 then
                    tbl_upv_4[a5] = true
                    flag(a5, "velocity", string.format("dv %.4f", (AssemblyLinearVelocity_2 - u4).Magnitude))
                else
                    local v7 = u2:GetAttributes()
                    for key_1, value_1 in v7 do
                        if u5[key_1] == value_1 then
                            continue
                        end
                        tbl_upv_4[a5] = true
                        flag(a5, "attributes", string.format("@%s %s>%s", key_1, tostring(u5[key_1]), tostring(value_1)))
                        return
                    end
                    for key_2 in u5 do
                        if v7[key_2] ~= nil then
                            continue
                        end
                        tbl_upv_4[a5] = true
                        flag(a5, "attributes", string.format("@%s removed", key_2))
                        return
                    end
                end
            else
                tbl_upv_4[a5] = true
                flag(a5, "cframe", string.format("moved %.4f", (CFrame_2.Position - u3.Position).Magnitude))
            end
        end
        RunService_upv_1.PostSimulation:Connect(record)
        RunService_upv_1:BindToRenderStep(
            "TribesWriteGuardStart",
            Enum.RenderPriority.First.Value - 1,
            function()
                --[[
                  line: 123
                  upvalues:
                    check (copy, index: 1)
                ]]
                check("RenderStart")
            end
        )
        RunService_upv_1:BindToRenderStep(
            "TribesWriteGuardEnd",
            Enum.RenderPriority.Last.Value + 2,
            function()
                --[[
                  line: 126
                  upvalues:
                    check (copy, index: 1)
                ]]
                check("RenderEnd")
            end
        )
        RunService_upv_1.PreAnimation:Connect(
            function()
                --[[
                  line: 129
                  upvalues:
                    check (copy, index: 1)
                ]]
                check("PreAnimation")
            end
        )
        RunService_upv_1.PreSimulation:Connect(
            function()
                --[[
                  line: 132
                  upvalues:
                    check (copy, index: 1)
                ]]
                check("PreSimulation")
            end
        )
        pcall(
            function()
                --[[
                  line: 135
                  upvalues:
                    RunService_upv_1 (copy, index: 1)
                    tbl_upv_2 (copy, index: 2)
                ]]
                RunService_upv_1.Rollback:Connect(
                    function()
                        --[[
                          line: 136
                          upvalues:
                            tbl_upv_2 (copy, index: 1)
                        ]]
                        tbl_upv_2.rollbacks = tbl_upv_2.rollbacks + 1
                    end
                )
            end
        )
    end
end
function tbl_1.Stats()
    --[[
      name: Stats
      line: 142
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    local tbl_5 = {}
    for key_3, value_2 in tbl_upv_2 do
        tbl_5[key_3] = value_2
    end
    tbl_5.log = table.concat(tbl_upv_3, " | ")
    return tbl_5
end
function tbl_1.Reset()
    --[[
      name: Reset
      line: 151
      upvalues:
        tbl_upv_2 (copy, index: 1)
        tbl_upv_3 (copy, index: 2)
    ]]
    for key_4 in tbl_upv_2 do
        tbl_upv_2[key_4] = 0
    end
    table.clear(tbl_upv_3)
end
return tbl_1