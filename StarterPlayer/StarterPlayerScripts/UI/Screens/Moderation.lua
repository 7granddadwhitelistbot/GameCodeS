local StarterGui_upv_1 = game:GetService("StarterGui")
local TextChatService_upv_1 = game:GetService("TextChatService")
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 24
      upvalues:
        TextChatService_upv_1 (copy, index: 1)
        StarterGui_upv_1 (copy, index: 2)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local MenuManager_upv_1 = a1.MenuManager
    local fromOffset_upv_1 = UDim2.fromOffset
    local tbl_upv_2 = {}
    local function escape(a2)
        --[[
          name: escape
          line: 33
        ]]
        return (string.gsub(string.gsub(string.gsub(a2, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
    end
    local function systemLine(a3, a4, a5)
        --[[
          name: systemLine
          line: 36
          upvalues:
            TextChatService_upv_1 (copy, index: 1)
            StarterGui_upv_1 (copy, index: 2)
        ]]
        local TextChannels_1 = TextChatService_upv_1:FindFirstChild("TextChannels")
        local u1 = TextChannels_1 and (TextChannels_1:FindFirstChild("RBXSystem"))
        if u1 and u1:IsA("TextChannel") then
            return (pcall(
                function()
                    --[[
                      line: 40
                      upvalues:
                        u1 (copy, index: 1)
                        a5 (copy, index: 2)
                        a4 (copy, index: 3)
                        a3 (copy, index: 4)
                    ]]
                    u1:DisplaySystemMessage((("<font color=\"%*\"><b>[%*]</b></font> <font color=\"#E4E8F0\">%*</font>"):format(a5 or "#FF7A82", a4 or "MOD", string.gsub(string.gsub(string.gsub(a3, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))))
                end
            ))
        end
        return (pcall(
            function()
                --[[
                  line: 46
                  upvalues:
                    StarterGui_upv_1 (copy, index: 1)
                    a3 (copy, index: 2)
                ]]
                StarterGui_upv_1:SetCore("ChatMakeSystemMessage", {Text = "[MOD] " .. a3, Color = Color3.fromRGB(255, 160, 165)})
            end
        ))
    end
    local u2 = nil
    local tbl_upv_3 = {}
    local u3 = nil
    local u4 = false
    local function text(a6)
        --[[
          name: text
          line: 80
          upvalues:
            Colors_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        a6.BackgroundTransparency = 1
        a6.TextXAlignment = a6.TextXAlignment or (Enum.TextXAlignment.Left)
        a6.TextColor3 = a6.TextColor3 or (Colors_upv_1.Text)
        return UI_upv_1.new("TextLabel", a6)
    end
    local function row(a7, a8, a9)
        --[[
          name: row
          line: 87
          upvalues:
            UI_upv_1 (copy, index: 1)
            fromOffset_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            u2 (ref,  index: 4)
            Fonts_upv_1 (copy, index: 5)
        ]]
        local v1 = UI_upv_1.new("Frame", {Name = a7, Position = fromOffset_upv_1(0, a8), Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.25, [1] = UI_upv_1.Corner(12), Parent = u2.Content})
        local tbl_4 = {Name = "Title", TextSize = 14}
        tbl_4.Text = a9
        tbl_4.FontFace = Fonts_upv_1.Heavy
        tbl_4.TextColor3 = Colors_upv_1.TextMuted
        tbl_4.Position = fromOffset_upv_1(18, 0)
        tbl_4.Size = UDim2.new(0, 110, 1, 0)
        tbl_4.Parent = v1
        tbl_4.BackgroundTransparency = 1
        tbl_4.TextXAlignment = tbl_4.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_4.TextColor3 = tbl_4.TextColor3 or (Colors_upv_1.Text)
        local _ = UI_upv_1.new("TextLabel", tbl_4)
        local tbl_5 = {Name = "Value", Text = "", TextSize = 21}
        tbl_5.FontFace = Fonts_upv_1.Bold
        tbl_5.Position = fromOffset_upv_1(128, 9)
        tbl_5.Size = UDim2.new(1, -146, 0, 24)
        tbl_5.TextTruncate = Enum.TextTruncate.AtEnd
        tbl_5.Parent = v1
        tbl_5.BackgroundTransparency = 1
        tbl_5.TextXAlignment = tbl_5.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_5.TextColor3 = tbl_5.TextColor3 or (Colors_upv_1.Text)
        local v2 = UI_upv_1.new("TextLabel", tbl_5)
        local tbl_6 = {Name = "Sub", Text = "", TextSize = 14}
        tbl_6.FontFace = Fonts_upv_1.SemiBold
        tbl_6.TextColor3 = Colors_upv_1.TextMuted
        tbl_6.Position = fromOffset_upv_1(128, 33)
        tbl_6.Size = UDim2.new(1, -146, 0, 16)
        tbl_6.Parent = v1
        tbl_6.BackgroundTransparency = 1
        tbl_6.TextXAlignment = tbl_6.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_6.TextColor3 = tbl_6.TextColor3 or (Colors_upv_1.Text)
        return v1, v2, (UI_upv_1.new("TextLabel", tbl_6))
    end
    local function close()
        --[[
          name: close
          line: 76
          upvalues:
            MenuManager_upv_1 (copy, index: 1)
        ]]
        MenuManager_upv_1.Close("ModBan")
    end
    local function build()
        --[[
          name: build
          line: 103
          upvalues:
            u2 (ref,  index: 1)
            UI_upv_1 (copy, index: 2)
            fromOffset_upv_1 (copy, index: 3)
            a1 (copy, index: 4)
            close (copy, index: 5)
            Colors_upv_1 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            tbl_upv_3 (copy, index: 8)
            Fonts_upv_1 (copy, index: 9)
            row (copy, index: 10)
            u4 (ref,  index: 11)
            u3 (ref,  index: 12)
            MenuManager_upv_1 (copy, index: 13)
        ]]
        local v3 = UI_upv_1.Window({HeaderHeight = 76, Subtitle = "Check it's the right account", Name = "ModBan", Title = "BAN PLAYER", Size = fromOffset_upv_1(600, 466), Parent = a1.Canvas.Menus, OnCloseRequested = close})
        u2 = v3
        u2.Title.TextColor3 = Colors_upv_1.Danger
        UI_upv_1.SelectionRing(u2.Root)
        local Content_1 = u2.Content
        local v4 = UI_upv_1.new("ImageLabel", {Name = "Head", Position = fromOffset_upv_1(0, 0), Size = fromOffset_upv_1(92, 92), BackgroundColor3 = Colors_upv_1.Raised, Image = "", [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = Content_1})
        UI_upv_1.Stroke(Colors_upv_1.Stroke, 1.5, 0.85).Parent = v4
        tbl_upv_3.head = v4
        local tbl_7 = {Name = "Name", Text = "", TextSize = 32}
        tbl_7.FontFace = Fonts_upv_1.Display
        tbl_7.Position = fromOffset_upv_1(112, 2)
        tbl_7.Size = UDim2.new(1, -112, 0, 36)
        tbl_7.TextTruncate = Enum.TextTruncate.AtEnd
        tbl_7.Parent = Content_1
        tbl_7.BackgroundTransparency = 1
        tbl_7.TextXAlignment = tbl_7.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_7.TextColor3 = tbl_7.TextColor3 or (Colors_upv_1.Text)
        tbl_upv_3.name = UI_upv_1.new("TextLabel", tbl_7)
        local tbl_8 = {Text = "", Name = "Handle", TextSize = 17}
        tbl_8.FontFace = Fonts_upv_1.SemiBold
        tbl_8.TextColor3 = Colors_upv_1.TextDim
        tbl_8.Position = fromOffset_upv_1(112, 40)
        tbl_8.Size = UDim2.new(1, -112, 0, 20)
        tbl_8.TextTruncate = Enum.TextTruncate.AtEnd
        tbl_8.Parent = Content_1
        tbl_8.BackgroundTransparency = 1
        tbl_8.TextXAlignment = tbl_8.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_8.TextColor3 = tbl_8.TextColor3 or (Colors_upv_1.Text)
        tbl_upv_3.handle = UI_upv_1.new("TextLabel", tbl_8)
        tbl_upv_3.whereHolder = UI_upv_1.new("Frame", {Name = "Where", Position = fromOffset_upv_1(112, 66), Size = fromOffset_upv_1(300, 24), Parent = Content_1})
        tbl_upv_3.already = UI_upv_1.new("Frame", {Name = "Already", Position = fromOffset_upv_1(0, 106), Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = Colors_upv_1.Warning, BackgroundTransparency = 0.82, Visible = false, [1] = UI_upv_1.Corner(10), Parent = Content_1})
        UI_upv_1.Stroke(Colors_upv_1.Warning, 1, 0.5).Parent = tbl_upv_3.already
        local tbl_9 = {Text = "", Name = "Text", TextSize = 16}
        tbl_9.FontFace = Fonts_upv_1.Bold
        tbl_9.TextColor3 = Colors_upv_1.Warning
        tbl_9.Position = fromOffset_upv_1(14, 0)
        tbl_9.Size = UDim2.new(1, -28, 1, 0)
        tbl_9.TextTruncate = Enum.TextTruncate.AtEnd
        tbl_9.Parent = tbl_upv_3.already
        tbl_9.BackgroundTransparency = 1
        tbl_9.TextXAlignment = tbl_9.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_9.TextColor3 = tbl_9.TextColor3 or (Colors_upv_1.Text)
        tbl_upv_3.alreadyText = UI_upv_1.new("TextLabel", tbl_9)
        local _, v5, v6 = row("Length", 106, "LENGTH")
        local v9, v7, v8 = row("Reason", 170, "REASON")
        tbl_upv_3.lengthRow = v5.Parent
        tbl_upv_3.reasonRow = v7.Parent
        tbl_upv_3.length = v5
        tbl_upv_3.lengthSub = v6
        tbl_upv_3.reason = v7
        tbl_upv_3.reasonSub = v8
        v8.Text = "They see this when they try to join"
        local tbl_10 = {Text = "", Name = "Note", TextWrapped = true, TextSize = 15}
        tbl_10.FontFace = Fonts_upv_1.SemiBold
        tbl_10.TextColor3 = Colors_upv_1.TextMuted
        tbl_10.TextYAlignment = Enum.TextYAlignment.Top
        tbl_10.Position = fromOffset_upv_1(0, 240)
        tbl_10.Size = UDim2.new(1, 0, 0, 40)
        tbl_10.Parent = Content_1
        tbl_10.BackgroundTransparency = 1
        tbl_10.TextXAlignment = tbl_10.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_10.TextColor3 = tbl_10.TextColor3 or (Colors_upv_1.Text)
        tbl_upv_3.note = UI_upv_1.new("TextLabel", tbl_10)
        tbl_upv_3.cancel = UI_upv_1.Button({Style = "Dark", Name = "Cancel", Text = "CANCEL", TextSize = 20, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, 0), Size = fromOffset_upv_1(272, 58), Parent = Content_1})
        tbl_upv_3.ban = UI_upv_1.Button({Style = "Danger", Name = "Ban", Text = "BAN", TextSize = 20, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 0, 1, 0), Size = fromOffset_upv_1(272, 58), Parent = Content_1})
        tbl_upv_3.cancel.Activated:Connect(close)
        tbl_upv_3.ban.Activated:Connect(
            function()
                --[[
                  line: 173
                  upvalues:
                    u4 (ref,  index: 1)
                    u3 (ref,  index: 2)
                    tbl_upv_3 (copy, index: 3)
                    a1 (copy, index: 4)
                    MenuManager_upv_1 (copy, index: 5)
                ]]
                if (u4) or not u3 then
                    return
                end
                u4 = true
                tbl_upv_3.ban:SetText("BANNING\226\128\166")
                tbl_upv_3.ban:SetEnabled(false)
                local token_upv_1 = u3.token
                task.spawn(
                    function()
                        --[[
                          line: 181
                          upvalues:
                            a1 (copy, index: 1)
                            token_upv_1 (copy, index: 2)
                            u4 (ref,  index: 3)
                            u3 (ref,  index: 4)
                            MenuManager_upv_1 (copy, index: 5)
                            tbl_upv_3 (copy, index: 6)
                        ]]
                        local v9, v10, v11 = a1.Remotes.Invoke("ModAction", "Ban", token_upv_1)
                        u4 = false
                        if v9 and v10 then
                            u3 = nil
                            MenuManager_upv_1.Close("ModBan")
                            local Toast_1 = a1.Toast
                            local v12
                            if type(v11) ~= "string" then
                                v12 = "Banned"
                            else
                                v12 = v11
                            end
                            Toast_1(v12, "success")
                            return
                        end
                        tbl_upv_3.ban:SetEnabled(true)
                        tbl_upv_3.ban:SetText("TRY AGAIN")
                        local Toast_2 = a1.Toast
                        local v12
                        if type(v11) == "string" then
                            v12 = v11
                        elseif type(v10) ~= "string" then
                            v12 = "The ban didn't go through"
                        else
                            v12 = v10
                        end
                        Toast_2(v12, "error")
                        if type(v11) ~= "string" or not string.find(v11, "expired", 1, true) then
                            return
                        end
                        u3 = nil
                        MenuManager_upv_1.Close("ModBan")
                    end
                )
            end
        )
    end
    local function paint()
        --[[
          name: paint
          line: 201
          upvalues:
            u3 (ref,  index: 1)
            tbl_upv_3 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u2 (ref,  index: 5)
            fromOffset_upv_1 (copy, index: 6)
        ]]
        if not u3 then
            return
        end
        local v13 = tonumber(u3.userId) or 0
        tbl_upv_3.head.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v13)
        local v14 = tostring(u3.display or (u3.name or "?"))
        local str_1 = tostring(u3.name or "?")
        tbl_upv_3.name.Text = v14
        tbl_upv_3.handle.Text = ("@%*  \194\183  id %*"):format(str_1, v13)
        tbl_upv_3.whereHolder:ClearAllChildren()
        local str_2 = tostring(u3.where or "away")
        if str_2 == "here" then
            v14 = "In this server"
        elseif str_2 ~= "away" then
            v14 = str_2
        else
            v14 = "Not in this server"
        end
        local Pill_1 = UI_upv_1.Pill
        local v15
        if str_2 ~= "here" then
            v15 = Colors_upv_1.Raised
        else
            v15 = Colors_upv_1.SuccessDark
        end
        Pill_1(v14, v15, {Height = 24, TextSize = 13, Parent = tbl_upv_3.whereHolder})
        local v16 = (type(u3.already) == "string") and (u3.already ~= "")
        tbl_upv_3.already.Visible = v16
        local alreadyText_1 = tbl_upv_3.alreadyText
        local v17
        if v16 then
            v17 = ("Already %*. Banning again replaces it."):format(u3.already)
        else
            v17 = ""
        end
        alreadyText_1.Text = v17
        v14 = (v16 and 152) or 106
        local Holder_1 = u2.Holder
        Holder_1.Size = fromOffset_upv_1(600, ((v16 and 46) or 0) + 466)
        u2.Refit()
        tbl_upv_3.lengthRow.Position = fromOffset_upv_1(0, v14)
        tbl_upv_3.reasonRow.Position = fromOffset_upv_1(0, v14 + 64)
        tbl_upv_3.note.Position = fromOffset_upv_1(0, v14 + 136)
        local v18 = (tonumber(u3.length) or -1) < 0
        local str_3 = tostring(u3.lengthText or "permanent")
        local length_1 = tbl_upv_3.length
        local v19
        if v18 then
            v19 = "Permanent"
        else
            v19 = string.upper(string.sub(str_3, 1, 1)) .. string.sub(str_3, 2)
        end
        length_1.Text = v19
        local length_2 = tbl_upv_3.length
        local v20
        if v18 then
            v20 = Colors_upv_1.Danger
        else
            v20 = Colors_upv_1.Text
        end
        length_2.TextColor3 = v20
        tbl_upv_3.lengthSub.Text = (v18 and "Until a moderator unbans them (/unban)") or "Then they can play again"
        tbl_upv_3.reason.Text = tostring(u3.reason or "Cheating")
        tbl_upv_3.note.Text = "Their alt accounts are banned too, and their device can't rejoin for 24 hours." .. (((u3.studio) and "  Studio: a test ban, it never reaches the live game.") or "")
        local ban_1 = tbl_upv_3.ban
        v15 = (v18 and "BAN PERMANENTLY") or (("BAN FOR %*"):format(string.upper(str_3)))
        ban_1:SetText(v15)
        tbl_upv_3.ban:SetEnabled(true)
    end
    local tbl_11 = {}
    function tbl_11.open()
        --[[
          name: open
          line: 239
          upvalues:
            u2 (ref,  index: 1)
            build (copy, index: 2)
            u4 (ref,  index: 3)
            paint (copy, index: 4)
        ]]
        if not (u2) then
            build()
        end
        u4 = false
        paint()
        u2:Open()
    end
    function tbl_11.close(a10)
        --[[
          name: close
          line: 247
          upvalues:
            u2 (ref, index: 1)
        ]]
        if not u2 then
            return
        end
        u2:Close(a10)
    end
    function tbl_11.select()
        --[[
          name: select
          line: 252
          upvalues:
            tbl_upv_3 (copy, index: 1)
        ]]
        if tbl_upv_3.cancel then
            return tbl_upv_3.cancel.Instance
        end
        return nil
    end
    MenuManager_upv_1.Register("ModBan", tbl_11)
    local function say(a11, a12, a13)
        --[[
          name: say
          line: 50
          upvalues:
            tbl_upv_2 (copy, index: 1)
            systemLine (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        local v21 = false
        if type(a11) == "table" then
            for _, value_1 in a11 do
                if type(value_1) == "string" then
                    table.insert(tbl_upv_2, value_1)
                    v21 = systemLine(value_1) or v21
                end
            end
            while #tbl_upv_2 > 30 do
                table.remove(tbl_upv_2, 1)
            end
        end
        if type(a12) == "string" and a12 ~= "" then
            local Toast_3 = a1.Toast
            local v22
            if type(a13) ~= "string" then
                v22 = "info"
            else
                v22 = a13
            end
            Toast_3(a12, v22)
            return
        end
        if (v21) or type(a11) ~= "table" then
            return
        end
        if type(a11[1]) == "string" then
            local Toast_4 = a1.Toast
            local v23 = a11[1]
            local v22
            if type(a13) ~= "string" then
                v22 = "info"
            else
                v22 = a13
            end
            Toast_4(v23, v22)
        end
    end
    a1.Remotes.On(
        "ModEvent",
        function(a14, a15, a16, a17)
            --[[
              line: 257
              upvalues:
                say (copy, index: 1)
                u3 (ref,  index: 2)
                MenuManager_upv_1 (copy, index: 3)
                paint (copy, index: 4)
                systemLine (copy, index: 5)
                a1 (copy, index: 6)
            ]]
            if a14 ~= "Say" then
                if a14 == "Confirm" and type(a15) == "table" then
                    u3 = a15
                    if MenuManager_upv_1.IsOpen("ModBan") then
                        paint()
                    else
                        MenuManager_upv_1.Open("ModBan")
                    end
                    return
                end
                if a14 == "Banned" and type(a15) == "string" then
                    local v24
                    if type(a16) ~= "string" or a16 == a15 then
                        v24 = a15
                    else
                        v24 = ("%* (@%*)"):format(a15, a16)
                    end
                    systemLine(("%* was banned for cheating."):format(v24), "BANNED", "#FF5A5F")
                    a1.Toast(("%* was banned for cheating"):format(a15), "success")
                end
            else
                say(a15, a16, a17)
            end
        end
    )
    a1.Debug.mod = function(a18)
        --[[
          line: 275
          upvalues:
            tbl_upv_3 (copy, index: 1)
            MenuManager_upv_1 (copy, index: 2)
            tbl_upv_2 (copy, index: 3)
        ]]
        if a18 == "ban" and tbl_upv_3.ban then
            tbl_upv_3.ban.Activated:Fire()
        end
        local tbl_12 = {name = 0, said = 0, length = 0, reason = 0}
        tbl_12.open = MenuManager_upv_1.IsOpen("ModBan")
        local v25
        if tbl_upv_3.name then
            v25 = tbl_upv_3.name.Text
        else
            v25 = false
        end
        tbl_12.name = v25
        local v26
        if tbl_upv_3.length then
            v26 = tbl_upv_3.length.Text
        else
            v26 = false
        end
        tbl_12.length = v26
        local v27
        if tbl_upv_3.reason then
            v27 = tbl_upv_3.reason.Text
        else
            v27 = false
        end
        tbl_12.reason = v27
        tbl_12.said = tbl_upv_2
        return tbl_12
    end
end
return tbl_1