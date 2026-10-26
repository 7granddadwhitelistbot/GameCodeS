local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Shared")
local Tribes_upv_1 = require(v1:WaitForChild("Tribes"))
local TribeArt_upv_1 = require(v1:WaitForChild("TribeArt"))
v1 = {}
local u1 = nil
local Theme_upv_1 = nil
function v1.Init(a1)
    --[[
      name: Init
      line: 21
      upvalues:
        u1 (ref, index: 1)
        Theme_upv_1 (ref, index: 2)
    ]]
    u1 = a1
    Theme_upv_1 = a1.Theme
end
function v1.Tag(a1)
    --[[
      name: Tag
      line: 26
    ]]
    if type(a1) == "string" and a1 ~= "" then
        return "[" .. a1 .. "]"
    end
    return ""
end
function v1.TagColor(a1)
    --[[
      name: TagColor
      line: 30
      upvalues:
        Tribes_upv_1 (copy, index: 1)
    ]]
    return Tribes_upv_1.TextColor(a1)
end
function v1.new(a1, a2)
    --[[
      name: new
      line: 39
      upvalues:
        u1 (ref,  index: 1)
        TribeArt_upv_1 (copy, index: 2)
        Theme_upv_1 (ref,  index: 3)
        Tribes_upv_1 (copy, index: 4)
    ]]
    local v2 = a2 or {}
    local v3 = math.floor((a1 * 1.08) + 0.5)
    local new_1 = u1.new
    local tbl_1 = {AnchorPoint = 0, Position = 0, Parent = 0, ZIndex = 0, LayoutOrder = 0}
    tbl_1.Name = v2.Name or "Emblem"
    tbl_1.Size = UDim2.fromOffset(a1, v3)
    local u2 = v2.Position or (UDim2.new())
    tbl_1.Position = u2
    tbl_1.AnchorPoint = v2.AnchorPoint or (Vector2.zero)
    tbl_1.LayoutOrder = v2.LayoutOrder or 0
    tbl_1.ZIndex = v2.ZIndex or 1
    tbl_1.Parent = v2.Parent
    local v4 = new_1("Frame", tbl_1)
    local v5 = v2.ZIndex or 1
    local u3 = TribeArt_upv_1.Badge ~= ""
    local u4 = nil
    local v6 = nil
    local u5 = nil
    local u6 = nil
    local v7 = a1 <= 36
    local v8
    if v7 then
        v8 = 0.74
    else
        v8 = 0.66
    end
    local v9 = UDim2.fromScale(v8, (v8 * a1) / v3)
    if u3 then
        u4 = u1.new("ImageLabel", {Name = "Badge", Image = TribeArt_upv_1.Badge, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Fit, ZIndex = v5, Parent = v4})
        u1.new("UIGradient", {Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(170, 170, 170)), Parent = u4})
        if TribeArt_upv_1.BadgeOutline ~= "" then
            v6 = v7 or (u1.new("ImageLabel", {Name = "Ring", Image = TribeArt_upv_1.BadgeOutline, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Fit, ZIndex = v5 + 1, Parent = v4}))
        end
        local v10 = math.max(1, math.floor((a1 / 36) + 0.5))
        u6 = u1.new("ImageLabel", {ImageTransparency = 0.55, Name = "GlyphShadow", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.46, v10), Size = v9, ScaleType = Enum.ScaleType.Fit, ImageColor3 = Color3.new(0, 0, 0), ZIndex = v5 + 2, Parent = v4})
        u5 = u1.new("ImageLabel", {Name = "Glyph", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.46), Size = v9, ScaleType = Enum.ScaleType.Fit, ZIndex = v5 + 3, Parent = v4})
    else
        u2 = v6
    end
    local v11 = u1.new("Frame", {Name = "Square", Size = UDim2.fromOffset(a1, a1), Position = UDim2.fromOffset(0, v3 - a1), BackgroundColor3 = Theme_upv_1.Colors.Raised, Visible = not u3, ZIndex = v5, [1] = u1.Corner(UDim.new(0.24, 0)), Parent = v4})
    local u7 = v11
    local u8 = u1.Stroke(Theme_upv_1.Colors.Stroke, math.max(1, math.floor(a1 / 18)), 0)
    u8.Parent = u7
    local v12 = u1.new("TextLabel", {Name = "Letter", Text = "", Size = UDim2.fromScale(1, 1), FontFace = Theme_upv_1.Fonts.Display, TextSize = math.floor(a1 * 0.52), ZIndex = v5 + 1, Parent = u7})
    local u9 = v12
    local tbl_2 = {}
    tbl_2.Instance = v4
    function tbl_2.Set(a3, a4, a5, a6, a7)
        --[[
          name: Set
          line: 112
          upvalues:
            Tribes_upv_1 (copy, index: 1)
            TribeArt_upv_1 (copy, index: 2)
            u3 (copy, index: 3)
            u4 (ref,  index: 4)
            u2 (ref,  index: 5)
            u5 (ref,  index: 6)
            u6 (ref,  index: 7)
            u7 (ref,  index: 8)
            u8 (ref,  index: 9)
            u9 (ref,  index: 10)
        ]]
        local v13 = Tribes_upv_1.Color(a5)
        local v14 = Tribes_upv_1.Color(a6)
        local ICONS_1 = Tribes_upv_1.ICONS
        local v15
        if type(a4) ~= "number" then
            v15 = 1
        else
            v15 = a4
        end
        local v16 = ICONS_1[v15] or (Tribes_upv_1.ICONS[1])
        local v17 = TribeArt_upv_1.Glyphs[v16] or ""
        local v18 = u3 and (v17 ~= "")
        if u4 then
            u4.Visible = v18
            u4.ImageColor3 = v13
            if u2 then
                u2.Visible = v18
                u2.ImageColor3 = v14
            end
            u5.Visible = v18
            u5.Image = v17
            u5.ImageColor3 = v14
            u6.Visible = v18
            u6.Image = v17
        end
        u7.Visible = not v18
        u7.BackgroundColor3 = v13
        u8.Color = v14
        u9.TextColor3 = v14
        local v19 = u9
        local v20
        if type(a7) ~= "string" or a7 == "" then
            v20 = string.upper(string.sub(v16, 1, 1))
        else
            v20 = string.sub(a7, 1, 1)
        end
        v19.Text = v20
    end
    return tbl_2
end
return v1