local replicatedStorage = game:GetService("ReplicatedStorage")
local shared = replicatedStorage:WaitForChild("Shared")
local Tribes = require(shared:WaitForChild("Tribes"))
local TribeArt = require(shared:WaitForChild("TribeArt"))
local v5 = {}
local v6 = nil
local theme = nil

function v5.Init(a8)
    --[[
      name: Init
      line: 21
      upvalues:
        v6 (ref, index: 1)
        theme (ref, index: 2)
    ]]
    v6 = a8
    theme = a8.Theme
end

function v5.Tag(a9)
    --[[
      name: Tag
      line: 26
    ]]
    if type(a9) == "string" and a9 ~= "" then
        return "[" .. a9 .. "]"
    end

    return ""
end

function v5.TagColor(a10)
    --[[
      name: TagColor
      line: 30
      upvalues:
        Tribes (copy, index: 1)
    ]]
    return Tribes.TextColor(a10)
end

function v5.new(a11: number, options)
    --[[
      name: new
      line: 39
      upvalues:
        v6 (ref,  index: 1)
        TribeArt (copy, index: 2)
        theme (ref,  index: 3)
        Tribes (copy, index: 4)
    ]]
    local v13, v14, v15, v16
    local v17 = options or {}
    local flooredValue = math.floor((a11 * 1.08) + 0.5)
    local new = v6.new
    local v20 = {Name = v17.Name or "Emblem", Size = UDim2.fromOffset(a11, flooredValue)}
    local v21 = v17.Position or UDim2.new()
    v20.Position = v21
    v20.AnchorPoint = v17.AnchorPoint or Vector2.zero
    v20.LayoutOrder = v17.LayoutOrder or 0
    v20.ZIndex = v17.ZIndex or 1
    v20.Parent = v17.Parent
    local v22 = new("Frame", v20)
    local zIndex = v17.ZIndex or 1
    local v24 = TribeArt.Badge ~= ""
    local v25 = nil
    local v26 = a11 <= 36
    local v27 = v26 and 0.74 or 0.66
    local size = UDim2.fromScale(v27, (v27 * a11) / flooredValue)

    if v24 then
        local parent = v6.new("ImageLabel", {Name = "Badge", Image = TribeArt.Badge, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Fit, ZIndex = zIndex, Parent = v22})
        v6.new("UIGradient", {Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(170, 170, 170)), Parent = parent})

        if TribeArt.BadgeOutline ~= "" and not v26 then
            v25 = v6.new("ImageLabel", {Name = "Ring", Image = TribeArt.BadgeOutline, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Fit, ZIndex = zIndex + 1, Parent = v22})
        end

        local v30 = math.max(1, (math.floor((a11 / 36) + 0.5)))
        v13 = v6.new("ImageLabel", {Name = "GlyphShadow", ImageTransparency = 0.55, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.46, v30), Size = size, ScaleType = Enum.ScaleType.Fit, ImageColor3 = Color3.new(0, 0, 0), ZIndex = zIndex + 2, Parent = v22})
        v14 = v6.new("ImageLabel", {Name = "Glyph", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.46), Size = size, ScaleType = Enum.ScaleType.Fit, ZIndex = zIndex + 3, Parent = v22})
        v15, v16 = parent, v25
    else
        v15, v16, v14, v13 = nil, v25, nil, nil
    end

    local parent = v6.new("Frame", {Name = "Square", Size = UDim2.fromOffset(a11, a11), Position = UDim2.fromOffset(0, flooredValue - a11), BackgroundColor3 = theme.Colors.Raised, Visible = not v24, ZIndex = zIndex, (v6.Corner(UDim.new(0.24, 0))), Parent = v22})
    local v32 = v6.Stroke(theme.Colors.Stroke, math.max(1, (math.floor(a11 / 18))), 0)
    v32.Parent = parent
    local v33 = v6.new("TextLabel", {Name = "Letter", Text = "", Size = UDim2.fromScale(1, 1), FontFace = theme.Fonts.Display, TextSize = math.floor(a11 * 0.52), ZIndex = zIndex + 1, Parent = parent})

    return {
        Instance = v22,
        Set = (function(a34, a35, a36, a37, text: string)
            --[[
              name: Set
              line: 112
              upvalues:
                Tribes (copy, index: 1)
                TribeArt (copy, index: 2)
                v24 (copy, index: 3)
                v15 (ref,  index: 4)
                v16 (ref,  index: 5)
                v14 (ref,  index: 6)
                v13 (ref,  index: 7)
                parent (ref,  index: 8)
                v32 (ref,  index: 9)
                v33 (ref,  index: 10)
            ]]
            local iconKey
            local text2
            local v41 = Tribes.Color(a36)
            local v42 = Tribes.Color(a37)
            local icons = Tribes.ICONS

            if type(a35) ~= "number" then
                iconKey = 1
            else
                iconKey = a35
            end

            local glyphKey = icons[iconKey] or Tribes.ICONS[1]
            local image = TribeArt.Glyphs[glyphKey] or ""
            local visible = v24 and image ~= ""

            if v15 then
                v15.Visible = visible
                v15.ImageColor3 = v41

                if v16 then
                    v16.Visible = visible
                    v16.ImageColor3 = v42
                end

                v14.Visible = visible
                v14.Image = image
                v14.ImageColor3 = v42
                v13.Visible = visible
                v13.Image = image
            end

            parent.Visible = not visible
            parent.BackgroundColor3 = v41
            v32.Color = v42
            v33.TextColor3 = v42
            local v47 = v33

            if type(text) ~= "string" or text == "" then
                text2 = string.upper((string.sub(glyphKey, 1, 1)))
            else
                text2 = string.sub(text, 1, 1)
            end

            v47.Text = text2
        end)
    }
end

return v5