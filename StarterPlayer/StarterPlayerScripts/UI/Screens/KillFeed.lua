local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 10
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local u1 = UI_upv_1.new("Frame", {Name = "KillFeed", AnchorPoint = Vector2.new(1, 0), Size = UDim2.fromOffset(460, 190), [1] = UI_upv_1.List(Enum.FillDirection.Vertical, 5, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Top), Parent = a1.Canvas.HUD})
    local function layout()
        --[[
          name: layout
          line: 21
          upvalues:
            a1 (copy, index: 1)
            u1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        local v1 = not (a1.MatchHud) or not (a1.MatchHud.KillFeedTop) or a1.MatchHud.KillFeedTop()
        local v2 = ((UI_upv_1.Compact) and -14) or -22
        local v3 = v1 or (UI_upv_1.TopInset())
        u1.Position = UDim2.new(1, v2, 0, v3)
    end
    a1.KillFeedRelayout = layout
    local v4
    if (a1.MatchHud) and (a1.MatchHud.KillFeedTop) then
        v4 = a1.MatchHud.KillFeedTop()
    else
        v4 = nil
    end
    local v5 = ((UI_upv_1.Compact) and -14) or -22
    local v6 = v4 or (UI_upv_1.TopInset())
    u1.Position = UDim2.new(1, v5, 0, v6)
    UI_upv_1.LayoutChanged:Connect(layout)
    UI_upv_1.TopInsetChanged:Connect(layout)
    local tbl_upv_2 = {}
    local tbl_upv_3 = {}
    local u2 = 0
    local function release(a2)
        --[[
          name: release
          line: 89
          upvalues:
            tbl_upv_3 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
        ]]
        local v7 = table.find(tbl_upv_3, a2)
        if v7 then
            table.remove(tbl_upv_3, v7)
        end
        a2.holder.Parent = nil
        table.insert(tbl_upv_2, a2)
    end
    local function colorFor(a3)
        --[[
          name: colorFor
          line: 98
          upvalues:
            Colors_upv_1 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
        ]]
        if a3 ~= nil and a3 ~= 0 and a3 ~= false then
            if State_upv_1.IsAllyTeam(a3) then
                return (Theme_upv_1.Lighten(Colors_upv_1.Ally, 0.15))
            end
            return (Theme_upv_1.Lighten(Colors_upv_1.Enemy, 0.1))
        end
        return Colors_upv_1.TextDim
    end
    local function newRow()
        --[[
          name: newRow
          line: 37
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Fonts_upv_1 (copy, index: 3)
        ]]
        local v8 = UI_upv_1.new("Frame", {Name = "Row", Size = UDim2.fromOffset(0, 33), AutomaticSize = Enum.AutomaticSize.X})
        local tbl_4 = {}
        tbl_4.Name = "Inner"
        tbl_4.Size = UDim2.fromOffset(0, 33)
        tbl_4.AutomaticSize = Enum.AutomaticSize.X
        tbl_4.BackgroundColor3 = Colors_upv_1.Void
        tbl_4.BackgroundTransparency = 0.4
        tbl_4[1], tbl_4[2], tbl_4[3] = UI_upv_1.Corner(8), UI_upv_1.Padding(0, 10, 0, 10), UI_upv_1.List(Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Right, Enum.VerticalAlignment.Center)
        tbl_4.Parent = v8
        local v9 = UI_upv_1.new("Frame", tbl_4)
        local v10 = UI_upv_1.Stroke(Colors_upv_1.Accent, 2, 0.1)
        v10.Parent = v9
        tbl_4 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, Name = "Killer", TextSize = 18, AutoLocalize = false, Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, FontFace = Fonts_upv_1.Heavy, Parent = v9})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.3).Parent = tbl_4
        local v11 = UI_upv_1.new("Frame", {LayoutOrder = 2, Name = "Weapon", Size = UDim2.fromOffset(38, 28), Parent = v9})
        local v12 = UI_upv_1.Image(UI_upv_1.Assets.Icons.Headshot, {Name = "Headshot", LayoutOrder = 3, Size = UDim2.fromOffset(20, 20), ImageColor3 = Colors_upv_1.Accent, Parent = v9})
        local v13 = UI_upv_1.new("TextLabel", {LayoutOrder = 4, Name = "Victim", TextSize = 18, AutoLocalize = false, Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, FontFace = Fonts_upv_1.Heavy, Parent = v9})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.3).Parent = v13
        UI_upv_1.new("UISizeConstraint", {MaxSize = Vector2.new(170, 30), Parent = tbl_4})
        UI_upv_1.new("UISizeConstraint", {MaxSize = Vector2.new(170, 30), Parent = v13})
        tbl_4.TextTruncate = Enum.TextTruncate.AtEnd
        v13.TextTruncate = Enum.TextTruncate.AtEnd
        local tbl_5 = {token = 0}
        tbl_5.holder = v8
        tbl_5.inner = v9
        tbl_5.stroke = v10
        tbl_5.killer = tbl_4
        tbl_5.victim = v13
        tbl_5.icon = v11
        tbl_5.hs = v12
        return tbl_5
    end
    local function push(a4)
        --[[
          name: push
          line: 105
          upvalues:
            State_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
            tbl_upv_3 (copy, index: 3)
            tbl_upv_2 (copy, index: 4)
            newRow (copy, index: 5)
            u2 (ref,  index: 6)
            Colors_upv_1 (copy, index: 7)
            Theme_upv_1 (copy, index: 8)
            WeaponIcon_upv_1 (copy, index: 9)
            u1 (copy, index: 10)
        ]]
        local v14 = State_upv_1.MyId()
        local v15 = ((UI_upv_1.Compact) and 3) or 5
        while v15 < #tbl_upv_3 do
            local v16 = table.remove(tbl_upv_3, 1)
            v16.token = v16.token + 1
            v16.holder.Parent = nil
            table.insert(tbl_upv_2, v16)
        end
        local u3
        if v15 <= #tbl_upv_3 then
            u3 = tbl_upv_3[1]
            table.remove(tbl_upv_3, 1)
        else
            local v17 = table.remove(tbl_upv_2) or newRow()
            u3 = v17
        end
        u3.token = u3.token + 1
        local token_upv_1 = u3.token
        u2 = u2 + 1
        local v18 = (type(a4.killerName) == "string") and ((a4.killerName ~= "") and (a4.killerId ~= a4.victimId))
        u3.killer.Visible = v18
        local killer_1 = u3.killer
        local v19
        if v18 then
            local killerName_1 = a4.killerName
            local v20 = State_upv_1.FindMember(a4.killerId)
            local v21 = v20 and (v20.tribe)
            if type(v21) == "table" and type(v21.tag) == "string" then
                v19 = "[" .. v21.tag .. "] " .. killerName_1
            else
                v19 = killerName_1
            end
        else
            v19 = ""
        end
        killer_1.Text = v19
        local killer_2 = u3.killer
        local killerTeam_1 = a4.killerTeam
        local v22
        local function tagged_1(a5, a6)
            --[[
              name: tagged
              line: 126
              upvalues:
                State_upv_1 (copy, index: 1)
            ]]
            local v23 = State_upv_1.FindMember(a5)
            local v24 = v23 and (v23.tribe)
            if type(v24) == "table" and type(v24.tag) == "string" then
                return "[" .. v24.tag .. "] " .. a6
            end
            return a6
        end
        if killerTeam_1 ~= nil and killerTeam_1 ~= 0 and killerTeam_1 ~= false then
            State_upv_1.IsAllyTeam(killerTeam_1)
        end
        v22 = Colors_upv_1.TextDim
        killer_2.TextColor3 = v22
        local victim_1 = u3.victim
        local str_1 = tostring(a4.victimName or "?")
        local v25 = State_upv_1.FindMember(a4.victimId)
        local v26 = v25 and (v25.tribe)
        if type(v26) == "table" and type(v26.tag) == "string" then
            v22 = "[" .. v26.tag .. "] " .. str_1
        else
            v22 = str_1
        end
        victim_1.Text = v22
        local victim_2 = u3.victim
        local v27 = a4.victimTeam
        if v27 ~= nil and v27 ~= 0 and v27 ~= false then
            State_upv_1.IsAllyTeam(v27)
        end
        v22 = Colors_upv_1.TextDim
        victim_2.TextColor3 = v22
        local hs_1 = u3.hs
        hs_1.Visible = a4.headshot == true
        if type(a4.weaponId) ~= "string" or a4.weaponId == "" then
            WeaponIcon_upv_1.Set(u3.icon, nil)
            if not (u3.icon:FindFirstChild("WeaponIcon")) then
                UI_upv_1.Image(UI_upv_1.Assets.Icons.Skull, {Name = "WeaponIcon", Size = UDim2.fromScale(1, 1), ImageColor3 = Colors_upv_1.TextDim, Parent = u3.icon})
            end
        else
            WeaponIcon_upv_1.Set(u3.icon, a4.weaponId, {glow = false})
        end
        UI_upv_1.Unfade(u3.inner)
        local v28 = true
        if a4.killerId ~= v14 then
            v28 = a4.victimId == v14
        end
        u3.stroke.Enabled = v28
        u3.stroke.Transparency = 0.1
        local inner_1 = u3.inner
        if v28 then
            v27 = 0.2
        else
            v27 = 0.4
        end
        inner_1.BackgroundTransparency = v27
        u3.holder.LayoutOrder = u2
        u3.holder.Parent = u1
        table.insert(tbl_upv_3, u3)
        UI_upv_1.SlideIn(u3.inner, Vector2.new(40, 0), Theme_upv_1.Tween.PopSmall, UDim2.new())
        task.delay(
            5,
            function()
                --[[
                  line: 161
                  upvalues:
                    u3 (ref,  index: 1)
                    token_upv_1 (copy, index: 2)
                    UI_upv_1 (copy, index: 3)
                    tbl_upv_3 (copy, index: 4)
                    tbl_upv_2 (copy, index: 5)
                ]]
                if u3.token ~= token_upv_1 then
                    return
                end
                UI_upv_1.FadeOut(u3.inner, TweenInfo.new(0.3))
                task.delay(
                    0.32,
                    function()
                        --[[
                          line: 166
                          upvalues:
                            u3 (ref,  index: 1)
                            token_upv_1 (copy, index: 2)
                            tbl_upv_3 (copy, index: 3)
                            tbl_upv_2 (copy, index: 4)
                        ]]
                        if u3.token == token_upv_1 then
                            local v29 = table.find(tbl_upv_3, u3)
                            if v29 then
                                table.remove(tbl_upv_3, v29)
                            end
                            u3.holder.Parent = nil
                            table.insert(tbl_upv_2, u3)
                        end
                    end
                )
            end
        )
    end
    a1.OnMatchEvent(
        function(a7, a8)
            --[[
              line: 174
              upvalues:
                push (copy, index: 1)
                tbl_upv_3 (copy, index: 2)
                tbl_upv_2 (copy, index: 3)
            ]]
            if (a7 ~= "Elimination" or type(a8) ~= "table") and a7 == "MatchStart" then
                for n_1 = #tbl_upv_3, 1, -1 do
                    local v30 = tbl_upv_3[n_1]
                    v30.token = v30.token + 1
                    local v31 = tbl_upv_3[n_1]
                    local v32 = table.find(tbl_upv_3, v31)
                    if v32 then
                        table.remove(tbl_upv_3, v32)
                    end
                    v31.holder.Parent = nil
                    table.insert(tbl_upv_2, v31)
                end
            end
            push(a8)
        end
    )
    u1.Visible = State_upv_1.SeesMatch() and not a1.HudHidden
    local function vis()
        --[[
          name: vis
          line: 185
          upvalues:
            u1 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        u1.Visible = State_upv_1.SeesMatch() and not a1.HudHidden
    end
    State_upv_1.PlayerStateChanged:Connect(vis)
    State_upv_1.WatchChanged:Connect(vis)
    a1.HudHiddenChanged:Connect(vis)
    a1.Debug.killfeed = function(a9)
        --[[
          line: 192
          upvalues:
            push (copy, index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
        ]]
        local v35
        if a9 then
            v35 = a9
        else
            v35 = {headshot = true, weaponId = "short_bow", victimName = "Grimtooth", victimId = "b2"}
            v35.killerId = State_upv_1.MyId()
            v35.killerName = a1.Player.DisplayName
            v35.killerTeam = State_upv_1.MyTeam()
            v35.victimTeam = 3 - State_upv_1.MyTeam()
        end
        push(v35)
        return true
    end
end
return tbl_1