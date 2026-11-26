local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")

return {
    Init = (function(a4)
        --[[
          name: Init
          line: 35
          upvalues:
            players (copy, index: 1)
            userInputService (copy, index: 2)
            workspace (copy, index: 3)
        ]]
        local ui = a4.UI
        local theme = a4.Theme
        local state = a4.State
        local colors = theme.Colors
        local fonts = theme.Fonts
        local localPlayer = players.LocalPlayer
        local state2 = {enabled = false, party = false, max = 3, canInvite = false, role = "Hub", serverNow = 0, invites = {}, outgoing = {}}
        local timestamp = os.clock()
        local ui2 = ui.new("Frame", {Name = "PartyHud", Size = UDim2.fromScale(1, 1), Parent = a4.Canvas.HUD})
        local parent = ui.new("Frame", {Name = "PartyPop", ZIndex = 10, Size = UDim2.fromScale(1, 1), Parent = a4.Canvas.HUD})
        local v15 = {}

        local function headshot(userId, a18)
            --[[
              name: headshot
              line: 50
              upvalues:
                v15 (copy, index: 1)
                players (copy, index: 2)
            ]]
            if const image = v15[userId] then
                a18.Image = image
                return
            end

            a18.Image = ""

            task.spawn(
                function()
                    --[[
                      line: 57
                      upvalues:
                        players (copy, index: 1)
                        userId (copy, index: 2)
                        v15 (copy, index: 3)
                        a18 (copy, index: 4)
                    ]]
                    local success, image = pcall(
                        function()
                            --[[
                              line: 58
                              upvalues:
                                players (copy, index: 1)
                                userId (copy, index: 2)
                            ]]
                            return players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                        end
                    )

                    if success and type(image) == "string" then
                        v15[userId] = image

                        if a18.Parent then
                            a18.Image = image
                        end
                    end
                end
            )
        end

        local function action(...)
            --[[
              name: action
              line: 70
              upvalues:
                a4 (copy, index: 1)
            ]]
            local v23, v24, v25 = a4.Remotes.Invoke("PartyAction", ...)
            if not v23 then
                a4.Toast("Server unavailable", "error")
                return false
            end

            if v24 == true then
                return true
            end

            if v25 then
                a4.Toast(tostring(v25), "error")
            end

            return false
        end

        local function isLeader()
            --[[
              name: isLeader
              line: 85
              upvalues:
                state2 (ref,  index: 1)
                localPlayer (copy, index: 2)
            ]]
            return state2.party ~= false and state2.party.leaderId == localPlayer.UserId
        end

        local function members()
            --[[
              name: members
              line: 89
              upvalues:
                state2 (ref,  index: 1)
                localPlayer (copy, index: 2)
            ]]
            if state2.party == false then
                return {{present = true, userId = localPlayer.UserId, name = localPlayer.DisplayName, username = localPlayer.Name}}
            end

            local values = table.clone(state2.party.members)

            table.sort(
                values,
                function(left, right)
                    --[[
                      line: 94
                      upvalues:
                        state2 (ref, index: 1)
                    ]]
                    local v31 = left.userId == state2.party.leaderId
                    local v32 = right.userId == state2.party.leaderId

                    if v31 ~= v32 then
                        return v31
                    end

                    return false
                end
            )

            return values
        end

        local function crown(parent, textSize: number)
            --[[
              name: crown
              line: 106
              upvalues:
                ui (copy, index: 1)
            ]]
            return ui.new("TextLabel", {Name = "Crown", Text = "👑", TextScaled = false, Rotation = -30, ZIndex = 5, Size = UDim2.fromOffset(textSize, textSize), TextSize = textSize, Parent = parent})
        end

        local ui3 = ui.new("Frame", {Name = "PartyRow", AnchorPoint = Vector2.new(1, 1), Size = UDim2.fromOffset(188, 108), Parent = ui2})
        local parent2 = ui.new("TextLabel", {Name = "Caption", Text = "PARTY", TextSize = 14, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -2, 0, 0), Size = UDim2.fromOffset(320, 16), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = ui3})
        ui.TextStroke(colors.Void, 1.5, 0.35).Parent = parent2
        local parent3 = ui.new("Frame", {Name = "Seats", Position = UDim2.fromOffset(0, 32), Size = UDim2.new(1, 0, 0, 76), (ui.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Top)), Parent = ui3})
        local v39 = {}

        local function makeSeat(layoutOrder: number)
            --[[
              name: makeSeat
              line: 151
              upvalues:
                ui (copy, index: 1)
                parent3 (copy, index: 2)
                colors (copy, index: 3)
                theme (copy, index: 4)
                fonts (copy, index: 5)
                crown (copy, index: 6)
            ]]
            local ui2 = ui.new("TextButton", {Text = "", Name = "Seat" .. layoutOrder, Size = UDim2.fromOffset(56, 76), LayoutOrder = layoutOrder, Parent = parent3})
            local parent = ui.new("Frame", {Name = "Circle", Size = UDim2.fromOffset(56, 56), BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.15, (ui.Corner(theme.Radius.Pill)), Parent = ui2})
            local ring = ui.Stroke(colors.Stroke, 2, 0.75)
            ring.Parent = parent
            local img = ui.new("ImageLabel", {Name = "Headshot", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Image = "", (ui.Corner(theme.Radius.Pill)), Parent = parent})
            local plus = ui.Icon("plus", 22, colors.TextDim, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = parent})
            local ui3 = ui.new("TextLabel", {Name = "Name", AutoLocalize = false, Text = "", TextSize = 13, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 59), Size = UDim2.fromOffset(76, 16), FontFace = fonts.Bold, TextColor3 = colors.Text, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui2})
            ui.TextStroke(colors.Void, 1.5, 0.3).Parent = ui3
            local crown2 = crown(ui2, 28)
            crown2.AnchorPoint = Vector2.new(0.5, 0.5)
            crown2.Position = UDim2.new(0.13, 0, 0.12, 0)
            crown2.Visible = false

            return {userId = nil, btn = ui2, ring = ring, img = img, plus = plus, name = ui3, crown = crown2}
        end

        v39[1] = makeSeat(1)
        v39[2] = makeSeat(2)
        v39[3] = makeSeat(3)
        local SettingsStore = require(script.Parent.Parent:WaitForChild("SettingsStore"))
        local MatchPrefs = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("MatchPrefs"))
        local parent4 = ui.new("Frame", {Name = "PremiumPill", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = colors.Panel, BackgroundTransparency = 0.1, Visible = false, ui.Corner(theme.Radius.Pill), ui.Padding(0, 12, 0, 5), (ui.List(Enum.FillDirection.Horizontal, 7, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)), Parent = ui3})
        local v52 = ui.Stroke(colors.Gold, 1.5, 0.15)
        v52.Parent = parent4
        local ui4 = ui.new("ImageLabel", {Name = "Robux", BackgroundTransparency = 1, Image = "rbxasset://textures/ui/common/robux@3x.png", LayoutOrder = 1, Size = UDim2.fromOffset(18, 18), ImageColor3 = colors.Gold, ScaleType = Enum.ScaleType.Fit, Parent = parent4})
        local parent5 = ui.new("Frame", {Name = "Alert", Size = UDim2.fromOffset(18, 18), BackgroundColor3 = colors.Danger, LayoutOrder = 1, Visible = false, (ui.Corner(18)), Parent = parent4})
        local backgroundColor3 = Color3.fromRGB(255, 255, 255)
        ui.new("Frame", {Name = "Bar", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 4), Size = UDim2.fromOffset(3, 7), BackgroundColor3 = backgroundColor3, (ui.Corner(2)), Parent = parent5})
        ui.new("Frame", {Name = "Dot", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 12), Size = UDim2.fromOffset(3, 3), BackgroundColor3 = backgroundColor3, (ui.Corner(2)), Parent = parent5})
        local ui5 = ui.new("TextLabel", {Name = "Text", BackgroundTransparency = 1, Text = "PREMIUM ONLY QUEUE", TextSize = 13, LayoutOrder = 2, Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Heavy, TextColor3 = colors.Gold, Parent = parent4})
        local v57 = {}
        local v58 = {}

        local function paintPremium()
            --[[
              name: paintPremium
              line: 280
              upvalues:
                members (copy, index: 1)
                SettingsStore (copy, index: 2)
                v57 (copy, index: 3)
                localPlayer (copy, index: 4)
                players (copy, index: 5)
                v58 (ref,  index: 6)
                MatchPrefs (copy, index: 7)
                parent4 (copy, index: 8)
                ui5 (copy, index: 9)
                colors (copy, index: 10)
                v52 (copy, index: 11)
                ui4 (copy, index: 12)
                parent5 (copy, index: 13)
                parent2 (copy, index: 14)
                parent3 (copy, index: 15)
                ui3 (copy, index: 16)
                v39 (copy, index: 17)
            ]]
            local v60 = members()
            local v61 = 0.5 < SettingsStore.Get("mmPremium")
            local v62 = true
            local v63 = {}
            table.clear(v57)

            for _, v65 in v60 do
                local player = if v65.userId == localPlayer.UserId then localPlayer else players:GetPlayerByUserId(v65.userId)
                local v67 = if player == nil then v58[v65.userId] else nil

                if not player or player == localPlayer or player:GetAttribute(MatchPrefs.PREMIUM_WANT_ATTR) ~= true then
                    if v67 == "want" then
                        v61 = true
                    end
                else
                    v61 = true
                end

                local v68 = if player then player:GetAttribute(MatchPrefs.PREMIUM_ATTR) == true else v67 ~= nil
                if not v68 then
                    local v69 = false

                    if player == localPlayer then
                        v62 = v69
                    elseif v65.present then
                        table.insert(v63, v65)
                        v57[v65.userId] = true
                        v62 = v69
                    else
                        v62 = v69
                    end
                end
            end

            local v70 = 0.5 < SettingsStore.Get("mmPremium")
                and localPlayer:GetAttribute(MatchPrefs.PREMIUM_ATTR) == true
            local v71 = v61 and v62
            local v72 = v70 and not v62 and 0 < #v63
            parent4.Visible = v71 or v72

            if v71 then
                ui5.Text = "PREMIUM ONLY QUEUE"
                ui5.TextColor3 = colors.Gold
                v52.Color = colors.Gold
                ui4.Visible = true
                parent5.Visible = false
            elseif v72 then
                ui5.Text = if #v63 == 1 then string.format("PREMIUM ONLY QUEUE OFF: %s ISN'T PREMIUM", string.upper(v63[1].name
                    or "A MEMBER")) else string.format("PREMIUM ONLY QUEUE OFF: %d MEMBERS AREN'T PREMIUM", #v63)
                ui5.TextColor3 = colors.Danger
                v52.Color = colors.Danger
                ui4.Visible = false
                parent5.Visible = true
            end

            local v73 = parent4.Visible and 34 or 0
            parent2.Position = UDim2.new(1, -2, 0, v73)
            parent3.Position = UDim2.fromOffset(0, v73 + 32)
            ui3.Size = UDim2.fromOffset(188, v73 + 108)

            for v74, v75 in v39 do
                if const v76 = v60[v74] then
                    local v77
                    local v78 = v72 and v57[v76.userId] == true
                    local ring = v75.ring

                    if v78 then
                        v77 = colors.Danger
                    else
                        v77 = if v76.userId == localPlayer.UserId then colors.Accent else colors.Stroke
                    end

                    ring.Color = v77
                    v75.ring.Transparency = v78 and 0 or v76.userId ~= localPlayer.UserId and 0.6 or 0.1
                end
            end
        end

        SettingsStore.Changed:Connect(
            function(a80)
                --[[
                  line: 337
                  upvalues:
                    paintPremium (copy, index: 1)
                ]]
                if a80 == "mmPremium" then
                    paintPremium()
                end
            end
        )

        localPlayer:GetAttributeChangedSignal(MatchPrefs.PREMIUM_ATTR):Connect(paintPremium)
        local v81 = nil

        local function closePop()
            --[[
              name: closePop
              line: 346
              upvalues:
                v81 (ref,  index: 1)
                a4 (copy, index: 2)
            ]]
            if v81 then
                v81:Destroy()
                v81 = nil
                a4.MenuManager.PopFocus("PartyPop")
            end
        end

        local function popDefault()
            --[[
              name: popDefault
              line: 354
              upvalues:
                v81 (ref, index: 1)
            ]]
            local descendant, descendant2
            local v86 = v81
            if not v86 then
                return nil
            end

            descendant, descendant2 = nil, nil

            for _, descendant3 in v86:GetDescendants() do
                if descendant3:IsA("GuiButton") then
                    if not descendant3.Visible then
                        continue
                    end
                    if not descendant3.Selectable then
                        continue
                    end

                    if descendant3.Name == "Close" then
                        descendant2 = descendant3
                    elseif not descendant or descendant3.AbsolutePosition.Y < descendant.AbsolutePosition.Y then
                        descendant = descendant3
                    end
                end
            end

            return descendant or descendant2
        end

        local function popPanel(name: string, vector2: Vector2)
            --[[
              name: popPanel
              line: 373
              upvalues:
                v81 (ref,  index: 1)
                a4 (copy, index: 2)
                ui (copy, index: 3)
                parent (copy, index: 4)
            ]]
            if v81 then
                v81:Destroy()
                v81 = nil
                a4.MenuManager.PopFocus("PartyPop")
            end

            local v92 = ui.Panel({BackgroundTransparency = 0.04, StrokeTransparency = 0.8, ZIndex = 20, Name = name, Size = UDim2.fromOffset(vector2.X, vector2.Y), Parent = parent})
            ui.DropShadow(v92, 12, 5, 0.4)
            v81 = v92

            return v92
        end

        local function popTitle(parent, text: string)
            --[[
              name: popTitle
              line: 388
              upvalues:
                ui (copy, index: 1)
                fonts (copy, index: 2)
                colors (copy, index: 3)
                closePop (copy, index: 4)
            ]]
            local ui2 = ui.new("TextLabel", {Name = "Title", TextSize = 22, ZIndex = 21, Position = UDim2.fromOffset(16, 12), Size = UDim2.new(1, -70, 0, 26), Text = text, FontFace = fonts.Display, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
            ui.IconButton({Name = "Close", IconName = "cross", ZIndex = 22, Size = UDim2.fromOffset(38, 38), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Parent = parent, OnClick = closePop})

            return ui2
        end

        local function placePop(a98)
            --[[
              name: placePop
              line: 415
              upvalues:
                ui3 (copy, index: 1)
                a4 (copy, index: 2)
                ui (copy, index: 3)
                popDefault (copy, index: 4)
                v81 (ref,  index: 5)
            ]]
            local absolutePosition = ui3.AbsolutePosition
            local hud = a4.Canvas.HUD
            local v101 = math.max(ui.Scale, 0.01)
            local absolutePosition2 = hud.AbsolutePosition
            local v103 = (absolutePosition.X - absolutePosition2.X) / v101
            local v104 = v103 + ui3.AbsoluteSize.X / v101
            local v105 = (absolutePosition.Y - absolutePosition2.Y) / v101

            if ui.Compact then
                a98.AnchorPoint = Vector2.new(1, 0)
                a98.Position = UDim2.fromOffset(v103 - 12, (math.max(ui.TopInset(), v105 - 60)))
            else
                a98.AnchorPoint = Vector2.new(1, 1)
                a98.Position = UDim2.fromOffset(v104, v105 + 24)
            end

            ui.Enter(a98, Vector2.new(0, 10))

            a4.MenuManager.PushFocus(
                "PartyPop",
                popDefault,
                function()
                    --[[
                      line: 431
                      upvalues:
                        v81 (ref,  index: 1)
                        a4 (copy, index: 2)
                    ]]
                    if v81 then
                        v81:Destroy()
                        v81 = nil
                        a4.MenuManager.PopFocus("PartyPop")
                    end

                    return true
                end
            )
        end

        local v106 = nil

        local function inviteStatus(userId)
            --[[
              name: inviteStatus
              line: 440
              upvalues:
                state2 (ref,  index: 1)
                state (copy, index: 2)
            ]]
            if state2.party ~= false then
                for _, member in state2.party.members do
                    if member.userId == userId then
                        return "IN PARTY", false
                    end
                end
            end

            local v111 = state2.outgoing[tostring(userId)]

            if type(v111) == "number" then
                local v112 = math.max(0, (math.ceil(v111 - state.Now())))

                if 0 < v112 then
                    return string.format("INVITED 0:%02d", v112), false
                end
            end

            if not state2.canInvite then
                return "INVITE", false
            end

            return "INVITE", true
        end

        local v113 = {}
        local timestamp2 = 0
        local refreshInviteList = nil
        local v116 = {}
        local v117 = {}

        local function isFriend(userId)
            --[[
              name: isFriend
              line: 470
              upvalues:
                v116 (copy, index: 1)
                v117 (copy, index: 2)
                localPlayer (copy, index: 3)
                refreshInviteList (ref,  index: 4)
            ]]
            local v120 = v116[userId]
            if v120 ~= nil then
                return v120
            end

            if not v117[userId] then
                v117[userId] = true

                task.spawn(
                    function()
                        --[[
                          line: 477
                          upvalues:
                            localPlayer (copy, index: 1)
                            userId (copy, index: 2)
                            v116 (copy, index: 3)
                            v117 (copy, index: 4)
                            refreshInviteList (ref,  index: 5)
                        ]]
                        local success, isFriendsWith = pcall(
                            function()
                                --[[
                                  line: 478
                                  upvalues:
                                    localPlayer (copy, index: 1)
                                    userId (copy, index: 2)
                                ]]
                                return localPlayer:IsFriendsWith(userId)
                            end
                        )
                        v116[userId] = success and (isFriendsWith == true)
                        v117[userId] = nil

                        if v116[userId] then
                            refreshInviteList()
                        end
                    end
                )
            end

            return false
        end

        local function makeRow(userId, text, text2, layoutOrder)
            --[[
              name: makeRow
              line: 491
              upvalues:
                ui (copy, index: 1)
                colors (copy, index: 2)
                theme (copy, index: 3)
                v106 (ref,  index: 4)
                v15 (copy, index: 5)
                players (copy, index: 6)
                fonts (copy, index: 7)
                action (copy, index: 8)
                a4 (copy, index: 9)
            ]]
            local ui2 = ui.new("Frame", {Name = "P" .. userId, Size = UDim2.new(1, -8, 0, 54), BackgroundColor3 = colors.PanelHi, BackgroundTransparency = 0.35, LayoutOrder = layoutOrder, ZIndex = 21, (ui.Corner(theme.Radius.Medium)), Parent = v106.list})
            local ui3 = ui.new("ImageLabel", {Position = UDim2.fromOffset(8, 7), Size = UDim2.fromOffset(40, 40), BackgroundColor3 = colors.Panel, ZIndex = 22, (ui.Corner(theme.Radius.Pill)), Parent = ui2})

            if const image = v15[userId] then
                ui3.Image = image
            else
                ui3.Image = ""

                task.spawn(
                    function()
                        --[[
                          line: 57
                          upvalues:
                            players (copy, index: 1)
                            userId (copy, index: 2)
                            v15 (copy, index: 3)
                            ui3 (copy, index: 4)
                        ]]
                        local success, image = pcall(
                            function()
                                --[[
                                  line: 58
                                  upvalues:
                                    players (copy, index: 1)
                                    userId (copy, index: 2)
                                ]]
                                return players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                            end
                        )

                        if success and type(image) == "string" then
                            v15[userId] = image

                            if ui3.Parent then
                                ui3.Image = image
                            end
                        end
                    end
                )
            end

            local stroke = ui.Stroke(colors.Success, 1.5, 0.15)
            stroke.Enabled = false
            stroke.Parent = ui2
            local tag = ui.new("TextLabel", {Name = "FriendTag", Position = UDim2.fromOffset(58, 29), Size = UDim2.fromOffset(54, 17), Text = "FRIEND", FontFace = fonts.Heavy, TextSize = 11, TextColor3 = colors.TextDark, BackgroundColor3 = colors.Success, BackgroundTransparency = 0, Visible = false, ZIndex = 22, (ui.Corner(theme.Radius.Pill)), Parent = ui2})
            ui.new("TextLabel", {AutoLocalize = false, TextSize = 17, ZIndex = 22, Position = UDim2.fromOffset(58, 7), Size = UDim2.new(1, -196, 0, 22), Text = text, FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = ui2})
            local newUi = ui.new
            local v136 = {TextSize = 13, ZIndex = 22, Position = UDim2.fromOffset(58, 28), Size = UDim2.new(1, -196, 0, 18), Text = text2}
            local autoLocalize = string.sub(text2, 1, 1) ~= "@"
            v136.AutoLocalize = autoLocalize
            v136.FontFace = fonts.Medium
            v136.TextColor3 = colors.TextMuted
            v136.TextXAlignment = Enum.TextXAlignment.Left
            v136.TextTruncate = Enum.TextTruncate.AtEnd
            v136.Parent = ui2
            local sub = newUi("TextLabel", v136)

            local button = ui.Button(
                {
                    Name = "Invite",
                    Text = "INVITE",
                    TextSize = 15,
                    Style = "Primary",
                    ZIndex = 22,
                    Size = UDim2.fromOffset(122, 40),
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -8, 0.5, 0),
                    Parent = ui2,
                    OnClick = (function()
                        --[[
                          name: OnClick
                          line: 566
                          upvalues:
                            action (copy, index: 1)
                            userId (copy, index: 2)
                            a4 (copy, index: 3)
                            text (copy, index: 4)
                        ]]
                        if action("Invite", userId) then
                            a4.Toast(`Invite sent to {text}`, "success")
                        end
                    end)
                }
            )

            button.Instance.ZIndex = 22

            for _, descendant in button.Instance:GetDescendants() do
                if descendant:IsA("GuiObject") then
                    descendant.ZIndex = 23
                end
            end

            return {friend = false, frame = ui2, button = button, stroke = stroke, tag = tag, sub = sub}
        end

        local function paintFriend(row, a144)
            --[[
              name: paintFriend
              line: 581
              upvalues:
                colors (copy, index: 1)
            ]]
            if row.friend == a144 then
                return
            end

            row.friend = a144
            row.stroke.Enabled = a144
            row.tag.Visible = a144
            local sub = row.sub
            local v146 = UDim2.fromOffset
            local v147 = a144 and 118 or 58
            sub.Position = v146(v147, 28)
            local sub2 = row.sub
            v146 = UDim2.new
            local v149 = a144 and -256 or -196
            sub2.Size = v146(1, v149, 0, 18)
            row.frame.BackgroundColor3 = if a144 then colors.PanelHi:Lerp(colors.Success, 0.14) else colors.PanelHi
        end

        local function paintButton(a151, text, enabled)
            --[[
              name: paintButton
              line: 593
            ]]
            a151.button:SetText(text)
            a151.button:SetEnabled(enabled)
            local button = a151.button
            local style = text == "INVITE" and enabled and "Primary" or "Dark"
            button:SetStyle(style)
        end

        refreshInviteList = function()
            --[[
              name: refreshInviteList
              line: 599
              upvalues:
                v106 (ref,  index: 1)
                players (copy, index: 2)
                localPlayer (copy, index: 3)
                makeRow (copy, index: 4)
                v116 (copy, index: 5)
                v117 (copy, index: 6)
                refreshInviteList (ref,  index: 7)
                paintFriend (copy, index: 8)
                inviteStatus (copy, index: 9)
                v113 (ref,  index: 10)
            ]]
            if not v106 or not v106.frame.Parent then
                v106 = nil
                return
            end

            local v156
            local v157 = {}
            local count = 0

            for _, player in players:GetPlayers() do
                if player ~= localPlayer then
                    local row
                    v157[player.UserId] = true
                    count += 1

                    if const row2 = v106.rows[player.UserId] then
                        row = row2
                    else
                        row = makeRow(player.UserId, player.DisplayName, "@" .. player.Name, count)
                        v106.rows[player.UserId] = row
                    end

                    local userId = player.UserId
                    local v164 = v116[userId]
                    if v164 == nil then
                        if not v117[userId] then
                            v117[userId] = true

                            task.spawn(
                                function()
                                    --[[
                                      line: 477
                                      upvalues:
                                        localPlayer (copy, index: 1)
                                        userId (copy, index: 2)
                                        v116 (copy, index: 3)
                                        v117 (copy, index: 4)
                                        refreshInviteList (ref,  index: 5)
                                    ]]
                                    local success, isFriendsWith = pcall(
                                        function()
                                            --[[
                                              line: 478
                                              upvalues:
                                                localPlayer (copy, index: 1)
                                                userId (copy, index: 2)
                                            ]]
                                            return localPlayer:IsFriendsWith(userId)
                                        end
                                    )
                                    v116[userId] = success and (isFriendsWith == true)
                                    v117[userId] = nil

                                    if v116[userId] then
                                        refreshInviteList()
                                    end
                                end
                            )
                        end

                        v164 = false
                    end

                    local frame = row.frame
                    local v168 = v164 and 0 or 600
                    frame.LayoutOrder = v168 + count
                    paintFriend(row, v164)
                    local text, enabled = inviteStatus(player.UserId)
                    row.button:SetText(text)
                    row.button:SetEnabled(enabled)
                    local button = row.button
                    local style = text == "INVITE" and enabled and "Primary" or "Dark"
                    button:SetStyle(style)
                end
            end

            for v173, v174 in v113 do
                if not v157[v174.userId] then
                    local row

                    if players:GetPlayerByUserId(v174.userId) then
                        continue
                    end

                    v157[v174.userId] = true

                    if const row3 = v106.rows[v174.userId] then
                        row = row3
                    else
                        local userId = v174.userId
                        local name = v174.name or "Friend"
                        local text = v174.where ~= "lobby" and "In a match" or "Another lobby"
                        row = makeRow(userId, name, text, v173 + 300)
                        v106.rows[v174.userId] = row
                    end

                    paintFriend(row, true)

                    if v174.where == "lobby" then
                        local text, enabled = inviteStatus(v174.userId)
                        row.button:SetText(text)
                        row.button:SetEnabled(enabled)
                        local button = row.button
                        local style = text == "INVITE" and enabled and "Primary" or "Dark"
                        button:SetStyle(style)
                    else
                        row.button:SetText("IN A MATCH")
                        row.button:SetEnabled(false)
                        row.button:SetStyle("Dark")
                    end
                end
            end

            local v184 = 0
            v156 = v184

            for rowKey, row in v106.rows do
                if v157[rowKey] then
                    v156 += 1
                else
                    row.frame:Destroy()
                    v106.rows[rowKey] = nil
                end
            end

            local empty = v106.empty
            local visible = v156 == 0
            empty.Visible = visible
        end

        local function fetchFriends()
            --[[
              name: fetchFriends
              line: 651
              upvalues:
                timestamp2 (ref,  index: 1)
                a4 (copy, index: 2)
                v113 (ref,  index: 3)
                refreshInviteList (ref,  index: 4)
            ]]
            if os.clock() - timestamp2 < 12 then
                return
            end

            timestamp2 = os.clock()

            task.spawn(
                function()
                    --[[
                      line: 656
                      upvalues:
                        a4 (copy, index: 1)
                        v113 (ref,  index: 2)
                        refreshInviteList (ref,  index: 3)
                    ]]
                    local v190, v191, _, v193 = a4.Remotes.Invoke("PartyAction", "Friends")

                    if v190 and v191 == true and type(v193) == "table" then
                        v113 = v193
                        refreshInviteList()
                    end
                end
            )
        end

        local function openInviteList()
            --[[
              name: openInviteList
              line: 665
              upvalues:
                v106 (ref,  index: 1)
                v81 (ref,  index: 2)
                a4 (copy, index: 3)
                popPanel (copy, index: 4)
                popTitle (copy, index: 5)
                ui (copy, index: 6)
                fonts (copy, index: 7)
                colors (copy, index: 8)
                refreshInviteList (ref,  index: 9)
                fetchFriends (copy, index: 10)
                placePop (copy, index: 11)
            ]]
            if not v106 or not v106.frame.Parent then
                local v195 = popPanel("InviteList", Vector2.new(360, 360))
                popTitle(v195, "INVITE TO PARTY")
                v106 = {
                    frame = v195,
                    list = ui.new("ScrollingFrame", {Name = "List", Position = UDim2.fromOffset(8, 54), Size = UDim2.new(1, -16, 1, -62), ScrollBarThickness = 4, ZIndex = 21, (ui.List(Enum.FillDirection.Vertical, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Top)), Parent = v195}),
                    rows = {},
                    empty = ui.new("TextLabel", {Name = "Empty", Text = "Nobody else is in this lobby yet. Friends playing Tribes elsewhere show up here too.", TextWrapped = true, TextSize = 15, ZIndex = 21, Visible = false, Position = UDim2.fromOffset(16, 70), Size = UDim2.new(1, -32, 0, 60), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = v195})
                }
                refreshInviteList()
                fetchFriends()
                placePop(v195)

                return
            end

            if v81 then
                v81:Destroy()
                v81 = nil
                a4.MenuManager.PopFocus("PartyPop")
            end

            v106 = nil
        end

        local function openSeatMenu(seatMenu)
            --[[
              name: openSeatMenu
              line: 704
              upvalues:
                localPlayer (copy, index: 1)
                state2 (ref,  index: 2)
                action (copy, index: 3)
                popPanel (copy, index: 4)
                popTitle (copy, index: 5)
                ui (copy, index: 6)
                fonts (copy, index: 7)
                colors (copy, index: 8)
                v81 (ref,  index: 9)
                a4 (copy, index: 10)
                placePop (copy, index: 11)
            ]]
            local v198 = seatMenu.userId == localPlayer.UserId
            local v199 = {}

            if v198 and state2.party ~= false then
                table.insert(
                    v199,
                    {
                        text = "LEAVE PARTY",
                        style = "Danger",
                        fn = (function()
                            --[[
                              name: fn
                              line: 708
                              upvalues:
                                action (copy, index: 1)
                            ]]
                            action("Leave")
                        end)
                    }
                )
            elseif not v198 then
                local v200 = state2.party ~= false and state2.party.leaderId == localPlayer.UserId

                if v200 and seatMenu.present then
                    table.insert(
                        v199,
                        {
                            text = "MAKE LEADER",
                            style = "Dark",
                            fn = (function()
                                --[[
                                  name: fn
                                  line: 712
                                  upvalues:
                                    action (copy, index: 1)
                                    seatMenu (copy, index: 2)
                                ]]
                                action("Promote", seatMenu.userId)
                            end)
                        }
                    )
                    table.insert(
                        v199,
                        {
                            text = "REMOVE",
                            style = "Danger",
                            fn = (function()
                                --[[
                                  name: fn
                                  line: 715
                                  upvalues:
                                    action (copy, index: 1)
                                    seatMenu (copy, index: 2)
                                ]]
                                action("Kick", seatMenu.userId)
                            end)
                        }
                    )
                end
            end

            local v201 = #v199 * 52 + 62
            local v202 = #v199 ~= 0 and 0 or 30
            local y = v201 + v202
            local parent = popPanel("SeatMenu", Vector2.new(260, y))
            popTitle(parent, string.upper(seatMenu.name or "Player"))

            if #v199 == 0 then
                local newUi = ui.new
                local v206 = {TextSize = 15, ZIndex = 21, Position = UDim2.fromOffset(16, 50), Size = UDim2.new(1, -32, 0, 30)}
                local userId = seatMenu.userId
                local leaderId = state2.party and state2.party.leaderId
                v206.Text = (userId ~= leaderId and (seatMenu.present and "In your party" or "Joining..."))
                    or "Party leader"
                v206.FontFace = fonts.SemiBold
                v206.TextColor3 = colors.TextDim
                v206.TextXAlignment = Enum.TextXAlignment.Left
                v206.Parent = parent
                newUi("TextLabel", v206)
            end

            for v209, v210 in v199 do
                local v211 = ui.Button(
                    {
                        TextSize = 17,
                        Name = "Item" .. v209,
                        Text = v210.text,
                        Style = v210.style,
                        Size = UDim2.new(1, -24, 0, 44),
                        Position = UDim2.fromOffset(12, ((v209 - 1) * 52) + 50),
                        Parent = parent,
                        OnClick = (function()
                            --[[
                              name: OnClick
                              line: 744
                              upvalues:
                                v81 (ref,  index: 1)
                                a4 (copy, index: 2)
                                v210 (copy, index: 3)
                            ]]
                            if v81 then
                                v81:Destroy()
                                v81 = nil
                                a4.MenuManager.PopFocus("PartyPop")
                            end

                            v210.fn()
                        end)
                    }
                )

                for _, descendant in v211.Instance:GetDescendants() do
                    if descendant:IsA("GuiObject") then
                        descendant.ZIndex = 23
                    end
                end

                v211.Instance.ZIndex = 22
            end

            placePop(parent)
        end

        local function render()
            --[[
              name: render
              line: 760
              upvalues:
                members (copy, index: 1)
                state2 (ref,  index: 2)
                v39 (copy, index: 3)
                v15 (copy, index: 4)
                players (copy, index: 5)
                localPlayer (copy, index: 6)
                a4 (copy, index: 7)
                colors (copy, index: 8)
                parent2 (copy, index: 9)
                v106 (ref,  index: 10)
                refreshInviteList (ref,  index: 11)
                paintPremium (copy, index: 12)
            ]]
            local v215 = members()
            local max = state2.max or 3

            for v217, v218 in v39 do
                local v219 = v215[v217]
                v218.btn.Visible = v217 <= max

                if v219 then
                    v218.userId = v219.userId
                    local userId = v219.userId
                    local img = v218.img

                    if const image = v15[userId] then
                        img.Image = image
                    else
                        img.Image = ""

                        task.spawn(
                            function()
                                --[[
                                  line: 57
                                  upvalues:
                                    players (copy, index: 1)
                                    userId (copy, index: 2)
                                    v15 (copy, index: 3)
                                    img (copy, index: 4)
                                ]]
                                local success, image = pcall(
                                    function()
                                        --[[
                                          line: 58
                                          upvalues:
                                            players (copy, index: 1)
                                            userId (copy, index: 2)
                                        ]]
                                        return players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                                    end
                                )

                                if success and type(image) == "string" then
                                    v15[userId] = image

                                    if img.Parent then
                                        img.Image = image
                                    end
                                end
                            end
                        )
                    end

                    v218.img.Visible = true
                    v218.img.ImageTransparency = v219.present and 0 or 0.55
                    v218.plus.Visible = false
                    v218.name.Text = if v219.userId == localPlayer.UserId then a4.Loc.T("YOU") else string.upper((v219.name
                        or ""))
                    v218.name.TextColor3 = if v219.present then colors.Text else colors.TextMuted
                    v218.ring.Color = if v219.userId == localPlayer.UserId then colors.Accent else colors.Stroke
                    v218.ring.Transparency = v219.userId ~= localPlayer.UserId and 0.6 or 0.1
                    v218.crown.Visible = state2.party ~= false and v219.userId == state2.party.leaderId
                else
                    v218.userId = nil
                    v218.img.Visible = false
                    local plus = v218.plus
                    plus.Visible = state2.canInvite == true
                    v218.name.Text = state2.canInvite and "INVITE" or ""
                    v218.name.TextColor3 = colors.TextMuted
                    v218.ring.Color = colors.TextMuted
                    v218.ring.Transparency = 0.55
                    v218.crown.Visible = false
                end
            end

            if state2.party == false then
                parent2.Text = "PARTY"
            else
                local v226 = state2.party ~= false and state2.party.leaderId == localPlayer.UserId
                parent2.Text = if v226 then string.format("PARTY  %d/%d", #v215, max) else string.format("PARTY  %d/%d  ·  LEADER STARTS", #v215, max)
            end

            if v106 then
                refreshInviteList()
            end

            paintPremium()
        end

        for v227, v228 in v39 do
            v228.btn.Activated:Connect(
                function()
                    --[[
                      line: 800
                      upvalues:
                        a4 (copy, index: 1)
                        members (copy, index: 2)
                        v227 (copy, index: 3)
                        v81 (ref,  index: 4)
                        openSeatMenu (copy, index: 5)
                        state2 (ref,  index: 6)
                        openInviteList (copy, index: 7)
                    ]]
                    a4.Sounds.Play("Click")

                    if const seatMenu = members()[v227] then
                        if not v81 or v81.Name ~= "SeatMenu" then
                            openSeatMenu(seatMenu)
                            return
                        end

                        if v81 then
                            v81:Destroy()
                            v81 = nil
                            a4.MenuManager.PopFocus("PartyPop")
                        end
                    elseif state2.canInvite then
                        openInviteList()
                    else
                        a4.Toast("Only the party leader can invite", "info")
                    end
                end
            )
        end

        local parent6 = ui.new("Frame", {Name = "PartyInvites", AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(460, 0), AutomaticSize = Enum.AutomaticSize.Y, (ui.List(Enum.FillDirection.Vertical, 8, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Bottom)), Parent = a4.Canvas.Overlay})
        local v231 = {}
        local v232 = {}

        local function dismiss(key)
            --[[
              name: dismiss
              line: 832
              upvalues:
                v231 (copy, index: 1)
                v232 (copy, index: 2)
            ]]
            if const v235 = v231[key] then
                v232[key] = v235.expiresAt or 0
                v235.frame:Destroy()
                v231[key] = nil
            end
        end

        local function renderInvites()
            --[[
              name: renderInvites
              line: 840
              upvalues:
                state2 (ref,  index: 1)
                v232 (copy, index: 2)
                v231 (copy, index: 3)
                ui (copy, index: 4)
                colors (copy, index: 5)
                parent6 (copy, index: 6)
                theme (copy, index: 7)
                v15 (copy, index: 8)
                players (copy, index: 9)
                fonts (copy, index: 10)
                a4 (copy, index: 11)
            ]]
            local v237 = {}
            local v238 = state2.invites or {}

            for _, v240 in v238 do
                if type(v240) == "table" then
                    if type(v240.fromUserId) == "number" and v232[v240.fromUserId] ~= v240.expiresAt then
                        v237[v240.fromUserId] = v240
                    end
                end
            end

            for v241, v242 in v231 do
                if not v237[v241] then
                    v242.frame:Destroy()
                    v231[v241] = nil
                end
            end

            for userId, v244 in v237 do
                local v245, v246

                if const v247 = v231[userId] then
                    v246, v245 = v244, v247
                else
                    local text
                    local v249 = ui.Panel({BackgroundTransparency = 0.04, StrokeTransparency = 0.35, StrokeThickness = 2, Name = "Invite" .. userId, Size = UDim2.fromOffset(460, 92), StrokeColor = colors.Accent, Parent = parent6})
                    local ui2 = ui.new("ImageLabel", {Position = UDim2.fromOffset(14, 14), Size = UDim2.fromOffset(60, 60), BackgroundColor3 = colors.PanelHi, (ui.Corner(theme.Radius.Pill)), Parent = v249})

                    if const image = v15[userId] then
                        ui2.Image = image
                    else
                        ui2.Image = ""

                        task.spawn(
                            function()
                                --[[
                                  line: 57
                                  upvalues:
                                    players (copy, index: 1)
                                    userId (copy, index: 2)
                                    v15 (copy, index: 3)
                                    ui2 (copy, index: 4)
                                ]]
                                local success, image = pcall(
                                    function()
                                        --[[
                                          line: 58
                                          upvalues:
                                            players (copy, index: 1)
                                            userId (copy, index: 2)
                                        ]]
                                        return players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                                    end
                                )

                                if success and type(image) == "string" then
                                    v15[userId] = image

                                    if ui2.Parent then
                                        ui2.Image = image
                                    end
                                end
                            end
                        )
                    end

                    ui.new("TextLabel", {TextSize = 21, Position = UDim2.fromOffset(86, 16), Size = UDim2.new(1, -250, 0, 26), Text = v244.fromName
                        or "Someone", FontFace = fonts.Display, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v249})
                    local newUi = ui.new
                    local v255 = {TextSize = 15, Position = UDim2.fromOffset(86, 44), Size = UDim2.new(1, -272, 0, 20), TextTruncate = Enum.TextTruncate.AtEnd}

                    if v244.remote then
                        text = "invite from another lobby"
                    else
                        text = "invited you to their party"
                    end

                    v255.Text = text
                    v255.FontFace = fonts.SemiBold
                    v255.TextColor3 = colors.TextDim
                    v255.TextXAlignment = Enum.TextXAlignment.Left
                    v255.Parent = v249
                    newUi("TextLabel", v255)
                    local v256 = ui.Button({Name = "Accept", Text = "ACCEPT", TextSize = 18, Style = "Success", Size = UDim2.fromOffset(112, 50), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -66, 0.5, -2), Parent = v249})
                    local v257 = ui.IconButton({Name = "Decline", IconName = "cross", Size = UDim2.fromOffset(46, 46), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, -2), Parent = v249})
                    ui.PadCap(Enum.KeyCode.DPadRight, {Height = 22, ZIndex = 5, Position = UDim2.fromOffset(-8, -10), Parent = v256.Instance})
                    local bar = ui.new("Frame", {Name = "Timer", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 14, 1, -6), Size = UDim2.new(1, -28, 0, 3), BackgroundColor3 = colors.Accent, (ui.Corner(theme.Radius.Pill)), Parent = v249})

                    v256.Activated:Connect(
                        function()
                            --[[
                              line: 923
                              upvalues:
                                a4 (copy, index: 1)
                                userId (copy, index: 2)
                                v231 (copy, index: 3)
                                v232 (copy, index: 4)
                            ]]
                            local v259, v260, v261 = a4.Remotes.Invoke("PartyAction", "Respond", userId, true)

                            if v259 and v260 == true then
                                a4.Sounds.Play("Select")
                                return
                            end

                            local toast = a4.Toast
                            local v263 = not v259 and "Server unavailable" or tostring((v261 or "That invite is gone"))
                            toast(v263, "error")

                            if v259 then
                                local userId2 = userId

                                if const v265 = v231[userId2] then
                                    v232[userId2] = v265.expiresAt or 0
                                    v265.frame:Destroy()
                                    v231[userId2] = nil
                                end
                            end
                        end
                    )

                    v257.Activated:Connect(
                        function()
                            --[[
                              line: 934
                              upvalues:
                                userId (copy, index: 1)
                                v231 (copy, index: 2)
                                v232 (copy, index: 3)
                                a4 (copy, index: 4)
                            ]]
                            local userId2 = userId

                            if const v267 = v231[userId2] then
                                v232[userId2] = v267.expiresAt or 0
                                v267.frame:Destroy()
                                v231[userId2] = nil
                            end

                            task.spawn(a4.Remotes.Invoke, "PartyAction", "Respond", userId, false)
                        end
                    )

                    ui.Enter(v249, Vector2.new(0, 16))
                    a4.Sounds.Play("Notify")
                    v245 = {frame = v249, bar = bar, expiresAt = v244.expiresAt, accept = v256.Instance, at = os.clock()}
                    v231[userId] = v245
                    v246 = v244
                end

                v245.expiresAt = v246.expiresAt
            end
        end

        local v268 = {}

        local function openPlayerCard(playerCard, vector2: Vector2)
            --[[
              name: openPlayerCard
              line: 950
              upvalues:
                popPanel (copy, index: 1)
                ui (copy, index: 2)
                colors (copy, index: 3)
                theme (copy, index: 4)
                v15 (copy, index: 5)
                players (copy, index: 6)
                fonts (copy, index: 7)
                closePop (copy, index: 8)
                inviteStatus (copy, index: 9)
                v81 (ref,  index: 10)
                a4 (copy, index: 11)
                action (copy, index: 12)
            ]]
            local text
            local parent = popPanel("PlayerCard", Vector2.new(280, 128))
            local ui2 = ui.new("ImageLabel", {Position = UDim2.fromOffset(14, 14), Size = UDim2.fromOffset(46, 46), BackgroundColor3 = colors.PanelHi, ZIndex = 21, (ui.Corner(theme.Radius.Pill)), Parent = parent})
            local userId = playerCard.UserId

            if const image = v15[userId] then
                ui2.Image = image
            else
                ui2.Image = ""

                task.spawn(
                    function()
                        --[[
                          line: 57
                          upvalues:
                            players (copy, index: 1)
                            userId (copy, index: 2)
                            v15 (copy, index: 3)
                            ui2 (copy, index: 4)
                        ]]
                        local success, image = pcall(
                            function()
                                --[[
                                  line: 58
                                  upvalues:
                                    players (copy, index: 1)
                                    userId (copy, index: 2)
                                ]]
                                return players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                            end
                        )

                        if success and type(image) == "string" then
                            v15[userId] = image

                            if ui2.Parent then
                                ui2.Image = image
                            end
                        end
                    end
                )
            end

            ui.new("TextLabel", {AutoLocalize = false, TextSize = 18, ZIndex = 21, Position = UDim2.fromOffset(70, 16), Size = UDim2.new(1, -120, 0, 22), Text = playerCard.DisplayName, FontFace = fonts.Heavy, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent})
            ui.new("TextLabel", {TextSize = 13, ZIndex = 21, Position = UDim2.fromOffset(70, 38), Size = UDim2.new(1, -120, 0, 18), Text = "@" .. playerCard.Name, FontFace = fonts.Medium, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent})
            ui.IconButton({Name = "Close", IconName = "cross", ZIndex = 22, Size = UDim2.fromOffset(34, 34), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Parent = parent, OnClick = closePop})
            local v279, enabled = inviteStatus(playerCard.UserId)
            local button = ui.Button
            local v282 = {Name = "Invite", TextSize = 16}

            if v279 ~= "INVITE" then
                text = v279
            else
                text = "INVITE TO PARTY"
            end

            v282.Text = text
            v282.Style = enabled and "Primary" or "Dark"
            v282.Size = UDim2.new(1, -24, 0, 46)
            v282.Position = UDim2.fromOffset(12, 70)
            v282.Parent = parent

            function v282.OnClick()
                --[[
                  name: OnClick
                  line: 1004
                  upvalues:
                    v81 (ref,  index: 1)
                    a4 (copy, index: 2)
                    action (copy, index: 3)
                    playerCard (copy, index: 4)
                ]]
                if v81 then
                    v81:Destroy()
                    v81 = nil
                    a4.MenuManager.PopFocus("PartyPop")
                end

                if action("Invite", playerCard.UserId) then
                    a4.Toast(`Invite sent to {playerCard.DisplayName}`, "success")
                end
            end

            local v283 = button(v282)
            v283:SetEnabled(enabled)

            for _, descendant in v283.Instance:GetDescendants() do
                if descendant:IsA("GuiObject") then
                    descendant.ZIndex = 23
                end
            end

            v283.Instance.ZIndex = 22
            local hud = a4.Canvas.HUD
            local v287 = math.max(ui.Scale, 0.01)
            local absolutePosition = hud.AbsolutePosition
            local v289 = ui.CanvasSize()
            local clampedValue = math.clamp(((vector2.X - absolutePosition.X) / v287) + 16, 8, v289.X - 290)
            local clampedValue2 = math.clamp(((vector2.Y - absolutePosition.Y) / v287) - 60, ui.TopInset() + 8, v289.Y - 140)
            parent.Position = UDim2.fromOffset(clampedValue, clampedValue2)
            ui.Enter(parent, Vector2.new(0, 8))

            task.delay(
                6,
                function()
                    --[[
                      line: 1028
                      upvalues:
                        v81 (ref,  index: 1)
                        parent (copy, index: 2)
                        a4 (copy, index: 3)
                    ]]
                    if v81 == parent and v81 then
                        v81:Destroy()
                        v81 = nil
                        a4.MenuManager.PopFocus("PartyPop")
                    end
                end
            )
        end

        local function lobbyClickable()
            --[[
              name: lobbyClickable
              line: 1035
              upvalues:
                state2 (ref,  index: 1)
                state (copy, index: 2)
                a4 (copy, index: 3)
            ]]
            return state2.enabled == true
                and state2.role == "Hub"
                and not state.InMatch()
                and state.Get("CombatMode") ~= true
                and not a4.MenuManager.IsOpen()
                and not a4.HudHidden
        end

        userInputService.InputBegan:Connect(
            function(input: InputObject, gameProcessedEvent: boolean)
                --[[
                  line: 1040
                  upvalues:
                    v268 (copy, index: 1)
                ]]
                if gameProcessedEvent then
                    return
                end

                local userInputType = input.UserInputType

                if userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch then
                    v268[input] = {pos = Vector2.new(input.Position.X, input.Position.Y), t = os.clock()}
                end
            end
        )

        userInputService.InputEnded:Connect(
            function(input: InputObject, gameProcessedEvent: boolean)
                --[[
                  line: 1049
                  upvalues:
                    v268 (copy, index: 1)
                    lobbyClickable (copy, index: 2)
                    workspace (copy, index: 3)
                    localPlayer (copy, index: 4)
                    players (copy, index: 5)
                    a4 (copy, index: 6)
                    openPlayerCard (copy, index: 7)
                    v81 (ref,  index: 8)
                ]]
                local v298 = v268[input]
                v268[input] = nil

                if not v298 or gameProcessedEvent or not lobbyClickable() then
                    return
                end

                local vector2 = Vector2.new(input.Position.X, input.Position.Y)

                if 10 < (vector2 - v298.pos).Magnitude or 0.45 < os.clock() - v298.t then
                    return
                end

                local camera = workspace.CurrentCamera
                if not camera then
                    return
                end

                local ray = camera:ScreenPointToRay(vector2.X, vector2.Y)
                local raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                raycastParams.FilterDescendantsInstances = {localPlayer.Character}
                local raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 250, raycastParams)
                local character = raycastResult and raycastResult.Instance:FindFirstAncestorOfClass("Model")

                while character and not character:FindFirstChildOfClass("Humanoid") do
                    if not character.Parent then
                        break
                    end

                    character = character.Parent:FindFirstAncestorOfClass("Model")
                end

                local player = character and players:GetPlayerFromCharacter(character)

                if player and player ~= localPlayer then
                    a4.Sounds.Play("Click")
                    openPlayerCard(player, vector2)

                    return
                end

                if v81 and v81.Name == "PlayerCard" and v81 then
                    v81:Destroy()
                    v81 = nil
                    a4.MenuManager.PopFocus("PartyPop")
                end
            end
        )

        local function layout()
            --[[
              name: layout
              line: 1082
              upvalues:
                ui (copy, index: 1)
                ui3 (copy, index: 2)
                parent6 (copy, index: 3)
            ]]
            local v307 = ui.TopInset()

            if ui.Compact then
                ui3.AnchorPoint = Vector2.new(1, 0)
                ui3.Position = UDim2.new(1, -16, 0, v307 + 160)
                parent6.Position = UDim2.new(0.5, 0, 1, -18)
                parent6.Size = UDim2.fromOffset(420, 0)

                return
            end

            ui3.AnchorPoint = Vector2.new(1, 1)
            ui3.Position = UDim2.new(1, -28, 1, -214)
            parent6.Position = UDim2.new(0.5, 0, 1, -28)
            parent6.Size = UDim2.fromOffset(460, 0)
        end

        layout()
        ui.LayoutChanged:Connect(layout)
        ui.TopInsetChanged:Connect(layout)

        local function refreshVisible()
            --[[
              name: refreshVisible
              line: 1102
              upvalues:
                state2 (ref,  index: 1)
                state (copy, index: 2)
                a4 (copy, index: 3)
                ui2 (copy, index: 4)
                parent (copy, index: 5)
                parent6 (copy, index: 6)
                v81 (ref,  index: 7)
            ]]
            local visible = state2.enabled == true
                and state2.role == "Hub"
                and not state.InMatch()
                and not a4.HudHidden
            ui2.Visible = visible
            parent.Visible = visible
            parent6.Visible = visible

            if not visible and v81 then
                v81:Destroy()
                v81 = nil
                a4.MenuManager.PopFocus("PartyPop")
            end
        end

        local visible = state2.enabled == true
            and state2.role == "Hub"
            and not state.InMatch()
            and not a4.HudHidden
        ui2.Visible = visible
        parent.Visible = visible
        parent6.Visible = visible

        if not visible and v81 then
            v81:Destroy()
            v81 = nil
            a4.MenuManager.PopFocus("PartyPop")
        end

        state.PlayerStateChanged:Connect(refreshVisible)
        a4.HudHiddenChanged:Connect(refreshVisible)
        local changed = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Signal")).new()

        local function apply(a313)
            --[[
              name: apply
              line: 1116
              upvalues:
                state2 (ref,  index: 1)
                timestamp (ref,  index: 2)
                render (copy, index: 3)
                renderInvites (copy, index: 4)
                state (copy, index: 5)
                a4 (copy, index: 6)
                ui2 (copy, index: 7)
                parent (copy, index: 8)
                parent6 (copy, index: 9)
                v81 (ref,  index: 10)
                changed (copy, index: 11)
            ]]
            if type(a313) ~= "table" then
                return
            end

            local v314
            local v315
            state2 = a313
            local v316 = state2

            if type(state2.outgoing) ~= "table" then
                v314 = {}
            else
                v314 = state2.outgoing
            end

            v316.outgoing = v314
            local v317 = state2

            if type(state2.invites) ~= "table" then
                v315 = {}
                v315 = render
            else
                v315, v315 = state2.invites, render
            end

            v317.invites = v315
            timestamp = os.clock()
            v315()
            renderInvites()
            local visible = state2.enabled == true
                and state2.role == "Hub"
                and not state.InMatch()
                and not a4.HudHidden
            ui2.Visible = visible
            parent.Visible = visible
            parent6.Visible = visible

            if not visible and v81 then
                v81:Destroy()
                v81 = nil
                a4.MenuManager.PopFocus("PartyPop")
            end

            changed:Fire()
        end

        a4.Remotes.On("PartyState", apply)
        task.defer(
            function()
                --[[
                  line: 1130
                  upvalues:
                    a4 (copy, index: 1)
                ]]
                a4.Remotes.Invoke("PartyAction", "Get")
            end
        )
        render()

        ui.Every(
            ui2,
            0.2,
            function()
                --[[
                  line: 1136
                  upvalues:
                    paintPremium (copy, index: 1)
                    state (copy, index: 2)
                    v231 (copy, index: 3)
                    v232 (copy, index: 4)
                    v106 (ref,  index: 5)
                    refreshInviteList (ref,  index: 6)
                    fetchFriends (copy, index: 7)
                ]]
                paintPremium()
                local v319 = state.Now()

                for v320, v321 in v231 do
                    local v322 = math.max(0, (v321.expiresAt or v319) - v319)
                    v321.bar.Size = UDim2.new(math.clamp(v322 / 30, 0, 1), -28, 0, 3)

                    if v322 <= 0 then
                        local v323 = v231[v320]
                        if not v323 then
                            continue
                        end

                        v232[v320] = v323.expiresAt or 0
                        v323.frame:Destroy()
                        v231[v320] = nil
                    end
                end

                if v106 then
                    refreshInviteList()
                    fetchFriends()
                end
            end
        )

        players.PlayerRemoving:Connect(
            function()
                --[[
                  line: 1151
                  upvalues:
                    v106 (ref, index: 1)
                    refreshInviteList (ref, index: 2)
                ]]
                task.defer(
                    function()
                        --[[
                          line: 1152
                          upvalues:
                            v106 (ref, index: 1)
                            refreshInviteList (ref, index: 2)
                        ]]
                        if v106 then
                            refreshInviteList()
                        end
                    end
                )
            end
        )

        players.PlayerAdded:Connect(
            function()
                --[[
                  line: 1158
                  upvalues:
                    v106 (ref, index: 1)
                    refreshInviteList (ref, index: 2)
                ]]
                if v106 then
                    refreshInviteList()
                end
            end
        )

        a4.Debug.party = function(a324, a325)
            --[[
              line: 1164
              upvalues:
                openInviteList (copy, index: 1)
                v81 (ref,  index: 2)
                a4 (copy, index: 3)
                apply (copy, index: 4)
                v58 (ref,  index: 5)
                paintPremium (copy, index: 6)
                v113 (ref,  index: 7)
                timestamp2 (ref,  index: 8)
                refreshInviteList (ref,  index: 9)
                state2 (ref,  index: 10)
                timestamp (ref,  index: 11)
                members (copy, index: 12)
            ]]
            if a324 == "open" then
                openInviteList()
            elseif a324 == "close" then
                if v81 then
                    v81:Destroy()
                    v81 = nil
                    a4.MenuManager.PopFocus("PartyPop")
                end
            elseif a324 == "mock" then
                apply(a325)
            elseif a324 == "premiumMock" then
                if type(a325) ~= "table" then
                    v58 = {}
                else
                    v58 = a325
                end

                paintPremium()
            elseif a324 == "friends" then
                if type(a325) ~= "table" then
                    v113 = {}
                else
                    v113 = a325
                end

                timestamp2 = os.clock()
                refreshInviteList()
            end

            local v326 = {state = state2, age = os.clock() - timestamp, seats = #members(), pop = if v81 then v81.Name else false}
            return v326
        end

        a4.Party = {
            Root = ui2,
            Row = ui3,
            Size = (function()
                --[[
                  name: Size
                  line: 1186
                  upvalues:
                    state2 (ref, index: 1)
                ]]
                if state2.party ~= false
                    and type(state2.party) == "table"
                    and type(state2.party.members) == "table"
                then
                    return (math.max(1, #state2.party.members))
                end

                return 1
            end),
            Changed = changed,
            PadTarget = (function()
                --[[
                  name: PadTarget
                  line: 1191
                  upvalues:
                    v231 (copy, index: 1)
                    parent6 (copy, index: 2)
                ]]
                local v327

                for _, v329 in v231 do
                    if v329.frame.Parent then
                        if v327 then
                            local at = v329.at

                            if not (v327.at < at) then
                                continue
                            end
                        end

                        v327 = v329
                    end
                end

                if v327 and parent6.Visible then
                    return v327.accept
                end

                return nil
            end)
        }
    end)
}