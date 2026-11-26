local runService = game:GetService("RunService")
local v2 = {}
local v3 = {checks = 0, violations = 0, cframe = 0, velocity = 0, attributes = 0, atRenderStart = 0, atRenderEnd = 0, atPreAnimation = 0, atPreSimulation = 0, rollbacks = 0}
local parts = {}
local v5 = false

local function sameCF(a7, a8)
    --[[
      name: sameCF
      line: 42
    ]]
    if 1e-04 < (a7.Position - a8.Position).Magnitude then
        return false
    end

    return (a7.XVector - a8.XVector).Magnitude <= 1e-04
        and (a7.YVector - a8.YVector).Magnitude <= 1e-04
end

function v2.Start(a9)
    --[[
      name: Start
      line: 49
      upvalues:
        v5 (ref,  index: 1)
        runService (copy, index: 2)
        v3 (copy, index: 3)
        parts (copy, index: 4)
    ]]
    if v5 or not runService:IsStudio() or not runService:IsClient() then
        return
    end

    v5 = true
    local v10 = nil
    local cFrame = nil
    local assemblyLinearVelocity = nil
    local attributes = nil
    local v14 = {}

    local function record()
        --[[
          name: record
          line: 60
          upvalues:
            a9 (copy, index: 1)
            v10 (ref,  index: 2)
            cFrame (ref,  index: 3)
            assemblyLinearVelocity (ref,  index: 4)
            attributes (ref,  index: 5)
            v14 (copy, index: 6)
        ]]
        local v16 = a9.Character
        v16 = v16 and v16:FindFirstChild("HumanoidRootPart")

        if v16 and v16:IsA("BasePart") then
            local cFrame2 = v16.CFrame
            local assemblyLinearVelocity2 = v16.AssemblyLinearVelocity
            local attributes2 = v16:GetAttributes()
            v10 = v16
            cFrame = cFrame2
            assemblyLinearVelocity = assemblyLinearVelocity2
            attributes = attributes2
        else
            v10 = nil
            cFrame = nil
            assemblyLinearVelocity = nil
            attributes = nil
        end

        table.clear(v14)
    end

    local function flag(key: string, key2: string, formattedText: string)
        --[[
          name: flag
          line: 71
          upvalues:
            v3 (copy, index: 1)
            parts (copy, index: 2)
        ]]
        v3.violations += 1
        v3[key2] += 1
        local v24 = "at" .. key
        v3[v24] += 1

        if #parts < 30 then
            table.insert(parts, string.format("%.2f %s %s %s", os.clock(), key, key2, formattedText))

            if #parts <= 5 then
                warn((`[WriteGuard] the predicted root changed outside the simulation ({key}, {key2}): {formattedText}`))
            end
        end
    end

    local function check(key: string)
        --[[
          name: check
          line: 83
          upvalues:
            v10 (ref,  index: 1)
            cFrame (ref,  index: 2)
            assemblyLinearVelocity (ref,  index: 3)
            attributes (ref,  index: 4)
            v14 (copy, index: 5)
            a9 (copy, index: 6)
            v3 (copy, index: 7)
            flag (copy, index: 8)
        ]]
        local v27 = v10
        local cFrame2 = cFrame
        local assemblyLinearVelocity2 = assemblyLinearVelocity
        local attributes2 = attributes

        if not v27 or not cFrame2 or not assemblyLinearVelocity2 or not attributes2 or v14[key] then
            return
        end

        local character = a9.Character

        if not character or v27.Parent ~= character then
            return
        end

        v3.checks += 1
        local cFrame3 = v27.CFrame

        if 1e-04 < (cFrame3.Position - cFrame2.Position).Magnitude
            or not ((cFrame3.XVector - cFrame2.XVector).Magnitude <= 1e-04)
            or not ((cFrame3.YVector - cFrame2.YVector).Magnitude <= 1e-04)
        then
            v14[key] = true
            flag(key, "cframe", string.format("moved %.4f", (cFrame3.Position - cFrame2.Position).Magnitude))

            return
        end

        local assemblyLinearVelocity3 = v27.AssemblyLinearVelocity

        if 1e-04 < (assemblyLinearVelocity3 - assemblyLinearVelocity2).Magnitude then
            v14[key] = true
            flag(key, "velocity", string.format("dv %.4f", (assemblyLinearVelocity3 - assemblyLinearVelocity2).Magnitude))

            return
        end

        local attributes3 = v27:GetAttributes()

        for attributeKey, attribute in attributes3 do
            if attributes2[attributeKey] ~= attribute then
                v14[key] = true
                flag(key, "attributes", string.format("@%s %s>%s", attributeKey, tostring(attributes2[attributeKey]), (tostring(attribute))))

                return
            end
        end

        for attributeKey in attributes2 do
            if attributes3[attributeKey] == nil then
                v14[key] = true
                flag(key, "attributes", string.format("@%s removed", attributeKey))

                return
            end
        end
    end

    runService.PostSimulation:Connect(record)
    runService:BindToRenderStep(
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
    runService:BindToRenderStep(
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
    runService.PreAnimation:Connect(
        function()
            --[[
              line: 129
              upvalues:
                check (copy, index: 1)
            ]]
            check("PreAnimation")
        end
    )
    runService.PreSimulation:Connect(
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
                runService (copy, index: 1)
                v3 (copy, index: 2)
            ]]
            runService.Rollback:Connect(
                function()
                    --[[
                      line: 136
                      upvalues:
                        v3 (copy, index: 1)
                    ]]
                    v3.rollbacks += 1
                end
            )
        end
    )
end

function v2.Stats()
    --[[
      name: Stats
      line: 142
      upvalues:
        v3 (copy, index: 1)
        parts (copy, index: 2)
    ]]
    local v38 = {}

    for v39, v40 in v3 do
        v38[v39] = v40
    end

    v38.log = table.concat(parts, " | ")

    return v38
end

function v2.Reset()
    --[[
      name: Reset
      line: 151
      upvalues:
        v3 (copy, index: 1)
        parts (copy, index: 2)
    ]]
    for v41 in v3 do
        v3[v41] = 0
    end

    table.clear(parts)
end

return v2