local Players_upv_1 = game:GetService("Players")
local TextChatService_upv_1 = game:GetService("TextChatService")
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 22
      upvalues:
        Players_upv_1 (copy, index: 1)
        TextChatService_upv_1 (copy, index: 2)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = Theme_upv_1.Lighten(Colors_upv_1.Ally, 0.25)
    local u2 = u1:ToHex()
    local u3 = "all"
    local function folder()
        --[[
          name: folder
          line: 42
          upvalues:
            TextChatService_upv_1 (copy, index: 1)
        ]]
        return TextChatService_upv_1:FindFirstChild("TribesTeamChat")
    end
    local function teamChannel()
        --[[
          name: teamChannel
          line: 45
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            TextChatService_upv_1 (copy, index: 2)
        ]]
        local v1 = LocalPlayer_upv_1:GetAttribute("TeamChannel")
        local TribesTeamChat_1 = TextChatService_upv_1:FindFirstChild("TribesTeamChat")
        local v2 = TribesTeamChat_1 and ((type(v1) == "string") and (TribesTeamChat_1:FindFirstChild(v1)))
        if v2 and v2:IsA("TextChannel") then
            return v2
        end
        return nil
    end
    local function general()
        --[[
          name: general
          line: 51
          upvalues:
            TextChatService_upv_1 (copy, index: 1)
        ]]
        local TextChannels_1 = TextChatService_upv_1:FindFirstChild("TextChannels")
        local v3 = TextChannels_1 and (TextChannels_1:FindFirstChild("RBXGeneral"))
        if v3 and v3:IsA("TextChannel") then
            return v3
        end
        return nil
    end
    local function inputBar()
        --[[
          name: inputBar
          line: 56
          upvalues:
            TextChatService_upv_1 (copy, index: 1)
        ]]
        return TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
    end
    local tbl_upv_2 = {}
    local function enabled()
        --[[
          name: enabled
          line: 32
          upvalues:
            TextChatService_upv_1 (copy, index: 1)
        ]]
        local success_1, v4 = pcall(
            function()
                --[[
                  line: 33
                  upvalues:
                    TextChatService_upv_1 (copy, index: 1)
                ]]
                return TextChatService_upv_1.ChatVersion
            end
        )
        if success_1 and v4 == Enum.ChatVersion.TextChatService then
            return true
        end
        local TextChannels_2 = TextChatService_upv_1:FindFirstChild("TextChannels")
        local v5 = (TextChannels_2 ~= nil) and (TextChannels_2:FindFirstChild("RBXGeneral") ~= nil)
        return v5
    end
    local function hook(a2)
        --[[
          name: hook
          line: 62
          upvalues:
            tbl_upv_2 (copy, index: 1)
            u2 (copy, index: 2)
            TextChatService_upv_1 (copy, index: 3)
        ]]
        if tbl_upv_2[a2] then
            return
        end
        tbl_upv_2[a2] = true
        a2.OnIncomingMessage = function(a3)
            --[[
              line: 67
              upvalues:
                u2 (copy, index: 1)
            ]]
            local v6 = Instance.new("TextChatMessageProperties")
            v6.PrefixText = string.format("<font color=\"#%s\">[TEAM] %s</font>", u2, a3.PrefixText)
            return v6
        end
        a2.AncestryChanged:Connect(
            function()
                --[[
                  line: 72
                  upvalues:
                    a2 (copy, index: 1)
                    TextChatService_upv_1 (copy, index: 2)
                    tbl_upv_2 (copy, index: 3)
                ]]
                if (a2:IsDescendantOf(TextChatService_upv_1)) then
                    return
                end
                tbl_upv_2[a2] = nil
            end
        )
    end
    local function apply()
        --[[
          name: apply
          line: 80
          upvalues:
            enabled (copy, index: 1)
            TextChatService_upv_1 (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            hook (copy, index: 4)
            State_upv_1 (copy, index: 5)
            u3 (ref,  index: 6)
        ]]
        if not enabled() then
            return
        end
        local v7 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
        if not v7 then
            return
        end
        local v8 = LocalPlayer_upv_1:GetAttribute("TeamChannel")
        local TribesTeamChat_2 = TextChatService_upv_1:FindFirstChild("TribesTeamChat")
        local v9 = TribesTeamChat_2 and ((type(v8) == "string") and (TribesTeamChat_2:FindFirstChild(v8)))
        local v10 = not (v9) or not (v9:IsA("TextChannel")) or v9
        if v10 then
            hook(v10)
        end
        local TargetTextChannel_1 = v7.TargetTextChannel
        local TribesTeamChat_3 = TextChatService_upv_1:FindFirstChild("TribesTeamChat")
        local v11 = true
        local v12
        if TargetTextChannel_1 == nil then
            v12 = v11
        else
            v12 = true
            local TextChannels_3 = TextChatService_upv_1:FindFirstChild("TextChannels")
            local v13 = TextChannels_3 and (TextChannels_3:FindFirstChild("RBXGeneral"))
            local v14 = not (v13) or not (v13:IsA("TextChannel")) or v13
            if TargetTextChannel_1 ~= v14 then
                v12 = (TribesTeamChat_3 ~= nil) and (TargetTextChannel_1:IsDescendantOf(TribesTeamChat_3))
            end
        end
        if not v12 then
            return
        end
        if State_upv_1.InMatch() and v10 then
            if u3 ~= "team" then
                local TextChannels_4 = TextChatService_upv_1:FindFirstChild("TextChannels")
                local v15 = TextChannels_4 and (TextChannels_4:FindFirstChild("RBXGeneral"))
                v9 = not (v15) or not (v15:IsA("TextChannel")) or v15
            else
                v9 = v10
            end
        else
            local TextChannels_4 = TextChatService_upv_1:FindFirstChild("TextChannels")
            local v15 = TextChannels_4 and (TextChannels_4:FindFirstChild("RBXGeneral"))
            v9 = not (v15) or not (v15:IsA("TextChannel")) or v15
        end
        if v9 and v7.TargetTextChannel ~= v9 then
            v7.TargetTextChannel = v9
        end
    end
    local u4 = UI_upv_1.new("Frame", {Name = "TeamChat", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.HUD})
    local u5 = UI_upv_1.new("TextButton", {Name = "Pill", Text = "", AutoButtonColor = false, AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(122, 30), BackgroundColor3 = Colors_upv_1.Panel, BackgroundTransparency = 0.15, Visible = false, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u4})
    Theme_upv_1 = UI_upv_1.Stroke(u1, 1.5, 0.35)
    Theme_upv_1.Parent = u5
    local u6 = UI_upv_1.Glyph("three-people", 16, u1, {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Parent = u5})
    local u7 = UI_upv_1.new("TextLabel", {Text = "TEAM CHAT", Name = "Text", TextSize = 13, FontFace = Theme_upv_1.Fonts.Heavy, TextColor3 = u1, TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(32, 0), Size = UDim2.new(1, -38, 1, 0), Parent = u5})
    local function paintPill()
        --[[
          name: paintPill
          line: 133
          upvalues:
            u3 (ref,  index: 1)
            u1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u7 (copy, index: 4)
            u6 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
        ]]
        local v16 = u3 == "team"
        local v17
        if v16 then
            v17 = u1
        else
            v17 = Colors_upv_1.TextDim
        end
        u7.Text = (v16 and "TEAM CHAT") or "ALL CHAT"
        u7.TextColor3 = v17
        u6.Text = (v16 and "three-people") or "globe-simplified"
        u6.TextColor3 = v17
        Theme_upv_1.Color = v17
    end
    local u8 = 0
    local function typing()
        --[[
          name: typing
          line: 145
          upvalues:
            TextChatService_upv_1 (copy, index: 1)
        ]]
        local _ = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
        local success_2, v18 = pcall(function() end)
        return success_2 and (v18 == true)
    end
    local function placePill()
        --[[
          name: placePill
          line: 152
          upvalues:
            enabled (copy, index: 1)
            State_upv_1 (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            TextChatService_upv_1 (copy, index: 4)
            a1 (copy, index: 5)
            u8 (ref,  index: 6)
            UI_upv_1 (copy, index: 7)
            u4 (copy, index: 8)
            u5 (copy, index: 9)
        ]]
        local v19 = enabled()
        local v23 = nil
        local v24 = nil
        if v19 then
            v19 = State_upv_1.InMatch()
            if v19 then
                v19 = false
                v24 = LocalPlayer_upv_1:GetAttribute("TeamChannel")
                local TribesTeamChat_4 = TextChatService_upv_1:FindFirstChild("TribesTeamChat")
                local v21 = TribesTeamChat_4 and ((type(v24) == "string") and (TribesTeamChat_4:FindFirstChild(v24)))
                v23 = not (v21) or not (v21:IsA("TextChannel")) or v21
                if v23 ~= nil then
                    v19 = not a1.HudHidden
                    if v19 then
                        v23 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                        v24, TribesTeamChat_4 = pcall(function() end)
                        v19 = v24 and (TribesTeamChat_4 == true) or os.clock() < u8
                    end
                end
            end
        end
        if v19 then
            v23 = UI_upv_1.ChatRectIn(u4)
        else
            v23 = nil
        end
        if v19 then
            v24 = UI_upv_1.ChatRect()
        else
            v24 = nil
        end
        if v23 and v24 then
            v19 = v23.Max.Y - 20
            local v25 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
            local v26 = v24.Max.Y - v24.Min.Y
            if v25 then
                v19 = ((v26 > 1) and (v23.Min.Y + (((v25.AbsolutePosition.Y + (v25.AbsoluteSize.Y / 2)) - v24.Min.Y) * (v23.Max.Y - v23.Min.Y)) / v26)) or v19
            end
            u5.Position = UDim2.fromOffset(v23.Max.X + 8, v19)
            u5.Visible = true
            return
        end
        u5.Visible = false
    end
    local function setMode(a4, a5)
        --[[
          name: setMode
          line: 174
          upvalues:
            u3 (ref,  index: 1)
            apply (copy, index: 2)
            u1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u7 (copy, index: 5)
            u6 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            a1 (copy, index: 8)
        ]]
        u3 = a4
        apply()
        local v27 = u3 == "team"
        local v28
        if v27 then
            v28 = u1
        else
            v28 = Colors_upv_1.TextDim
        end
        u7.Text = (v27 and "TEAM CHAT") or "ALL CHAT"
        u7.TextColor3 = v28
        u6.Text = (v27 and "three-people") or "globe-simplified"
        u6.TextColor3 = v28
        Theme_upv_1.Color = v28
        if not a5 then
            return
        end
        a1.Toast(((a4 ~= "team") and "Chat: everyone") or "Chat: your team", "info")
    end
    u5.Activated:Connect(
        function()
            --[[
              line: 182
              upvalues:
                a1 (copy, index: 1)
                u3 (ref,  index: 2)
                apply (copy, index: 3)
                u1 (copy, index: 4)
                Colors_upv_1 (copy, index: 5)
                u7 (copy, index: 6)
                u6 (copy, index: 7)
                Theme_upv_1 (copy, index: 8)
            ]]
            a1.Sounds.Play("Click")
            local v29 = ((u3 ~= "team") and "team") or "all"
            u3 = v29
            apply()
            local v30 = u3 == "team"
            local v31
            if v30 then
                v31 = u1
            else
                v31 = Colors_upv_1.TextDim
            end
            u7.Text = (v30 and "TEAM CHAT") or "ALL CHAT"
            u7.TextColor3 = v31
            u6.Text = (v30 and "three-people") or "globe-simplified"
            u6.TextColor3 = v31
            Theme_upv_1.Color = v31
            a1.Toast(((v29 ~= "team") and "Chat: everyone") or "Chat: your team", "info")
        end
    )
    local function onCommand(a6, a7)
        --[[
          name: onCommand
          line: 189
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            TextChatService_upv_1 (copy, index: 2)
            State_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            u3 (ref,  index: 5)
            apply (copy, index: 6)
            u1 (copy, index: 7)
            Colors_upv_1 (copy, index: 8)
            u7 (copy, index: 9)
            u6 (copy, index: 10)
            Theme_upv_1 (copy, index: 11)
        ]]
        local v32 = LocalPlayer_upv_1:GetAttribute("TeamChannel")
        local u9 = TextChatService_upv_1:FindFirstChild("TribesTeamChat")
        local v33 = u9 and ((type(v32) == "string") and (u9:FindFirstChild(v32)))
        local v34 = not (v33) or not (v33:IsA("TextChannel")) or v33
        if State_upv_1.InMatch() then
            local u10
            if v34 then
                u10 = string.match(a7, "^%S+%s+(.-)%s*$")
                if u10 and u10 ~= "" then
                    if a6 ~= "team" then
                        local TextChannels_5 = TextChatService_upv_1:FindFirstChild("TextChannels")
                        local v35 = TextChannels_5 and (TextChannels_5:FindFirstChild("RBXGeneral"))
                        u9 = not (v35) or not (v35:IsA("TextChannel")) or v35
                    else
                        u9 = v34
                    end
                    if u9 then
                        task.spawn(
                            function()
                                --[[
                                  line: 199
                                  upvalues:
                                    u9 (copy, index: 1)
                                    u10 (copy, index: 2)
                                ]]
                                pcall(
                                    function()
                                        --[[
                                          line: 200
                                          upvalues:
                                            u9 (copy, index: 1)
                                            u10 (copy, index: 2)
                                        ]]
                                        u9:SendAsync(u10)
                                    end
                                )
                            end
                        )
                    end
                    return "sent to " .. a6
                end
                u3 = a6
                apply()
                v34 = u3 == "team"
                local v36
                if v34 then
                    v36 = u1
                else
                    v36 = Colors_upv_1.TextDim
                end
                u7.Text = (v34 and "TEAM CHAT") or "ALL CHAT"
                u7.TextColor3 = v36
                u6.Text = (v34 and "three-people") or "globe-simplified"
                u6.TextColor3 = v36
                Theme_upv_1.Color = v36
                a1.Toast(((a6 ~= "team") and "Chat: everyone") or "Chat: your team", "info")
                return "switched to " .. a6
            end
        end
        a1.Toast(((a6 ~= "team") and "You're talking to everyone") or "Team chat works in matches", "info")
        return "not in a match"
    end
    local u11 = false
    local function command(a8, a9, a10, a11)
        --[[
          name: command
          line: 210
          upvalues:
            TextChatService_upv_1 (copy, index: 1)
            onCommand (copy, index: 2)
        ]]
        if TextChatService_upv_1:FindFirstChild(a8) then
            return
        end
        local v37 = Instance.new("TextChatCommand")
        v37.Name = a8
        v37.PrimaryAlias = a9
        v37.SecondaryAlias = a10
        v37.Triggered:Connect(
            function(a12, a13)
                --[[
                  line: 218
                  upvalues:
                    onCommand (copy, index: 1)
                    a11 (copy, index: 2)
                ]]
                onCommand(a11, a13)
            end
        )
        v37.Parent = TextChatService_upv_1
    end
    local function start()
        --[[
          name: start
          line: 225
          upvalues:
            u11 (ref,  index: 1)
            enabled (copy, index: 2)
            command (copy, index: 3)
        ]]
        if (u11) or not enabled() then
            return
        end
        u11 = true
        command("TribesTeamChat_Team", "/t", "/team", "team")
        command("TribesTeamChat_All", "/a", "/all", "all")
    end
    local u12 = nil
    local function watchBar()
        --[[
          name: watchBar
          line: 235
          upvalues:
            TextChatService_upv_1 (copy, index: 1)
            u12 (ref,  index: 2)
        ]]
        local v38 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
        if not v38 or v38 == u12 then
            return
        end
        u12 = v38
        pcall(function() end)
    end
    local function refresh()
        --[[
          name: refresh
          line: 253
          upvalues:
            TextChatService_upv_1 (copy, index: 1)
            u12 (ref,  index: 2)
            placePill (copy, index: 4)
            u11 (ref,  index: 5)
            enabled (copy, index: 6)
            command (copy, index: 7)
            apply (copy, index: 8)
            u3 (ref,  index: 9)
            u1 (copy, index: 10)
            Colors_upv_1 (copy, index: 11)
            u7 (copy, index: 12)
            u6 (copy, index: 13)
            Theme_upv_1 (copy, index: 14)
        ]]
        local v39 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
        if v39 and v39 ~= u12 then
            u12 = v39
            pcall(function() end)
        end
        if not (u11) and enabled() then
            u11 = true
            command("TribesTeamChat_Team", "/t", "/team", "team")
            command("TribesTeamChat_All", "/a", "/all", "all")
        end
        apply()
        local v40 = u3 == "team"
        local v41
        if v40 then
            v41 = u1
        else
            v41 = Colors_upv_1.TextDim
        end
        u7.Text = (v40 and "TEAM CHAT") or "ALL CHAT"
        u7.TextColor3 = v41
        u6.Text = (v40 and "three-people") or "globe-simplified"
        u6.TextColor3 = v41
        Theme_upv_1.Color = v41
        placePill()
    end
    State_upv_1.PlayerStateChanged:Connect(refresh)
    State_upv_1.AttrChanged:Connect(
        function(a14)
            --[[
              line: 261
              upvalues:
                TextChatService_upv_1 (copy, index: 1)
                u12 (ref,  index: 2)
                placePill (copy, index: 4)
                u11 (ref,  index: 5)
                enabled (copy, index: 6)
                command (copy, index: 7)
                apply (copy, index: 8)
                u3 (ref,  index: 9)
                u1 (copy, index: 10)
                Colors_upv_1 (copy, index: 11)
                u7 (copy, index: 12)
                u6 (copy, index: 13)
                Theme_upv_1 (copy, index: 14)
            ]]
            if a14 == "Team" or a14 == "MatchId" then
                local v42 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                if v42 and v42 ~= u12 then
                    u12 = v42
                    pcall(function() end)
                end
                if not (u11) and enabled() then
                    u11 = true
                    command("TribesTeamChat_Team", "/t", "/team", "team")
                    command("TribesTeamChat_All", "/a", "/all", "all")
                end
                apply()
                local v43 = u3 == "team"
                local v44
                if v43 then
                    v44 = u1
                else
                    v44 = Colors_upv_1.TextDim
                end
                u7.Text = (v43 and "TEAM CHAT") or "ALL CHAT"
                u7.TextColor3 = v44
                u6.Text = (v43 and "three-people") or "globe-simplified"
                u6.TextColor3 = v44
                Theme_upv_1.Color = v44
                placePill()
            end
        end
    )
    LocalPlayer_upv_1:GetAttributeChangedSignal("TeamChannel"):Connect(refresh)
    a1.HudHiddenChanged:Connect(placePill)
    UI_upv_1.ChatChanged:Connect(
        function()
            --[[
              line: 268
              upvalues:
                TextChatService_upv_1 (copy, index: 1)
                u12 (ref,  index: 2)
                placePill (copy, index: 4)
            ]]
            local v45 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
            if v45 and v45 ~= u12 then
                u12 = v45
                pcall(function() end)
            end
            placePill()
        end
    )
    UI_upv_1.LayoutChanged:Connect(placePill)
    local u13 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
    if u13 and u13 ~= u12 then
        u12 = u13
        pcall(
            function()
                --[[
                  line: 241
                  upvalues:
                    u13 (copy, index: 1)
                    TextChatService_upv_1 (copy, index: 2)
                    u8 (ref,  index: 3)
                    placePill (copy, index: 4)
                ]]
                u13:GetPropertyChangedSignal("IsFocused"):Connect(
                    function()
                        --[[
                          line: 242
                          upvalues:
                            TextChatService_upv_1 (copy, index: 1)
                            u8 (ref,  index: 2)
                            placePill (copy, index: 3)
                        ]]
                        local u14 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                        local success_4, v46 = pcall(
                            function()
                                --[[
                                  line: 147
                                  upvalues:
                                    u14 (copy, index: 1)
                                ]]
                                return u14.IsFocused
                            end
                        )
                        if not success_4 or v46 ~= true then
                            u8 = os.clock() + 2.5
                            task.delay(2.55, placePill)
                        end
                        placePill()
                    end
                )
            end
        )
    end
    if not (u11) and enabled() then
        u11 = true
        command("TribesTeamChat_Team", "/t", "/team", "team")
        command("TribesTeamChat_All", "/a", "/all", "all")
    end
    apply()
    local v47 = u3 == "team"
    local v48
    if v47 then
        v48 = u1
    else
        v48 = Colors_upv_1.TextDim
    end
    u7.Text = (v47 and "TEAM CHAT") or "ALL CHAT"
    u7.TextColor3 = v48
    u6.Text = (v47 and "three-people") or "globe-simplified"
    u6.TextColor3 = v48
    Theme_upv_1.Color = v48
    placePill()
    a1.Debug.teamChat = function(a15, a16)
        --[[
          line: 275
          upvalues:
            u3 (ref,  index: 1)
            apply (copy, index: 2)
            u1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u7 (copy, index: 5)
            u6 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            onCommand (copy, index: 8)
            TextChatService_upv_1 (copy, index: 9)
            enabled (copy, index: 10)
            LocalPlayer_upv_1 (copy, index: 11)
            u5 (copy, index: 12)
        ]]
        local v49 = nil
        if a15 == "team" or a15 == "all" then
            u3 = a15
            apply()
            local v50 = u3 == "team"
            local v51
            if v50 then
                v51 = u1
            else
                v51 = Colors_upv_1.TextDim
            end
            u7.Text = (v50 and "TEAM CHAT") or "ALL CHAT"
            u7.TextColor3 = v51
            u6.Text = (v50 and "three-people") or "globe-simplified"
            u6.TextColor3 = v51
            Theme_upv_1.Color = v51
        elseif a15 == "cmd" then
            local v52 = nil
            if type(a16) == "string" then
                v52 = string.match(a16, "^(%S+)")
                local v53
                if v52 == "/a" or v52 == "/all" then
                    v53 = "all"
                else
                    v53 = "team"
                end
                v49 = onCommand(v53, a16)
            end
        end
        local v54 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
        local v55 = v54 and (v54.TargetTextChannel)
        local tbl_3 = {target = 0, did = 0, pill = 0}
        tbl_3.enabled = enabled()
        tbl_3.mode = u3
        tbl_3.channel = LocalPlayer_upv_1:GetAttribute("TeamChannel") or false
        local v56
        if v55 then
            v56 = v55:GetFullName()
        else
            v56 = false
        end
        tbl_3.target = v56
        tbl_3.pill = u5.Visible
        tbl_3.did = v49 or false
        return tbl_3
    end
end
return tbl_1