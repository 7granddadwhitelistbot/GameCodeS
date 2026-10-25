local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_upv_1 = game:GetService("RunService")
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 26
      upvalues:
        Players_upv_1 (copy, index: 1)
        ReplicatedStorage_upv_1 (copy, index: 2)
        RunService_upv_1 (copy, index: 3)
    ]]
    local UI_upv_1 = a1.UI
    local Colors_upv_1 = a1.Theme.Colors
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local success_1, v1 = pcall(
        function()
            --[[
              line: 31
              upvalues:
                ReplicatedStorage_upv_1 (copy, index: 1)
            ]]
            return (require(ReplicatedStorage_upv_1:WaitForChild("Shared"):WaitForChild("Config")))
        end
    )
    local v2 = not (success_1) or type(v1) ~= "table" or v1.STAGING_PLACE_ID
    if RunService_upv_1:IsStudio() or v2 and game.PlaceId == v2 then
        local success_2, u1 = pcall(
            function()
                --[[
                  line: 38
                  upvalues:
                    ReplicatedStorage_upv_1 (copy, index: 1)
                ]]
                return (require(ReplicatedStorage_upv_1.Shared:WaitForChild("Camera"):WaitForChild("Smoothing")))
            end
        )
        if not (success_2) then
            u1 = nil
        end
        local success_3, _ = pcall(
            function()
                --[[
                  line: 44
                  upvalues:
                    ReplicatedStorage_upv_1 (copy, index: 1)
                ]]
                return (require(ReplicatedStorage_upv_1.Shared:WaitForChild("Simulation")))
            end
        )
        local u2 = (success_3) or nil
        local u3 = nil
        local u4 = nil
        local u5 = nil
        local u6 = false
        local tbl_upv_2 = {}
        local tbl_upv_3 = {}
        pcall(
            function()
                --[[
                  line: 58
                  upvalues:
                    RunService_upv_1 (copy, index: 1)
                    u6 (ref,  index: 2)
                    tbl_upv_2 (copy, index: 3)
                ]]
                RunService_upv_1.Rollback:Connect(
                    function()
                        --[[
                          line: 59
                          upvalues:
                            u6 (ref,  index: 1)
                            tbl_upv_2 (copy, index: 2)
                        ]]
                        if not u6 then
                            return
                        end
                        table.insert(tbl_upv_2, os.clock())
                    end
                )
            end
        )
        pcall(
            function()
                --[[
                  line: 65
                  upvalues:
                    RunService_upv_1 (copy, index: 1)
                    u6 (ref,  index: 2)
                    tbl_upv_3 (copy, index: 3)
                ]]
                RunService_upv_1.Misprediction:Connect(
                    function()
                        --[[
                          line: 66
                          upvalues:
                            u6 (ref,  index: 1)
                            tbl_upv_3 (copy, index: 2)
                        ]]
                        if not u6 then
                            return
                        end
                        table.insert(tbl_upv_3, os.clock())
                    end
                )
            end
        )
        local tbl_upv_4 = {}
        local u7 = nil
        local u8 = -1e+09
        local u9 = nil
        local u10 = nil
        local u11 = 0
        local tbl_upv_5 = {}
        local u12 = 0
        local function judge(a2)
            --[[
              name: judge
              line: 88
              upvalues:
                u10 (ref,  index: 1)
                u1 (ref,  index: 2)
                u9 (ref,  index: 3)
                u11 (ref,  index: 4)
                u12 (ref,  index: 5)
                tbl_upv_5 (copy, index: 6)
            ]]
            local v3 = 0
            local v4 = 0
            local v5 = 0
            if v6 then
                for _, value_1 in v6.CorrectionsSince(u9 - 0.1) do
                    if value_1[1] <= u9 + 0.7 then
                        local v7 = Vector3.new(value_1[2], 0, value_1[4])
                        v3 = v3 + v7:Dot(u10)
                        v4 = v4 + (v7 - (u10 * v7:Dot(u10))).Magnitude
                        v5 = v5 + 1
                    end
                end
            end
            u11 = u11 + 1
            local v8
            if v5 ~= 0 then
                local v9 = string.format("STOP %d: %s %.2f  side %.2f  (%d corr)", u11, ((v3 < 0) and "BACK") or "fwd", math.abs(v3), v4, v5)
                if v3 < 0 then
                    u12 = math.max(u12, -v3)
                end
                v8 = v9
            else
                v8 = string.format("STOP %d: clean (no correction)", u11)
            end
            table.insert(tbl_upv_5, 1, v8)
            if #tbl_upv_5 > 6 then
                table.remove(tbl_upv_5)
            end
            u9 = nil
            u10 = nil
        end
        local function perSecond(a3, a4)
            --[[
              name: perSecond
              line: 72
            ]]
            while a3[1] do
                if a4 - a3[1] > 1 then
                    table.remove(a3, 1)
                    continue
                else
                    break
                end
            end
            return #a3
        end
        local function frame(a5)
            --[[
              name: frame
              line: 118
              upvalues:
                tbl_upv_4 (copy, index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                u7 (ref,  index: 3)
                u8 (ref,  index: 4)
                u9 (ref,  index: 5)
                u10 (ref,  index: 6)
                judge (copy, index: 7)
                u1 (ref,  index: 8)
                u2 (ref,  index: 9)
                perSecond (copy, index: 10)
                tbl_upv_2 (copy, index: 11)
                tbl_upv_3 (copy, index: 12)
                u12 (ref,  index: 13)
                RunService_upv_1 (copy, index: 14)
                tbl_upv_5 (copy, index: 15)
                u4 (ref,  index: 16)
            ]]
            local v10 = os.clock()
            table.insert(tbl_upv_4, v10)
            while tbl_upv_4[1] do
                if v10 - tbl_upv_4[1] > 0.5 then
                    table.remove(tbl_upv_4, 1)
                    continue
                else
                    break
                end
            end
            local v11 = LocalPlayer_upv_1.Character
            local v12 = v11 and (v11:FindFirstChild("HumanoidRootPart"))
            local v13 = 0
            if v12 then
                local v14 = v12:IsA("BasePart")
                local v15 = nil
                if v14 then
                    local v16 = v12.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
                    v15 = v16.Magnitude
                    if v15 > 12 then
                        u7 = v16.Unit
                        u8 = v10
                    elseif v15 < 1 and u9 == nil and u7 and v10 - u8 < 0.35 then
                        u9 = v10
                        u10 = u7
                        u7 = nil
                    end
                    v11 = v15
                else
                    v11 = v13
                end
            else
                v11 = v13
            end
            if u9 and v10 - u9 > 0.7 then
                judge(v10)
            end
            local v17 = "?"
            if v6 then
                local v18 = v6.Stats()
                if (v6.BodyOn()) and (v18.proxyShown) then
                    v17 = "PROXY"
                else
                    v17 = ((v6.BodyOn()) and "PROXY (waiting)") or "REAL (60 Hz steps)"
                end
                local _ = v6.CameraOffset().Magnitude
            end
            v12 = v17
            local v19 = "SERVER (client predicts)"
            if u2 then
                v19 = ((u2.ClientAuthority) and "CLIENT (no prediction, no rollbacks)") or v19
            end
            local tbl_6 = {}
            local v20 = string.format("MOVEMENT DEBUG   fps %d", math.floor(#tbl_upv_4 / 0.5 + 0.5))
            local format_1 = string.format
            local v21
            if (u2) and (u2.StepSource) then
                v21 = u2.StepSource()
            else
                v21 = "?"
            end
            __setlist(tbl_6, 1, {v20, format_1("authority %s   steps %s", v19, v21), string.format("rollbacks/s %d   mispredictions/s %d", perSecond(tbl_upv_2, v10), perSecond(tbl_upv_3, v10)), string.format("speed %.1f   body %s   drawn-sim %.2f", v11, v12, 0), string.format("worst pull-back %.2f studs", u12)})
            if u2 and u2.ArrivalHolds then
                local v22, v23 = u2.ArrivalHolds()
                table.insert(tbl_6, string.format("held for missing ground: %d times, %.1f s", v22, v23))
            end
            if RunService_upv_1:IsStudio() and u2 and u2.WriteGuardStats then
                table.insert(tbl_6, string.format("root writes outside the simulation: %d", u2.WriteGuardStats().violations or 0))
            end
            for _, value_2 in tbl_upv_5 do
                table.insert(tbl_6, value_2)
            end
            if not u4 then
                return
            end
            u4.Text = table.concat(tbl_6, "\n")
        end
        local function build()
            --[[
              name: build
              line: 177
              upvalues:
                u3 (ref,  index: 1)
                UI_upv_1 (copy, index: 2)
                Colors_upv_1 (copy, index: 3)
                a1 (copy, index: 4)
                u4 (ref,  index: 5)
            ]]
            if u3 then
                return
            end
            local tbl_7 = {}
            tbl_7.Name = "MoveDebug"
            tbl_7.Position = UDim2.new(0, 12, 0.3, 0)
            tbl_7.Size = UDim2.fromOffset(360, 190)
            tbl_7.BackgroundColor3 = Colors_upv_1.Void
            tbl_7.BackgroundTransparency = 0.35
            tbl_7.Active = false
            tbl_7.ZIndex = 50
            tbl_7[1], tbl_7[2] = UI_upv_1.Corner(8), UI_upv_1.Padding(8, 10, 8, 10)
            tbl_7.Parent = a1.Canvas.Top
            local v24 = UI_upv_1.new("Frame", tbl_7)
            local v25 = UI_upv_1.new("TextLabel", {Text = "", Name = "Text", ZIndex = 51, TextSize = 14, Size = UDim2.fromScale(1, 1), FontFace = Font.fromEnum(Enum.Font.RobotoMono), TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = v24})
            u4 = v25
            u3 = v24
        end
        local function setShown(a6)
            --[[
              name: setShown
              line: 208
              upvalues:
                u6 (ref,  index: 1)
                build (copy, index: 2)
                u12 (ref,  index: 3)
                u11 (ref,  index: 4)
                tbl_upv_5 (copy, index: 5)
                tbl_upv_2 (copy, index: 6)
                tbl_upv_3 (copy, index: 7)
                u5 (ref,  index: 8)
                RunService_upv_1 (copy, index: 9)
                frame (copy, index: 10)
                u3 (ref,  index: 11)
            ]]
            u6 = a6
            if a6 then
                build()
                u12 = 0
                u11 = 0
                table.clear(tbl_upv_5)
                table.clear(tbl_upv_2)
                table.clear(tbl_upv_3)
                if not (u5) then
                    u5 = RunService_upv_1.RenderStepped:Connect(frame)
                end
            elseif u5 then
                u5:Disconnect()
                u5 = nil
            end
            if not u3 then
                return
            end
            u3.Visible = a6
        end
        a1.MoveDebugToggle = function()
            --[[
              line: 229
              upvalues:
                setShown (copy, index: 1)
                u6 (ref,  index: 2)
                a1 (copy, index: 3)
            ]]
            setShown(not u6)
            a1.Toast((u6 and "Movement debug on") or "Movement debug off", "info")
        end
        a1.BodySmoothingToggle = function()
            --[[
              line: 233
              upvalues:
                u1 (ref,  index: 1)
                a1 (copy, index: 2)
            ]]
            if not v6 then
                return
            end
            local v26 = not v6.BodyOn()
            v6.SetBody(v26)
            a1.Toast((v26 and "Body smoothing ON: a visual copy is drawn smoothly") or "Body smoothing OFF: your character at 60 Hz steps", "info")
        end
        a1.MoveDebugShown = function()
            --[[
              line: 242
              upvalues:
                u6 (ref, index: 1)
            ]]
            return u6
        end
        a1.BodySmoothingOn = function()
            --[[
              line: 245
              upvalues:
                u1 (ref, index: 1)
            ]]
            local v27 = (v6 ~= nil) and (v6.BodyOn() == true)
            return v27
        end
        a1.Debug.moveDebug = function(a7)
            --[[
              line: 248
              upvalues:
                a1 (copy, index: 1)
                u6 (ref,  index: 2)
                u1 (ref,  index: 3)
                tbl_upv_5 (copy, index: 4)
                u4 (ref,  index: 5)
            ]]
            if a7 == "toggle" then
                a1.MoveDebugToggle()
            elseif a7 == "body" then
                a1.BodySmoothingToggle()
            end
            local tbl_8 = {text = 0, stops = 0, body = 0}
            tbl_8.shown = u6
            tbl_8.body = v6 and v6.BodyOn()
            tbl_8.stops = tbl_upv_5
            tbl_8.text = (u4 and (u4.Text)) or ""
            return tbl_8
        end
    end
end
return tbl_1