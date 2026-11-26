local players = game:GetService("Players")
local textChatService = game:GetService("TextChatService")

return {
    Init = (function(a3)
        --[[
          name: Init
          line: 24
          upvalues:
            players (copy, index: 1)
            textChatService (copy, index: 2)
        ]]
        local ui = a3.UI
        local theme = a3.Theme
        local state = a3.State
        local colors = theme.Colors
        local fonts = theme.Fonts
        local localPlayer = players.LocalPlayer
        local textColor3 = theme.Lighten(colors.Ally, 0.25)
        local v11 = textColor3:ToHex()
        local mode = "all"

        local function enabled()
            --[[
              name: enabled
              line: 34
              upvalues:
                textChatService (copy, index: 1)
            ]]
            local success, chatVersion = pcall(
                function()
                    --[[
                      line: 35
                      upvalues:
                        textChatService (copy, index: 1)
                    ]]
                    return textChatService.ChatVersion
                end
            )

            if success and chatVersion == Enum.ChatVersion.TextChatService then
                return true
            end

            local textChannels = textChatService:FindFirstChild("TextChannels")

            return textChannels ~= nil and textChannels:FindFirstChild("RBXGeneral") ~= nil
        end

        local function folder()
            --[[
              name: folder
              line: 44
              upvalues:
                textChatService (copy, index: 1)
            ]]
            return textChatService:FindFirstChild("TribesTeamChat")
        end

        local function teamChannel()
            --[[
              name: teamChannel
              line: 47
              upvalues:
                localPlayer (copy, index: 1)
                textChatService (copy, index: 2)
            ]]
            local v19 = localPlayer:GetAttribute("TeamChannel")
            local tribesTeamChat = textChatService:FindFirstChild("TribesTeamChat")
            local child = tribesTeamChat and type(v19) == "string" and tribesTeamChat:FindFirstChild(v19)

            if child and child:IsA("TextChannel") then
                return child
            end

            return nil
        end

        local function general()
            --[[
              name: general
              line: 53
              upvalues:
                textChatService (copy, index: 1)
            ]]
            local textChannels = textChatService:FindFirstChild("TextChannels")
            local rbxGeneral = textChannels and textChannels:FindFirstChild("RBXGeneral")

            if rbxGeneral and rbxGeneral:IsA("TextChannel") then
                return rbxGeneral
            end

            return nil
        end

        local function inputBar()
            --[[
              name: inputBar
              line: 58
              upvalues:
                textChatService (copy, index: 1)
            ]]
            return textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
        end

        local v26 = {}

        local function hook(a28)
            --[[
              name: hook
              line: 64
              upvalues:
                v26 (copy, index: 1)
                v11 (copy, index: 2)
                textChatService (copy, index: 3)
            ]]
            if v26[a28] then
                return
            end

            v26[a28] = true

            a28.OnIncomingMessage = function(a29)
                --[[
                  line: 69
                  upvalues:
                    v11 (copy, index: 1)
                ]]
                local textChatMessageProperties = Instance.new("TextChatMessageProperties")
                textChatMessageProperties.PrefixText = string.format("<font color=\"#%s\">[TEAM] %s</font>", v11, a29.PrefixText)
                return textChatMessageProperties
            end

            a28.AncestryChanged:Connect(
                function()
                    --[[
                      line: 74
                      upvalues:
                        a28 (copy, index: 1)
                        textChatService (copy, index: 2)
                        v26 (copy, index: 3)
                    ]]
                    if not a28:IsDescendantOf(textChatService) then
                        v26[a28] = nil
                    end
                end
            )
        end

        local function apply()
            --[[
              name: apply
              line: 82
              upvalues:
                enabled (copy, index: 1)
                textChatService (copy, index: 2)
                localPlayer (copy, index: 3)
                hook (copy, index: 4)
                state (copy, index: 5)
                mode (ref,  index: 6)
            ]]
            local v32

            if not enabled() then
                return
            end

            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
            if not chatInputBarConfiguration then
                return
            end

            local v34 = localPlayer:GetAttribute("TeamChannel")
            local tribesTeamChat = textChatService:FindFirstChild("TribesTeamChat")
            local child = tribesTeamChat and type(v34) == "string" and tribesTeamChat:FindFirstChild(v34)
            local v37 = if child and child:IsA("TextChannel") then child else nil
            if v37 then
                hook(v37)
            end

            local targetTextChannel = chatInputBarConfiguration.TargetTextChannel
            local tribesTeamChat2 = textChatService:FindFirstChild("TribesTeamChat")
            local isDescendantOf = true

            if targetTextChannel ~= nil then
                isDescendantOf = true
                local textChannels = textChatService:FindFirstChild("TextChannels")
                local rbxGeneral = textChannels and textChannels:FindFirstChild("RBXGeneral")
                local instance = if rbxGeneral and rbxGeneral:IsA("TextChannel") then rbxGeneral else nil

                if targetTextChannel ~= instance then
                    isDescendantOf = tribesTeamChat2 ~= nil and targetTextChannel:IsDescendantOf(tribesTeamChat2)
                end
            end

            if not isDescendantOf then
                return
            end

            if state.InMatch() and v37 and mode == "team" then
                v32 = v37
            else
                local instance = textChatService:FindFirstChild("TextChannels")
                instance = instance and instance:FindFirstChild("RBXGeneral")
                v32 = if instance and instance:IsA("TextChannel") then instance else nil
            end

            if v32 and chatInputBarConfiguration.TargetTextChannel ~= v32 then
                chatInputBarConfiguration.TargetTextChannel = v32
            end
        end

        local parent = ui.new("Frame", {Name = "TeamChat", Size = UDim2.fromScale(1, 1), Parent = a3.Canvas.HUD})
        local parent2 = ui.new("TextButton", {Name = "Pill", Text = "", AutoButtonColor = false, AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(122, 30), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.15, Visible = false, (ui.Corner(theme.Radius.Pill)), Parent = parent})
        local v47 = ui.Stroke(textColor3, 1.5, 0.35)
        v47.Parent = parent2
        local v48 = ui.Glyph("three-people", 16, textColor3, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Parent = parent2})
        local ui2 = ui.new("TextLabel", {Name = "Text", Text = "TEAM CHAT", TextSize = 13, FontFace = fonts.Heavy, TextColor3 = textColor3, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(32, 0), Size = UDim2.new(1, -38, 1, 0), Parent = parent2})

        local function paintPill()
            --[[
              name: paintPill
              line: 135
              upvalues:
                mode (ref,  index: 1)
                textColor3 (copy, index: 2)
                colors (copy, index: 3)
                ui2 (copy, index: 4)
                v48 (copy, index: 5)
                v47 (copy, index: 6)
            ]]
            local v51 = mode == "team"
            local v52 = if v51 then textColor3 else colors.TextDim
            ui2.Text = v51 and "TEAM CHAT" or "ALL CHAT"
            ui2.TextColor3 = v52
            v48.Text = v51 and "three-people" or "globe-simplified"
            v48.TextColor3 = v52
            v47.Color = v52
        end

        local v53 = 0

        local function typing()
            --[[
              name: typing
              line: 147
              upvalues:
                textChatService (copy, index: 1)
            ]]
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
            local success, isFocused = pcall(
                function()
                    --[[
                      line: 149
                      upvalues:
                        chatInputBarConfiguration (copy, index: 1)
                    ]]
                    return chatInputBarConfiguration.IsFocused
                end
            )

            return success and (isFocused == true)
        end

        local function placePill()
            --[[
              name: placePill
              line: 154
              upvalues:
                enabled (copy, index: 1)
                state (copy, index: 2)
                localPlayer (copy, index: 3)
                textChatService (copy, index: 4)
                a3 (copy, index: 5)
                v53 (ref,  index: 6)
                ui (copy, index: 7)
                parent (copy, index: 8)
                parent2 (copy, index: 9)
            ]]
            local v59 = enabled()
            if v59 then
                v59 = state.InMatch()

                if v59 then
                    v59 = false
                    local v60 = localPlayer:GetAttribute("TeamChannel")
                    local tribesTeamChat = textChatService:FindFirstChild("TribesTeamChat")
                    local child = tribesTeamChat and type(v60) == "string" and tribesTeamChat:FindFirstChild(v60)
                    local v63 = if child and child:IsA("TextChannel") then child else nil
                    if v63 ~= nil then
                        v59 = not a3.HudHidden

                        if v59 then
                            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
                            local success, isFocused = pcall(
                                function()
                                    --[[
                                      line: 149
                                      upvalues:
                                        chatInputBarConfiguration (copy, index: 1)
                                    ]]
                                    return chatInputBarConfiguration.IsFocused
                                end
                            )
                            v59 = success
                            v59 = v59 and isFocused == true
                            v59 = v59 or os.clock() < v53
                        end
                    end
                end
            end

            local v67 = if v59 then ui.ChatRectIn(parent) else nil
            local v68 = if v59 then ui.ChatRect() else nil

            if not v67 or not v68 then
                parent2.Visible = false
                return
            end

            local v69 = v67.Max.Y - 20
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
            local v71 = v68.Max.Y - v68.Min.Y

            if chatInputBarConfiguration and 1 < v71 then
                local v72 = chatInputBarConfiguration.AbsolutePosition.Y + chatInputBarConfiguration.AbsoluteSize.Y / 2
                v69 = v67.Min.Y + ((v72 - v68.Min.Y) * (v67.Max.Y - v67.Min.Y)) / v71
            end

            parent2.Position = UDim2.fromOffset(v67.Max.X + 8, v69)
            parent2.Visible = true
        end

        local function setMode(a74, a75)
            --[[
              name: setMode
              line: 176
              upvalues:
                mode (ref,  index: 1)
                apply (copy, index: 2)
                textColor3 (copy, index: 3)
                colors (copy, index: 4)
                ui2 (copy, index: 5)
                v48 (copy, index: 6)
                v47 (copy, index: 7)
                a3 (copy, index: 8)
            ]]
            mode = a74
            apply()
            local v76 = mode == "team"
            local v77 = if v76 then textColor3 else colors.TextDim
            ui2.Text = v76 and "TEAM CHAT" or "ALL CHAT"
            ui2.TextColor3 = v77
            v48.Text = v76 and "three-people" or "globe-simplified"
            v48.TextColor3 = v77
            v47.Color = v77

            if a75 then
                local toast = a3.Toast
                local v79 = a74 ~= "team" and "Chat: everyone" or "Chat: your team"
                toast(v79, "info")
            end
        end

        parent2.Activated:Connect(
            function()
                --[[
                  line: 184
                  upvalues:
                    a3 (copy, index: 1)
                    mode (ref,  index: 2)
                    apply (copy, index: 3)
                    textColor3 (copy, index: 4)
                    colors (copy, index: 5)
                    ui2 (copy, index: 6)
                    v48 (copy, index: 7)
                    v47 (copy, index: 8)
                ]]
                local text
                a3.Sounds.Play("Click")
                local v81 = mode ~= "team" and "team" or "all"
                mode = v81
                apply()
                local v82 = mode == "team"
                local v83 = if v82 then textColor3 else colors.TextDim
                ui2.Text = v82 and "TEAM CHAT" or "ALL CHAT"
                ui2.TextColor3 = v83

                if v82 then
                    text = "three-people"
                    text = a3
                else
                    text = "globe-simplified"
                    text = a3
                end

                v48.Text = text
                v48.TextColor3 = v83
                v47.Color = v83
                local toast = text.Toast
                local v85 = v81 ~= "team" and "Chat: everyone" or "Chat: your team"
                toast(v85, "info")
            end
        )

        local function onCommand(a87, text: string)
            --[[
              name: onCommand
              line: 191
              upvalues:
                localPlayer (copy, index: 1)
                textChatService (copy, index: 2)
                state (copy, index: 3)
                a3 (copy, index: 4)
                mode (ref,  index: 5)
                apply (copy, index: 6)
                textColor3 (copy, index: 7)
                colors (copy, index: 8)
                ui2 (copy, index: 9)
                v48 (copy, index: 10)
                v47 (copy, index: 11)
            ]]
            local v89 = localPlayer:GetAttribute("TeamChannel")
            local tribesTeamChat = textChatService:FindFirstChild("TribesTeamChat")
            local child = tribesTeamChat and type(v89) == "string" and tribesTeamChat:FindFirstChild(v89)
            local v92 = if child and child:IsA("TextChannel") then child else nil

            if state.InMatch() and v92 then
                local v93 = string.match(text, "^%S+%s+(.-)%s*$")

                if v93 and v93 ~= "" then
                    local v94

                    if a87 ~= "team" then
                        local textChannels = textChatService:FindFirstChild("TextChannels")
                        local rbxGeneral = textChannels and textChannels:FindFirstChild("RBXGeneral")
                        v94 = if rbxGeneral and rbxGeneral:IsA("TextChannel") then rbxGeneral else nil
                    else
                        v94 = v92
                    end

                    if v94 then
                        task.spawn(
                            function()
                                --[[
                                  line: 201
                                  upvalues:
                                    tribesTeamChat (copy, index: 1)
                                    v93 (copy, index: 2)
                                ]]
                                pcall(
                                    function()
                                        --[[
                                          line: 202
                                          upvalues:
                                            tribesTeamChat (copy, index: 1)
                                            v93 (copy, index: 2)
                                        ]]
                                        tribesTeamChat:SendAsync(v93)
                                    end
                                )
                            end
                        )
                    end

                    return "sent to " .. a87
                end

                mode = a87
                apply()
                local v97 = mode == "team"
                local v98 = if v97 then textColor3 else colors.TextDim
                ui2.Text = v97 and "TEAM CHAT" or "ALL CHAT"
                ui2.TextColor3 = v98
                v48.Text = v97 and "three-people" or "globe-simplified"
                v48.TextColor3 = v98
                v47.Color = v98
                local toast = a3.Toast
                local v100 = a87 ~= "team" and "Chat: everyone" or "Chat: your team"
                toast(v100, "info")

                return "switched to " .. a87
            end

            local toast = a3.Toast
            local v102 = a87 ~= "team" and "You're talking to everyone" or "Team chat works in matches"
            toast(v102, "info")

            return "not in a match"
        end

        local function command(name: string, primaryAlias: string, secondaryAlias: string, a107: string)
            --[[
              name: command
              line: 212
              upvalues:
                textChatService (copy, index: 1)
                onCommand (copy, index: 2)
            ]]
            if textChatService:FindFirstChild(name) then
                return
            end

            local textChatCommand = Instance.new("TextChatCommand")
            textChatCommand.Name = name
            textChatCommand.PrimaryAlias = primaryAlias
            textChatCommand.SecondaryAlias = secondaryAlias
            textChatCommand.Triggered:Connect(
                function(originTextSource: TextSource, unfilteredText: string)
                    --[[
                      line: 220
                      upvalues:
                        onCommand (copy, index: 1)
                        a107 (copy, index: 2)
                    ]]
                    onCommand(a107, unfilteredText)
                end
            )
            textChatCommand.Parent = textChatService
        end

        local v111 = false

        local function start()
            --[[
              name: start
              line: 227
              upvalues:
                v111 (ref,  index: 1)
                enabled (copy, index: 2)
                command (copy, index: 3)
            ]]
            if v111 or not enabled() then
                return
            end

            v111 = true
            command("TribesTeamChat_Team", "/t", "/team", "team")
            command("TribesTeamChat_All", "/a", "/all", "all")
        end

        local chatInputBarConfiguration = nil

        local function watchBar()
            --[[
              name: watchBar
              line: 237
              upvalues:
                textChatService (copy, index: 1)
                chatInputBarConfiguration (ref,  index: 2)
                v53 (ref,  index: 3)
                placePill (copy, index: 4)
            ]]
            local chatInputBarConfiguration2 = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if not chatInputBarConfiguration2 or chatInputBarConfiguration2 == chatInputBarConfiguration then
                return
            end

            chatInputBarConfiguration = chatInputBarConfiguration2
            pcall(
                function()
                    --[[
                      line: 243
                      upvalues:
                        chatInputBarConfiguration2 (copy, index: 1)
                        textChatService (copy, index: 2)
                        v53 (ref,  index: 3)
                        placePill (copy, index: 4)
                    ]]
                    chatInputBarConfiguration2:GetPropertyChangedSignal("IsFocused"):Connect(
                        function()
                            --[[
                              line: 244
                              upvalues:
                                textChatService (copy, index: 1)
                                v53 (ref,  index: 2)
                                placePill (copy, index: 3)
                            ]]
                            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
                            local v117, isFocused = pcall(
                                function()
                                    --[[
                                      line: 149
                                      upvalues:
                                        chatInputBarConfiguration (copy, index: 1)
                                    ]]
                                    return chatInputBarConfiguration.IsFocused
                                end
                            )
                            v117 = v117 and isFocused == true

                            if not v117 then
                                v53 = os.clock() + 2.5
                                task.delay(2.55, placePill)
                            end

                            placePill()
                        end
                    )
                end
            )
        end

        local enabled2 = nil

        local function bubbles()
            --[[
              name: bubbles
              line: 256
              upvalues:
                textChatService (copy, index: 1)
                enabled2 (ref,  index: 2)
                state (copy, index: 3)
            ]]
            local bubbleChatConfiguration = textChatService:FindFirstChildOfClass("BubbleChatConfiguration")
            if not bubbleChatConfiguration then
                return
            end

            if enabled2 == nil then
                enabled2 = bubbleChatConfiguration.Enabled
            end

            local enabled = enabled2 == true and not state.SeesMatch()

            if bubbleChatConfiguration.Enabled ~= enabled then
                bubbleChatConfiguration.Enabled = enabled
            end
        end

        task.spawn(
            function()
                --[[
                  line: 269
                  upvalues:
                    textChatService (copy, index: 1)
                    enabled2 (ref,  index: 2)
                    state (copy, index: 3)
                ]]
                if textChatService:WaitForChild("BubbleChatConfiguration", 30) then
                    local bubbleChatConfiguration = textChatService:FindFirstChildOfClass("BubbleChatConfiguration")
                    if not bubbleChatConfiguration then
                        return
                    end

                    if enabled2 == nil then
                        enabled2 = bubbleChatConfiguration.Enabled
                    end

                    local enabled = enabled2 == true and not state.SeesMatch()

                    if bubbleChatConfiguration.Enabled ~= enabled then
                        bubbleChatConfiguration.Enabled = enabled
                    end
                end
            end
        )

        local function refresh()
            --[[
              name: refresh
              line: 276
              upvalues:
                textChatService (copy, index: 1)
                enabled2 (ref,  index: 2)
                state (copy, index: 3)
                chatInputBarConfiguration (ref,  index: 4)
                v53 (ref,  index: 5)
                placePill (copy, index: 6)
                v111 (ref,  index: 7)
                enabled (copy, index: 8)
                command (copy, index: 9)
                apply (copy, index: 10)
                mode (ref,  index: 11)
                textColor3 (copy, index: 12)
                colors (copy, index: 13)
                ui2 (copy, index: 14)
                v48 (copy, index: 15)
                v47 (copy, index: 16)
            ]]
            if const bubbleChatConfiguration = textChatService:FindFirstChildOfClass("BubbleChatConfiguration") then
                if enabled2 == nil then
                    enabled2 = bubbleChatConfiguration.Enabled
                end

                local enabled3 = enabled2 == true and not state.SeesMatch()

                if bubbleChatConfiguration.Enabled ~= enabled3 then
                    bubbleChatConfiguration.Enabled = enabled3
                end
            end

            local chatInputBarConfiguration2 = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatInputBarConfiguration2 and chatInputBarConfiguration2 ~= chatInputBarConfiguration then
                chatInputBarConfiguration = chatInputBarConfiguration2
                pcall(
                    function()
                        --[[
                          line: 243
                          upvalues:
                            chatInputBarConfiguration2 (copy, index: 1)
                            textChatService (copy, index: 2)
                            v53 (ref,  index: 3)
                            placePill (copy, index: 4)
                        ]]
                        chatInputBarConfiguration2:GetPropertyChangedSignal("IsFocused"):Connect(
                            function()
                                --[[
                                  line: 244
                                  upvalues:
                                    textChatService (copy, index: 1)
                                    v53 (ref,  index: 2)
                                    placePill (copy, index: 3)
                                ]]
                                local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
                                local v130, isFocused = pcall(
                                    function()
                                        --[[
                                          line: 149
                                          upvalues:
                                            chatInputBarConfiguration (copy, index: 1)
                                        ]]
                                        return chatInputBarConfiguration.IsFocused
                                    end
                                )
                                v130 = v130 and isFocused == true

                                if not v130 then
                                    v53 = os.clock() + 2.5
                                    task.delay(2.55, placePill)
                                end

                                placePill()
                            end
                        )
                    end
                )
            end

            if not v111 and enabled() then
                v111 = true
                command("TribesTeamChat_Team", "/t", "/team", "team")
                command("TribesTeamChat_All", "/a", "/all", "all")
            end

            apply()
            local v132 = mode == "team"
            local v133 = if v132 then textColor3 else colors.TextDim
            ui2.Text = v132 and "TEAM CHAT" or "ALL CHAT"
            ui2.TextColor3 = v133
            v48.Text = v132 and "three-people" or "globe-simplified"
            v48.TextColor3 = v133
            v47.Color = v133
            placePill()
        end

        state.PlayerStateChanged:Connect(refresh)

        state.AttrChanged:Connect(
            function(a134)
                --[[
                  line: 285
                  upvalues:
                    textChatService (copy, index: 1)
                    enabled2 (ref,  index: 2)
                    state (copy, index: 3)
                    chatInputBarConfiguration (ref,  index: 4)
                    v53 (ref,  index: 5)
                    placePill (copy, index: 6)
                    v111 (ref,  index: 7)
                    enabled (copy, index: 8)
                    command (copy, index: 9)
                    apply (copy, index: 10)
                    mode (ref,  index: 11)
                    textColor3 (copy, index: 12)
                    colors (copy, index: 13)
                    ui2 (copy, index: 14)
                    v48 (copy, index: 15)
                    v47 (copy, index: 16)
                ]]
                if a134 == "Team" or a134 == "MatchId" then
                    if const bubbleChatConfiguration = textChatService:FindFirstChildOfClass("BubbleChatConfiguration") then
                        if enabled2 == nil then
                            enabled2 = bubbleChatConfiguration.Enabled
                        end

                        local enabled3 = enabled2 == true and not state.SeesMatch()

                        if bubbleChatConfiguration.Enabled ~= enabled3 then
                            bubbleChatConfiguration.Enabled = enabled3
                        end
                    end

                    local chatInputBarConfiguration2 = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                    if chatInputBarConfiguration2 and chatInputBarConfiguration2 ~= chatInputBarConfiguration then
                        chatInputBarConfiguration = chatInputBarConfiguration2
                        pcall(
                            function()
                                --[[
                                  line: 243
                                  upvalues:
                                    chatInputBarConfiguration2 (copy, index: 1)
                                    textChatService (copy, index: 2)
                                    v53 (ref,  index: 3)
                                    placePill (copy, index: 4)
                                ]]
                                chatInputBarConfiguration2:GetPropertyChangedSignal("IsFocused"):Connect(
                                    function()
                                        --[[
                                          line: 244
                                          upvalues:
                                            textChatService (copy, index: 1)
                                            v53 (ref,  index: 2)
                                            placePill (copy, index: 3)
                                        ]]
                                        local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
                                        local v139, isFocused = pcall(
                                            function()
                                                --[[
                                                  line: 149
                                                  upvalues:
                                                    chatInputBarConfiguration (copy, index: 1)
                                                ]]
                                                return chatInputBarConfiguration.IsFocused
                                            end
                                        )
                                        v139 = v139 and isFocused == true

                                        if not v139 then
                                            v53 = os.clock() + 2.5
                                            task.delay(2.55, placePill)
                                        end

                                        placePill()
                                    end
                                )
                            end
                        )
                    end

                    if not v111 and enabled() then
                        v111 = true
                        command("TribesTeamChat_Team", "/t", "/team", "team")
                        command("TribesTeamChat_All", "/a", "/all", "all")
                    end

                    apply()
                    local v141 = mode == "team"
                    local v142 = if v141 then textColor3 else colors.TextDim
                    ui2.Text = v141 and "TEAM CHAT" or "ALL CHAT"
                    ui2.TextColor3 = v142
                    v48.Text = v141 and "three-people" or "globe-simplified"
                    v48.TextColor3 = v142
                    v47.Color = v142
                    placePill()
                end
            end
        )

        localPlayer:GetAttributeChangedSignal("TeamChannel"):Connect(refresh)
        a3.HudHiddenChanged:Connect(placePill)

        ui.ChatChanged:Connect(
            function()
                --[[
                  line: 292
                  upvalues:
                    textChatService (copy, index: 1)
                    chatInputBarConfiguration (ref,  index: 2)
                    v53 (ref,  index: 3)
                    placePill (copy, index: 4)
                ]]
                local chatInputBarConfiguration2 = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                if chatInputBarConfiguration2 and chatInputBarConfiguration2 ~= chatInputBarConfiguration then
                    chatInputBarConfiguration = chatInputBarConfiguration2
                    pcall(
                        function()
                            --[[
                              line: 243
                              upvalues:
                                chatInputBarConfiguration2 (copy, index: 1)
                                textChatService (copy, index: 2)
                                v53 (ref,  index: 3)
                                placePill (copy, index: 4)
                            ]]
                            chatInputBarConfiguration2:GetPropertyChangedSignal("IsFocused"):Connect(
                                function()
                                    --[[
                                      line: 244
                                      upvalues:
                                        textChatService (copy, index: 1)
                                        v53 (ref,  index: 2)
                                        placePill (copy, index: 3)
                                    ]]
                                    local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
                                    local v145, isFocused = pcall(
                                        function()
                                            --[[
                                              line: 149
                                              upvalues:
                                                chatInputBarConfiguration (copy, index: 1)
                                            ]]
                                            return chatInputBarConfiguration.IsFocused
                                        end
                                    )
                                    v145 = v145 and isFocused == true

                                    if not v145 then
                                        v53 = os.clock() + 2.5
                                        task.delay(2.55, placePill)
                                    end

                                    placePill()
                                end
                            )
                        end
                    )
                end

                placePill()
            end
        )

        ui.LayoutChanged:Connect(placePill)

        if const bubbleChatConfiguration = textChatService:FindFirstChildOfClass("BubbleChatConfiguration") then
            if enabled2 == nil then
                enabled2 = bubbleChatConfiguration.Enabled
            end

            local enabled3 = enabled2 == true and not state.SeesMatch()

            if bubbleChatConfiguration.Enabled ~= enabled3 then
                bubbleChatConfiguration.Enabled = enabled3
            end
        end

        local chatInputBarConfiguration2 = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

        if chatInputBarConfiguration2 and chatInputBarConfiguration2 ~= chatInputBarConfiguration then
            chatInputBarConfiguration = chatInputBarConfiguration2
            pcall(
                function()
                    --[[
                      line: 243
                      upvalues:
                        chatInputBarConfiguration2 (copy, index: 1)
                        textChatService (copy, index: 2)
                        v53 (ref,  index: 3)
                        placePill (copy, index: 4)
                    ]]
                    chatInputBarConfiguration2:GetPropertyChangedSignal("IsFocused"):Connect(
                        function()
                            --[[
                              line: 244
                              upvalues:
                                textChatService (copy, index: 1)
                                v53 (ref,  index: 2)
                                placePill (copy, index: 3)
                            ]]
                            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
                            local v151, isFocused = pcall(
                                function()
                                    --[[
                                      line: 149
                                      upvalues:
                                        chatInputBarConfiguration (copy, index: 1)
                                    ]]
                                    return chatInputBarConfiguration.IsFocused
                                end
                            )
                            v151 = v151 and isFocused == true

                            if not v151 then
                                v53 = os.clock() + 2.5
                                task.delay(2.55, placePill)
                            end

                            placePill()
                        end
                    )
                end
            )
        end

        if not v111 and enabled() then
            v111 = true
            command("TribesTeamChat_Team", "/t", "/team", "team")
            command("TribesTeamChat_All", "/a", "/all", "all")
        end

        apply()
        local v153 = mode == "team"
        local v154 = if v153 then textColor3 else colors.TextDim
        ui2.Text = v153 and "TEAM CHAT" or "ALL CHAT"
        ui2.TextColor3 = v154
        v48.Text = v153 and "three-people" or "globe-simplified"
        v48.TextColor3 = v154
        v47.Color = v154
        placePill()

        a3.Debug.teamChat = function(a155, text: string)
            --[[
              line: 299
              upvalues:
                mode (ref,  index: 1)
                apply (copy, index: 2)
                textColor3 (copy, index: 3)
                colors (copy, index: 4)
                ui2 (copy, index: 5)
                v48 (copy, index: 6)
                v47 (copy, index: 7)
                onCommand (copy, index: 8)
                textChatService (copy, index: 9)
                enabled (copy, index: 10)
                localPlayer (copy, index: 11)
                parent2 (copy, index: 12)
            ]]
            local v157
            local v158 = nil

            if a155 == "team" or a155 == "all" then
                mode = a155
                apply()
                local v159 = mode == "team"
                local v160 = if v159 then textColor3 else colors.TextDim
                ui2.Text = v159 and "TEAM CHAT" or "ALL CHAT"
                ui2.TextColor3 = v160
                v48.Text = v159 and "three-people" or "globe-simplified"
                v48.TextColor3 = v160
                v47.Color = v160
            elseif a155 == "cmd" and type(text) == "string" then
                local v161 = string.match(text, "^(%S+)")
                local v162 = v161 ~= "/a" and v161 ~= "/all" and "team" or "all"
                v158 = onCommand(v162, text)
            end

            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
            local targetTextChannel = chatInputBarConfiguration and chatInputBarConfiguration.TargetTextChannel
            local v165 = {enabled = enabled(), mode = mode, channel = localPlayer:GetAttribute("TeamChannel") or false}

            if targetTextChannel then
                v157 = targetTextChannel:GetFullName()
                v157 = textChatService
            else
                v157 = false
                v157 = textChatService
            end

            v165.target = v157
            v165.pill = parent2.Visible
            local bubbleChatConfiguration = v157:FindFirstChildOfClass("BubbleChatConfiguration")
            v165.bubbles = if bubbleChatConfiguration then bubbleChatConfiguration.Enabled else false
            v165.did = v158 or false

            return v165
        end
    end)
}