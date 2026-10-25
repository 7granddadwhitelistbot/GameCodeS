local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local Ranks_upv_1 = require(ReplicatedStorage_1.Shared.Ranks)
local UIAssets_upv_1 = require(ReplicatedStorage_1.Shared.UIAssets)
local UI_upv_1 = require(script.Parent.UI)
local Theme_upv_1 = require(script.Parent.Theme)
local Colors_upv_1 = Theme_upv_1.Colors
local Fonts_upv_1 = Theme_upv_1.Fonts
local fromRGB_1 = Color3.fromRGB
local tbl_upv_1 = {}
tbl_upv_1.Ranks = Ranks_upv_1
local tbl_upv_2 = {}
tbl_upv_2.bronze = {main = fromRGB_1(214, 136, 78), dark = fromRGB_1(104, 56, 26)}
tbl_upv_2.silver = {main = fromRGB_1(206, 216, 232), dark = fromRGB_1(92, 104, 126)}
tbl_upv_2.gold = {main = fromRGB_1(255, 204, 64), dark = fromRGB_1(150, 98, 8)}
tbl_upv_2.platinum = {main = fromRGB_1(146, 236, 222), dark = fromRGB_1(38, 118, 120)}
tbl_upv_2.diamond = {main = fromRGB_1(86, 202, 255), dark = fromRGB_1(18, 86, 176)}
tbl_upv_2.master = {main = fromRGB_1(186, 116, 255), dark = fromRGB_1(76, 30, 150)}
tbl_upv_2.grandmaster = {main = fromRGB_1(255, 84, 96), dark = fromRGB_1(128, 18, 34)}
tbl_upv_2.immortal = {main = fromRGB_1(255, 226, 120), dark = fromRGB_1(34, 26, 18)}
function tbl_upv_1.Color(a1)
    --[[
      name: Color
      line: 36
      upvalues:
        Ranks_upv_1 (copy, index: 1)
        tbl_upv_2 (copy, index: 2)
    ]]
    local v1 = tbl_upv_2[Ranks_upv_1.Get(a1).id] or (tbl_upv_2.bronze)
    return v1.main, v1.dark
end
local function artFor(a1)
    --[[
      name: artFor
      line: 42
      upvalues:
        UIAssets_upv_1 (copy, index: 1)
        Ranks_upv_1 (copy, index: 2)
    ]]
    local v2 = ((type(UIAssets_upv_1.Ranks) == "table") and (UIAssets_upv_1.Ranks)) or nil
    local v3 = v2 and (v2[Ranks_upv_1.Get(a1).id])
    if type(v3) == "string" and v3 ~= "" then
        return v3
    end
    return nil
end
local function drawFallback(a1, a2, a3)
    --[[
      name: drawFallback
      line: 49
      upvalues:
        tbl_upv_1 (copy, index: 1)
        UI_upv_1 (copy, index: 2)
        Theme_upv_1 (copy, index: 3)
        Ranks_upv_1 (copy, index: 4)
        Fonts_upv_1 (copy, index: 5)
        Colors_upv_1 (copy, index: 6)
    ]]
    local v4, v5 = tbl_upv_1.Color(a2)
    local tbl_3 = {}
    tbl_3.Name = "Body"
    tbl_3.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_3.Position = UDim2.fromScale(0.5, 0.5)
    tbl_3.Size = UDim2.fromScale(0.68, 0.68)
    tbl_3.Rotation = 45
    tbl_3.BackgroundColor3 = Color3.new(1, 1, 1)
    tbl_3.ZIndex = a3
    tbl_3[1], tbl_3[2], tbl_3[3] = UI_upv_1.Corner(UDim.new(0.14, 0)), UI_upv_1.Gradient(Theme_upv_1.Lighten(v4, 0.25), v5, 90), UI_upv_1.Stroke(Theme_upv_1.Lighten(v4, 0.5), 1.5, 0.15)
    tbl_3.Parent = a1
    local v6 = UI_upv_1.new("Frame", tbl_3)
    local tbl_4 = {}
    tbl_4.Name = "Core"
    tbl_4.AnchorPoint = Vector2.new(0.5, 0.5)
    tbl_4.Position = UDim2.fromScale(0.5, 0.5)
    tbl_4.Size = UDim2.fromScale(0.5, 0.5)
    tbl_4.BackgroundColor3 = Color3.new(1, 1, 1)
    tbl_4.ZIndex = a3 + 1
    tbl_4[1], tbl_4[2] = UI_upv_1.Corner(UDim.new(0.18, 0)), UI_upv_1.Gradient(v5, Theme_upv_1.Lighten(v4, 0.1), 90)
    tbl_4.Parent = v6
    UI_upv_1.new("Frame", tbl_4)
    local tbl_5 = {}
    tbl_5.Name = "Tier"
    tbl_5.Size = UDim2.fromScale(1, 1)
    tbl_5.Text = string.upper(string.sub(Ranks_upv_1.Get(a2).name, 1, 1))
    tbl_5.FontFace = Fonts_upv_1.Display
    tbl_5.TextScaled = true
    tbl_5.TextColor3 = Colors_upv_1.Text
    tbl_5.ZIndex = a3 + 2
    tbl_5[1], tbl_5[2], tbl_5[3] = UI_upv_1.new("UITextSizeConstraint", {MaxTextSize = 200, MinTextSize = 6}), UI_upv_1.new("UIPadding", {PaddingTop = UDim.new(0.33, 0), PaddingBottom = UDim.new(0.33, 0), PaddingLeft = UDim.new(0.3, 0), PaddingRight = UDim.new(0.3, 0)}), UI_upv_1.TextStroke(Colors_upv_1.Void, 1, 0.4)
    tbl_5.Parent = a1
    UI_upv_1.new("TextLabel", tbl_5)
end
function tbl_upv_1.SetEmblem(a1, a2)
    --[[
      name: SetEmblem
      line: 95
      upvalues:
        Ranks_upv_1 (copy, index: 1)
        UIAssets_upv_1 (copy, index: 2)
        UI_upv_1 (copy, index: 3)
        drawFallback (copy, index: 4)
    ]]
    local v7 = math.clamp(math.floor(tonumber(a2) or 1), 1, Ranks_upv_1.Count())
    if a1:GetAttribute("Rank") == v7 then
        return
    end
    a1:SetAttribute("Rank", v7)
    for _, value_1 in a1:GetChildren() do
        if value_1:IsA("GuiObject") then
            value_1:Destroy()
        end
    end
    local ZIndex_1 = a1.ZIndex
    local v8 = ((type(UIAssets_upv_1.Ranks) == "table") and (UIAssets_upv_1.Ranks)) or nil
    local v9 = v8 and (v8[Ranks_upv_1.Get(v7).id])
    local v10
    if type(v9) ~= "string" or v9 == "" then
        v10 = nil
    else
        v10 = v9
    end
    if v10 then
        UI_upv_1.new("ImageLabel", {Name = "Art", Size = UDim2.fromScale(1, 1), Image = v10, ScaleType = Enum.ScaleType.Fit, ZIndex = ZIndex_1, Parent = a1})
    else
        drawFallback(a1, v7, ZIndex_1)
    end
end
function tbl_upv_1.Emblem(a1, a2, a3)
    --[[
      name: Emblem
      line: 122
      upvalues:
        UI_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    local v11 = a3 or {}
    local new_1 = UI_upv_1.new
    local tbl_6 = {AnchorPoint = 0, Position = 0, Parent = 0, ZIndex = 0, LayoutOrder = 0}
    tbl_6.Name = v11.Name or "RankEmblem"
    tbl_6.Size = UDim2.fromOffset(a2, a2)
    tbl_6.Position = v11.Position or UDim2.new()
    tbl_6.AnchorPoint = v11.AnchorPoint or (Vector2.zero)
    tbl_6.LayoutOrder = v11.LayoutOrder or 0
    tbl_6.ZIndex = v11.ZIndex or 1
    tbl_6.Parent = v11.Parent
    local v13 = new_1("Frame", tbl_6)
    tbl_upv_1.SetEmblem(v13, a1)
    return v13
end
function tbl_upv_1.Trophy(a1, a2)
    --[[
      name: Trophy
      line: 137
      upvalues:
        UIAssets_upv_1 (copy, index: 1)
        UI_upv_1 (copy, index: 2)
        Theme_upv_1 (copy, index: 3)
        Colors_upv_1 (copy, index: 4)
    ]]
    local v14 = a2 or {}
    local v15 = ((type(UIAssets_upv_1.Icons) == "table") and (UIAssets_upv_1.Icons.Trophy)) or nil
    if type(v15) == "string" and v15 ~= "" then
        local new_2 = UI_upv_1.new
        local tbl_7 = {LayoutOrder = 0, ScaleType = 0, Parent = 0, AnchorPoint = 0, Image = 0, Name = "Trophy", Position = 0, ZIndex = 0}
        tbl_7.Size = UDim2.fromOffset(a1, a1)
        tbl_7.Position = v14.Position or UDim2.new()
        tbl_7.AnchorPoint = v14.AnchorPoint or (Vector2.zero)
        tbl_7.LayoutOrder = v14.LayoutOrder or 0
        tbl_7.ZIndex = v14.ZIndex or 1
        tbl_7.Image = v15
        tbl_7.ScaleType = Enum.ScaleType.Fit
        tbl_7.Parent = v14.Parent
        return new_2("ImageLabel", tbl_7)
    end
    local new_3 = UI_upv_1.new
    local tbl_8 = {AnchorPoint = 0, Name = "Trophy", Position = 0, Parent = 0, ZIndex = 0, LayoutOrder = 0}
    tbl_8.Size = UDim2.fromOffset(a1, a1)
    tbl_8.Position = v14.Position or UDim2.new()
    tbl_8.AnchorPoint = v14.AnchorPoint or (Vector2.zero)
    tbl_8.LayoutOrder = v14.LayoutOrder or 0
    tbl_8.ZIndex = v14.ZIndex or 1
    tbl_8.Parent = v14.Parent
    v15 = new_3("Frame", tbl_8)
    local tbl_9 = {}
    tbl_9.Name = "Cup"
    tbl_9.AnchorPoint = Vector2.new(0.5, 0)
    tbl_9.Position = UDim2.fromScale(0.5, 0.08)
    tbl_9.Size = UDim2.fromScale(0.62, 0.52)
    tbl_9.BackgroundColor3 = Color3.new(1, 1, 1)
    tbl_9.ZIndex = v14.ZIndex or 1
    tbl_9[1], tbl_9[2] = UI_upv_1.new("UICorner", {CornerRadius = UDim.new(0.45, 0)}), UI_upv_1.Gradient(Theme_upv_1.Lighten(Colors_upv_1.Gold, 0.3), Theme_upv_1.Darken(Colors_upv_1.Gold, 0.35), 90)
    tbl_9.Parent = v15
    UI_upv_1.new("Frame", tbl_9)
    UI_upv_1.new("Frame", {Name = "Base", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 0.94), Size = UDim2.fromScale(0.5, 0.16), BackgroundColor3 = Theme_upv_1.Darken(Colors_upv_1.Gold, 0.2), ZIndex = v14.ZIndex or 1, [1] = UI_upv_1.Corner(UDim.new(0.3, 0)), Parent = v15})
    UI_upv_1.new("Frame", {Name = "Stem", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.58), Size = UDim2.fromScale(0.14, 0.24), BackgroundColor3 = Theme_upv_1.Darken(Colors_upv_1.Gold, 0.25), ZIndex = v14.ZIndex or 1, Parent = v15})
    return v15
end
function tbl_upv_1.Chip(a1, a2, a3)
    --[[
      name: Chip
      line: 197
      upvalues:
        UI_upv_1 (copy, index: 1)
        Fonts_upv_1 (copy, index: 3)
        Colors_upv_1 (copy, index: 4)
        Ranks_upv_1 (copy, index: 5)
    ]]
    local v18 = a3 or {}
    local new_4 = UI_upv_1.new
    local tbl_10 = {}
    tbl_10.Name = v18.Name or "RankChip"
    tbl_10.AutomaticSize = Enum.AutomaticSize.X
    tbl_10.Size = UDim2.fromOffset(0, a2)
    local u1 = v18.Position or (UDim2.new())
    tbl_10.Position = u1
    tbl_10.AnchorPoint = v18.AnchorPoint or (Vector2.zero)
    tbl_10.LayoutOrder = v18.LayoutOrder or 0
    tbl_10.BackgroundTransparency = 1
    tbl_10.ZIndex = v18.ZIndex or 1
    tbl_10[1] = UI_upv_1.List(Enum.FillDirection.Horizontal, math.floor(a2 * 0.18), Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)
    tbl_10.Parent = v18.Parent
    local v19 = new_4("Frame", tbl_10)
    local u2 = set.Emblem(1, a2, {LayoutOrder = 1, ZIndex = v18.ZIndex, Parent = v19})
    local u3 = nil
    if v18.ShowName then
        local _ = UI_upv_1.new("TextLabel", {Name = "RankName", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, a2), Text = "", FontFace = Fonts_upv_1.Heavy, TextSize = math.floor(a2 * 0.5), TextColor3 = Colors_upv_1.Text, LayoutOrder = 2, ZIndex = v18.ZIndex or 1, [1] = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.35), Parent = v19})
    end
    local _ = set.Trophy(math.floor(a2 * 0.62), {LayoutOrder = 3, ZIndex = v18.ZIndex, Parent = v19})
    local new_5 = UI_upv_1.new
    local tbl_11 = {}
    tbl_11.Name = "Trophies"
    tbl_11.AutomaticSize = Enum.AutomaticSize.X
    tbl_11.Size = UDim2.fromOffset(0, a2)
    tbl_11.Text = "0"
    tbl_11.FontFace = Fonts_upv_1.Display
    tbl_11.TextSize = math.floor(a2 * 0.56)
    tbl_11.TextColor3 = v18.TextColor3 or (Colors_upv_1.Text)
    tbl_11.LayoutOrder = 4
    tbl_11.ZIndex = v18.ZIndex or 1
    tbl_11[1] = UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.35)
    tbl_11.Parent = v19
    u1 = new_5("TextLabel", tbl_11)
    local function set(a4)
        --[[
          name: set
          line: 243
          upvalues:
            Ranks_upv_1 (copy, index: 1)
            u2 (copy, index: 3)
            u1 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            u3 (ref,  index: 6)
        ]]
        local v20 = math.max(0, math.floor(tonumber(a4) or 0))
        local v21 = Ranks_upv_1.RankOf(v20)
        tbl_upv_1.SetEmblem(u2, v21)
        u1.Text = UI_upv_1.FormatNumber(v20)
        if u3 then
            v20 = tbl_upv_1.Color(v21)
            u3.Text = string.upper(Ranks_upv_1.Get(v21).name)
            u3.TextColor3 = v20
        end
    end
    set(tonumber(a1) or 0)
    return v19, set
end
return tbl_upv_1