local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")

return {
    Init = (function(a4)
        --[[
          name: Init
          line: 26
          upvalues:
            players (copy, index: 1)
            replicatedStorage (copy, index: 2)
            runService (copy, index: 3)
        ]]
        local stagingPlaceId
        local ui = a4.UI
        local theme = a4.Theme
        local colors = theme.Colors
        local localPlayer = players.LocalPlayer
        local success, Config = pcall(
            function()
                --[[
                  line: 31
                  upvalues:
                    replicatedStorage (copy, index: 1)
                ]]
                return (require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Config")))
            end
        )

        if success then
            if type(Config) ~= "table" then
                stagingPlaceId = nil
            else
                stagingPlaceId = Config.STAGING_PLACE_ID
            end
        else
            stagingPlaceId = nil
        end

        repeat
            local frame
            local Simulation

            if not runService:IsStudio() then
                if not stagingPlaceId then
                    break
                end
                if game.PlaceId ~= stagingPlaceId then
                    break
                end
            end

            local success2, Smoothing = pcall(
                function()
                    --[[
                      line: 38
                      upvalues:
                        replicatedStorage (copy, index: 1)
                    ]]
                    return (require(replicatedStorage.Shared:WaitForChild("Camera"):WaitForChild("Smoothing")))
                end
            )
            if not success2 then
                Smoothing = nil
            end

            local success3, Simulation2 = pcall(
                function()
                    --[[
                      line: 44
                      upvalues:
                        replicatedStorage (copy, index: 1)
                    ]]
                    return (require(replicatedStorage.Shared:WaitForChild("Simulation")))
                end
            )

            if success3 then
                Simulation = Simulation2
            else
                Simulation = nil
            end

            local ui2 = nil
            local ui3 = nil
            local renderSteppedConnection = nil
            local shown2 = false
            local v22 = {}
            local v23 = {}
            pcall(
                function()
                    --[[
                      line: 58
                      upvalues:
                        runService (copy, index: 1)
                        shown2 (ref,  index: 2)
                        v22 (copy, index: 3)
                    ]]
                    runService.Rollback:Connect(
                        function()
                            --[[
                              line: 59
                              upvalues:
                                shown2 (ref,  index: 1)
                                v22 (copy, index: 2)
                            ]]
                            if shown2 then
                                table.insert(v22, os.clock())
                            end
                        end
                    )
                end
            )
            pcall(
                function()
                    --[[
                      line: 65
                      upvalues:
                        runService (copy, index: 1)
                        shown2 (ref,  index: 2)
                        v23 (copy, index: 3)
                    ]]
                    runService.Misprediction:Connect(
                        function()
                            --[[
                              line: 66
                              upvalues:
                                shown2 (ref,  index: 1)
                                v23 (copy, index: 2)
                            ]]
                            if shown2 then
                                table.insert(v23, os.clock())
                            end
                        end
                    )
                end
            )

            local function perSecond(a25, timestamp: number)
                --[[
                  name: perSecond
                  line: 72
                ]]
                while a25[1] and 1 < timestamp - a25[1] do
                    table.remove(a25, 1)
                end

                return #a25
            end

            local v27 = {}
            local unit = nil
            local timestamp = -1e+09
            local timestamp2 = nil
            local unit2 = nil
            local v32 = 0
            local stops = {}
            local v34 = 0

            local function judge(timestamp: number)
                --[[
                  name: judge
                  line: 88
                  upvalues:
                    unit2 (ref,  index: 1)
                    Smoothing (ref,  index: 2)
                    timestamp2 (ref,  index: 3)
                    v32 (ref,  index: 4)
                    v34 (ref,  index: 5)
                    stops (copy, index: 6)
                ]]
                local formattedText
                local unit = unit2
                local total = 0
                local total2 = 0
                local count = 0

                if Smoothing then
                    for _, v43 in Smoothing.CorrectionsSince(timestamp2 - 0.1) do
                        if v43[1] <= timestamp2 + 0.7 then
                            local vector3 = Vector3.new(v43[2], 0, v43[4])
                            total += vector3:Dot(unit)
                            total2 += (vector3 - (unit * vector3:Dot(unit))).Magnitude
                            count += 1
                        end
                    end
                end

                v32 += 1

                if count ~= 0 then
                    local stringFormat = string.format
                    local v46 = v32
                    local v47 = not (total < 0) and "fwd" or "BACK"
                    formattedText = stringFormat("STOP %d: %s %.2f  side %.2f  (%d corr)", v46, v47, math.abs(total), total2, count)

                    if total < 0 then
                        v34 = math.max(v34, -total)
                    end
                else
                    formattedText = string.format("STOP %d: clean (no correction)", v32)
                end

                table.insert(stops, 1, formattedText)

                if 6 < #stops then
                    table.remove(stops)
                end

                timestamp2 = nil
                unit2 = nil
            end

            frame = function(deltaTime)
                --[[
                  name: frame
                  line: 118
                  upvalues:
                    v27 (copy, index: 1)
                    localPlayer (copy, index: 2)
                    unit (ref,  index: 3)
                    timestamp (ref,  index: 4)
                    timestamp2 (ref,  index: 5)
                    unit2 (ref,  index: 6)
                    judge (copy, index: 7)
                    Smoothing (ref,  index: 8)
                    Simulation (ref,  index: 9)
                    perSecond (copy, index: 10)
                    v22 (copy, index: 11)
                    v23 (copy, index: 12)
                    v34 (ref,  index: 13)
                    runService (copy, index: 14)
                    stops (copy, index: 15)
                    ui3 (ref,  index: 16)
                ]]
                local v49
                local timestamp3 = os.clock()
                table.insert(v27, timestamp3)

                while v27[1] and 0.5 < timestamp3 - v27[1] do
                    table.remove(v27, 1)
                end

                local v51 = #v27 / 0.5
                local instance = localPlayer.Character
                instance = instance and instance:FindFirstChild("HumanoidRootPart")
                local magnitude = 0

                if instance and instance:IsA("BasePart") then
                    local v54 = instance.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
                    magnitude = v54.Magnitude

                    if not (12 < magnitude) then
                        if magnitude < 1 and timestamp2 == nil and unit and timestamp3 - timestamp < 0.35 then
                            timestamp2 = timestamp3
                            unit2 = unit
                            unit = nil
                        end
                    else
                        unit = v54.Unit
                        timestamp = timestamp3
                    end
                end

                if timestamp2 and 0.7 < timestamp3 - timestamp2 then
                    judge(timestamp3)
                end

                local v55 = "?"
                local magnitude2 = 0

                if Smoothing then
                    local v57 = Smoothing.Stats()
                    v55 = Smoothing.BodyOn() and v57.proxyShown and "PROXY"
                        or Smoothing.BodyOn() and "PROXY (waiting)"
                        or "REAL (60 Hz steps)"
                    magnitude2 = Smoothing.CameraOffset().Magnitude
                end

                local v58 = "SERVER (client predicts)"

                if Simulation and Simulation.ClientAuthority then
                    v58 = "CLIENT (no prediction, no rollbacks)"
                end

                local parts = {}
                local formattedText = string.format("MOVEMENT DEBUG   fps %d", (math.floor(v51 + 0.5)))
                local stringFormat = string.format

                if Simulation and Simulation.StepSource then
                    v49 = Simulation.StepSource()
                else
                    v49 = "?"
                end

                do
                    local parts2, tableMove, values = parts, table.move, table.pack(formattedText, stringFormat("authority %s   steps %s", v58, v49), string.format("rollbacks/s %d   mispredictions/s %d", perSecond(v22, timestamp3), (perSecond(v23, timestamp3))), string.format("speed %.1f   body %s   drawn-sim %.2f", magnitude, v55, magnitude2), string.format("worst pull-back %.2f studs", v34))
                    tableMove(values, 1, values.n, 1, parts2)
                end

                if Simulation and Simulation.ArrivalHolds then
                    local v65, v66 = Simulation.ArrivalHolds()
                    table.insert(parts, string.format("held for missing ground: %d times, %.1f s", v65, v66))
                end

                if runService:IsStudio() and Simulation and Simulation.WriteGuardStats then
                    local v67 = Simulation.WriteGuardStats()
                    table.insert(parts, string.format("root writes outside the simulation: %d", v67.violations or 0))
                end

                for _, v69 in stops do
                    table.insert(parts, v69)
                end

                if ui3 then
                    ui3.Text = table.concat(parts, "\n")
                end
            end

            local function build()
                --[[
                  name: build
                  line: 177
                  upvalues:
                    ui2 (ref,  index: 1)
                    ui (copy, index: 2)
                    colors (copy, index: 3)
                    a4 (copy, index: 4)
                    ui3 (ref,  index: 5)
                ]]
                if ui2 then
                    return
                end

                local parent = ui.new("Frame", {Name = "MoveDebug", Position = UDim2.new(0, 12, 0.3, 0), Size = UDim2.fromOffset(360, 190), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.35, Active = false, ZIndex = 50, ui.Corner(8), (ui.Padding(8, 10, 8, 10)), Parent = a4.Canvas.Top})
                ui3 = ui.new("TextLabel", {Name = "Text", Text = "", TextSize = 14, ZIndex = 51, Size = UDim2.fromScale(1, 1), FontFace = Font.fromEnum(Enum.Font.RobotoMono), TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = parent})
                ui2 = parent
            end

            local function setShown(shown: boolean)
                --[[
                  name: setShown
                  line: 208
                  upvalues:
                    shown2 (ref,  index: 1)
                    build (copy, index: 2)
                    v34 (ref,  index: 3)
                    v32 (ref,  index: 4)
                    stops (copy, index: 5)
                    v22 (copy, index: 6)
                    v23 (copy, index: 7)
                    renderSteppedConnection (ref,  index: 8)
                    runService (copy, index: 9)
                    frame (copy, index: 10)
                    ui2 (ref,  index: 11)
                ]]
                shown2 = shown

                if shown then
                    build()
                    v34 = 0
                    v32 = 0
                    table.clear(stops)
                    table.clear(v22)
                    table.clear(v23)
                    renderSteppedConnection = renderSteppedConnection or runService.RenderStepped:Connect(frame)
                elseif renderSteppedConnection then
                    renderSteppedConnection:Disconnect()
                    renderSteppedConnection = nil
                end

                if ui2 then
                    ui2.Visible = shown
                end
            end

            a4.MoveDebugToggle = function()
                --[[
                  line: 229
                  upvalues:
                    setShown (copy, index: 1)
                    shown2 (ref,  index: 2)
                    a4 (copy, index: 3)
                ]]
                setShown(not shown2)
                local toast = a4.Toast
                local v75 = shown2 and "Movement debug on" or "Movement debug off"
                toast(v75, "info")
            end

            a4.BodySmoothingToggle = function()
                --[[
                  line: 233
                  upvalues:
                    Smoothing (ref,  index: 1)
                    a4 (copy, index: 2)
                ]]
                local v76

                if not Smoothing then
                    return
                end

                local v77 = not Smoothing.BodyOn()
                Smoothing.SetBody(v77)
                local toast = a4.Toast

                if v77 then
                    v76 = "Body smoothing ON: a visual copy is drawn smoothly"
                else
                    v76 = "Body smoothing OFF: your character at 60 Hz steps"
                end

                toast(v76, "info")
            end

            a4.MoveDebugShown = function()
                --[[
                  line: 242
                  upvalues:
                    shown2 (ref, index: 1)
                ]]
                return shown2
            end

            a4.BodySmoothingOn = function()
                --[[
                  line: 245
                  upvalues:
                    Smoothing (ref, index: 1)
                ]]
                return Smoothing ~= nil and Smoothing.BodyOn() == true
            end

            a4.Debug.moveDebug = function(a79)
                --[[
                  line: 248
                  upvalues:
                    a4 (copy, index: 1)
                    shown2 (ref,  index: 2)
                    Smoothing (ref,  index: 3)
                    stops (copy, index: 4)
                    ui3 (ref,  index: 5)
                ]]
                if a79 == "toggle" then
                    a4.MoveDebugToggle()
                elseif a79 == "body" then
                    a4.BodySmoothingToggle()
                end

                local v80 = {shown = shown2}
                local body = Smoothing and Smoothing.BodyOn()
                v80.body = body
                v80.stops = stops
                v80.text = ui3 and ui3.Text or ""

                return v80
            end

            return
        until true
    end)
}