local CollectionService_upv_1 = game:GetService("CollectionService")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local Workspace_upv_1 = game:GetService("Workspace")
local v1 = ReplicatedStorage_1:WaitForChild("Shared")
local Tribes_upv_1 = require(v1:WaitForChild("Tribes"))
local TribeArt_upv_1 = require(v1:WaitForChild("TribeArt"))
v1 = {}
local u1 = Color3.fromRGB(176, 162, 134)
local u2 = Color3.fromRGB(228, 232, 240)
local u3 = Color3.fromRGB(142, 149, 166)
local u4 = Color3.fromRGB(255, 186, 46)
local tbl_upv_1 = {u4, Color3.fromRGB(196, 206, 222), Color3.fromRGB(222, 140, 74)}
local u5 = Color3.fromRGB(14, 15, 20)
function v1.Init(a1)
    --[[
      name: Init
      line: 29
      upvalues:
        Tribes_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
        CollectionService_upv_1 (copy, index: 3)
        Workspace_upv_1 (copy, index: 4)
        TribeArt_upv_1 (copy, index: 5)
        u5 (copy, index: 6)
        u4 (copy, index: 7)
        u3 (copy, index: 8)
        tbl_upv_1 (copy, index: 9)
        u2 (copy, index: 10)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local Tribes_upv_2 = a1.Tribes
    local TribeEmblem_upv_1 = require(script.Parent.Parent:WaitForChild("TribeEmblem"))
    TribeEmblem_upv_1.Init(UI_upv_1)
    local tbl_upv_2 = {}
    local tbl_upv_3 = {}
    local tbl_upv_4 = {}
    local function paintBanner(a2)
        --[[
          name: paintBanner
          line: 40
          upvalues:
            tbl_upv_2 (ref,  index: 1)
            tbl_upv_4 (copy, index: 2)
            Tribes_upv_1 (copy, index: 3)
            u1 (copy, index: 4)
            TribeEmblem_upv_1 (copy, index: 5)
            UI_upv_1 (copy, index: 6)
            Fonts_upv_1 (copy, index: 7)
        ]]
        local v2 = a2:GetAttribute("Rank")
        local v3
        if type(v2) ~= "number" then
            v3 = nil
        else
            v3 = tbl_upv_2[v2]
        end
        local v4
        if v3 then
            v4 = string.format("%s:%s:%s:%s", tostring(v3.id), tostring(v3.icon), tostring(v3.color1), tostring(v3.color2))
        else
            v4 = "-"
        end
        if tbl_upv_4[a2] == v4 then
            return
        end
        tbl_upv_4[a2] = v4
        local v5
        if v3 then
            v5 = Tribes_upv_1.Color(v3.color1):Lerp(Color3.new(0, 0, 0), 0.12)
        else
            v5 = u1
        end
        a2.Color = v5
        local v6 = a2:FindFirstAncestorOfClass("Model")
        if v6 then
            for _, value_1 in v6:GetDescendants() do
                if not (value_1:IsA("BasePart")) then
                    continue
                end
                if value_1:GetAttribute("BannerTail") == v2 then
                    value_1.Color = v5
                end
            end
        end
        local Placeholder_1 = a2:FindFirstChild("Placeholder")
        if Placeholder_1 and Placeholder_1:IsA("SurfaceGui") then
            Placeholder_1.Enabled = v3 == nil
        end
        local Emblem_1 = a2:FindFirstChild("Emblem")
        if not Emblem_1 then
            return
        end
        for _, value_2 in Emblem_1:GetChildren() do
            value_2:Destroy()
        end
        if not v3 then
            return
        end
        local tbl_5 = {}
        tbl_5.AnchorPoint = Vector2.new(0.5, 0)
        tbl_5.Position = UDim2.new(0.5, 0, 0, 22)
        tbl_5.Parent = Emblem_1
        TribeEmblem_upv_1.new(116, tbl_5):Set(v3.icon, v3.color2, v3.color1, v3.tag)
        local v7 = UI_upv_1.new("TextLabel", {AutoLocalize = false, Name = "Tag", TextScaled = true, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 160), Size = UDim2.new(1, -16, 0, 40), Text = "[" .. tostring(v3.tag) .. "]", FontFace = Fonts_upv_1.Display, TextColor3 = Tribes_upv_1.Color(v3.color2), Parent = Emblem_1})
        UI_upv_1.TextStroke(Color3.new(0, 0, 0), 1.5, 0.6).Parent = v7
    end
    local function paintMap()
        --[[
          name: paintMap
          line: 98
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            TribeArt_upv_1 (copy, index: 2)
            UI_upv_1 (copy, index: 3)
        ]]
        local TribeHall_1 = Workspace_upv_1:FindFirstChild("TribeHall")
        local v8 = TribeHall_1 and (TribeHall_1:FindFirstChild("MapCloth", true))
        local v9 = v8 and (v8:FindFirstChild("Map"))
        if not v9 or TribeArt_upv_1.Map.image == "" then
            return
        end
        if not (v9:FindFirstChild("Base")) then
            local Title_1 = v9:FindFirstChild("Title")
            if Title_1 and Title_1:IsA("GuiObject") then
                Title_1.Visible = false
            end
            UI_upv_1.new("ImageLabel", {Name = "Base", Image = TribeArt_upv_1.Map.image, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop, Parent = v8})
        end
    end
    local LocalPlayer_upv_1 = game:GetService("Players").LocalPlayer
    local u6 = UI_upv_1.new("ScreenGui", {ResetOnSpawn = false, Name = "TR_TribeBoards", Parent = a1.PlayerGui})
    local tbl_upv_6 = {}
    local u7 = "top"
    local function paintAll()
        --[[
          name: paintAll
          line: 90
          upvalues:
            CollectionService_upv_1 (copy, index: 1)
            paintBanner (copy, index: 2)
        ]]
        for _, value_3 in CollectionService_upv_1:GetTagged("TribeBanner") do
            if value_3:IsA("BasePart") then
                paintBanner(value_3)
            end
        end
    end
    local function fillBoard(a3)
        --[[
          name: fillBoard
          line: 195
          upvalues:
            u7 (ref,  index: 1)
            tbl_upv_3 (ref,  index: 2)
            tbl_upv_2 (ref,  index: 3)
            LocalPlayer_upv_1 (copy, index: 4)
            Tribes_upv_1 (copy, index: 5)
            TribeEmblem_upv_1 (copy, index: 6)
            u2 (copy, index: 7)
            UI_upv_1 (copy, index: 8)
            u3 (copy, index: 9)
        ]]
        local v10
        if u7 ~= "alltime" then
            v10 = tbl_upv_2
        else
            v10 = tbl_upv_3
        end
        local v11 = LocalPlayer_upv_1:GetAttribute("TribeId")
        local v12 = nil
        if u7 ~= "alltime" then
            v12 = math.max(0, Tribes_upv_1.WeekEndsAt(Tribes_upv_1.WeekOf(os.time())) - os.time())
            local v13
            if v12 >= 86400 then
                v13 = ("%*D %*H"):format(v12 // 86400, (v12 % 86400) // 3600)
            else
                v13 = ("%*H %*M"):format(v12 // 3600, (v12 % 3600) // 60)
            end
            a3.caption.Text = ("THIS WEEK  \194\183  RESETS IN %*"):format(v13)
        else
            a3.caption.Text = "ALL TIME  \194\183  GLORY"
        end
        local v14 = nil
        for key_1, value_4 in a3.rows do
            local v15 = v10[key_1]
            local v16 = a3.emblems[key_1]
            if not (v15) then
                value_4.crest.Visible = false
                value_4.name.Text = "-"
                value_4.name.TextColor3 = u3
                value_4.value.Text = ""
                value_4.stroke.Enabled = false
                continue
            end
            if not (v16) then
                v16 = TribeEmblem_upv_1.new(a3.emblemSize, {AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Parent = value_4.crest})
                a3.emblems[key_1] = v16
            end
            v16:Set(v15.icon, v15.color1, v15.color2, v15.tag)
            value_4.crest.Visible = true
            value_4.name.Text = string.format("<font color=\"#%s\">%s</font> %s", TribeEmblem_upv_1.TagColor(v15.color1):ToHex(), TribeEmblem_upv_1.Tag(v15.tag), tostring(v15.name or ""))
            value_4.name.TextColor3 = u2
            local value_5 = value_4.value
            local FormatNumber_1 = UI_upv_1.FormatNumber
            if u7 ~= "alltime" then
                v14 = v15.weekRenown
            else
                v14 = v15.renown
            end
            value_5.Text = FormatNumber_1(tonumber(v14) or 0)
            local stroke_1 = value_4.stroke
            stroke_1.Enabled = type(v11) == "number" and v11 > 0 and v15.id == v11
        end
    end
    local function buildBoard(a4)
        --[[
          name: buildBoard
          line: 121
          upvalues:
            UI_upv_1 (copy, index: 1)
            u6 (copy, index: 2)
            u5 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
            u4 (copy, index: 5)
            Theme_upv_1 (copy, index: 6)
            u3 (copy, index: 7)
            tbl_upv_1 (copy, index: 8)
            u2 (copy, index: 9)
        ]]
        local v18 = math.floor((800 * a4.Size.Y) / math.max(a4.Size.X, 0.1))
        local v19 = UI_upv_1.new("SurfaceGui", {LightInfluence = 0, Name = "TopTribes", ResetOnSpawn = false, MaxDistance = 220, Adornee = a4, Face = Enum.NormalId.Front, SizingMode = Enum.SurfaceGuiSizingMode.FixedSize, CanvasSize = Vector2.new(800, v18), ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = u6})
        local v20 = UI_upv_1.new("Frame", {BackgroundTransparency = 0.05, Size = UDim2.fromScale(1, 1), BackgroundColor3 = u5, Parent = v19})
        UI_upv_1.new("UIPadding", {PaddingTop = UDim.new(0.03, 0), PaddingBottom = UDim.new(0.03, 0), PaddingLeft = UDim.new(0.04, 0), PaddingRight = UDim.new(0.04, 0), Parent = v20})
        local v21 = UI_upv_1.new("TextLabel", {Text = "TOP TRIBES", TextScaled = true, Size = UDim2.fromScale(1, 0.1), FontFace = Fonts_upv_1.Display, TextColor3 = u4, Parent = v20})
        UI_upv_1.TextStroke(Theme_upv_1.Colors.Void, 3, 0).Parent = v21
        local v22 = UI_upv_1.new("TextLabel", {Text = "", TextScaled = true, Position = UDim2.fromScale(0, 0.105), Size = UDim2.fromScale(1, 0.045), FontFace = Fonts_upv_1.Heavy, TextColor3 = u3, Parent = v20})
        UI_upv_1.new("Frame", {Position = UDim2.fromScale(0, 0.162), Size = UDim2.new(1, 0, 0, 4), BackgroundColor3 = Color3.fromRGB(176, 120, 22), Parent = v20})
        local v23 = UI_upv_1.new("Frame", {Position = UDim2.fromScale(0, 0.185), Size = UDim2.fromScale(1, 0.815), [1] = UI_upv_1.new("UIListLayout", {Padding = UDim.new(0.022, 0), SortOrder = Enum.SortOrder.LayoutOrder}), Parent = v20})
        v20 = (v18 * 0.94) * 0.815 * 0.18
        v18 = math.clamp(math.floor(v20 * 0.36), 14, 60)
        local tbl_7 = {}
        local v24 = nil
        for n_1 = 1, 5 do
            local new_1 = UI_upv_1.new
            local tbl_8 = {}
            tbl_8.Name = "Row" .. n_1
            tbl_8.Size = UDim2.fromScale(1, 0.18)
            local v25
            if n_1 % 2 ~= 1 then
                v25 = Color3.fromRGB(24, 26, 34)
            else
                v25 = Color3.fromRGB(30, 33, 42)
            end
            tbl_8.BackgroundColor3 = v25
            tbl_8.LayoutOrder = n_1
            tbl_8[1] = UI_upv_1.Corner(UDim.new(0.18, 0))
            tbl_8.Parent = v23
            local v26 = new_1("Frame", tbl_8)
            local v27 = UI_upv_1.new("UIStroke", {Enabled = false, Thickness = 4, Color = Theme_upv_1.Colors.Ally, Parent = v26})
            local v28 = math.floor(v20 * 0.8)
            local new_2 = UI_upv_1.new
            local tbl_9 = {TextColor3 = 0, Parent = 0}
            tbl_9.Position = UDim2.fromScale(0.005, 0)
            tbl_9.Size = UDim2.fromScale(0.09, 1)
            tbl_9.Text = "#" .. n_1
            tbl_9.FontFace = Fonts_upv_1.Display
            tbl_9.TextSize = v18
            v24 = tbl_upv_1[n_1] or u2
            tbl_9.TextColor3 = v24
            tbl_9.Parent = v26
            tbl_7[n_1] = {
                frame = v26,
                rank = new_2("TextLabel", tbl_9),
                crest = UI_upv_1.new("Frame", {Name = "Crest", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0.095, 0.5), Size = UDim2.fromOffset(v28, v28), Parent = v26}),
                name = UI_upv_1.new("TextLabel", {AutoLocalize = false, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0.095, v28 + 14, 0.5, 0), Size = UDim2.new(0.705, -(v28 + 14), 0.5, 0), Text = "-", RichText = true, FontFace = Fonts_upv_1.Heavy, TextScaled = true, TextWrapped = false, TextColor3 = u2, TextXAlignment = Enum.TextXAlignment.Left, [1] = UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = v18, MinTextSize = math.floor(v18 * 0.55)}), Parent = v26}),
                value = UI_upv_1.new("TextLabel", {Text = "", AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(0.975, 0), Size = UDim2.fromScale(0.175, 1), FontFace = Fonts_upv_1.Display, TextSize = v18, TextColor3 = u4, TextXAlignment = Enum.TextXAlignment.Right, Parent = v26}),
                stroke = v27
            }
        end
        local tbl_10 = {}
        tbl_10.sg = v19
        tbl_10.rows = tbl_7
        tbl_10.caption = v22
        tbl_10.emblems = {}
        tbl_10.emblemSize = math.floor(v20 * 0.74)
        return tbl_10
    end
    for _, value_6 in CollectionService_upv_1:GetTagged("TribeLeaderboard") do
        local v29 = value_6:IsA("BasePart")
        if not (v29) then
            continue
        end
        if not (tbl_upv_6[value_6]) then
            local v30 = buildBoard(value_6)
            tbl_upv_6[value_6] = v30
            fillBoard(v30)
        end
    end
    local function addBoard(a5)
        --[[
          name: addBoard
          line: 235
          upvalues:
            tbl_upv_6 (copy, index: 1)
            buildBoard (copy, index: 2)
            fillBoard (copy, index: 3)
        ]]
        if not a5:IsA("BasePart") then
            return
        end
        if not (tbl_upv_6[a5]) then
            local v31 = buildBoard(a5)
            tbl_upv_6[a5] = v31
            fillBoard(v31)
        end
    end
    CollectionService_upv_1:GetInstanceAddedSignal("TribeLeaderboard"):Connect(addBoard)
    CollectionService_upv_1:GetInstanceRemovedSignal("TribeLeaderboard"):Connect(
        function(a6)
            --[[
              line: 246
              upvalues:
                tbl_upv_6 (copy, index: 1)
            ]]
            local v32 = tbl_upv_6[a6]
            if not v32 then
                return
            end
            tbl_upv_6[a6] = nil
            v32.sg:Destroy()
        end
    )
    local function fillAll()
        --[[
          name: fillAll
          line: 229
          upvalues:
            tbl_upv_6 (copy, index: 1)
            fillBoard (copy, index: 2)
        ]]
        for _, value_7 in tbl_upv_6 do
            fillBoard(value_7)
        end
    end
    LocalPlayer_upv_1:GetAttributeChangedSignal("TribeId"):Connect(fillAll)
    local function fadeText(a7, a8)
        --[[
          name: fadeText
          line: 255
          upvalues:
            tbl_upv_6 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        local v33 = TweenInfo.new(a8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        for _, value_8 in tbl_upv_6 do
            UI_upv_1.Tween(value_8.caption, v33, {TextTransparency = a7})
            for v34, value_9 in value_8.rows do
                UI_upv_1.Tween(value_9.name, v33, {TextTransparency = a7})
                UI_upv_1.Tween(value_9.value, v33, {TextTransparency = a7})
            end
        end
    end
    task.spawn(
        function()
            --[[
              line: 267
              upvalues:
                u7 (ref,  index: 1)
                tbl_upv_3 (ref,  index: 2)
                tbl_upv_2 (ref,  index: 3)
                tbl_upv_6 (copy, index: 4)
                fadeText (copy, index: 5)
                fillBoard (copy, index: 6)
            ]]
            task.wait(8)
            local v34
            if u7 == "top" and #tbl_upv_3 > 0 then
                v34 = "alltime"
            else
                v34 = ((#tbl_upv_2 > 0) and "top") or "alltime"
            end
            if v34 == u7 then
                if v34 == u7 then
                    return
                end
                u7 = v34
            elseif next(tbl_upv_6) then
                fadeText(1, 0.18)
                task.wait(0.2)
                u7 = v34
                for _, value_10 in tbl_upv_6 do
                    fillBoard(value_10)
                end
                fadeText(0, 0.3)
            elseif v34 ~= u7 then
                u7 = v34
            end
        end
    )
    CollectionService_upv_1:GetInstanceAddedSignal("TribeBanner"):Connect(
        function(a9)
            --[[
              line: 285
              upvalues:
                tbl_upv_4 (copy, index: 1)
                paintBanner (copy, index: 2)
                paintMap (copy, index: 3)
            ]]
            if not a9:IsA("BasePart") then
                return
            end
            tbl_upv_4[a9] = nil
            paintBanner(a9)
            paintMap()
        end
    )
    CollectionService_upv_1:GetInstanceRemovedSignal("TribeBanner"):Connect(
        function(a10)
            --[[
              line: 292
              upvalues:
                tbl_upv_4 (copy, index: 1)
            ]]
            tbl_upv_4[a10] = nil
        end
    )
    task.spawn(
        function()
            --[[
              line: 296
              upvalues:
                Workspace_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
                Tribes_upv_2 (copy, index: 3)
                tbl_upv_2 (ref,  index: 4)
                paintAll (copy, index: 5)
                tbl_upv_3 (ref,  index: 6)
                u7 (ref,  index: 7)
                tbl_upv_6 (copy, index: 8)
                fillBoard (copy, index: 9)
                paintMap (copy, index: 10)
            ]]
            if Workspace_upv_1:FindFirstChild("TribeHall") then
                if a1.State.InMatch() then
                    task.wait(120)
                else
                    local v35, v36 = Tribes_upv_2.Board("top")
                    if v35 then
                        if type(v36) ~= "table" then
                            local v37, v38 = Tribes_upv_2.Board("alltime")
                            if v37 and type(v38) == "table" then
                                tbl_upv_3 = {}
                                for _, value_11 in v38 do
                                    if type(value_11) ~= "table" or not ((tonumber(value_11.renown) or 0) > 0) then
                                        continue
                                    end
                                    if #tbl_upv_3 < 5 then
                                        table.insert(tbl_upv_3, value_11)
                                    end
                                end
                            end
                            if u7 == "top" and #tbl_upv_2 == 0 then
                                u7 = "alltime"
                            end
                            for _, value_12 in tbl_upv_6 do
                                fillBoard(value_12)
                            end
                            paintMap()
                            task.wait(120)
                        else
                            tbl_upv_2 = {}
                            for _, value_13 in v36 do
                                if type(value_13) ~= "table" or not ((tonumber(value_13.weekRenown) or 0) > 0) then
                                    continue
                                end
                                if #tbl_upv_2 < 5 then
                                    table.insert(tbl_upv_2, value_13)
                                end
                            end
                            paintAll()
                            local v37, v38 = Tribes_upv_2.Board("alltime")
                            if v37 and type(v38) == "table" then
                                tbl_upv_3 = {}
                                for _, value_11 in v38 do
                                    if type(value_11) ~= "table" or not ((tonumber(value_11.renown) or 0) > 0) then
                                        continue
                                    end
                                    if #tbl_upv_3 < 5 then
                                        table.insert(tbl_upv_3, value_11)
                                    end
                                end
                            end
                            if u7 == "top" and #tbl_upv_2 == 0 then
                                u7 = "alltime"
                            end
                            for _, value_12 in tbl_upv_6 do
                                fillBoard(value_12)
                            end
                            paintMap()
                            task.wait(120)
                        end
                    else
                        local v37, v38 = Tribes_upv_2.Board("alltime")
                        if v37 and type(v38) == "table" then
                            tbl_upv_3 = {}
                            for _, value_11 in v38 do
                                if type(value_11) ~= "table" or not ((tonumber(value_11.renown) or 0) > 0) then
                                    continue
                                end
                                if #tbl_upv_3 < 5 then
                                    table.insert(tbl_upv_3, value_11)
                                end
                            end
                        end
                        if u7 == "top" and #tbl_upv_2 == 0 then
                            u7 = "alltime"
                        end
                        for _, value_12 in tbl_upv_6 do
                            fillBoard(value_12)
                        end
                        paintMap()
                        task.wait(120)
                    end
                end
            else
                task.wait(120)
            end
        end
    )
end
return v1