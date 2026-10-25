local Players_upv_1 = game:GetService("Players")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 35
      upvalues:
        Players_upv_1 (copy, index: 1)
        UserInputService_upv_1 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = {enabled = false, party = false, serverNow = 0, canInvite = false, max = 3, role = "Hub", outgoing = 0, invites = 0}
    u1.invites = {}
    u1.outgoing = {}
    local u2 = os.clock()
    local u3 = UI_upv_1.new("Frame", {Name = "PartyHud", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.HUD})
    local u4 = UI_upv_1.new("Frame", {ZIndex = 10, Name = "PartyPop", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.HUD})
    local tbl_upv_2 = {}
    local function headshot(a2, a3)
        --[[
          name: headshot
          line: 50
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        local v1 = tbl_upv_2[a2]
        if v1 then
            a3.Image = v1
        else
            a3.Image = ""
            task.spawn(function() end)
        end
    end
    local function isLeader()
        --[[
          name: isLeader
          line: 85
          upvalues:
            u1 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
        ]]
        local v2 = (u1.party ~= false) and (u1.party.leaderId == LocalPlayer_upv_1.UserId)
        return v2
    end
    local function members()
        --[[
          name: members
          line: 89
          upvalues:
            u1 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
        ]]
        if u1.party == false then
            return {{present = true, userId = LocalPlayer_upv_1.UserId, name = LocalPlayer_upv_1.DisplayName, username = LocalPlayer_upv_1.Name}}
        end
        local v3 = table.clone(u1.party.members)
        table.sort(
            v3,
            function(a4, a5)
                --[[
                  line: 94
                  upvalues:
                    u1 (ref, index: 1)
                ]]
                local v4 = a4.userId == u1.party.leaderId
                local v5 = a5.userId == u1.party.leaderId
                if v4 == v5 then
                    return false
                end
                return v4
            end
        )
        return v3
    end
    local u5 = UI_upv_1.new("Frame", {Name = "PartyRow", AnchorPoint = Vector2.new(1, 1), Size = UDim2.fromOffset(188, 108), Parent = u3})
    local u6 = UI_upv_1.new("TextLabel", {Text = "PARTY", Name = "Caption", TextSize = 14, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -2, 0, 0), Size = UDim2.fromOffset(320, 16), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = u5})
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.35).Parent = u6
    local u7 = UI_upv_1.new("Frame", {Name = "Seats", Position = UDim2.fromOffset(0, 32), Size = UDim2.new(1, 0, 0, 76), [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Top), Parent = u5})
    local tbl_upv_3 = {}
    local function crown(a6, a7)
        --[[
          name: crown
          line: 106
          upvalues:
            UI_upv_1 (copy, index: 1)
        ]]
        return UI_upv_1.new("TextLabel", {Rotation = -30, TextScaled = false, Name = "Crown", ZIndex = 5, Text = "\240\159\145\145", Size = UDim2.fromOffset(a7, a7), TextSize = a7, Parent = a6})
    end
    local function makeSeat(a8)
        --[[
          name: makeSeat
          line: 151
          upvalues:
            UI_upv_1 (copy, index: 1)
            u7 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
            Fonts_upv_1 (copy, index: 5)
            crown (copy, index: 6)
        ]]
        local v6 = UI_upv_1.new("TextButton", {Text = "", Name = "Seat" .. a8, Size = UDim2.fromOffset(56, 76), LayoutOrder = a8, Parent = u7})
        local v7 = {}
        v7.Name = "Circle"
        v7.Size = UDim2.fromOffset(56, 56)
        v7.BackgroundColor3 = Colors_upv_1.Panel
        v7.BackgroundTransparency = 0.15
        v7[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        v7.Parent = v6
        local v8 = UI_upv_1.new("Frame", v7)
        local v9 = UI_upv_1.Stroke(Colors_upv_1.Stroke, 2, 0.75)
        v9.Parent = v8
        local tbl_4 = {}
        tbl_4.Name = "Headshot"
        tbl_4.Size = UDim2.fromScale(1, 1)
        tbl_4.BackgroundTransparency = 1
        tbl_4.Image = ""
        tbl_4[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_4.Parent = v8
        v7 = UI_upv_1.new("ImageLabel", tbl_4)
        local v10 = UI_upv_1.Icon("plus", 22, Colors_upv_1.TextDim, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = v8})
        v8 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Text = "", Name = "Name", TextSize = 13, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 59), Size = UDim2.fromOffset(76, 16), FontFace = Fonts_upv_1.Bold, TextColor3 = Colors_upv_1.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v6})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.3).Parent = v8
        local v11 = crown(v6, 28)
        v11.AnchorPoint = Vector2.new(0.5, 0.5)
        v11.Position = UDim2.new(0.13, 0, 0.12, 0)
        v11.Visible = false
        local tbl_5 = {}
        tbl_5.btn = v6
        tbl_5.ring = v9
        tbl_5.img = v7
        tbl_5.plus = v10
        tbl_5.name = v8
        tbl_5.crown = v11
        return tbl_5
    end
    tbl_upv_3[1] = makeSeat(1)
    tbl_upv_3[2] = makeSeat(2)
    tbl_upv_3[3] = makeSeat(3)
    local SettingsStore_upv_1 = require(script.Parent.Parent:WaitForChild("SettingsStore"))
    local MatchPrefs_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("MatchPrefs"))
    local tbl_upv_6 = {}
    tbl_upv_6.Name = "PremiumPill"
    tbl_upv_6.AnchorPoint = Vector2.new(1, 0)
    tbl_upv_6.Position = UDim2.new(1, 0, 0, 0)
    tbl_upv_6.Size = UDim2.fromOffset(0, 26)
    tbl_upv_6.AutomaticSize = Enum.AutomaticSize.X
    tbl_upv_6.BackgroundColor3 = Colors_upv_1.Panel
    tbl_upv_6.BackgroundTransparency = 0.1
    tbl_upv_6.Visible = false
    tbl_upv_6[1], tbl_upv_6[2], tbl_upv_6[3] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 12, 0, 5), UI_upv_1.List(Enum.FillDirection.Horizontal, 7, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)
    tbl_upv_6.Parent = u5
    local u8 = UI_upv_1.new("Frame", tbl_upv_6)
    local u9 = UI_upv_1.Stroke(Colors_upv_1.Gold, 1.5, 0.15)
    u9.Parent = u8
    tbl_upv_6 = UI_upv_1.new("ImageLabel", {Image = "rbxasset://textures/ui/common/robux@3x.png", Name = "Robux", LayoutOrder = 1, BackgroundTransparency = 1, Size = UDim2.fromOffset(18, 18), ImageColor3 = Colors_upv_1.Gold, ScaleType = Enum.ScaleType.Fit, Parent = u8})
    local u10 = UI_upv_1.new("Frame", {Name = "Alert", Size = UDim2.fromOffset(18, 18), BackgroundColor3 = Colors_upv_1.Danger, LayoutOrder = 1, Visible = false, [1] = UI_upv_1.Corner(18), Parent = u8})
    local v12 = Color3.fromRGB(255, 255, 255)
    UI_upv_1.new("Frame", {Name = "Bar", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 4), Size = UDim2.fromOffset(3, 7), BackgroundColor3 = v12, [1] = UI_upv_1.Corner(2), Parent = u10})
    UI_upv_1.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 12), Size = UDim2.fromOffset(3, 3), BackgroundColor3 = v12, [1] = UI_upv_1.Corner(2), Parent = u10})
    local u11 = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Text = "PREMIUM ONLY QUEUE", Name = "Text", TextSize = 13, BackgroundTransparency = 1, Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Gold, Parent = u8})
    local tbl_upv_7 = {}
    local u12 = {}
    local function paintPremium()
        --[[
          name: paintPremium
          line: 280
          upvalues:
            members (copy, index: 1)
            SettingsStore_upv_1 (copy, index: 2)
            tbl_upv_7 (copy, index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
            Players_upv_1 (copy, index: 5)
            u12 (ref,  index: 6)
            MatchPrefs_upv_1 (copy, index: 7)
            u8 (copy, index: 8)
            u11 (copy, index: 9)
            Colors_upv_1 (copy, index: 10)
            u9 (copy, index: 11)
            tbl_upv_6 (copy, index: 12)
            u10 (copy, index: 13)
            u6 (copy, index: 14)
            u7 (copy, index: 15)
            u5 (copy, index: 16)
            tbl_upv_3 (copy, index: 17)
        ]]
        local v13 = members()
        local v14 = SettingsStore_upv_1.Get("mmPremium") > 0.5
        local v15 = true
        local tbl_8 = {}
        table.clear(tbl_upv_7)
        local v16, v17 = nil, nil
        local v18 = nil
        for _, value_1 in v13 do
            if value_1.userId ~= LocalPlayer_upv_1.UserId then
                v16 = Players_upv_1:GetPlayerByUserId(value_1.userId)
            else
                v16 = LocalPlayer_upv_1
            end
            if v16 ~= nil then
                v17 = nil
            else
                v17 = u12[value_1.userId]
            end
            if v16 and v16 ~= LocalPlayer_upv_1 and v16:GetAttribute(MatchPrefs_upv_1.PREMIUM_WANT_ATTR) == true or v17 == "want" then
                v14 = true
            end
            if v16 then
                v18 = v16:GetAttribute(MatchPrefs_upv_1.PREMIUM_ATTR) == true
            else
                v18 = v17 ~= nil
            end
            if v18 then
                continue
            end
            v15 = false
            if v16 == LocalPlayer_upv_1 then
                continue
            end
            if value_1.present then
                table.insert(tbl_8, value_1)
                tbl_upv_7[value_1.userId] = true
            end
        end
        local v19 = (SettingsStore_upv_1.Get("mmPremium") > 0.5) and (LocalPlayer_upv_1:GetAttribute(MatchPrefs_upv_1.PREMIUM_ATTR) == true)
        local v20 = v14 and v15
        v14 = v19 and (not v15 and (#tbl_8 > 0))
        u8.Visible = v20 or v14
        if v20 then
            u11.Text = "PREMIUM ONLY QUEUE"
            u11.TextColor3 = Colors_upv_1.Gold
            u9.Color = Colors_upv_1.Gold
            tbl_upv_6.Visible = true
            u10.Visible = false
        elseif v14 then
            local v21
            if #tbl_8 ~= 1 then
                v21 = string.format("PREMIUM ONLY QUEUE OFF: %d MEMBERS AREN'T PREMIUM", #tbl_8)
            else
                v21 = string.format("PREMIUM ONLY QUEUE OFF: %s ISN'T PREMIUM", string.upper(tbl_8[1].name or "A MEMBER"))
            end
            u11.Text = v21
            u11.TextColor3 = Colors_upv_1.Danger
            u9.Color = Colors_upv_1.Danger
            tbl_upv_6.Visible = false
            u10.Visible = true
        end
        local v22 = ((u8.Visible) and 34) or 0
        u6.Position = UDim2.new(1, -2, 0, v22)
        u7.Position = UDim2.fromOffset(0, v22 + 32)
        u5.Size = UDim2.fromOffset(188, v22 + 108)
        local v23 = nil
        for key_1, value_2 in tbl_upv_3 do
            local v24 = v13[key_1]
            if not (v24) then
                continue
            end
            local v25 = v14 and (tbl_upv_7[v24.userId] == true)
            local ring_1 = value_2.ring
            if v25 then
                v23 = Colors_upv_1.Danger
                ring_1.Color = v23
                value_2.ring.Transparency = (v25 and 0) or (((v24.userId ~= LocalPlayer_upv_1.UserId) and 0.6) or 0.1)
                continue
            end
            if v24.userId ~= LocalPlayer_upv_1.UserId then
                v23 = Colors_upv_1.Stroke
            else
                v23 = Colors_upv_1.Accent
            end
            ring_1.Color = v23
            value_2.ring.Transparency = (v25 and 0) or (((v24.userId ~= LocalPlayer_upv_1.UserId) and 0.6) or 0.1)
        end
    end
    SettingsStore_upv_1.Changed:Connect(
        function(a9)
            --[[
              line: 337
              upvalues:
                paintPremium (copy, index: 1)
            ]]
            if a9 ~= "mmPremium" then
                return
            end
            paintPremium()
        end
    )
    LocalPlayer_upv_1:GetAttributeChangedSignal(MatchPrefs_upv_1.PREMIUM_ATTR):Connect(paintPremium)
    local u13 = nil
    local function closePop()
        --[[
          name: closePop
          line: 346
          upvalues:
            u13 (ref,  index: 1)
            a1 (copy, index: 2)
        ]]
        if not u13 then
            return
        end
        u13:Destroy()
        u13 = nil
        a1.MenuManager.PopFocus("PartyPop")
    end
    local function popDefault()
        --[[
          name: popDefault
          line: 354
          upvalues:
            u13 (ref, index: 1)
        ]]
        if not u13 then
            return nil
        end
        local v26 = nil
        local v27 = nil
        for _, value_3 in u13:GetDescendants() do
            local v28 = value_3:IsA("GuiButton")
            if not (v28) or not (value_3.Visible) or not (value_3.Selectable) then
                continue
            end
            if value_3.Name == "Close" then
                v27 = value_3
                continue
            end
            if not (v26) or value_3.AbsolutePosition.Y < v26.AbsolutePosition.Y then
                v26 = value_3
            end
        end
        return v26 or v27
    end
    local function popPanel(a10, a11)
        --[[
          name: popPanel
          line: 373
          upvalues:
            u13 (ref,  index: 1)
            a1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            u4 (copy, index: 4)
        ]]
        if u13 then
            u13:Destroy()
            u13 = nil
            a1.MenuManager.PopFocus("PartyPop")
        end
        local v29 = UI_upv_1.Panel({StrokeTransparency = 0.8, ZIndex = 20, BackgroundTransparency = 0.04, Name = a10, Size = UDim2.fromOffset(a11.X, a11.Y), Parent = u4})
        UI_upv_1.DropShadow(v29, 12, 5, 0.4)
        u13 = v29
        return v29
    end
    local function placePop(a12)
        --[[
          name: placePop
          line: 415
          upvalues:
            u5 (copy, index: 1)
            a1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            popDefault (copy, index: 4)
            u13 (ref,  index: 5)
        ]]
        local AbsolutePosition_1 = u5.AbsolutePosition
        local v30 = math.max(UI_upv_1.Scale, 0.01)
        local AbsolutePosition_2 = a1.Canvas.HUD.AbsolutePosition
        local v31 = (AbsolutePosition_1.X - AbsolutePosition_2.X) / v30
        local v32 = (AbsolutePosition_1.Y - AbsolutePosition_2.Y) / v30
        if UI_upv_1.Compact then
            a12.AnchorPoint = Vector2.new(1, 0)
            a12.Position = UDim2.fromOffset(v31 - 12, math.max(UI_upv_1.TopInset(), v32 - 60))
        else
            a12.AnchorPoint = Vector2.new(1, 1)
            a12.Position = UDim2.fromOffset(v31 + (u5.AbsoluteSize.X / v30), v32 + 24)
        end
        UI_upv_1.Enter(a12, Vector2.new(0, 10))
        a1.MenuManager.PushFocus(
            "PartyPop",
            popDefault,
            function()
                --[[
                  line: 431
                  upvalues:
                    u13 (ref,  index: 1)
                    a1 (copy, index: 2)
                ]]
                if u13 then
                    u13:Destroy()
                    u13 = nil
                    a1.MenuManager.PopFocus("PartyPop")
                end
                return true
            end
        )
    end
    local u14 = nil
    local function inviteStatus(a13)
        --[[
          name: inviteStatus
          line: 440
          upvalues:
            u1 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
        ]]
        if u1.party == false then
            local v33 = u1.outgoing[tostring(a13)]
            local v34 = nil
            if type(v33) == "number" then
                v34 = math.max(0, math.ceil(v33 - State_upv_1.Now()))
                if v34 > 0 then
                    return string.format("INVITED 0:%02d", v34), false
                end
            end
            if u1.canInvite then
                return "INVITE", true
            end
            return "INVITE", false
        else
            for _, value_4 in u1.party.members do
                if value_4.userId ~= a13 then
                    continue
                end
                return "IN PARTY", false
            end
            local v33 = u1.outgoing[tostring(a13)]
            local v34 = nil
            if type(v33) == "number" then
                v34 = math.max(0, math.ceil(v33 - State_upv_1.Now()))
                if v34 > 0 then
                    return string.format("INVITED 0:%02d", v34), false
                end
            end
            if u1.canInvite then
                return "INVITE", true
            end
            return "INVITE", false
        end
    end
    local u15 = {}
    local u16 = 0
    local tbl_upv_9 = {}
    local tbl_upv_10 = {}
    local function isFriend(a14)
        --[[
          name: isFriend
          line: 470
          upvalues:
            tbl_upv_9 (copy, index: 1)
            tbl_upv_10 (copy, index: 2)
        ]]
        local v35 = tbl_upv_9[a14]
        if v35 == nil then
            if not (tbl_upv_10[a14]) then
                tbl_upv_10[a14] = true
                task.spawn(function() end)
            end
            return false
        end
        return v35
    end
    local function action(...)
        --[[
          name: action
          line: 70
          upvalues:
            a1 (copy, index: 1)
        ]]
        local v36, v37, v38 = a1.Remotes.Invoke("PartyAction", ...)
        if v36 then
            if v37 == true then
                return true
            end
            if v38 then
                a1.Toast(tostring(v38), "error")
            end
        else
            a1.Toast("Server unavailable", "error")
        end
        return false
    end
    local function makeRow(a15, a16, a17, a18)
        --[[
          name: makeRow
          line: 491
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            u14 (ref,  index: 4)
            tbl_upv_2 (copy, index: 5)
            Fonts_upv_1 (copy, index: 7)
            action (copy, index: 8)
            a1 (copy, index: 9)
        ]]
        local v39 = UI_upv_1.new("Frame", {Name = "P" .. a15, Size = UDim2.new(1, -8, 0, 54), BackgroundColor3 = Colors_upv_1.PanelHi, BackgroundTransparency = 0.35, LayoutOrder = a18, ZIndex = 21, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Medium), Parent = u14.list})
        local v40 = UI_upv_1.new("ImageLabel", {Position = UDim2.fromOffset(8, 7), Size = UDim2.fromOffset(40, 40), BackgroundColor3 = Colors_upv_1.Panel, ZIndex = 22, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v39})
        local v41 = tbl_upv_2[a15]
        if v41 then
            v40.Image = v41
        else
            v40.Image = ""
            task.spawn(function() end)
        end
        local v42 = UI_upv_1.Stroke(Colors_upv_1.Success, 1.5, 0.15)
        v42.Enabled = false
        v42.Parent = v39
        local v43 = UI_upv_1.new("TextLabel", {Name = "FriendTag", Position = UDim2.fromOffset(58, 29), Size = UDim2.fromOffset(54, 17), Text = "FRIEND", FontFace = Fonts_upv_1.Heavy, TextSize = 11, TextColor3 = Colors_upv_1.TextDark, BackgroundColor3 = Colors_upv_1.Success, BackgroundTransparency = 0, Visible = false, ZIndex = 22, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v39})
        UI_upv_1.new("TextLabel", {AutoLocalize = false, ZIndex = 22, TextSize = 17, Position = UDim2.fromOffset(58, 7), Size = UDim2.new(1, -196, 0, 22), Text = a16, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v39})
        local new_1 = UI_upv_1.new
        local tbl_11 = {FontFace = 0, AutoLocalize = 0, TextColor3 = 0, Parent = 0, TextXAlignment = 0, TextTruncate = 0, ZIndex = 22, TextSize = 13}
        tbl_11.Position = UDim2.fromOffset(58, 28)
        tbl_11.Size = UDim2.new(1, -196, 0, 18)
        tbl_11.Text = a17
        tbl_11.AutoLocalize = string.sub(a17, 1, 1) ~= "@"
        tbl_11.FontFace = Fonts_upv_1.Medium
        tbl_11.TextColor3 = Colors_upv_1.TextMuted
        tbl_11.TextXAlignment = Enum.TextXAlignment.Left
        tbl_11.TextTruncate = Enum.TextTruncate.AtEnd
        tbl_11.Parent = v39
        local v45 = new_1("TextLabel", tbl_11)
        local function OnClick_1()
            --[[
              name: OnClick
              line: 566
              upvalues:
                action (copy, index: 1)
                a15 (copy, index: 2)
                a1 (copy, index: 3)
                a16 (copy, index: 4)
            ]]
            if not action("Invite", a15) then
                return
            end
            a1.Toast(("Invite sent to %*"):format(a16), "success")
        end
        local v46 = UI_upv_1.Button({Text = "INVITE", Name = "Invite", Style = "Primary", ZIndex = 22, TextSize = 15, Size = UDim2.fromOffset(122, 40), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Parent = v39, OnClick = OnClick_1})
        v46.Instance.ZIndex = 22
        for _, value_5 in v46.Instance:GetDescendants() do
            if value_5:IsA("GuiObject") then
                value_5.ZIndex = 23
            end
        end
        local tbl_12 = {friend = false}
        tbl_12.frame = v39
        tbl_12.button = v46
        tbl_12.stroke = v42
        tbl_12.tag = v43
        tbl_12.sub = v45
        return tbl_12
    end
    local function paintButton(a19, a20, a21)
        --[[
          name: paintButton
          line: 593
        ]]
        a19.button:SetText(a20)
        a19.button:SetEnabled(a21)
        local button_1 = a19.button
        local v47
        if a20 == "INVITE" and (a21) then
            v47 = "Primary"
        else
            v47 = "Dark"
        end
        button_1:SetStyle(v47)
    end
    local function paintFriend(a22, a23)
        --[[
          name: paintFriend
          line: 581
          upvalues:
            Colors_upv_1 (copy, index: 1)
        ]]
        if a22.friend == a23 then
            return
        end
        a22.friend = a23
        a22.stroke.Enabled = a23
        a22.tag.Visible = a23
        local sub_1 = a22.sub
        sub_1.Position = UDim2.fromOffset((a23 and 118) or 58, 28)
        local sub_2 = a22.sub
        sub_2.Size = UDim2.new(1, (a23 and -256) or -196, 0, 18)
        local frame_1 = a22.frame
        local v48
        if a23 then
            v48 = Colors_upv_1.PanelHi:Lerp(Colors_upv_1.Success, 0.14)
        else
            v48 = Colors_upv_1.PanelHi
        end
        frame_1.BackgroundColor3 = v48
    end
    local function refreshInviteList()
        --[[
          name: refreshInviteList
          line: 599
          upvalues:
            u14 (ref,  index: 1)
            Players_upv_1 (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            makeRow (copy, index: 4)
            tbl_upv_9 (copy, index: 5)
            tbl_upv_10 (copy, index: 6)
            refreshInviteList (ref,  index: 7)
            paintFriend (copy, index: 8)
            inviteStatus (copy, index: 9)
            u15 (ref,  index: 10)
        ]]
        if u14 and u14.frame.Parent then
            local tbl_13 = {}
            local v49 = 0
            local v50 = nil
            local v51 = nil
            local v52 = nil
            local v53 = nil
            for _, value_6 in Players_upv_1:GetPlayers() do
                if value_6 == LocalPlayer_upv_1 then
                    continue
                end
                tbl_13[value_6.UserId] = true
                v49 = v49 + 1
                local v54 = u14.rows[value_6.UserId]
                if not (v54) then
                    local v55 = makeRow(value_6.UserId, value_6.DisplayName, "@" .. value_6.Name, v49)
                    u14.rows[value_6.UserId] = v55
                    v54 = v55
                end
                local UserId_upv_1 = value_6.UserId
                local v56 = tbl_upv_9[UserId_upv_1]
                if v56 == nil then
                    if not (tbl_upv_10[UserId_upv_1]) then
                        tbl_upv_10[UserId_upv_1] = true
                        task.spawn(
                            function()
                                --[[
                                  line: 477
                                  upvalues:
                                    LocalPlayer_upv_1 (copy, index: 1)
                                    UserId_upv_1 (copy, index: 2)
                                    tbl_upv_9 (copy, index: 3)
                                    tbl_upv_10 (copy, index: 4)
                                    refreshInviteList (ref,  index: 5)
                                ]]
                                local success_1, v57 = pcall(
                                    function()
                                        --[[
                                          line: 478
                                          upvalues:
                                            LocalPlayer_upv_1 (copy, index: 1)
                                            UserId_upv_1 (copy, index: 2)
                                        ]]
                                        return LocalPlayer_upv_1:IsFriendsWith(UserId_upv_1)
                                    end
                                )
                                tbl_upv_9[UserId_upv_1] = success_1 and (v57 == true)
                                tbl_upv_10[UserId_upv_1] = nil
                                if not tbl_upv_9[UserId_upv_1] then
                                    return
                                end
                                refreshInviteList()
                            end
                        )
                    end
                    v50 = false
                else
                    v50 = v56
                end
                local frame_2 = v54.frame
                if v50 then
                    v51 = 0
                else
                    v51 = 600
                end
                frame_2.LayoutOrder = v51 + v49
                paintFriend(v54, v50)
                local v58, v51 = inviteStatus(value_6.UserId)
                v54.button:SetText(v58)
                v54.button:SetEnabled(v51)
                v53 = v54.button
                if v58 ~= "INVITE" then
                    v52 = "Dark"
                    v53:SetStyle(v52)
                    continue
                end
                if v51 then
                    v52 = "Primary"
                else
                    v52 = "Dark"
                end
                v53:SetStyle(v52)
            end
            for key_2, value_7 in u15 do
                if tbl_13[value_7.userId] then
                    continue
                end
                local v59 = Players_upv_1:GetPlayerByUserId(value_7.userId)
                if v59 then
                    continue
                end
                tbl_13[value_7.userId] = true
                v49 = u14.rows[value_7.userId]
                if not v49 then
                    v49 = makeRow(value_7.userId, value_7.name or "Friend", value_7.where ~= "lobby" and "In a match" or "Another lobby", key_2 + 300)
                    u14.rows[value_7.userId] = v49
                end
                paintFriend(v49, true)
                if value_7.where ~= "lobby" then
                    v49.button:SetText("IN A MATCH")
                    v49.button:SetEnabled(false)
                    v49.button:SetStyle("Dark")
                    continue
                end
                local v60, v61 = inviteStatus(value_7.userId)
                v49.button:SetText(v60)
                v49.button:SetEnabled(v61)
                local button_2 = v49.button
                if v60 ~= "INVITE" then
                    v53 = "Dark"
                    button_2:SetStyle(v53)
                    continue
                end
                if v61 then
                    v53 = "Primary"
                else
                    v53 = "Dark"
                end
                button_2:SetStyle(v53)
            end
            local v63 = 0
            for key_3, value_8 in u14.rows do
                if tbl_13[key_3] then
                    v63 = v63 + 1
                else
                    value_8.frame:Destroy()
                    u14.rows[key_3] = nil
                end
            end
            local empty_1 = u14.empty
            empty_1.Visible = v63 == 0
        else
            u14 = nil
        end
    end
    local function fetchFriends()
        --[[
          name: fetchFriends
          line: 651
          upvalues:
            u16 (ref,  index: 1)
            a1 (copy, index: 2)
            u15 (ref,  index: 3)
            refreshInviteList (ref,  index: 4)
        ]]
        if (os.clock() - u16 < 12) then
            return
        end
        u16 = os.clock()
        task.spawn(
            function()
                --[[
                  line: 656
                  upvalues:
                    a1 (copy, index: 1)
                    u15 (ref,  index: 2)
                    refreshInviteList (ref,  index: 3)
                ]]
                local v64, v65, _, v66 = a1.Remotes.Invoke("PartyAction", "Friends")
                if not v64 or v65 ~= true or type(v66) ~= "table" then
                    return
                end
                u15 = v66
                refreshInviteList()
            end
        )
    end
    local function popTitle(a24, a25)
        --[[
          name: popTitle
          line: 388
          upvalues:
            UI_upv_1 (copy, index: 1)
            Fonts_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            closePop (copy, index: 4)
        ]]
        local v67 = UI_upv_1.new("TextLabel", {Name = "Title", ZIndex = 21, TextSize = 22, Position = UDim2.fromOffset(16, 12), Size = UDim2.new(1, -70, 0, 26), Text = a25, FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = a24})
        UI_upv_1.IconButton({IconName = "cross", Name = "Close", ZIndex = 22, Size = UDim2.fromOffset(38, 38), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Parent = a24, OnClick = closePop})
        return v67
    end
    local function openInviteList()
        --[[
          name: openInviteList
          line: 665
          upvalues:
            u14 (ref,  index: 1)
            u13 (ref,  index: 2)
            a1 (copy, index: 3)
            popPanel (copy, index: 4)
            popTitle (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            Colors_upv_1 (copy, index: 8)
            refreshInviteList (ref,  index: 9)
            fetchFriends (copy, index: 10)
            placePop (copy, index: 11)
        ]]
        if u14 and u14.frame.Parent then
            if u13 then
                u13:Destroy()
                u13 = nil
                a1.MenuManager.PopFocus("PartyPop")
            end
            u14 = nil
            return
        end
        local v68 = popPanel("InviteList", Vector2.new(360, 360))
        popTitle(v68, "INVITE TO PARTY")
        local tbl_14 = {}
        tbl_14.frame = v68
        tbl_14.list = UI_upv_1.new("ScrollingFrame", {Name = "List", Position = UDim2.fromOffset(8, 54), Size = UDim2.new(1, -16, 1, -62), ScrollBarThickness = 4, ZIndex = 21, [1] = UI_upv_1.List(Enum.FillDirection.Vertical, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top), Parent = v68})
        tbl_14.rows = {}
        tbl_14.empty = UI_upv_1.new("TextLabel", {Visible = false, TextWrapped = true, Text = "Nobody else is in this lobby yet. Friends playing Tribes elsewhere show up here too.", ZIndex = 21, Name = "Empty", TextSize = 15, Position = UDim2.fromOffset(16, 70), Size = UDim2.new(1, -32, 0, 60), FontFace = Fonts_upv_1.SemiBold, TextColor3 = Colors_upv_1.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = v68})
        u14 = tbl_14
        refreshInviteList()
        fetchFriends()
        placePop(v68)
    end
    local function openSeatMenu(a26)
        --[[
          name: openSeatMenu
          line: 704
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            u1 (ref,  index: 2)
            action (copy, index: 3)
            popPanel (copy, index: 4)
            popTitle (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            Colors_upv_1 (copy, index: 8)
            u13 (ref,  index: 9)
            a1 (copy, index: 10)
            placePop (copy, index: 11)
        ]]
        local v69 = a26.userId == LocalPlayer_upv_1.UserId
        local tbl_15 = {}
        if (v69) and u1.party ~= false then
            local tbl_16 = {text = "LEAVE PARTY", style = "Danger"}
            function tbl_16.fn()
                --[[
                  name: fn
                  line: 708
                  upvalues:
                    action (copy, index: 1)
                ]]
                action("Leave")
            end
            table.insert(tbl_15, tbl_16)
        else
            local v70 = nil
            if not (v69) then
                v70 = (u1.party ~= false) and (u1.party.leaderId == LocalPlayer_upv_1.UserId)
                if v70 and a26.present then
                    local tbl_17 = {text = "MAKE LEADER", style = "Dark"}
                    function tbl_17.fn()
                        --[[
                          name: fn
                          line: 712
                          upvalues:
                            action (copy, index: 1)
                            a26 (copy, index: 2)
                        ]]
                        action("Promote", a26.userId)
                    end
                    table.insert(tbl_15, tbl_17)
                    local tbl_18 = {text = "REMOVE", style = "Danger"}
                    function tbl_18.fn()
                        --[[
                          name: fn
                          line: 715
                          upvalues:
                            action (copy, index: 1)
                            a26 (copy, index: 2)
                        ]]
                        action("Kick", a26.userId)
                    end
                    table.insert(tbl_15, tbl_18)
                end
            end
        end
        local v71 = popPanel("SeatMenu", Vector2.new(260, ((#tbl_15 * 52) + 62) + (((#tbl_15 ~= 0) and 0) or 30)))
        popTitle(v71, string.upper(a26.name or "Player"))
        if #tbl_15 == 0 then
            local new_2 = UI_upv_1.new
            local tbl_19 = {FontFace = 0, TextColor3 = 0, Parent = 0, Text = 0, TextXAlignment = 0, ZIndex = 21, TextSize = 15}
            tbl_19.Position = UDim2.fromOffset(16, 50)
            tbl_19.Size = UDim2.new(1, -32, 0, 30)
            local userId_1 = a26.userId
            local v72 = u1.party and (u1.party.leaderId)
            local v73
            if userId_1 ~= v72 then
                v73 = ((a26.present) and "In your party") or "Joining..."
            else
                v73 = "Party leader"
            end
            tbl_19.Text = v73
            tbl_19.FontFace = Fonts_upv_1.SemiBold
            tbl_19.TextColor3 = Colors_upv_1.TextDim
            tbl_19.TextXAlignment = Enum.TextXAlignment.Left
            tbl_19.Parent = v71
            new_2("TextLabel", tbl_19)
        end
        for key_4, value_upv_9 in tbl_15 do
            local tbl_20 = {TextSize = 17}
            tbl_20.Name = "Item" .. key_4
            tbl_20.Text = value_upv_9.text
            tbl_20.Style = value_upv_9.style
            tbl_20.Size = UDim2.new(1, -24, 0, 44)
            tbl_20.Position = UDim2.fromOffset(12, ((key_4 - 1) * 52) + 50)
            tbl_20.Parent = v71
            function tbl_20.OnClick()
                --[[
                  name: OnClick
                  line: 744
                  upvalues:
                    u13 (ref,  index: 1)
                    a1 (copy, index: 2)
                    value_upv_9 (copy, index: 3)
                ]]
                if u13 then
                    u13:Destroy()
                    u13 = nil
                    a1.MenuManager.PopFocus("PartyPop")
                end
                value_upv_9.fn()
            end
            local v74 = UI_upv_1.Button(tbl_20)
            for _, value_10 in v74.Instance:GetDescendants() do
                if value_10:IsA("GuiObject") then
                    value_10.ZIndex = 23
                end
            end
            v74.Instance.ZIndex = 22
        end
        placePop(v71)
    end
    local function render()
        --[[
          name: render
          line: 760
          upvalues:
            members (copy, index: 1)
            u1 (ref,  index: 2)
            tbl_upv_3 (copy, index: 3)
            tbl_upv_2 (copy, index: 4)
            LocalPlayer_upv_1 (copy, index: 6)
            a1 (copy, index: 7)
            Colors_upv_1 (copy, index: 8)
            u6 (copy, index: 9)
            u14 (ref,  index: 10)
            refreshInviteList (ref,  index: 11)
            paintPremium (copy, index: 12)
        ]]
        local v75 = members()
        local v76 = u1.max or 3
        local v77 = nil
        local v82 = nil
        for key_5, value_11 in tbl_upv_3 do
            local v78 = v75[key_5]
            value_11.btn.Visible = key_5 <= v76
            if not (v78) then
                value_11.userId = nil
                value_11.img.Visible = false
                local plus_1 = value_11.plus
                plus_1.Visible = u1.canInvite == true
                local name_1 = value_11.name
                local img_1 = ((u1.canInvite) and "INVITE") or ""
                name_1.Text = img_1
                value_11.name.TextColor3 = Colors_upv_1.TextMuted
                value_11.ring.Color = Colors_upv_1.TextMuted
                value_11.ring.Transparency = 0.55
                value_11.crown.Visible = false
                continue
            end
            value_11.userId = v78.userId
            local userId_2 = v78.userId
            local img_1 = value_11.img
            local v79 = tbl_upv_2[userId_2]
            if v79 then
                img_1.Image = v79
            else
                img_1.Image = ""
                task.spawn(function() end)
            end
            value_11.img.Visible = true
            value_11.img.ImageTransparency = ((v78.present) and 0) or 0.55
            value_11.plus.Visible = false
            local name_2 = value_11.name
            if v78.userId ~= LocalPlayer_upv_1.UserId then
                v77 = string.upper(v78.name or "")
            else
                v77 = a1.Loc.T("YOU")
            end
            name_2.Text = v77
            local name_3 = value_11.name
            if v78.present then
                v77 = Colors_upv_1.Text
            else
                v77 = Colors_upv_1.TextMuted
            end
            name_3.TextColor3 = v77
            local ring_2 = value_11.ring
            if v78.userId ~= LocalPlayer_upv_1.UserId then
                v77 = Colors_upv_1.Stroke
            else
                v77 = Colors_upv_1.Accent
            end
            ring_2.Color = v77
            local ring_3 = value_11.ring
            if v78.userId ~= LocalPlayer_upv_1.UserId then
                v77 = 0.6
            else
                v77 = 0.1
            end
            ring_3.Transparency = v77
            local crown_2 = value_11.crown
            v77 = (u1.party ~= false) and (v78.userId == u1.party.leaderId)
            crown_2.Visible = v77
        end
        if u1.party == false then
            u6.Text = "PARTY"
        else
            local v80 = (u1.party ~= false) and (u1.party.leaderId == LocalPlayer_upv_1.UserId)
            local v81
            if v80 then
                v81 = string.format("PARTY  %d/%d", #v75, v76)
            else
                v81 = string.format("PARTY  %d/%d  \194\183  LEADER STARTS", #v75, v76)
            end
            u6.Text = v81
        end
        if u14 then
            refreshInviteList()
        end
        paintPremium()
    end
    for key_upv_6, value_12 in tbl_upv_3 do
        value_12.btn.Activated:Connect(
            function()
                --[[
                  line: 800
                  upvalues:
                    a1 (copy, index: 1)
                    members (copy, index: 2)
                    key_upv_6 (copy, index: 3)
                    u13 (ref,  index: 4)
                    openSeatMenu (copy, index: 5)
                    u1 (ref,  index: 6)
                    openInviteList (copy, index: 7)
                ]]
                a1.Sounds.Play("Click")
                local v82 = members()[key_upv_6]
                if v82 then
                    if u13 and u13.Name == "SeatMenu" then
                        if u13 then
                            u13:Destroy()
                            u13 = nil
                            a1.MenuManager.PopFocus("PartyPop")
                        end
                        return
                    end
                    openSeatMenu(v82)
                elseif u1.canInvite then
                    openInviteList()
                else
                    a1.Toast("Only the party leader can invite", "info")
                end
            end
        )
    end
    local u17 = UI_upv_1.new("Frame", {Name = "PartyInvites", AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(460, 0), AutomaticSize = Enum.AutomaticSize.Y, [1] = UI_upv_1.List(Enum.FillDirection.Vertical, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Bottom), Parent = a1.Canvas.Overlay})
    local tbl_upv_21 = {}
    local tbl_upv_22 = {}
    local function dismiss(a27)
        --[[
          name: dismiss
          line: 832
          upvalues:
            tbl_upv_21 (copy, index: 1)
            tbl_upv_22 (copy, index: 2)
        ]]
        local v83 = tbl_upv_21[a27]
        if not v83 then
            return
        end
        tbl_upv_22[a27] = v83.expiresAt or 0
        v83.frame:Destroy()
        tbl_upv_21[a27] = nil
    end
    local function renderInvites()
        --[[
          name: renderInvites
          line: 840
          upvalues:
            u1 (ref,  index: 1)
            tbl_upv_22 (copy, index: 2)
            tbl_upv_21 (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            u17 (copy, index: 6)
            Theme_upv_1 (copy, index: 7)
            tbl_upv_2 (copy, index: 8)
            Fonts_upv_1 (copy, index: 10)
            a1 (copy, index: 11)
        ]]
        local tbl_23 = {}
        local v84 = u1.invites or {}
        for _, value_13 in v84 do
            if type(value_13) ~= "table" or type(value_13.fromUserId) ~= "number" then
                continue
            end
            if tbl_upv_22[value_13.fromUserId] ~= value_13.expiresAt then
                tbl_23[value_13.fromUserId] = value_13
            end
        end
        for key_7, value_14 in tbl_upv_21 do
            if not (tbl_23[key_7]) then
                value_14.frame:Destroy()
                tbl_upv_21[key_7] = nil
            end
        end
        for key_upv_8, value_15 in tbl_23 do
            local v85 = tbl_upv_21[key_upv_8]
            if v85 then
                v85.expiresAt = value_15.expiresAt
                continue
            end
            local v86 = UI_upv_1.Panel({StrokeThickness = 2, StrokeTransparency = 0.35, BackgroundTransparency = 0.04, Name = "Invite" .. key_upv_8, Size = UDim2.fromOffset(460, 92), StrokeColor = Colors_upv_1.Accent, Parent = u17})
            local v87 = UI_upv_1.new("ImageLabel", {Position = UDim2.fromOffset(14, 14), Size = UDim2.fromOffset(60, 60), BackgroundColor3 = Colors_upv_1.PanelHi, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v86})
            local v88 = tbl_upv_2[key_upv_8]
            if v88 then
                v87.Image = v88
            else
                v87.Image = ""
                task.spawn(function() end)
            end
            UI_upv_1.new("TextLabel", {TextSize = 21, Position = UDim2.fromOffset(86, 16), Size = UDim2.new(1, -250, 0, 26), Text = value_15.fromName or "Someone", FontFace = Fonts_upv_1.Display, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v86})
            local new_3 = UI_upv_1.new
            local tbl_24 = {FontFace = 0, TextColor3 = 0, Parent = 0, Text = 0, TextXAlignment = 0, TextSize = 15}
            tbl_24.Position = UDim2.fromOffset(86, 44)
            tbl_24.Size = UDim2.new(1, -272, 0, 20)
            tbl_24.TextTruncate = Enum.TextTruncate.AtEnd
            tbl_24.Text = ((value_15.remote) and "invite from another lobby") or "invited you to their party"
            tbl_24.FontFace = Fonts_upv_1.SemiBold
            tbl_24.TextColor3 = Colors_upv_1.TextDim
            tbl_24.TextXAlignment = Enum.TextXAlignment.Left
            tbl_24.Parent = v86
            new_3("TextLabel", tbl_24)
            local v89 = UI_upv_1.Button({Style = "Success", Name = "Accept", Text = "ACCEPT", TextSize = 18, Size = UDim2.fromOffset(112, 50), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -66, 0.5, -2), Parent = v86})
            local v90 = UI_upv_1.IconButton({IconName = "cross", Name = "Decline", Size = UDim2.fromOffset(46, 46), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, -2), Parent = v86})
            UI_upv_1.PadCap(Enum.KeyCode.DPadRight, {Height = 22, ZIndex = 5, Position = UDim2.fromOffset(-8, -10), Parent = v89.Instance})
            local v91 = UI_upv_1.new("Frame", {Name = "Timer", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 14, 1, -6), Size = UDim2.new(1, -28, 0, 3), BackgroundColor3 = Colors_upv_1.Accent, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v86})
            v89.Activated:Connect(
                function()
                    --[[
                      line: 923
                      upvalues:
                        a1 (copy, index: 1)
                        key_upv_8 (copy, index: 2)
                        tbl_upv_21 (copy, index: 3)
                        tbl_upv_22 (copy, index: 4)
                    ]]
                    local v92, v93, v94 = a1.Remotes.Invoke("PartyAction", "Respond", key_upv_8, true)
                    if v92 and v93 == true then
                        a1.Sounds.Play("Select")
                        return
                    end
                    local Toast_1 = a1.Toast
                    local v95 = ((not v92) and "Server unavailable") or (tostring(v94 or "That invite is gone"))
                    Toast_1(v95, "error")
                    if v92 then
                        local v96 = key_upv_8
                        local v97 = tbl_upv_21[v96]
                        if v97 then
                            tbl_upv_22[v96] = v97.expiresAt or 0
                            v97.frame:Destroy()
                            tbl_upv_21[v96] = nil
                        end
                    end
                end
            )
            v90.Activated:Connect(
                function()
                    --[[
                      line: 934
                      upvalues:
                        key_upv_8 (copy, index: 1)
                        tbl_upv_21 (copy, index: 2)
                        tbl_upv_22 (copy, index: 3)
                        a1 (copy, index: 4)
                    ]]
                    local v98 = tbl_upv_21[key_upv_8]
                    if v98 then
                        tbl_upv_22[key_upv_8] = v98.expiresAt or 0
                        v98.frame:Destroy()
                        tbl_upv_21[key_upv_8] = nil
                    end
                    task.spawn(a1.Remotes.Invoke, "PartyAction", "Respond", key_upv_8, false)
                end
            )
            UI_upv_1.Enter(v86, Vector2.new(0, 16))
            a1.Sounds.Play("Notify")
            local tbl_25 = {frame = v86, bar = v91, expiresAt = value_15.expiresAt, accept = v89.Instance, at = os.clock()}
            tbl_upv_21[key_upv_8] = tbl_25
            v85 = tbl_25
            v85.expiresAt = value_15.expiresAt
        end
    end
    local tbl_upv_26 = {}
    local function openPlayerCard(a28, a29)
        --[[
          name: openPlayerCard
          line: 950
          upvalues:
            popPanel (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            Theme_upv_1 (copy, index: 4)
            tbl_upv_2 (copy, index: 5)
            Players_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
            closePop (copy, index: 8)
            inviteStatus (copy, index: 9)
            u13 (ref,  index: 10)
            a1 (copy, index: 11)
            action (copy, index: 12)
        ]]
        local u18 = popPanel("PlayerCard", Vector2.new(280, 128))
        local u19 = UI_upv_1.new("ImageLabel", {Position = UDim2.fromOffset(14, 14), Size = UDim2.fromOffset(46, 46), BackgroundColor3 = Colors_upv_1.PanelHi, ZIndex = 21, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u18})
        local UserId_upv_2 = a28.UserId
        local v99 = tbl_upv_2[UserId_upv_2]
        if v99 then
            u19.Image = v99
        else
            u19.Image = ""
            task.spawn(
                function()
                    --[[
                      line: 57
                      upvalues:
                        Players_upv_1 (copy, index: 1)
                        UserId_upv_2 (copy, index: 2)
                        tbl_upv_2 (copy, index: 3)
                        u19 (copy, index: 4)
                    ]]
                    local success_2, v100 = pcall(
                        function()
                            --[[
                              line: 58
                              upvalues:
                                Players_upv_1 (copy, index: 1)
                                UserId_upv_2 (copy, index: 2)
                            ]]
                            return Players_upv_1:GetUserThumbnailAsync(UserId_upv_2, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                        end
                    )
                    if not success_2 or type(v100) ~= "string" then
                        return
                    end
                    tbl_upv_2[UserId_upv_2] = v100
                    if not u19.Parent then
                        return
                    end
                    u19.Image = v100
                end
            )
        end
        UI_upv_1.new("TextLabel", {AutoLocalize = false, ZIndex = 21, TextSize = 18, Position = UDim2.fromOffset(70, 16), Size = UDim2.new(1, -120, 0, 22), Text = a28.DisplayName, FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = u18})
        UI_upv_1.new("TextLabel", {ZIndex = 21, TextSize = 13, Position = UDim2.fromOffset(70, 38), Size = UDim2.new(1, -120, 0, 18), Text = "@" .. a28.Name, FontFace = Fonts_upv_1.Medium, TextColor3 = Colors_upv_1.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = u18})
        UI_upv_1.IconButton({IconName = "cross", Name = "Close", ZIndex = 22, Size = UDim2.fromOffset(34, 34), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Parent = u18, OnClick = closePop})
        local v101, v99 = inviteStatus(a28.UserId)
        local Button_1 = UI_upv_1.Button
        local tbl_27 = {OnClick = 0, Style = 0, Name = "Invite", Position = 0, Parent = 0, Text = 0, TextSize = 16, Size = 0}
        local v102
        if v101 ~= "INVITE" then
            v102 = v101
        else
            v102 = "INVITE TO PARTY"
        end
        tbl_27.Text = v102
        tbl_27.Style = (v99 and "Primary") or "Dark"
        tbl_27.Size = UDim2.new(1, -24, 0, 46)
        tbl_27.Position = UDim2.fromOffset(12, 70)
        tbl_27.Parent = u18
        function tbl_27.OnClick()
            --[[
              name: OnClick
              line: 1004
              upvalues:
                u13 (ref,  index: 1)
                a1 (copy, index: 2)
                action (copy, index: 3)
                a28 (copy, index: 4)
            ]]
            if u13 then
                u13:Destroy()
                u13 = nil
                a1.MenuManager.PopFocus("PartyPop")
            end
            if not action("Invite", a28.UserId) then
                return
            end
            a1.Toast(("Invite sent to %*"):format(a28.DisplayName), "success")
        end
        local v103 = Button_1(tbl_27)
        v103:SetEnabled(v99)
        for _, value_16 in v103.Instance:GetDescendants() do
            if value_16:IsA("GuiObject") then
                value_16.ZIndex = 23
            end
        end
        v103.Instance.ZIndex = 22
        local v104 = math.max(UI_upv_1.Scale, 0.01)
        local AbsolutePosition_3 = a1.Canvas.HUD.AbsolutePosition
        local v105 = UI_upv_1.CanvasSize()
        u18.Position = UDim2.fromOffset(math.clamp(((a29.X - AbsolutePosition_3.X) / v104) + 16, 8, v105.X - 290), math.clamp(((a29.Y - AbsolutePosition_3.Y) / v104) - 60, UI_upv_1.TopInset() + 8, v105.Y - 140))
        UI_upv_1.Enter(u18, Vector2.new(0, 8))
        task.delay(
            6,
            function()
                --[[
                  line: 1028
                  upvalues:
                    u13 (ref,  index: 1)
                    u18 (copy, index: 2)
                    a1 (copy, index: 3)
                ]]
                if u13 ~= u18 or not u13 then
                    return
                end
                u13:Destroy()
                u13 = nil
                a1.MenuManager.PopFocus("PartyPop")
            end
        )
    end
    local function lobbyClickable()
        --[[
          name: lobbyClickable
          line: 1035
          upvalues:
            u1 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        local v106 = (u1.enabled == true) and ((u1.role == "Hub") and (not State_upv_1.InMatch() and ((State_upv_1.Get("CombatMode") ~= true) and (not a1.MenuManager.IsOpen() and (not a1.HudHidden)))))
        return v106
    end
    UserInputService_upv_1.InputBegan:Connect(
        function(a30, a31)
            --[[
              line: 1040
              upvalues:
                tbl_upv_26 (copy, index: 1)
            ]]
            if a31 then
                return
            end
            local UserInputType_1 = a30.UserInputType
            if UserInputType_1 ~= Enum.UserInputType.MouseButton1 and UserInputType_1 ~= Enum.UserInputType.Touch then
                return
            end
            tbl_upv_26[a30] = {pos = Vector2.new(a30.Position.X, a30.Position.Y), t = os.clock()}
        end
    )
    UserInputService_upv_1.InputEnded:Connect(
        function(a32, a33)
            --[[
              line: 1049
              upvalues:
                tbl_upv_26 (copy, index: 1)
                lobbyClickable (copy, index: 2)
                Workspace_upv_1 (copy, index: 3)
                LocalPlayer_upv_1 (copy, index: 4)
                Players_upv_1 (copy, index: 5)
                a1 (copy, index: 6)
                openPlayerCard (copy, index: 7)
                u13 (ref,  index: 8)
            ]]
            local v107 = tbl_upv_26[a32]
            tbl_upv_26[a32] = nil
            if not v107 or a33 or not lobbyClickable() then
                return
            end
            local v108 = Vector2.new(a32.Position.X, a32.Position.Y)
            if (v108 - v107.pos).Magnitude > 10 or os.clock() - v107.t > 0.45 then
                return
            end
            local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
            if not CurrentCamera_1 then
                return
            end
            local v109 = CurrentCamera_1:ScreenPointToRay(v108.X, v108.Y)
            local v110 = RaycastParams.new()
            v110.FilterType = Enum.RaycastFilterType.Exclude
            v110.FilterDescendantsInstances = {LocalPlayer_upv_1.Character}
            local v111 = Workspace_upv_1:Raycast(v109.Origin, v109.Direction * 250, v110)
            v109 = v111 and (v111.Instance:FindFirstAncestorOfClass("Model"))
            while v109 and not v109:FindFirstChildOfClass("Humanoid") do
                if v109.Parent then
                    v109 = v109.Parent:FindFirstAncestorOfClass("Model")
                    continue
                else
                    break
                end
            end
            local v112 = v109 and (Players_upv_1:GetPlayerFromCharacter(v109))
            if (not v112 or v112 == LocalPlayer_upv_1) and u13 then
                if u13.Name ~= "PlayerCard" or not u13 then
                    return
                end
                u13:Destroy()
                u13 = nil
                a1.MenuManager.PopFocus("PartyPop")
            end
            a1.Sounds.Play("Click")
            openPlayerCard(v112, v108)
        end
    )
    local function layout()
        --[[
          name: layout
          line: 1082
          upvalues:
            UI_upv_1 (copy, index: 1)
            u5 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
            u17 (copy, index: 4)
        ]]
        local v113 = UI_upv_1.TopInset()
        if UI_upv_1.Compact then
            u5.AnchorPoint = Vector2.new(1, 0)
            u5.Position = UDim2.new(1, -16, 0, (v113 + (((Theme_upv_1.ShowCurrency) and 60) or 0)) + 160)
            u17.Position = UDim2.new(0.5, 0, 1, -18)
            u17.Size = UDim2.fromOffset(420, 0)
        else
            u5.AnchorPoint = Vector2.new(1, 1)
            u5.Position = UDim2.new(1, -28, 1, -214)
            u17.Position = UDim2.new(0.5, 0, 1, -28)
            u17.Size = UDim2.fromOffset(460, 0)
        end
    end
    layout()
    UI_upv_1.LayoutChanged:Connect(layout)
    UI_upv_1.TopInsetChanged:Connect(layout)
    local function refreshVisible()
        --[[
          name: refreshVisible
          line: 1102
          upvalues:
            u1 (ref,  index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            u3 (copy, index: 4)
            u4 (copy, index: 5)
            u17 (copy, index: 6)
            u13 (ref,  index: 7)
        ]]
        local v114 = (u1.enabled == true) and ((u1.role == "Hub") and (not State_upv_1.InMatch() and (not a1.HudHidden)))
        u3.Visible = v114
        u4.Visible = v114
        u17.Visible = v114
        if (v114) or not u13 then
            return
        end
        u13:Destroy()
        u13 = nil
        a1.MenuManager.PopFocus("PartyPop")
    end
    local v115 = (u1.enabled == true) and ((u1.role == "Hub") and (not State_upv_1.InMatch() and (not a1.HudHidden)))
    u3.Visible = v115
    u4.Visible = v115
    u17.Visible = v115
    if not (v115) and u13 then
        u13:Destroy()
        u13 = nil
        a1.MenuManager.PopFocus("PartyPop")
    end
    State_upv_1.PlayerStateChanged:Connect(refreshVisible)
    a1.HudHiddenChanged:Connect(refreshVisible)
    local u20 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Signal")).new()
    local function apply(a34)
        --[[
          name: apply
          line: 1116
          upvalues:
            u1 (ref,  index: 1)
            u2 (ref,  index: 2)
            render (copy, index: 3)
            renderInvites (copy, index: 4)
            State_upv_1 (copy, index: 5)
            a1 (copy, index: 6)
            u3 (copy, index: 7)
            u4 (copy, index: 8)
            u17 (copy, index: 9)
            u13 (ref,  index: 10)
            u20 (copy, index: 11)
        ]]
        if type(a34) ~= "table" then
            return
        end
        u1 = a34
        u1.outgoing = type(u1.outgoing) ~= "table" and {} or u1.outgoing
        u1.invites = type(u1.invites) ~= "table" and {} or u1.invites
        u2 = os.clock()
        render()
        renderInvites()
        local v118 = (u1.enabled == true) and ((u1.role == "Hub") and (not State_upv_1.InMatch() and (not a1.HudHidden)))
        u3.Visible = v118
        u4.Visible = v118
        u17.Visible = v118
        if not (v118) and u13 then
            u13:Destroy()
            u13 = nil
            a1.MenuManager.PopFocus("PartyPop")
        end
        u20:Fire()
    end
    a1.Remotes.On("PartyState", apply)
    task.defer(
        function()
            --[[
              line: 1130
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.Remotes.Invoke("PartyAction", "Get")
        end
    )
    render()
    UI_upv_1.Every(
        u3,
        0.2,
        function()
            --[[
              line: 1136
              upvalues:
                paintPremium (copy, index: 1)
                State_upv_1 (copy, index: 2)
                tbl_upv_21 (copy, index: 3)
                tbl_upv_22 (copy, index: 4)
                u14 (ref,  index: 5)
                refreshInviteList (ref,  index: 6)
                fetchFriends (copy, index: 7)
            ]]
            paintPremium()
            local v119 = State_upv_1.Now()
            for key_9, value_17 in tbl_upv_21 do
                local v120 = math.max(0, (value_17.expiresAt or v119) - v119)
                value_17.bar.Size = UDim2.new(math.clamp(v120 / 30, 0, 1), -28, 0, 3)
                if not (v120 <= 0) then
                    continue
                end
                local v121 = tbl_upv_21[key_9]
                if v121 then
                    tbl_upv_22[key_9] = v121.expiresAt or 0
                    v121.frame:Destroy()
                    tbl_upv_21[key_9] = nil
                end
            end
            if not u14 then
                return
            end
            refreshInviteList()
            fetchFriends()
        end
    )
    Players_upv_1.PlayerRemoving:Connect(
        function()
            --[[
              line: 1151
              upvalues:
                u14 (ref, index: 1)
                refreshInviteList (ref, index: 2)
            ]]
            task.defer(
                function()
                    --[[
                      line: 1152
                      upvalues:
                        u14 (ref, index: 1)
                        refreshInviteList (ref, index: 2)
                    ]]
                    if not u14 then
                        return
                    end
                    refreshInviteList()
                end
            )
        end
    )
    Players_upv_1.PlayerAdded:Connect(
        function()
            --[[
              line: 1158
              upvalues:
                u14 (ref, index: 1)
                refreshInviteList (ref, index: 2)
            ]]
            if not u14 then
                return
            end
            refreshInviteList()
        end
    )
    a1.Debug.party = function(a35, a36)
        --[[
          line: 1164
          upvalues:
            openInviteList (copy, index: 1)
            u13 (ref,  index: 2)
            a1 (copy, index: 3)
            apply (copy, index: 4)
            u12 (ref,  index: 5)
            paintPremium (copy, index: 6)
            u15 (ref,  index: 7)
            u16 (ref,  index: 8)
            refreshInviteList (ref,  index: 9)
            u1 (ref,  index: 10)
            u2 (ref,  index: 11)
            members (copy, index: 12)
        ]]
        if a35 == "open" then
            openInviteList()
        elseif a35 ~= "close" then
            if a35 == "mock" then
                apply(a36)
            elseif a35 == "premiumMock" then
                local v122
                if type(a36) ~= "table" then
                    v122 = {}
                else
                    v122 = a36
                end
                u12 = v122
                paintPremium()
            elseif a35 == "friends" then
                local v122
                if type(a36) ~= "table" then
                    v122 = {}
                else
                    v122 = a36
                end
                u15 = v122
                u16 = os.clock()
                refreshInviteList()
            end
        elseif u13 then
            u13:Destroy()
            u13 = nil
            a1.MenuManager.PopFocus("PartyPop")
        end
        local tbl_28 = {pop = 0}
        tbl_28.state = u1
        tbl_28.age = os.clock() - u2
        tbl_28.seats = #members()
        local v123
        if u13 then
            v123 = u13.Name
        else
            v123 = false
        end
        tbl_28.pop = v123
        return tbl_28
    end
    local function Size()
        --[[
          name: Size
          line: 1186
          upvalues:
            u1 (ref, index: 1)
        ]]
        if u1.party ~= false and type(u1.party) == "table" and type(u1.party.members) == "table" then
            return (math.max(1, #u1.party.members))
        end
        return 1
    end
    local function PadTarget()
        --[[
          name: PadTarget
          line: 1191
          upvalues:
            tbl_upv_21 (copy, index: 1)
            u17 (copy, index: 2)
        ]]
        local v124 = nil
        for _, value_18 in tbl_upv_21 do
            if value_18.frame.Parent and (not (v124) or v124.at < value_18.at) then
                v124 = value_18
            end
        end
        if v124 and u17.Visible then
            return v124.accept
        end
        return nil
    end
    a1.Party = {Root = u3, Row = u5, Size = Size, Changed = u20, PadTarget = PadTarget}
end
return tbl_1