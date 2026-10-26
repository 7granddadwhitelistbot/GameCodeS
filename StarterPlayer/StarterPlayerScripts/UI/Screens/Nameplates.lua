local Players_upv_1 = game:GetService("Players")
local Combat_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Combat"))
local TweenService_upv_1 = game:GetService("TweenService")
local CollectionService_upv_1 = game:GetService("CollectionService")
local Workspace_upv_1 = game:GetService("Workspace")
local RunService_upv_1 = game:GetService("RunService")
local Tribes_upv_1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Tribes"))
local RankArt_upv_1 = require(script.Parent.Parent.RankArt)
local tbl_1 = {}
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 60
      upvalues:
        Players_upv_1 (copy, index: 1)
        Tribes_upv_1 (copy, index: 2)
        CollectionService_upv_1 (copy, index: 3)
        RankArt_upv_1 (copy, index: 4)
        TweenService_upv_1 (copy, index: 5)
        Workspace_upv_1 (copy, index: 6)
        RunService_upv_1 (copy, index: 7)
        Combat_upv_1 (copy, index: 8)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local u1 = Color3.fromRGB(226, 222, 212)
    local u2 = Theme_upv_1.Lighten(Colors_upv_1.Ally, 0.1)
    local u3 = Theme_upv_1.Lighten(Colors_upv_1.Enemy, 0.05)
    local u4 = UI_upv_1.new("ScreenGui", {ResetOnSpawn = false, Name = "TR_Nameplates", DisplayOrder = 0, Parent = a1.PlayerGui})
    local u5 = UI_upv_1.new("ScreenGui", {Name = "TR_Plates", DisplayOrder = 1, ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = a1.PlayerGui})
    u5.ScreenInsets = Enum.ScreenInsets.None
    local tbl_upv_2 = {}
    local u6 = RaycastParams.new()
    u6.FilterType = Enum.RaycastFilterType.Exclude
    u6.IgnoreWater = true
    local function modelName(a2)
        --[[
          name: modelName
          line: 124
          upvalues:
            Players_upv_1 (copy, index: 1)
        ]]
        local v1 = a2:GetAttribute("DisplayName")
        if type(v1) == "string" and v1 ~= "" then
            return v1
        end
        local v2 = Players_upv_1:GetPlayerFromCharacter(a2)
        if v2 then
            return v2.DisplayName
        end
        return a2.Name
    end
    local function escape(a3)
        --[[
          name: escape
          line: 133
        ]]
        return (string.gsub(string.gsub(string.gsub(a3, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
    end
    local function levelOf(a4)
        --[[
          name: levelOf
          line: 139
          upvalues:
            Players_upv_1 (copy, index: 1)
        ]]
        local v3 = a4:GetAttribute("Level")
        if type(v3) ~= "number" then
            local v4 = Players_upv_1:GetPlayerFromCharacter(a4)
            v3 = v4 and v4:GetAttribute("Level")
        end
        if type(v3) == "number" and v3 >= 1 then
            return (math.floor(v3))
        end
        return nil
    end
    local function levelPrefix(a5)
        --[[
          name: levelPrefix
          line: 148
          upvalues:
            levelOf (copy, index: 1)
        ]]
        local v6 = levelOf(a5)
        if v6 then
            return (string.format("<font color=\"%s\">[%d]</font> ", "#AEB5C2", v6))
        end
        return ""
    end
    local function tribeOf(a6)
        --[[
          name: tribeOf
          line: 155
          upvalues:
            Players_upv_1 (copy, index: 1)
        ]]
        local v7 = a6:GetAttribute("TribeTag")
        local v8 = a6:GetAttribute("TribeColor1")
        if type(v7) ~= "string" or v7 == "" then
            local v9 = Players_upv_1:GetPlayerFromCharacter(a6)
            local v10 = v9 and (v9:GetAttribute("TribeTag"))
            v10 = v9 and (v9:GetAttribute("TribeColor1"))
            v7 = v10
        end
        if type(v7) == "string" and v7 ~= "" then
            if type(v8) ~= "number" then
                return v7, 1
            end
            return v7, v8
        end
        return nil, nil
    end
    local function tribePrefix(a7, a8)
        --[[
          name: tribePrefix
          line: 168
          upvalues:
            tribeOf (copy, index: 1)
            Tribes_upv_1 (copy, index: 2)
        ]]
        local v11, v12 = tribeOf(a7)
        if v11 then
            if a8 then
                return string.format("<font color=\"#%s\">[%s]</font> ", Tribes_upv_1.TextColor(v12):ToHex(), string.gsub(string.gsub(string.gsub(v11, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
            end
            return "[" .. v11 .. "] "
        end
        return ""
    end
    local function isFighterTagged(a9)
        --[[
          name: isFighterTagged
          line: 179
          upvalues:
            CollectionService_upv_1 (copy, index: 1)
        ]]
        local v13 = CollectionService_upv_1:HasTag(a9, "Combatant") or (CollectionService_upv_1:HasTag(a9, "Bot"))
        return v13
    end
    local function ensureBillboard(a10)
        --[[
          name: ensureBillboard
          line: 207
          upvalues:
            UI_upv_1 (copy, index: 1)
            u4 (copy, index: 2)
            Players_upv_1 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            u1 (copy, index: 5)
            Colors_upv_1 (copy, index: 6)
        ]]
        if a10.bb then
            return
        end
        local v14 = UI_upv_1.new("BillboardGui", {Enabled = false, Active = false, ResetOnSpawn = false, LightInfluence = 0, MaxDistance = 90, Name = "Plate", StudsOffsetWorldSpace = Vector3.new(0, 1.899999976158142, 0), AlwaysOnTop = false, Size = UDim2.new(5.5, 104, 0.6, 12), Parent = u4})
        local new_1 = UI_upv_1.new
        local tbl_3 = {RichText = true, AutoLocalize = false, TextColor3 = 0, Parent = 0, Text = 0, Name = "PlayerName", TextTruncate = 0, FontFace = 0, TextScaled = true}
        tbl_3.Size = UDim2.fromScale(1, 1)
        local model_1 = a10.model
        local v15 = model_1:GetAttribute("DisplayName")
        local v16
        if type(v15) ~= "string" or v15 == "" then
            local v17 = Players_upv_1:GetPlayerFromCharacter(model_1)
            if v17 then
                v16 = v17.DisplayName
            else
                v16 = model_1.Name
            end
        else
            v16 = v15
        end
        tbl_3.Text = v16
        tbl_3.FontFace = Fonts_upv_1.Heavy
        tbl_3.TextColor3 = u1
        tbl_3.TextTruncate = Enum.TextTruncate.AtEnd
        tbl_3.Parent = v14
        local u7 = new_1("TextLabel", tbl_3)
        UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 20, MinTextSize = 9, Parent = u7})
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.6, 0.15).Parent = u7
        local u8 = UI_upv_1.new("Frame", {Name = "RankEmblem", Visible = false, BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Parent = v14})
        local function place_1()
            --[[
              name: place
              line: 245
              upvalues:
                u7 (copy, index: 1)
                u8 (copy, index: 2)
            ]]
            local TextBounds_1 = u7.TextBounds
            local v18 = math.max(10, math.floor(TextBounds_1.Y * 1.3))
            u8.Size = UDim2.fromOffset(v18, v18)
            u8.Position = UDim2.new(0.5, -math.floor(TextBounds_1.X / 2) - 2, 0.5, 0)
        end
        u7:GetPropertyChangedSignal("TextBounds"):Connect(place_1)
        place_1()
        a10.bb = v14
        a10.bbName = u7
        a10.bbRank = u8
    end
    local function playerOf(a11)
        --[[
          name: playerOf
          line: 279
          upvalues:
            Players_upv_1 (copy, index: 1)
        ]]
        return Players_upv_1:GetPlayerFromCharacter(a11.model)
    end
    local function paintQueue(a12)
        --[[
          name: paintQueue
          line: 292
          upvalues:
            Players_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
            u4 (copy, index: 4)
            Colors_upv_1 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
            TweenService_upv_1 (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
        ]]
        local v19 = Players_upv_1:GetPlayerFromCharacter(a12.model)
        local v20 = (v19 ~= nil) and ((v19:GetAttribute("Queued") == true) and ((a12.role == "lobby") and ((a12.head ~= nil) and (not a1.HudHidden))))
        local v21 = nil
        if v20 then
            local v22 = v19:GetAttribute("QueueFound") == true
            v21 = a12.queueBB
            if v21 then
                v19 = v21
            else
                v19 = UI_upv_1.new("BillboardGui", {Active = false, ResetOnSpawn = false, LightInfluence = 0, MaxDistance = 90, Name = "QueueTag", StudsOffsetWorldSpace = Vector3.new(0, 3.049999952316284, 0), AlwaysOnTop = false, Size = UDim2.new(2.9, 36, 0.5, 9), Parent = u4})
                local v23 = UI_upv_1.new("Frame", {Name = "Pill", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, BackgroundTransparency = 0.3, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = v19})
                UI_upv_1.new("UIStroke", {Thickness = 1.5, Transparency = 0.2, Name = "Rim", Color = Colors_upv_1.Accent, Parent = v23})
                UI_upv_1.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, Parent = v23})
                local tbl_4 = {}
                tbl_4.Name = "Dot"
                tbl_4.Size = UDim2.fromScale(0.34, 0.34)
                tbl_4.SizeConstraint = Enum.SizeConstraint.RelativeYY
                tbl_4.BackgroundColor3 = Colors_upv_1.Accent
                tbl_4.LayoutOrder = 1
                tbl_4[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
                tbl_4.Parent = v23
                local tbl_5 = {BackgroundTransparency = 0.75}
                TweenService_upv_1:Create(UI_upv_1.new("Frame", tbl_4), TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), tbl_5):Play()
                UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 15, MinTextSize = 7, Parent = UI_upv_1.new("TextLabel", {LayoutOrder = 2, Name = "Label", Text = "IN QUEUE", TextScaled = true, Size = UDim2.fromScale(0.72, 0.62), FontFace = Fonts_upv_1.Heavy, TextColor3 = Colors_upv_1.Text, Parent = v23})})
                a12.queueBB = v19
            end
            local Pill_1 = v19:FindFirstChild("Pill")
            local v24
            if v22 then
                v24 = Colors_upv_1.Success
            else
                v24 = Colors_upv_1.Accent
            end
            Pill_1:FindFirstChild("Dot").BackgroundColor3 = v24
            Pill_1:FindFirstChild("Rim").Color = v24
            local Label_1 = Pill_1:FindFirstChild("Label")
            Label_1.Text = (v22 and "MATCH FOUND") or "IN QUEUE"
            local v25
            if v22 then
                v25 = Colors_upv_1.Success
            else
                v25 = Colors_upv_1.Text
            end
            Label_1.TextColor3 = v25
            v19.Adornee = a12.head
            v19.Enabled = true
        elseif a12.queueBB then
            a12.queueBB.Enabled = false
        end
    end
    local function paintArmor(a13)
        --[[
          name: paintArmor
          line: 479
        ]]
        local flat_1 = a13.flat
        if not flat_1 then
            return
        end
        local v26 = a13.model:GetAttribute("MaxArmor")
        local v27 = a13.model:GetAttribute("Armor")
        if type(v26) ~= "number" then
            v26 = 0
        end
        if type(v27) ~= "number" then
            v27 = 0
        end
        flat_1.armorBg.Visible = (v26 > 0) and ((v27 > 0) and (flat_1.mode ~= "bar"))
        if not (v26 > 0) then
            return
        end
        flat_1.armorFill.Size = UDim2.fromScale(math.clamp(v27 / v26, 0, 1), 1)
    end
    local function healthFrac(a14)
        --[[
          name: healthFrac
          line: 494
        ]]
        local hum_1 = a14.hum
        if hum_1 then
            if hum_1.MaxHealth > 0 then
                return (math.clamp(hum_1.Health / hum_1.MaxHealth, 0, 1))
            end
            return 0
        end
        return 1
    end
    local function alive(a15)
        --[[
          name: alive
          line: 502
        ]]
        local v28 = true
        if a15.hum ~= nil then
            v28 = a15.hum.Health > 0
        end
        return v28
    end
    local function setMode(a16, a17)
        --[[
          name: setMode
          line: 523
        ]]
        if a16.mode == a17 then
            return
        end
        a16.mode = a17
        a16.row.Visible = a17 == "full"
        a16.chevron.Visible = a17 == "far"
    end
    local tbl_upv_6 = {}
    local u9 = table.create(12, 0)
    local u10 = table.create(12, 0)
    local u11 = table.create(12, 0)
    local u12 = table.create(12, 0)
    local function overlaps(a18, a19, a20, a21, a22)
        --[[
          name: overlaps
          line: 559
          upvalues:
            u9 (copy, index: 1)
            u11 (copy, index: 2)
            u10 (copy, index: 3)
            u12 (copy, index: 4)
        ]]
        for n_1 = 1, a18 do
            if not (a19 < u9[n_1] + u11[n_1]) or not (u9[n_1] < a19 + a21) or not (a20 < u10[n_1] + u12[n_1]) or not (u10[n_1] < a20 + a22) then
                continue
            end
            return true
        end
        return false
    end
    local u13 = nil
    local function byDistance(a23, a24)
        --[[
          name: byDistance
          line: 556
        ]]
        return a23.dist < a24.dist
    end
    local function wantsPlate(a25)
        --[[
          name: wantsPlate
          line: 646
        ]]
        local v29 = false
        local _
        if a25.head ~= nil then
            _ = true
            if a25.hum ~= nil then
                v29 = a25.hum.Health > 0
            end
            if v29 then
                v29 = true
                if a25.role ~= "ally" then
                    v29 = (a25.role == "enemy") and (a25.visibleLOS)
                end
            end
        end
        return v29
    end
    local function wantsOutline(a26)
        --[[
          name: wantsOutline
          line: 649
        ]]
        local v30 = false
        local _
        if a26.role == "enemy" then
            _ = true
            if a26.hum ~= nil then
                v30 = a26.hum.Health > 0
            end
            v30 = v30 and (a26.head ~= nil) and (not a26.smoked)
        end
        return v30
    end
    local function step()
        --[[
          name: step
          line: 569
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
            tbl_upv_6 (copy, index: 3)
            byDistance (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            overlaps (copy, index: 6)
            u9 (copy, index: 7)
            u10 (copy, index: 8)
            u11 (copy, index: 9)
            u12 (copy, index: 10)
        ]]
        local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
        if not CurrentCamera_1 then
            return
        end
        local Position_1 = CurrentCamera_1.CFrame.Position
        local HudHidden_1 = a1.HudHidden
        for _, value_1 in tbl_upv_6 do
            local head_1 = value_1.head
            value_1.onScreen = false
            if not (head_1) then
                value_1.dist = math.huge
                continue
            end
            if value_1.flat then
                local v31 = head_1.Position + Vector3.new(0, 1.899999976158142, 0)
                value_1.dist = (v31 - Position_1).Magnitude
                local v32, v33 = CurrentCamera_1:WorldToViewportPoint(v31)
                value_1.onScreen = v33 and ((v32.Z > 0) and ((value_1.dist <= (((value_1.role ~= "ally") and 200) or 450)) and (not HudHidden_1)))
                value_1.sx = v32.X
                value_1.sy = v32.Y
            else
                value_1.dist = math.huge
            end
        end
        table.sort(tbl_upv_6, byDistance)
        local v34 = 0
        local v35 = 0
        local v36 = -1
        local v37 = a1.Scoreboard
        local v38
        if v37 and v37.Parent and v37.AbsoluteSize.X > 0 and v37.Parent.Visible then
            local v39 = v37.AbsolutePosition.X - 8
            local v40 = v37.AbsolutePosition.X + v37.AbsoluteSize.X + 8
            v36, v38, v35 = v37.AbsolutePosition.Y + v37.AbsoluteSize.Y + 6, v39, v40
        else
            v38 = v34
        end
        local v41 = 0
        local Scale_1 = UI_upv_1.Scale
        local v42 = ((UI_upv_1.Compact) and 1.3) or 1
        local v43, v44, v45 = nil, nil, nil
        v37 = v41
        local v46 = nil
        local v47 = nil
        for _, value_2 in tbl_upv_6 do
            local flat_2 = value_2.flat
            if not (flat_2) then
                continue
            end
            if not (value_2.onScreen) then
                flat_2.frame.Visible = false
                continue
            end
            local v48 = ((value_2.dist < 35) and 1) or (((value_2.dist < 90) and 2) or 3)
            if v48 ~= flat_2.bucket then
                flat_2.bucket = v48
                flat_2.scale.Scale = Scale_1 * v42 * (((v48 == 1) and 1) or (((v48 ~= 2) and 0.72) or 0.85))
            end
            local Scale_2 = flat_2.scale.Scale
            if value_2.role == "ally" and (value_2.dist > 60) then
                v44 = "far"
            else
                v44 = "full"
            end
            if v44 ~= "full" then
                v46 = ((v44 ~= "far") and 14) or 26
            else
                v46 = 38
            end
            v43 = v46 * Scale_2
            if v44 ~= "full" then
                v47 = 100
            else
                v47 = 150
            end
            v46 = v47 * Scale_2
            v47 = value_2.sx - v46 / 2
            v45 = value_2.sy
            local v49 = 0
            while v49 < 2 do
                if overlaps(v37, v47, v45 - v43, v46, v43) then
                    v45 = v45 - (v43 + 2)
                    v49 = v49 + 1
                    continue
                else
                    break
                end
            end
            local v50 = overlaps(v37, v47, v45 - v43, v46, v43)
            if v50 then
                v43, v44 = 14 * Scale_2, "bar"
            end
            if v36 > 0 and v38 < value_2.sx and value_2.sx < v35 then
                v45 = ((v45 - v43 < v36) and (v36 + v43)) or v45
            end
            if v37 < 12 then
                local v51 = v37 + 1
                u9[v51] = v47
                u10[v51] = v45 - v43
                u11[v51] = v46
                u12[v51] = v43
                v37 = v51
            end
            if flat_2.mode ~= v44 then
                flat_2.mode = v44
                flat_2.row.Visible = v44 == "full"
                flat_2.chevron.Visible = v44 == "far"
            end
            flat_2.frame.Position = UDim2.fromOffset(math.floor(value_2.sx + 0.5), math.floor(v45 + 0.5))
            flat_2.frame.Visible = true
        end
    end
    local function setOutline(a27, a28)
        --[[
          name: setOutline
          line: 533
          upvalues:
            Colors_upv_1 (copy, index: 1)
        ]]
        if a28 and not (a27.outline) then
            local v52 = Instance.new("Highlight")
            v52.Name = "TR_EnemyOutline"
            v52.Adornee = a27.model
            v52.DepthMode = Enum.HighlightDepthMode.Occluded
            v52.FillTransparency = 1
            v52.OutlineTransparency = 0.35
            v52.OutlineColor = Colors_upv_1.Enemy
            v52.Parent = a27.model
            a27.outline = v52
            return
        end
        if (a28) or not a27.outline then
            return
        end
        a27.outline:Destroy()
        a27.outline = nil
    end
    local function refreshActive()
        --[[
          name: refreshActive
          line: 652
          upvalues:
            tbl_upv_6 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
            setOutline (copy, index: 3)
            u13 (ref,  index: 4)
            RunService_upv_1 (copy, index: 5)
            step (copy, index: 6)
        ]]
        table.clear(tbl_upv_6)
        local v53, v53, v54, _, v53 = nil, nil, nil, nil, nil
        for v55, value_3 in tbl_upv_2 do
            v53 = false
            if value_3.head ~= nil then
                v53 = true
                if value_3.hum ~= nil then
                    v53 = value_3.hum.Health > 0
                end
                if v53 then
                    v53 = true
                    if value_3.role ~= "ally" then
                        v53 = (value_3.role == "enemy") and (value_3.visibleLOS)
                    end
                end
            end
            if v53 then
                v53 = #tbl_upv_6 < 12
            end
            value_3.listed = v53
            if v53 then
                table.insert(tbl_upv_6, value_3)
            elseif value_3.flat then
                value_3.flat.frame.Visible = false
            end
            v54 = false
            if value_3.role ~= "enemy" then
                setOutline(value_3, v54)
                continue
            end
            v54 = true
            if value_3.hum ~= nil then
                v54 = value_3.hum.Health > 0
            end
            v54 = v54 and (value_3.head ~= nil) and (not value_3.smoked)
            setOutline(value_3, v54)
        end
        if #tbl_upv_6 > 0 and not (u13) then
            u13 = RunService_upv_1.RenderStepped:Connect(step)
            return
        end
        if #tbl_upv_6 ~= 0 then
            return
        end
        if u13 then
            u13:Disconnect()
            u13 = nil
        end
    end
    UI_upv_1.ScaleChanged:Connect(
        function()
            --[[
              line: 671
              upvalues:
                tbl_upv_2 (copy, index: 1)
            ]]
            for _, value_4 in tbl_upv_2 do
                if value_4.flat then
                    value_4.flat.bucket = 0
                end
            end
        end
    )
    local function lobbyName(a29)
        --[[
          name: lobbyName
          line: 283
          upvalues:
            levelOf (copy, index: 1)
            tribeOf (copy, index: 2)
            Tribes_upv_1 (copy, index: 3)
            Players_upv_1 (copy, index: 4)
        ]]
        local v55 = levelOf(a29.model)
        local v56 = ((not v55) and "") or (string.format("<font color=\"%s\">[%d]</font> ", "#AEB5C2", v55))
        local v57, v58 = tribeOf(a29.model)
        local v59 = ((not v57) and "") or (string.format("<font color=\"#%s\">[%s]</font> ", Tribes_upv_1.TextColor(v58):ToHex(), string.gsub(string.gsub(string.gsub(v57, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")))
        local model_2 = a29.model
        local v60 = model_2:GetAttribute("DisplayName")
        if type(v60) ~= "string" or v60 == "" then
            local v61 = Players_upv_1:GetPlayerFromCharacter(model_2)
            if v61 then
                v57 = v61.DisplayName
            else
                v57 = model_2.Name
            end
        else
            v57 = v60
        end
        local v62 = v56 .. v59 .. string.gsub(string.gsub(string.gsub(v57, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")
        local v63 = Players_upv_1:GetPlayerFromCharacter(a29.model)
        v59 = v63 and (v63:GetAttribute("Streak"))
        if type(v59) == "number" and v59 >= 2 then
            return string.format("%s  <font color=\"#FFA24A\">\240\159\148\165 %d</font>", v62, math.floor(v59))
        end
        return v62
    end
    local function paintRank(a30)
        --[[
          name: paintRank
          line: 258
          upvalues:
            Players_upv_1 (copy, index: 1)
            RankArt_upv_1 (copy, index: 2)
        ]]
        local bbRank_1 = a30.bbRank
        if not bbRank_1 then
            return
        end
        local v64 = Players_upv_1:GetPlayerFromCharacter(a30.model)
        local v65 = v64 and ((v64 ~= Players_upv_1.LocalPlayer) and (v64:GetAttribute("Trophies")))
        if type(v65) == "number" then
            RankArt_upv_1.SetEmblem(bbRank_1, RankArt_upv_1.Ranks.RankOf(v65))
            for _, value_5 in bbRank_1:GetChildren() do
                if value_5:IsA("GuiObject") then
                    value_5.ZIndex = 2
                end
            end
            bbRank_1.Visible = true
        else
            bbRank_1.Visible = false
        end
    end
    local function ensureFlat(a31)
        --[[
          name: ensureFlat
          line: 370
          upvalues:
            UI_upv_1 (copy, index: 1)
            u5 (copy, index: 2)
            Fonts_upv_1 (copy, index: 3)
            Colors_upv_1 (copy, index: 4)
            u2 (copy, index: 5)
        ]]
        if a31.flat then
            return a31.flat
        end
        local v66 = UI_upv_1.new("Frame", {Name = "Plate", Visible = false, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(220, 38), Parent = u5})
        local v67 = UI_upv_1.new("UIScale", {Parent = v66})
        local tbl_7 = {}
        tbl_7.Name = "NameRow"
        tbl_7.Size = UDim2.new(1, 0, 0, 22)
        tbl_7[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
        tbl_7.Parent = v66
        local v68 = UI_upv_1.new("Frame", tbl_7)
        local v69 = UI_upv_1.new("TextLabel", {LayoutOrder = 1, Text = "", Name = "Level", Visible = false, TextSize = 19, Size = UDim2.fromOffset(0, 22), AutomaticSize = Enum.AutomaticSize.X, FontFace = Fonts_upv_1.Heavy, TextColor3 = Color3.fromHex("#AEB5C2"), Parent = v68})
        tbl_7 = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.8, 0.1)
        tbl_7.Parent = v69
        local tbl_8 = {}
        tbl_8.Name = "PlayerName"
        tbl_8.AutoLocalize = false
        tbl_8.Size = UDim2.fromOffset(0, 22)
        tbl_8.AutomaticSize = Enum.AutomaticSize.X
        tbl_8.Text = ""
        tbl_8.FontFace = Fonts_upv_1.Heavy
        tbl_8.TextSize = 19
        tbl_8.TextTruncate = Enum.TextTruncate.AtEnd
        tbl_8.LayoutOrder = 2
        tbl_8[1] = UI_upv_1.new("UISizeConstraint", {MaxSize = Vector2.new(168, 22)})
        tbl_8.Parent = v68
        local v70 = UI_upv_1.new("TextLabel", tbl_8)
        local v71 = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.8, 0.1)
        v71.Parent = v70
        local tbl_9 = {}
        tbl_9.Name = "Bar"
        tbl_9.AnchorPoint = Vector2.new(0.5, 1)
        tbl_9.Position = UDim2.new(0.5, 0, 1, -4)
        tbl_9.Size = UDim2.fromOffset(96, 8)
        tbl_9.BackgroundColor3 = Colors_upv_1.Void
        tbl_9.BackgroundTransparency = 0.3
        tbl_9[1] = UI_upv_1.Corner(4)
        tbl_9.Parent = v66
        tbl_8 = UI_upv_1.new("Frame", tbl_9)
        local tbl_10 = {}
        tbl_10.Name = "Fill"
        tbl_10.Size = UDim2.fromScale(1, 1)
        tbl_10.BackgroundColor3 = u2
        tbl_10[1] = UI_upv_1.Corner(4)
        tbl_10.Parent = tbl_8
        local v72 = UI_upv_1.new("Frame", tbl_10)
        local tbl_11 = {}
        tbl_11.Name = "Armor"
        tbl_11.AnchorPoint = Vector2.new(0.5, 1)
        tbl_11.Position = UDim2.new(0.5, 0, 1, -13)
        tbl_11.Size = UDim2.fromOffset(96, 4)
        tbl_11.BackgroundColor3 = Colors_upv_1.Void
        tbl_11.BackgroundTransparency = 0.4
        tbl_11.Visible = false
        tbl_11[1] = UI_upv_1.Corner(2)
        tbl_11.Parent = v66
        tbl_9 = UI_upv_1.new("Frame", tbl_11)
        local tbl_12 = {}
        tbl_12.Size = UDim2.fromScale(1, 1)
        tbl_12.BackgroundColor3 = Colors_upv_1.Armor
        tbl_12[1] = UI_upv_1.Corner(2)
        tbl_12.Parent = tbl_9
        tbl_10 = UI_upv_1.new("Frame", tbl_12)
        tbl_11 = UI_upv_1.new("Frame", {Name = "Chevron", Visible = false, ClipsDescendants = true, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -15), Size = UDim2.fromOffset(18, 12), Parent = v66})
        local tbl_13 = {}
        tbl_13.Name = "Tri"
        tbl_13.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_13.Position = UDim2.fromScale(0.5, 0)
        tbl_13.Size = UDim2.fromOffset(15, 15)
        tbl_13.Rotation = 45
        tbl_13.BackgroundColor3 = u2
        tbl_13[1] = UI_upv_1.Stroke(Colors_upv_1.Void, 1.5, 0.2)
        tbl_13.Parent = tbl_11
        UI_upv_1.new("Frame", tbl_13)
        local tbl_14 = {mode = "full", faded = false, bucket = 0}
        tbl_14.frame = v66
        tbl_14.scale = v67
        tbl_14.row = v68
        tbl_14.level = v69
        tbl_14.levelStroke = tbl_7
        tbl_14.name = v70
        tbl_14.nameStroke = v71
        tbl_14.barBg = tbl_8
        tbl_14.fill = v72
        tbl_14.chevron = tbl_11
        tbl_14.armorBg = tbl_9
        tbl_14.armorFill = tbl_10
        a31.flat = tbl_14
        return tbl_14
    end
    local function setHealth(a32)
        --[[
          name: setHealth
          line: 712
          upvalues:
            refreshActive (copy, index: 1)
        ]]
        if a32.flat then
            local fill_1 = a32.flat.fill
            local hum_2 = a32.hum
            local v73 = ((not hum_2) and 1) or (((not (hum_2.MaxHealth > 0)) and 0) or (math.clamp(hum_2.Health / hum_2.MaxHealth, 0, 1)))
            fill_1.Size = UDim2.fromScale(v73, 1)
        end
        local v74 = true
        if a32.hum ~= nil then
            v74 = a32.hum.Health > 0
        end
        if v74 == a32.wasAlive then
            return
        end
        a32.wasAlive = v74
        refreshActive()
    end
    local function paint(a33)
        --[[
          name: paint
          line: 679
          upvalues:
            ensureFlat (copy, index: 1)
            u2 (copy, index: 2)
            u3 (copy, index: 3)
            levelOf (copy, index: 4)
            tribeOf (copy, index: 5)
            Players_upv_1 (copy, index: 6)
            paintArmor (copy, index: 7)
            a1 (copy, index: 8)
            ensureBillboard (copy, index: 9)
            lobbyName (copy, index: 10)
            paintRank (copy, index: 11)
            paintQueue (copy, index: 12)
            refreshActive (copy, index: 13)
        ]]
        local role_1 = a33.role
        if role_1 == "ally" or role_1 == "enemy" then
            local v75 = ensureFlat(a33)
            local v76
            if role_1 ~= "ally" then
                v76 = u3
            else
                v76 = u2
            end
            local v77 = levelOf(a33.model)
            local level_1 = v75.level
            level_1.Text = not v77 and "" or string.format("[%d]", v77)
            v75.level.Visible = v77 ~= nil
            local name_1 = v75.name
            local v79 = tribeOf(a33.model)
            local v80 = (v79 and ("[" .. v79 .. "] ")) or ""
            local model_3 = a33.model
            local v81 = model_3:GetAttribute("DisplayName")
            local v82
            if type(v81) ~= "string" or v81 == "" then
                local v83 = Players_upv_1:GetPlayerFromCharacter(model_3)
                if v83 then
                    v82 = v83.DisplayName
                else
                    v82 = model_3.Name
                end
            else
                v82 = v81
            end
            name_1.Text = v80 .. v82
            v75.name.TextColor3 = v76
            v75.fill.BackgroundColor3 = v76
            local fill_2 = v75.fill
            local hum_3 = a33.hum
            v80 = ((not hum_3) and 1) or (((not (hum_3.MaxHealth > 0)) and 0) or (math.clamp(hum_3.Health / hum_3.MaxHealth, 0, 1)))
            fill_2.Size = UDim2.fromScale(v80, 1)
            v75.chevron:FindFirstChild("Tri").BackgroundColor3 = v76
            paintArmor(a33)
            if role_1 == "enemy" and v75.faded ~= false then
                v75.faded = false
                v75.name.TextTransparency = 0
                v75.nameStroke.Transparency = 0.1
                v75.level.TextTransparency = 0
                v75.levelStroke.Transparency = 0.1
                v75.fill.BackgroundTransparency = 0
                v75.barBg.BackgroundTransparency = 0.3
                v75.chevron:FindFirstChild("Tri").BackgroundTransparency = 0
            end
        end
        if a33.bb then
            a33.bb.Enabled = (role_1 == "lobby") and ((a33.head ~= nil) and (not a1.HudHidden))
        elseif role_1 == "lobby" then
            ensureBillboard(a33)
            a33.bb.Enabled = (a33.head ~= nil) and (not a1.HudHidden)
        end
        if a33.bb and a33.head then
            a33.bb.Adornee = a33.head
            a33.bbName.Text = lobbyName(a33)
            paintRank(a33)
        end
        paintQueue(a33)
        refreshActive()
    end
    local function hookHead(a34)
        --[[
          name: hookHead
          line: 747
          upvalues:
            paint (copy, index: 1)
        ]]
        local Head_1 = a34.model:FindFirstChild("Head")
        a34.head = not (Head_1) or not (Head_1:IsA("BasePart")) or Head_1
        paint(a34)
    end
    local u14 = false
    local function detach(a35)
        --[[
          name: detach
          line: 725
          upvalues:
            tbl_upv_2 (copy, index: 1)
            refreshActive (copy, index: 2)
        ]]
        local v85 = tbl_upv_2[a35]
        if not v85 then
            return
        end
        tbl_upv_2[a35] = nil
        for _, value_6 in v85.conns do
            value_6:Disconnect()
        end
        if v85.outline then
            v85.outline:Destroy()
            v85.outline = nil
        end
        if v85.bb then
            v85.bb:Destroy()
        end
        if v85.queueBB then
            v85.queueBB:Destroy()
        end
        if v85.flat then
            v85.flat.frame:Destroy()
        end
        refreshActive()
    end
    local function roleOf(a36)
        --[[
          name: roleOf
          line: 183
          upvalues:
            State_upv_1 (copy, index: 1)
            Players_upv_1 (copy, index: 2)
        ]]
        local v86 = nil
        if State_upv_1.SeesMatch() then
            v86 = State_upv_1.SeenMatchId()
            local v87 = a36:GetAttribute("MatchId")
            if type(v86) ~= "string" or v86 == "" or type(v87) ~= "string" or v87 == "" or v87 == v86 then
                v87 = a36:GetAttribute("Team")
                if type(v87) ~= "number" then
                    local v88 = Players_upv_1:GetPlayerFromCharacter(a36)
                    v87 = v88 and v88:GetAttribute("Team")
                end
            else
                return "none"
            end
            if type(v87) == "number" and v87 ~= 0 then
                if v87 ~= State_upv_1.MyTeam() then
                    return "enemy"
                end
                return "ally"
            end
        else
            local v90 = a36:GetAttribute("MatchId")
            local v91 = (type(v90) == "string") and (v90 ~= "")
            if Players_upv_1:GetPlayerFromCharacter(a36) and not (v91) then
                return "lobby"
            end
        end
        return "none"
    end
    local function hookHumanoid(a37, a38)
        --[[
          name: hookHumanoid
          line: 753
          upvalues:
            refreshActive (copy, index: 1)
        ]]
        a37.hum = a38
        pcall(
            function()
                --[[
                  line: 755
                  upvalues:
                    a38 (copy, index: 1)
                ]]
                a38.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            end
        )
        table.insert(
            a37.conns,
            a38.HealthChanged:Connect(
                function()
                    --[[
                      line: 758
                      upvalues:
                        a37 (copy, index: 1)
                        refreshActive (copy, index: 2)
                    ]]
                    if a37.flat then
                        local fill_3 = a37.flat.fill
                        local hum_4 = a37.hum
                        local v92 = ((not hum_4) and 1) or (((not (hum_4.MaxHealth > 0)) and 0) or (math.clamp(hum_4.Health / hum_4.MaxHealth, 0, 1)))
                        fill_3.Size = UDim2.fromScale(v92, 1)
                    end
                    local v93 = true
                    if a37.hum ~= nil then
                        v93 = a37.hum.Health > 0
                    end
                    if v93 == a37.wasAlive then
                        return
                    end
                    a37.wasAlive = v93
                    refreshActive()
                end
            )
        )
        if a37.flat then
            local fill_4 = a37.flat.fill
            local hum_5 = a37.hum
            local v94 = ((not hum_5) and 1) or (((not (hum_5.MaxHealth > 0)) and 0) or (math.clamp(hum_5.Health / hum_5.MaxHealth, 0, 1)))
            fill_4.Size = UDim2.fromScale(v94, 1)
        end
        local v95 = true
        if a37.hum ~= nil then
            v95 = a37.hum.Health > 0
        end
        if v95 == a37.wasAlive then
            return
        end
        a37.wasAlive = v95
        refreshActive()
    end
    local function attach(a39)
        --[[
          name: attach
          line: 765
          upvalues:
            tbl_upv_2 (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            u14 (ref,  index: 3)
            roleOf (copy, index: 4)
            hookHumanoid (copy, index: 5)
            paint (copy, index: 6)
            paintArmor (copy, index: 7)
            detach (copy, index: 8)
        ]]
        if tbl_upv_2[a39] or a39 == LocalPlayer_upv_1.Character and not (u14) then
            return
        end
        local tbl_upv_15 = {dist = 0, smoked = false, onScreen = false, visibleLOS = false, sx = 0, sy = 0, listed = false, wasAlive = true}
        tbl_upv_15.model = a39
        tbl_upv_15.conns = {}
        tbl_upv_15.role = roleOf(a39)
        tbl_upv_2[a39] = tbl_upv_15
        local v96 = a39:FindFirstChildOfClass("Humanoid")
        if v96 then
            hookHumanoid(tbl_upv_15, v96)
        end
        table.insert(
            tbl_upv_15.conns,
            a39.ChildAdded:Connect(
                function(a40)
                    --[[
                      line: 795
                      upvalues:
                        tbl_upv_15 (copy, index: 1)
                        paint (copy, index: 2)
                        hookHumanoid (copy, index: 3)
                    ]]
                    local v97 = nil
                    if a40.Name == "Head" then
                        local v98 = tbl_upv_15
                        v97 = v98.model:FindFirstChild("Head")
                        v98.head = not (v97) or not (v97:IsA("BasePart")) or v97
                        paint(v98)
                    elseif a40:IsA("Humanoid") and not (tbl_upv_15.hum) then
                        hookHumanoid(tbl_upv_15, a40)
                    end
                end
            )
        )
        table.insert(
            tbl_upv_15.conns,
            a39.ChildRemoved:Connect(
                function(a41)
                    --[[
                      line: 802
                      upvalues:
                        tbl_upv_15 (copy, index: 1)
                        paint (copy, index: 2)
                    ]]
                    if a41.Name == "Head" then
                        local v100 = tbl_upv_15
                        local Head_2 = v100.model:FindFirstChild("Head")
                        v100.head = not (Head_2) or not (Head_2:IsA("BasePart")) or Head_2
                        paint(v100)
                    end
                end
            )
        )
        table.insert(
            tbl_upv_15.conns,
            a39.AttributeChanged:Connect(
                function(a42)
                    --[[
                      line: 807
                      upvalues:
                        tbl_upv_15 (copy, index: 1)
                        roleOf (copy, index: 2)
                        a39 (copy, index: 3)
                        paint (copy, index: 4)
                    ]]
                    if a42 ~= "Team" and a42 ~= "MatchId" and a42 ~= "DisplayName" and a42 ~= "Level" then
                        return
                    end
                    tbl_upv_15.role = roleOf(a39)
                    paint(tbl_upv_15)
                end
            )
        )
        table.insert(
            tbl_upv_15.conns,
            a39:GetAttributeChangedSignal("Armor"):Connect(
                function()
                    --[[
                      line: 813
                      upvalues:
                        paintArmor (copy, index: 1)
                        tbl_upv_15 (copy, index: 2)
                    ]]
                    paintArmor(tbl_upv_15)
                end
            )
        )
        table.insert(
            tbl_upv_15.conns,
            a39:GetAttributeChangedSignal("MaxArmor"):Connect(
                function()
                    --[[
                      line: 816
                      upvalues:
                        paintArmor (copy, index: 1)
                        tbl_upv_15 (copy, index: 2)
                    ]]
                    paintArmor(tbl_upv_15)
                end
            )
        )
        table.insert(
            tbl_upv_15.conns,
            a39.AncestryChanged:Connect(
                function(a43, a44)
                    --[[
                      line: 819
                      upvalues:
                        detach (copy, index: 1)
                        a39 (copy, index: 2)
                    ]]
                    if (a44) then
                        return
                    end
                    detach(a39)
                end
            )
        )
        local Head_3 = tbl_upv_15.model:FindFirstChild("Head")
        tbl_upv_15.head = not (Head_3) or not (Head_3:IsA("BasePart")) or Head_3
        paint(tbl_upv_15)
    end
    local function watchPlayer(a45)
        --[[
          name: watchPlayer
          line: 828
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            u14 (ref,  index: 2)
            detach (copy, index: 3)
            Workspace_upv_1 (copy, index: 4)
            attach (copy, index: 5)
            tbl_upv_2 (copy, index: 6)
            roleOf (copy, index: 7)
            paint (copy, index: 8)
            paintQueue (copy, index: 9)
            lobbyName (copy, index: 10)
            paintRank (copy, index: 11)
        ]]
        if a45 == LocalPlayer_upv_1 and not (u14) then
            return
        end
        local u15 = nil
        local u16 = nil
        local function setChar_upv_1(a46)
            --[[
              name: setChar
              line: 834
              upvalues:
                u15 (ref,  index: 1)
                detach (copy, index: 2)
                u16 (ref,  index: 3)
                Workspace_upv_1 (copy, index: 4)
                attach (copy, index: 5)
            ]]
            if u15 ~= a46 then
                if u15 then
                    detach(u15)
                end
                if u16 then
                    u16:Disconnect()
                    u16 = nil
                end
                u15 = a46
                if a46 then
                    local v103 = a46.AncestryChanged:Connect(
                        function()
                            --[[
                              line: 849
                              upvalues:
                                u15 (ref,  index: 1)
                                a46 (copy, index: 2)
                                Workspace_upv_1 (copy, index: 3)
                                attach (copy, index: 4)
                            ]]
                            if u15 ~= a46 or not a46:IsDescendantOf(Workspace_upv_1) then
                                return
                            end
                            attach(a46)
                        end
                    )
                    u16 = v103
                end
            end
            if not a46 or not a46:IsDescendantOf(Workspace_upv_1) then
                return
            end
            attach(a46)
        end
        a45.CharacterAdded:Connect(setChar_upv_1)
        a45.CharacterRemoving:Connect(
            function(a47)
                --[[
                  line: 861
                  upvalues:
                    u15 (ref,  index: 1)
                    detach (copy, index: 2)
                    u16 (ref,  index: 3)
                ]]
                if a47 ~= u15 then
                    detach(a47)
                elseif u15 ~= nil then
                    if u15 then
                        detach(u15)
                    end
                    if u16 then
                        u16:Disconnect()
                        u16 = nil
                    end
                    u15 = nil
                end
            end
        )
        a45:GetPropertyChangedSignal("Character"):Connect(
            function()
                --[[
                  line: 868
                  upvalues:
                    setChar_upv_1 (copy, index: 1)
                    a45 (copy, index: 2)
                ]]
                setChar_upv_1(a45.Character)
            end
        )
        a45:GetAttributeChangedSignal("Team"):Connect(
            function()
                --[[
                  line: 871
                  upvalues:
                    a45 (copy, index: 1)
                    tbl_upv_2 (copy, index: 2)
                    roleOf (copy, index: 3)
                    paint (copy, index: 4)
                ]]
                local Character_1 = a45.Character
                local v104 = Character_1 and (tbl_upv_2[Character_1])
                if not v104 then
                    return
                end
                v104.role = roleOf(Character_1)
                paint(v104)
            end
        )
        for _, value_7 in {"Queued", "QueueFound"} do
            a45:GetAttributeChangedSignal(value_7):Connect(
                function()
                    --[[
                      line: 880
                      upvalues:
                        a45 (copy, index: 1)
                        tbl_upv_2 (copy, index: 2)
                        paintQueue (copy, index: 3)
                    ]]
                    local Character_2 = a45.Character
                    local v105 = Character_2 and (tbl_upv_2[Character_2])
                    if not v105 then
                        return
                    end
                    paintQueue(v105)
                end
            )
        end
        a45:GetAttributeChangedSignal("Streak"):Connect(
            function()
                --[[
                  line: 888
                  upvalues:
                    a45 (copy, index: 1)
                    tbl_upv_2 (copy, index: 2)
                    lobbyName (copy, index: 3)
                ]]
                local Character_3 = a45.Character
                local v106 = Character_3 and (tbl_upv_2[Character_3])
                if not v106 or not v106.bbName then
                    return
                end
                v106.bbName.Text = lobbyName(v106)
            end
        )
        a45:GetAttributeChangedSignal("Trophies"):Connect(
            function()
                --[[
                  line: 895
                  upvalues:
                    a45 (copy, index: 1)
                    tbl_upv_2 (copy, index: 2)
                    paintRank (copy, index: 3)
                ]]
                local Character_4 = a45.Character
                local v107 = Character_4 and (tbl_upv_2[Character_4])
                if not v107 then
                    return
                end
                paintRank(v107)
            end
        )
        a45:GetAttributeChangedSignal("TribeTag"):Connect(
            function()
                --[[
                  line: 904
                  upvalues:
                    a45 (copy, index: 1)
                    tbl_upv_2 (copy, index: 2)
                    paint (copy, index: 3)
                ]]
                local Character_5 = a45.Character
                local v108 = Character_5 and (tbl_upv_2[Character_5])
                if not v108 then
                    return
                end
                paint(v108)
            end
        )
        a45:GetAttributeChangedSignal("Level"):Connect(
            function()
                --[[
                  line: 911
                  upvalues:
                    a45 (copy, index: 1)
                    tbl_upv_2 (copy, index: 2)
                    paint (copy, index: 3)
                ]]
                local Character_6 = a45.Character
                local v109 = Character_6 and (tbl_upv_2[Character_6])
                if not v109 then
                    return
                end
                paint(v109)
            end
        )
        setChar_upv_1(a45.Character)
    end
    for _, drawnPart in Players_upv_1:GetPlayers() do
        watchPlayer(drawnPart)
    end
    Players_upv_1.PlayerAdded:Connect(watchPlayer)
    local u17 = nil
    local u18 = nil
    local u19 = nil
    local function _()
        --[[
          name: cameraModule
          line: 932
          upvalues:
            u19 (ref, index: 1)
        ]]
        if u19 == nil then
            local success_1, v110 = pcall(function() end)
            local v111
            if (success_1) and type(v110) == "table" then
                v111 = v110
            else
                v111 = false
            end
            u19 = v111
        end
        return u19 or nil
    end
    local function drawnPart(a48)
        --[[
          name: drawnPart
          line: 941
          upvalues:
            u19 (ref, index: 1)
        ]]
        if u19 == nil then
            local success_2, v112 = pcall(function() end)
            local v113
            if (success_2) and type(v112) == "table" then
                v113 = v112
            else
                v113 = false
            end
            u19 = v113
        end
        local v114 = u19 or nil
        if v114 and type(v114.Drawn) == "function" then
            local success_3, v115 = pcall(v114.Drawn, a48)
            if success_3 and typeof(v115) == "Instance" then
                return v115
            end
        end
        return a48
    end
    local function paintSelf()
        --[[
          name: paintSelf
          line: 951
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            State_upv_1 (copy, index: 2)
            a1 (copy, index: 3)
            u14 (ref,  index: 4)
            u17 (ref,  index: 5)
            UI_upv_1 (copy, index: 6)
            u4 (copy, index: 7)
            Fonts_upv_1 (copy, index: 8)
            Colors_upv_1 (copy, index: 9)
            u18 (ref,  index: 10)
            u19 (ref,  index: 11)
        ]]
        local v116 = LocalPlayer_upv_1:GetAttribute("Streak")
        local Character_7 = LocalPlayer_upv_1.Character
        local v117 = Character_7 and (Character_7:FindFirstChild("Head"))
        Character_7 = (type(v116) == "number") and ((v116 >= 2) and ((v117 ~= nil) and (not State_upv_1.SeesMatch() and (not a1.HudHidden and (not u14)))))
        local v118 = nil
        if Character_7 then
            if not (u17) then
                local v119 = UI_upv_1.new("BillboardGui", {Active = false, ResetOnSpawn = false, LightInfluence = 0, MaxDistance = 90, Name = "MyStreak", StudsOffsetWorldSpace = Vector3.new(0, 1.899999976158142, 0), AlwaysOnTop = false, Size = UDim2.new(2.2, 40, 0.6, 12), Parent = u4})
                local v120 = UI_upv_1.new("TextLabel", {Name = "Streak", Text = "", TextScaled = true, Size = UDim2.fromScale(1, 1), FontFace = Fonts_upv_1.Heavy, TextColor3 = Color3.fromRGB(255, 162, 74), Parent = v119})
                UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 22, MinTextSize = 10, Parent = v120})
                UI_upv_1.TextStroke(Colors_upv_1.Void, 1.6, 0.15).Parent = v120
                u17 = v119
                u18 = v120
            end
            local v123 = nil
            if u19 == nil then
                local success_4, v121 = pcall(function() end)
                if (success_4) and type(v121) == "table" then
                    v123 = v121
                else
                    v123 = false
                end
                u19 = v123
            end
            v118 = u19 or nil
            if v118 then
                local v124 = nil
                if type(v118.Drawn) ~= "function" then
                    v123 = Character_7
                else
                    local success_5, v124 = pcall(v118.Drawn, Character_7)
                    if success_5 then
                        if typeof(v124) ~= "Instance" then
                            v123 = Character_7
                        else
                            v123 = v124
                        end
                    else
                        v123 = Character_7
                    end
                end
            else
                v123 = Character_7
            end
            u17.Adornee = v123
            u18.Text = string.format("\240\159\148\165 %d", math.floor(v116))
            u17.Enabled = true
        elseif u17 then
            u17.Enabled = false
        end
    end
    LocalPlayer_upv_1:GetAttributeChangedSignal("Streak"):Connect(paintSelf)
    task.spawn(
        function()
            --[[
              line: 996
              upvalues:
                u19 (ref,  index: 1)
                paintSelf (copy, index: 2)
            ]]
            if u19 == nil then
                local success_6, v125 = pcall(
                    function()
                        --[[
                          line: 934
                        ]]
                        return (require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Camera")))
                    end
                )
                local v126
                if (success_6) and type(v125) == "table" then
                    v126 = v125
                else
                    v126 = false
                end
                u19 = v126
            end
            local v127 = u19 or nil
            local v128 = v127 and (v127.DrawnChanged)
            if not v128 then
                return
            end
            v128:Connect(
                function()
                    --[[
                      line: 1000
                      upvalues:
                        paintSelf (copy, index: 1)
                    ]]
                    task.defer(paintSelf)
                end
            )
        end
    )
    LocalPlayer_upv_1.CharacterAdded:Connect(
        function(a49)
            --[[
              line: 1005
              upvalues:
                paintSelf (copy, index: 1)
            ]]
            a49:WaitForChild("Head", 10)
            paintSelf()
        end
    )
    State_upv_1.PlayerStateChanged:Connect(paintSelf)
    a1.HudHiddenChanged:Connect(paintSelf)
    task.defer(paintSelf)
    local function addFighter(a50)
        --[[
          name: addFighter
          line: 1014
          upvalues:
            Players_upv_1 (copy, index: 1)
            attach (copy, index: 2)
        ]]
        if not a50:IsA("Model") or (Players_upv_1:GetPlayerFromCharacter(a50)) then
            return
        end
        attach(a50)
    end
    for v131, value_8 in {"Combatant", "Bot"} do
        for v132, value_9 in CollectionService_upv_1:GetTagged(value_8) do
            local v129 = value_9:IsA("Model")
            if not (v129) then
                continue
            end
            local v130 = Players_upv_1:GetPlayerFromCharacter(value_9)
            if not (v130) then
                attach(value_9)
            end
        end
        CollectionService_upv_1:GetInstanceAddedSignal(value_8):Connect(addFighter)
        CollectionService_upv_1:GetInstanceRemovedSignal(value_8):Connect(
            function(a51)
                --[[
                  line: 1024
                  upvalues:
                    CollectionService_upv_1 (copy, index: 1)
                    Players_upv_1 (copy, index: 2)
                    detach (copy, index: 3)
                ]]
                if a51:IsA("Model") then
                    local v131 = CollectionService_upv_1:HasTag(a51, "Combatant") or (CollectionService_upv_1:HasTag(a51, "Bot"))
                    if (v131) or (Players_upv_1:GetPlayerFromCharacter(a51)) then
                        return
                    end
                    detach(a51)
                end
            end
        )
    end
    local function repaintAll()
        --[[
          name: repaintAll
          line: 1032
          upvalues:
            tbl_upv_2 (copy, index: 1)
            roleOf (copy, index: 2)
            paint (copy, index: 3)
        ]]
        for key_1, value_10 in tbl_upv_2 do
            value_10.role = roleOf(key_1)
            paint(value_10)
        end
    end
    State_upv_1.PlayerStateChanged:Connect(repaintAll)
    State_upv_1.WatchChanged:Connect(repaintAll)
    State_upv_1.AttrChanged:Connect(
        function(a52)
            --[[
              line: 1040
              upvalues:
                repaintAll (copy, index: 1)
            ]]
            if a52 ~= "Team" and a52 ~= "MatchId" then
                return
            end
            repaintAll()
        end
    )
    State_upv_1.MatchChanged:Connect(
        function()
            --[[
              line: 1045
              upvalues:
                tbl_upv_2 (copy, index: 1)
                roleOf (copy, index: 2)
                paint (copy, index: 3)
            ]]
            for key_2, value_11 in tbl_upv_2 do
                local v132 = roleOf(key_2)
                if v132 ~= value_11.role then
                    value_11.role = v132
                    paint(value_11)
                end
            end
        end
    )
    a1.HudHiddenChanged:Connect(
        function()
            --[[
              line: 1054
              upvalues:
                tbl_upv_2 (copy, index: 1)
                a1 (copy, index: 2)
                paintQueue (copy, index: 3)
            ]]
            for _, value_12 in tbl_upv_2 do
                if value_12.flat and a1.HudHidden then
                    value_12.flat.frame.Visible = false
                end
                if value_12.bb then
                    value_12.bb.Enabled = (value_12.role == "lobby") and ((value_12.head ~= nil) and (not a1.HudHidden))
                end
                paintQueue(value_12)
            end
        end
    )
    local tbl_upv_16 = {}
    local u20 = 0
    local function setFaded(a53, a54)
        --[[
          name: setFaded
          line: 507
        ]]
        if a53.faded == a54 then
            return
        end
        a53.faded = a54
        local v133 = (a54 and 0.4) or 0
        a53.name.TextTransparency = v133
        a53.nameStroke.Transparency = (a54 and 0.5) or 0.1
        a53.level.TextTransparency = v133
        a53.levelStroke.Transparency = (a54 and 0.5) or 0.1
        a53.fill.BackgroundTransparency = v133
        a53.barBg.BackgroundTransparency = (a54 and 0.6) or 0.3
        a53.chevron:FindFirstChild("Tri").BackgroundTransparency = v133
    end
    UI_upv_1.Every(
        u4,
        0.2,
        function()
            --[[
              line: 1069
              upvalues:
                u20 (ref,  index: 1)
                Players_upv_1 (copy, index: 2)
                LocalPlayer_upv_1 (copy, index: 3)
                u14 (ref,  index: 4)
                tbl_upv_2 (copy, index: 5)
                Workspace_upv_1 (copy, index: 6)
                attach (copy, index: 7)
                State_upv_1 (copy, index: 8)
                tbl_upv_16 (copy, index: 9)
                u6 (copy, index: 10)
                Combat_upv_1 (copy, index: 11)
                setFaded (copy, index: 12)
                tbl_upv_6 (copy, index: 13)
                refreshActive (copy, index: 14)
            ]]
            local v134 = os.clock()
            if u20 <= v134 then
                u20 = v134 + 1
                for _, value_13 in Players_upv_1:GetPlayers() do
                    local Character_8 = value_13.Character
                    if not (Character_8) then
                        continue
                    end
                    if value_13 ~= LocalPlayer_upv_1 or u14 then
                        if tbl_upv_2[Character_8] then
                            continue
                        end
                        if Character_8:IsDescendantOf(Workspace_upv_1) then
                            attach(Character_8)
                        end
                    end
                end
            end
            if not State_upv_1.SeesMatch() then
                return
            end
            v134 = Workspace_upv_1.CurrentCamera
            if not v134 then
                return
            end
            local Position_2 = v134.CFrame.Position
            v134 = LocalPlayer_upv_1.Character and (LocalPlayer_upv_1.Character:FindFirstChild("Head"))
            local v135
            if v134 and v134:IsA("BasePart") then
                v135 = State_upv_1.Watching() or v134.Position
            else
                v135 = nil
            end
            local v136 = false
            local v137, v138, v139, v138, v138, v140, _, v138 = nil, nil, nil, nil, nil, nil, nil, nil
            v134 = v136
            local value_14 = nil
            for key_3, value_14 in tbl_upv_2 do
                if value_14.role == "enemy" or value_14.role == "ally" then
                    v138 = false
                    v139 = false
                    v140 = value_14.head
                    local v141 = ((value_14.role ~= "enemy") and 450) or 200
                    if v140 then
                        v137 = true
                        if value_14.hum ~= nil then
                            v137 = value_14.hum.Health > 0
                        end
                        if v137 then
                            v137 = v140.Position - Position_2
                            if v137.Magnitude <= v141 then
                                table.clear(tbl_upv_16)
                                table.insert(tbl_upv_16, key_3)
                                if LocalPlayer_upv_1.Character then
                                    table.insert(tbl_upv_16, LocalPlayer_upv_1.Character)
                                end
                                local FX_1 = Workspace_upv_1:FindFirstChild("FX")
                                if FX_1 then
                                    table.insert(tbl_upv_16, FX_1)
                                end
                                local Projectiles_1 = Workspace_upv_1:FindFirstChild("Projectiles")
                                if Projectiles_1 then
                                    table.insert(tbl_upv_16, Projectiles_1)
                                end
                                u6.FilterDescendantsInstances = tbl_upv_16
                                v138 = Workspace_upv_1:Raycast(Position_2, v137, u6) == nil
                            end
                            if value_14.role == "enemy" then
                                local v142 = Combat_upv_1.SmokeBlocks(Position_2, v140.Position) or v135 ~= nil and Combat_upv_1.SmokeBlocks(v135, v140.Position)
                                v139 = v142
                                v142 = v138 and (not v139)
                                v138 = v142
                            end
                        end
                    end
                    if v139 ~= value_14.smoked then
                        value_14.smoked = v139
                        v134 = true
                    end
                    if value_14.role ~= "ally" or not (value_14.flat) then
                        if v138 == value_14.visibleLOS then
                            v136 = v134
                        else
                            v136 = true
                        end
                        value_14.visibleLOS = v138
                        v134 = v136
                        v138 = false
                        if value_14.head ~= nil then
                            v138 = true
                            if value_14.hum ~= nil then
                                v138 = value_14.hum.Health > 0
                            end
                            if v138 then
                                v138 = true
                                if value_14.role ~= "ally" then
                                    v138 = (value_14.role == "enemy") and (value_14.visibleLOS)
                                end
                            end
                        end
                        if v138 == value_14.listed or v138 and not (#tbl_upv_6 < 12) then
                            v139 = value_14.outline ~= nil
                            v140 = false
                            if value_14.role == "enemy" then
                                v140 = true
                                if value_14.hum ~= nil then
                                    v140 = value_14.hum.Health > 0
                                end
                                v140 = v140 and (value_14.head ~= nil) and (not value_14.smoked)
                            end
                            if v139 ~= v140 then
                                v134 = true
                                continue
                            end
                        end
                        v134 = true
                        continue
                    end
                    setFaded(value_14.flat, not v138)
                    v136 = v134
                    value_14.visibleLOS = v138
                    v134 = v136
                    v138 = false
                    if value_14.head ~= nil then
                        v138 = true
                        if value_14.hum ~= nil then
                            v138 = value_14.hum.Health > 0
                        end
                        if v138 then
                            v138 = true
                            if value_14.role ~= "ally" then
                                v138 = (value_14.role == "enemy") and (value_14.visibleLOS)
                            end
                        end
                    end
                    if v138 == value_14.listed or v138 and not (#tbl_upv_6 < 12) then
                        v139 = value_14.outline ~= nil
                        v140 = false
                        if value_14.role == "enemy" then
                            v140 = true
                            if value_14.hum ~= nil then
                                v140 = value_14.hum.Health > 0
                            end
                            v140 = v140 and (value_14.head ~= nil) and (not value_14.smoked)
                        end
                        if v139 ~= v140 then
                            v134 = true
                            continue
                        end
                    end
                    v134 = true
                    continue
                end
                v138 = false
                if value_14.head ~= nil then
                    v138 = true
                    if value_14.hum ~= nil then
                        v138 = value_14.hum.Health > 0
                    end
                    if v138 then
                        v138 = true
                        if value_14.role ~= "ally" then
                            v138 = (value_14.role == "enemy") and (value_14.visibleLOS)
                        end
                    end
                end
                if v138 == value_14.listed or v138 and not (#tbl_upv_6 < 12) then
                    v139 = value_14.outline ~= nil
                    local v143 = false
                    if value_14.role ~= "enemy" then
                        v140 = v143
                    else
                        v140 = true
                        if value_14.hum ~= nil then
                            v140 = value_14.hum.Health > 0
                        end
                        v140 = v140 and (value_14.head ~= nil) and (not value_14.smoked)
                    end
                    if v139 ~= v140 then
                        v134 = true
                        continue
                    end
                end
                v134 = true
            end
            if not v134 then
                return
            end
            refreshActive()
        end
    )
    a1.Debug.plateSelf = function(a55)
        --[[
          line: 1148
          upvalues:
            u14 (ref,  index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            watchPlayer (copy, index: 3)
            tbl_upv_2 (copy, index: 4)
            detach (copy, index: 5)
            paintSelf (copy, index: 6)
        ]]
        u14 = a55 == true
        local Character_9 = LocalPlayer_upv_1.Character
        if u14 then
            watchPlayer(LocalPlayer_upv_1)
        elseif Character_9 and tbl_upv_2[Character_9] then
            detach(Character_9)
        end
        paintSelf()
        return true
    end
    a1.Debug.plates = function()
        --[[
          line: 1160
          upvalues:
            tbl_upv_6 (copy, index: 1)
            tbl_upv_2 (copy, index: 2)
            Players_upv_1 (copy, index: 3)
            u13 (ref,  index: 4)
            a1 (copy, index: 5)
        ]]
        local tbl_17 = {}
        for _, value_15 in tbl_upv_6 do
            tbl_17[value_15] = true
        end
        local tbl_18 = {}
        local v144 = nil
        for key_4, value_16 in tbl_upv_2 do
            local tbl_19 = {visible = 0, head = 0, parent = 0, smoked = 0, hp = 0, onScreen = 0, role = 0, name = 0, los = 0, active = 0, alive = 0}
            local v145 = key_4:GetAttribute("DisplayName")
            if type(v145) ~= "string" or v145 == "" then
                local v146 = Players_upv_1:GetPlayerFromCharacter(key_4)
                if v146 then
                    v144 = v146.DisplayName
                else
                    v144 = key_4.Name
                end
                tbl_19.name = v144
                tbl_19.role = value_16.role
                tbl_19.head = value_16.head ~= nil
                v144 = true
                if value_16.hum ~= nil then
                    v144 = value_16.hum.Health > 0
                end
                tbl_19.alive = v144
                local v147 = nil
                v144 = ((not (value_16.hum)) and -1) or (math.floor(v147.hum.Health))
                tbl_19.hp = v144
                tbl_19.los = v147.visibleLOS
                tbl_19.smoked = v147.smoked
                tbl_19.active = tbl_17[v147] == true
                tbl_19.visible = (value_16.flat ~= nil) and (v147.flat.frame.Visible)
                tbl_19.onScreen = v147.onScreen
                tbl_19.parent = ((not (key_4.Parent)) and "nil") or (key_4.Parent.Name)
                table.insert(tbl_18, tbl_19)
            end
            v144 = v145
            tbl_19.name = v144
            tbl_19.role = value_16.role
            tbl_19.head = value_16.head ~= nil
            v144 = true
            if value_16.hum ~= nil then
                v144 = value_16.hum.Health > 0
            end
            tbl_19.alive = v144
            local v147 = nil
            v144 = ((not (value_16.hum)) and -1) or (math.floor(v147.hum.Health))
            tbl_19.hp = v144
            tbl_19.los = v147.visibleLOS
            tbl_19.smoked = v147.smoked
            tbl_19.active = tbl_17[v147] == true
            tbl_19.visible = (value_16.flat ~= nil) and (v147.flat.frame.Visible)
            tbl_19.onScreen = v147.onScreen
            tbl_19.parent = ((not (key_4.Parent)) and "nil") or (key_4.Parent.Name)
            table.insert(tbl_18, tbl_19)
        end
        local tbl_20 = {render = 0, hudHidden = 0}
        tbl_20.plates = tbl_18
        tbl_20.render = u13 ~= nil
        tbl_20.hudHidden = a1.HudHidden == true
        return tbl_20
    end
end
return tbl_1