local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local Signal = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Signal"))
local CustomMatch = require(replicatedStorage.Shared:WaitForChild("CustomMatch"))

return {
    Init = (function(a6)
        --[[
          name: Init
          line: 33
          upvalues:
            players (copy, index: 1)
            Signal (copy, index: 2)
            workspace (copy, index: 3)
            CustomMatch (copy, index: 4)
        ]]
        local remotes = a6.Remotes
        local localPlayer = players.LocalPlayer
        local v9 = false
        local v10 = nil
        local custom = {Changed = Signal.new(), RevealChanged = Signal.new(), MASK = "••• •••"}
        remotes.Timeouts.CustomAction = 25
        remotes.Timeouts.CustomHost = 15

        local function current()
            --[[
              name: current
              line: 46
              upvalues:
                v10 (ref, index: 1)
                v9 (ref, index: 2)
            ]]
            return v10 or v9
        end

        function custom.IsServer()
            --[[
              name: IsServer
              line: 50
              upvalues:
                v10 (ref,  index: 1)
                workspace (copy, index: 2)
            ]]
            return v10 ~= nil or workspace:GetAttribute("CustomServer") == true
        end

        function custom.State()
            --[[
              name: State
              line: 53
              upvalues:
                v10 (ref, index: 1)
                v9 (ref, index: 2)
            ]]
            return v10 or v9
        end

        function custom.Code()
            --[[
              name: Code
              line: 56
              upvalues:
                v10 (ref,  index: 1)
                v9 (ref,  index: 2)
                workspace (copy, index: 3)
            ]]
            if const v13 = v10 or v9 then
                if type(v13.code) == "string" then
                    return v13.code
                end
            end

            local customCode = workspace:GetAttribute("CustomCode")

            if type(customCode) ~= "string" then
                return ""
            end

            return customCode
        end

        function custom.IsHost()
            --[[
              name: IsHost
              line: 64
              upvalues:
                v10 (ref,  index: 1)
                v9 (ref,  index: 2)
                localPlayer (copy, index: 3)
                custom (copy, index: 4)
                workspace (copy, index: 5)
            ]]
            local v15 = v10 or v9

            if v15 and v15.custom and type(v15.ownerId) == "number" then
                return v15.ownerId == localPlayer.UserId
            end

            return custom.IsServer() and workspace:GetAttribute("CustomOwner") == localPlayer.UserId
        end

        function custom.IsPrivate()
            --[[
              name: IsPrivate
              line: 73
              upvalues:
                v10 (ref,  index: 1)
                v9 (ref,  index: 2)
                custom (copy, index: 3)
            ]]
            local v16 = v10 or v9
            return custom.IsServer() and type(v16) == "table" and v16.public == false
        end

        local count = 0
        local v18 = false

        function custom.IsRevealed()
            --[[
              name: IsRevealed
              line: 79
              upvalues:
                v18 (ref, index: 1)
            ]]
            return v18
        end

        function custom.Reveal(a19)
            --[[
              name: Reveal
              line: 82
              upvalues:
                count (ref,  index: 1)
                v18 (ref,  index: 2)
                custom (copy, index: 3)
            ]]
            count += 1
            local v20 = count

            if not v18 then
                v18 = true
                custom.RevealChanged:Fire(true)
            end

            task.delay(
                (a19 or 10),
                function()
                    --[[
                      line: 89
                      upvalues:
                        v20 (copy, index: 1)
                        count (ref,  index: 2)
                        v18 (ref,  index: 3)
                        custom (copy, index: 4)
                    ]]
                    if v20 == count and v18 then
                        v18 = false
                        custom.RevealChanged:Fire(false)
                    end
                end
            )
        end

        function custom.Hide()
            --[[
              name: Hide
              line: 96
              upvalues:
                count (ref,  index: 1)
                v18 (ref,  index: 2)
                custom (copy, index: 3)
            ]]
            count += 1

            if v18 then
                v18 = false
                custom.RevealChanged:Fire(false)
            end
        end

        function custom.CodeShown()
            --[[
              name: CodeShown
              line: 103
              upvalues:
                custom (copy, index: 1)
                v18 (ref,  index: 2)
                CustomMatch (copy, index: 3)
            ]]
            if custom.IsPrivate() and not v18 then
                return "••• •••"
            end

            return CustomMatch.FormatCode(custom.Code())
        end

        function custom.MaskDots(options)
            --[[
              name: MaskDots
              line: 110
              upvalues:
                a6 (copy, index: 1)
            ]]
            local ui = a6.UI
            local dot = options.Dot or 8
            local gap = options.Gap or 4
            local groupGap = options.GroupGap or 10
            local v26 = ui.new
            local v27 = {Name = options.Name or "Mask"}
            local v28 = options.AnchorPoint or Vector2.new(1, 0.5)
            v27.AnchorPoint = v28
            local v29 = options.Position or UDim2.new()
            v27.Position = v29
            v27.Size = UDim2.fromOffset((6 * dot + (4 * gap)) + groupGap, dot)
            v27.Parent = options.Parent
            v26 = v26("Frame", v27)

            for index = 1, 6 do
                local v31 = (index - 1) * (dot + gap)
                local v32 = not (3 < index) and 0 or groupGap - gap
                local v33 = v31 + v32
                local newUi = ui.new
                local v35 = {Name = "Dot" .. index, Position = UDim2.fromOffset(v33, 0), Size = UDim2.fromOffset(dot, dot), BackgroundColor3 = options.Color
                    or a6.Theme.Colors.TextDim, [1] = (ui.Corner(a6.Theme.Radius.Pill)), Parent = v26}
                newUi("Frame", v35)
            end

            return v26
        end

        local function apply(a37)
            --[[
              name: apply
              line: 136
              upvalues:
                v9 (ref,  index: 1)
                v10 (ref,  index: 2)
                custom (copy, index: 3)
            ]]
            if type(a37) ~= "table" then
                return
            end

            if a37.custom ~= false then
                v9 = a37
            else
                v9 = false
            end

            if not v10 then
                local changed = custom.Changed
                local v39 = v10 or v9
                changed:Fire(v39)
            end
        end

        remotes.On("CustomState", apply)

        function custom.Host(a40, a41)
            --[[
              name: Host
              line: 151
              upvalues:
                v10 (ref,  index: 1)
                remotes (copy, index: 2)
                v9 (ref,  index: 3)
                custom (copy, index: 4)
            ]]
            if v10 then
                return true, v10
            end

            local v42, v43, v44 = remotes.Invoke("CustomHost", a40, a41)
            if not v42 then
                return false, (tostring((v43 or "Server unavailable")))
            end

            if v43 ~= true then
                local v45 = false

                if type(v44) ~= "string" then
                    return v45, "Couldn't do that"
                end

                return v45, v44
            end

            if type(v44) == "table" and type(v44) == "table" then
                if v44.custom ~= false then
                    v9 = v44
                else
                    v9 = false
                end

                if not v10 then
                    local changed = custom.Changed
                    local v47 = v10 or v9
                    changed:Fire(v47)
                end
            end

            return true, v44
        end

        function custom.Action(a48, a49)
            --[[
              name: Action
              line: 168
              upvalues:
                remotes (copy, index: 1)
            ]]
            local v50, v51, v52 = remotes.Invoke("CustomAction", a48, a49)
            if not v50 then
                return false, (tostring((v51 or "Server unavailable")))
            end
            if v51 == true then
                return true, v52
            end

            local v53 = false

            if type(v52) ~= "string" then
                return v53, "Couldn't do that"
            end

            return v53, v52
        end

        local function fetch()
            --[[
              name: fetch
              line: 181
              upvalues:
                custom (copy, index: 1)
                v9 (ref,  index: 2)
                v10 (ref,  index: 3)
            ]]
            if custom.IsServer() and not v9 then
                task.spawn(
                    function()
                        --[[
                          line: 183
                          upvalues:
                            custom (copy, index: 1)
                            v9 (ref,  index: 2)
                            v10 (ref,  index: 3)
                        ]]
                        local v55, v56 = custom.Host("Get")

                        if v55 and type(v56) == "table" then
                            if type(v56) ~= "table" then
                                return
                            end

                            if v56.custom ~= false then
                                v9 = v56
                            else
                                v9 = false
                            end

                            if not v10 then
                                local changed = custom.Changed
                                local v58 = v10 or v9
                                changed:Fire(v58)
                            end
                        end
                    end
                )
            end
        end

        workspace:GetAttributeChangedSignal("CustomServer"):Connect(
            function()
                --[[
                  line: 191
                  upvalues:
                    workspace (copy, index: 1)
                    v9 (ref,  index: 2)
                    custom (copy, index: 3)
                    v10 (ref,  index: 4)
                ]]
                if workspace:GetAttribute("CustomServer") == true then
                    if custom.IsServer() and not v9 then
                        task.spawn(
                            function()
                                --[[
                                  line: 183
                                  upvalues:
                                    custom (copy, index: 1)
                                    v9 (ref,  index: 2)
                                    v10 (ref,  index: 3)
                                ]]
                                local v59, v60 = custom.Host("Get")

                                if v59 and type(v60) == "table" then
                                    if type(v60) ~= "table" then
                                        return
                                    end

                                    if v60.custom ~= false then
                                        v9 = v60
                                    else
                                        v9 = false
                                    end

                                    if not v10 then
                                        local changed = custom.Changed
                                        local v62 = v10 or v9
                                        changed:Fire(v62)
                                    end
                                end
                            end
                        )
                    end
                else
                    v9 = false
                    local changed = custom.Changed
                    local v64 = v10 or v9
                    changed:Fire(v64)
                end
            end
        )

        workspace:GetAttributeChangedSignal("CustomOwner"):Connect(
            function()
                --[[
                  line: 199
                  upvalues:
                    custom (copy, index: 1)
                    v10 (ref,  index: 2)
                    v9 (ref,  index: 3)
                ]]
                local changed = custom.Changed
                local v66 = v10 or v9
                changed:Fire(v66)
            end
        )

        task.delay(1, fetch)

        function custom.SetMock(mock)
            --[[
              name: SetMock
              line: 205
              upvalues:
                v10 (ref,  index: 1)
                custom (copy, index: 2)
                v9 (ref,  index: 3)
            ]]
            if type(mock) ~= "table" then
                v10 = nil
            else
                v10 = mock
            end

            local changed = custom.Changed
            local v69 = v10 or v9
            changed:Fire(v69)
        end

        a6.Custom = custom
    end)
}