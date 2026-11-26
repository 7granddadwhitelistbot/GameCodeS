local replicatedStorage = game:GetService("ReplicatedStorage")
local Ranks = require(replicatedStorage.Shared.Ranks)
local UIAssets = require(replicatedStorage.Shared.UIAssets)
local UI = require(script.Parent.UI)
local Theme = require(script.Parent.Theme)
local colors = Theme.Colors
local fonts = Theme.Fonts
local color3FromRGB = Color3.fromRGB
local v9 = {Ranks = Ranks}
local v10 = {
    bronze = {main = color3FromRGB(214, 136, 78), dark = color3FromRGB(104, 56, 26)},
    silver = {main = color3FromRGB(206, 216, 232), dark = color3FromRGB(92, 104, 126)},
    gold = {main = color3FromRGB(255, 204, 64), dark = color3FromRGB(150, 98, 8)},
    platinum = {main = color3FromRGB(146, 236, 222), dark = color3FromRGB(38, 118, 120)},
    diamond = {main = color3FromRGB(86, 202, 255), dark = color3FromRGB(18, 86, 176)},
    master = {main = color3FromRGB(186, 116, 255), dark = color3FromRGB(76, 30, 150)},
    grandmaster = {main = color3FromRGB(255, 84, 96), dark = color3FromRGB(128, 18, 34)},
    immortal = {main = color3FromRGB(255, 226, 120), dark = color3FromRGB(34, 26, 18)}
}

function v9.Color(a11)
    --[[
      name: Color
      line: 36
      upvalues:
        Ranks (copy, index: 1)
        v10 (copy, index: 2)
    ]]
    local v12 = v10[Ranks.Get(a11).id] or v10.bronze
    return v12.main, v12.dark
end

local function artFor(a14)
    --[[
      name: artFor
      line: 42
      upvalues:
        UIAssets (copy, index: 1)
        Ranks (copy, index: 2)
    ]]
    local ranks = type(UIAssets.Ranks) == "table" and UIAssets.Ranks or nil
    local rank = ranks and ranks[Ranks.Get(a14).id]

    if type(rank) == "string" and rank ~= "" then
        return rank
    end

    return nil
end

local function drawFallback(parent, clampedValue: number, zIndex)
    --[[
      name: drawFallback
      line: 49
      upvalues:
        v9 (copy, index: 1)
        UI (copy, index: 2)
        Theme (copy, index: 3)
        Ranks (copy, index: 4)
        fonts (copy, index: 5)
        colors (copy, index: 6)
    ]]
    local v21, v22 = v9.Color(clampedValue)
    local parent2 = UI.new("Frame", {Name = "Body", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.68, 0.68), Rotation = 45, BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = zIndex, UI.Corner(UDim.new(0.14, 0)), UI.Gradient(Theme.Lighten(v21, 0.25), v22, 90), (UI.Stroke(Theme.Lighten(v21, 0.5), 1.5, 0.15)), Parent = parent})
    UI.new("Frame", {Name = "Core", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.5), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = zIndex + 1, UI.Corner(UDim.new(0.18, 0)), (UI.Gradient(v22, Theme.Lighten(v21, 0.1), 90)), Parent = parent2})
    local newUi = UI.new
    local ui = UI.new("UITextSizeConstraint", {MaxTextSize = 200, MinTextSize = 6})
    local newUi2 = UI.new
    local v27 = {PaddingTop = UDim.new(0.33, 0), PaddingBottom = UDim.new(0.33, 0), PaddingLeft = UDim.new(0.3, 0), PaddingRight = UDim.new(0.3, 0)}
    newUi("TextLabel", {Name = "Tier", Size = UDim2.fromScale(1, 1), Text = string.upper((string.sub(Ranks.Get(clampedValue).name, 1, 1))), FontFace = fonts.Display, TextScaled = true, TextColor3 = colors.Text, ZIndex = zIndex + 2, ui, newUi2("UIPadding", v27), (UI.TextStroke(colors.Void, 1, 0.4)), Parent = parent})
end

function v9.SetEmblem(emblem, a29)
    --[[
      name: SetEmblem
      line: 95
      upvalues:
        Ranks (copy, index: 1)
        UIAssets (copy, index: 2)
        UI (copy, index: 3)
        drawFallback (copy, index: 4)
    ]]
    local rank = math.clamp(math.floor((tonumber(a29) or 1)), 1, Ranks.Count())

    if emblem:GetAttribute("Rank") == rank then
        return
    end

    local image
    emblem:SetAttribute("Rank", rank)

    for _, child in emblem:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy()
        end
    end

    local zIndex = emblem.ZIndex
    local ranks = type(UIAssets.Ranks) == "table" and UIAssets.Ranks or nil
    local rank2 = ranks and ranks[Ranks.Get(rank).id]

    if type(rank2) ~= "string" or rank2 == "" then
        image = nil
    else
        image = rank2
    end

    if image then
        UI.new("ImageLabel", {Name = "Art", Size = UDim2.fromScale(1, 1), Image = image, ScaleType = Enum.ScaleType.Fit, ZIndex = zIndex, Parent = emblem})
        return
    end

    drawFallback(emblem, rank, zIndex)
end

function v9.Emblem(a37, a38: number, options)
    --[[
      name: Emblem
      line: 122
      upvalues:
        UI (copy, index: 1)
        v9 (copy, index: 2)
    ]]
    local v40 = options or {}
    local newUi = UI.new
    local v42 = {Name = v40.Name or "RankEmblem", Size = UDim2.fromOffset(a38, a38)}
    local v43 = v40.Position or UDim2.new()
    v42.Position = v43
    v42.AnchorPoint = v40.AnchorPoint or Vector2.zero
    v42.LayoutOrder = v40.LayoutOrder or 0
    v42.ZIndex = v40.ZIndex or 1
    v42.Parent = v40.Parent
    local ui = newUi("Frame", v42)
    v9.SetEmblem(ui, a37)

    return ui
end

function v9.Trophy(a45: number, options)
    --[[
      name: Trophy
      line: 137
      upvalues:
        UIAssets (copy, index: 1)
        UI (copy, index: 2)
        Theme (copy, index: 3)
        colors (copy, index: 4)
    ]]
    local v47 = options or {}
    local trophy = type(UIAssets.Icons) == "table" and UIAssets.Icons.Trophy or nil

    if type(trophy) == "string" and trophy ~= "" then
        local newUi = UI.new
        local v50 = {Name = "Trophy", Size = UDim2.fromOffset(a45, a45)}
        local v51 = v47.Position or UDim2.new()
        v50.Position = v51
        v50.AnchorPoint = v47.AnchorPoint or Vector2.zero
        v50.LayoutOrder = v47.LayoutOrder or 0
        v50.ZIndex = v47.ZIndex or 1
        v50.Image = trophy
        v50.ScaleType = Enum.ScaleType.Fit
        v50.Parent = v47.Parent

        return newUi("ImageLabel", v50)
    end

    local newUi = UI.new
    local v53 = {Name = "Trophy", Size = UDim2.fromOffset(a45, a45)}
    local v54 = v47.Position or UDim2.new()
    v53.Position = v54
    v53.AnchorPoint = v47.AnchorPoint or Vector2.zero
    v53.LayoutOrder = v47.LayoutOrder or 0
    v53.ZIndex = v47.ZIndex or 1
    v53.Parent = v47.Parent
    local parent = newUi("Frame", v53)
    local newUi2 = UI.new
    local newUi3 = UI.new
    local v58 = {CornerRadius = UDim.new(0.45, 0)}
    newUi2("Frame", {Name = "Cup", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.08), Size = UDim2.fromScale(0.62, 0.52), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = v47.ZIndex
        or 1, newUi3("UICorner", v58), (UI.Gradient(Theme.Lighten(colors.Gold, 0.3), Theme.Darken(colors.Gold, 0.35), 90)), Parent = parent})
    UI.new("Frame", {Name = "Base", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 0.94), Size = UDim2.fromScale(0.5, 0.16), BackgroundColor3 = Theme.Darken(colors.Gold, 0.2), ZIndex = v47.ZIndex
        or 1, (UI.Corner(UDim.new(0.3, 0))), Parent = parent})
    UI.new("Frame", {Name = "Stem", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.58), Size = UDim2.fromScale(0.14, 0.24), BackgroundColor3 = Theme.Darken(colors.Gold, 0.25), ZIndex = v47.ZIndex
        or 1, Parent = parent})

    return parent
end

function v9.Chip(a59, a60: number, options)
    --[[
      name: Chip
      line: 197
      upvalues:
        UI (copy, index: 1)
        v9 (copy, index: 2)
        fonts (copy, index: 3)
        colors (copy, index: 4)
        Ranks (copy, index: 5)
    ]]
    local set
    local ui
    local v64 = options or {}
    local newUi = UI.new
    local v66 = {Name = v64.Name or "RankChip", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, a60)}
    local v67 = v64.Position or UDim2.new()
    v66.Position = v67
    v66.AnchorPoint = v64.AnchorPoint or Vector2.zero
    v66.LayoutOrder = v64.LayoutOrder or 0
    v66.BackgroundTransparency = 1
    v66.ZIndex = v64.ZIndex or 1
    v66[1] = (UI.List(Enum.FillDirection.Horizontal, math.floor(a60 * 0.18), Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center))
    v66.Parent = v64.Parent
    local parent = newUi("Frame", v66)
    local v69 = v9.Emblem(1, a60, {LayoutOrder = 1, ZIndex = v64.ZIndex, Parent = parent})

    if v64.ShowName then
        ui = UI.new("TextLabel", {Name = "RankName", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, a60), Text = "", FontFace = fonts.Heavy, TextSize = math.floor(a60 * 0.5), TextColor3 = colors.Text, LayoutOrder = 2, ZIndex = v64.ZIndex
            or 1, (UI.TextStroke(colors.Void, 1.5, 0.35)), Parent = parent})
    else
        ui = nil
    end

    local _ = v9.Trophy(math.floor(a60 * 0.62), {LayoutOrder = 3, ZIndex = v64.ZIndex, Parent = parent})
    local newUi2 = UI.new
    local v72 = {Name = "Trophies", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, a60), Text = "0", FontFace = fonts.Display, TextSize = math.floor(a60 * 0.56)}
    v72.TextColor3 = v64.TextColor3 or colors.Text
    v72.LayoutOrder = 4
    v72.ZIndex = v64.ZIndex or 1
    v72[1] = (UI.TextStroke(colors.Void, 1.5, 0.35))
    v72.Parent = parent
    local ui2 = newUi2("TextLabel", v72)

    set = function(a74)
        --[[
          name: set
          line: 243
          upvalues:
            Ranks (copy, index: 1)
            v9 (copy, index: 2)
            v69 (copy, index: 3)
            ui2 (copy, index: 4)
            UI (copy, index: 5)
            ui (ref,  index: 6)
        ]]
        local v75 = math.max(0, (math.floor((tonumber(a74) or 0))))
        local v76 = Ranks.RankOf(v75)
        v9.SetEmblem(v69, v76)
        ui2.Text = UI.FormatNumber(v75)

        if ui then
            local textColor3 = v9.Color(v76)
            ui.Text = string.upper(Ranks.Get(v76).name)
            ui.TextColor3 = textColor3
        end
    end

    set((tonumber(a59) or 0))

    return parent, set
end

return v9