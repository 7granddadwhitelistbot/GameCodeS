local GuiService_upv_1 = game:GetService("GuiService")
local Players_upv_1 = game:GetService("Players")
local RunService_upv_1 = game:GetService("RunService")
local StarterGui_upv_1 = game:GetService("StarterGui")
local TextChatService_upv_1 = game:GetService("TextChatService")
local UserInputService_upv_1 = game:GetService("UserInputService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_1 = {}
local holoBands = Color3.fromRGB
local tbl_upv_2 = {
    {min = 1, name = "ROOKIE", holo = 0.15, hi = holoBands(178, 188, 206), lo = holoBands(78, 86, 104), accent = holoBands(168, 184, 210), deep = holoBands(22, 26, 34)},
    {min = 5, name = "BRONZE", holo = 0.3, hi = holoBands(238, 168, 108), lo = holoBands(116, 62, 30), accent = holoBands(240, 158, 92), deep = holoBands(34, 22, 15)},
    {min = 10, name = "SILVER", holo = 0.45, hi = holoBands(210, 220, 236), lo = holoBands(98, 110, 134), accent = holoBands(190, 206, 232), deep = holoBands(22, 27, 38)},
    {min = 20, name = "GOLD", holo = 0.6, hi = holoBands(255, 214, 98), lo = holoBands(160, 98, 18), accent = holoBands(255, 194, 60), deep = holoBands(36, 27, 10)},
    {min = 35, name = "DIAMOND", holo = 0.8, hi = holoBands(140, 234, 255), lo = holoBands(26, 100, 192), accent = holoBands(92, 206, 255), deep = holoBands(10, 25, 44)},
    {min = 50, name = "MYTHIC", prism = true, holo = 1, hi = holoBands(236, 146, 255), lo = holoBands(66, 38, 156), accent = holoBands(196, 132, 255), deep = holoBands(25, 14, 44)}
}
local function tierFor(a1)
    --[[
      name: tierFor
      line: 68
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    local v1 = tbl_upv_2[1]
    for _, value_1 in tbl_upv_2 do
        if value_1.min <= a1 then
            v1 = value_1
        end
    end
    return v1
end
local u1 = ColorSequence.new({ColorSequenceKeypoint.new(0, holoBands(255, 120, 190)), ColorSequenceKeypoint.new(0.2, holoBands(190, 120, 255)), ColorSequenceKeypoint.new(0.4, holoBands(100, 190, 255)), ColorSequenceKeypoint.new(0.6, holoBands(110, 240, 190)), ColorSequenceKeypoint.new(0.8, holoBands(255, 222, 110)), ColorSequenceKeypoint.new(1, holoBands(255, 130, 170))})
local u2 = ColorSequence.new({ColorSequenceKeypoint.new(0, holoBands(255, 90, 170)), ColorSequenceKeypoint.new(0.17, holoBands(255, 200, 90)), ColorSequenceKeypoint.new(0.34, holoBands(120, 255, 150)), ColorSequenceKeypoint.new(0.5, holoBands(90, 220, 255)), ColorSequenceKeypoint.new(0.67, holoBands(150, 120, 255)), ColorSequenceKeypoint.new(0.84, holoBands(255, 110, 210)), ColorSequenceKeypoint.new(1, holoBands(255, 200, 90))})
local u3 = nil
local function hideChat()
    --[[
      name: hideChat
      line: 108
      upvalues:
        u3 (ref, index: 1)
    ]]
    if u3 then
        return
    end
    local tbl_3 = {}
    pcall(function() end)
    u3 = tbl_3
end
local function restoreChat()
    --[[
      name: restoreChat
      line: 129
      upvalues:
        u3 (ref, index: 1)
    ]]
    local v2 = u3
    if not v2 then
        return
    end
    u3 = nil
    pcall(function() end)
end
local function easeOutBack(a1)
    --[[
      name: easeOutBack
      line: 150
    ]]
    return ((((a1 - 1) ^ 3) * 2.4) + 1) + (((a1 - 1) ^ 2) * 1.4)
end
local function easeOutCubic(a1)
    --[[
      name: easeOutCubic
      line: 154
    ]]
    return 1 - ((1 - a1) ^ 3)
end
local function easeInCubic(a1)
    --[[
      name: easeInCubic
      line: 157
    ]]
    return (a1 * a1) * a1
end
holoBands = function(a1)
    --[[
      name: holoBands
      line: 96
    ]]
    local v3 = 1 - math.clamp(a1, 0, 1) * 0.22
    local tbl_4 = {}
    for n_1 = 0, 6 do
        local new_1 = NumberSequenceKeypoint.new
        local v4 = n_1 / 6
        local v5
        if n_1 % 2 ~= 0 then
            v5 = v3
        else
            v5 = 1
        end
        table.insert(tbl_4, new_1(v4, v5))
    end
    return NumberSequence.new(tbl_4)
end
function tbl_1.Init(a1)
    --[[
      name: Init
      line: 161
      upvalues:
        Players_upv_1 (copy, index: 1)
        u2 (copy, index: 2)
        tbl_upv_2 (copy, index: 3)
        u1 (copy, index: 4)
        holoBands (copy, index: 5)
        GuiService_upv_1 (copy, index: 6)
        Workspace_upv_1 (copy, index: 7)
        RunService_upv_1 (copy, index: 8)
        UserInputService_upv_1 (copy, index: 9)
        u3 (ref,  index: 10)
        TextChatService_upv_1 (copy, index: 11)
        StarterGui_upv_1 (copy, index: 12)
    ]]
    local UI_upv_1 = a1.UI
    local Theme_upv_1 = a1.Theme
    local State_upv_1 = a1.State
    local Colors_upv_1 = Theme_upv_1.Colors
    local Fonts_upv_1 = Theme_upv_1.Fonts
    local Economy_upv_1 = a1.Economy
    local WeaponInfo_upv_1 = a1.WeaponInfo
    local WeaponIcon_upv_1 = a1.WeaponIcon
    local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
    local Assets_upv_1 = UI_upv_1.Assets
    local u4 = Instance.new("Model")
    u4.Name = "TR_PlayerCard"
    local function plane(a2)
        --[[
          name: plane
          line: 172
          upvalues:
            u4 (copy, index: 1)
        ]]
        local v6 = Instance.new("Part")
        v6.Name = a2
        v6.Anchored = true
        v6.CanCollide = false
        v6.CanQuery = false
        v6.CanTouch = false
        v6.CastShadow = false
        v6.Transparency = 1
        v6.Size = Vector3.new(0.7142857313156128, 1, 0.004000000189989805)
        v6.Parent = u4
        return v6
    end
    local u5 = Instance.new("Part")
    u5.Name = "Card"
    u5.Anchored = true
    u5.CanCollide = false
    u5.CanQuery = false
    u5.CanTouch = false
    u5.CastShadow = false
    u5.Transparency = 1
    u5.Size = Vector3.new(0.7142857313156128, 1, 0.004000000189989805)
    u5.Parent = u4
    local u6 = Instance.new("Part")
    u6.Name = "Shadow"
    u6.Anchored = true
    u6.CanCollide = false
    u6.CanQuery = false
    u6.CanTouch = false
    u6.CastShadow = false
    u6.Transparency = 1
    u6.Size = Vector3.new(0.7142857313156128, 1, 0.004000000189989805)
    u6.Parent = u4
    local u7 = Instance.new("Part")
    u7.Name = "Backdrop"
    u7.Anchored = true
    u7.CanCollide = false
    u7.CanQuery = false
    u7.CanTouch = false
    u7.CastShadow = false
    u7.Transparency = 1
    u7.Size = Vector3.new(0.7142857313156128, 1, 0.004000000189989805)
    u7.Parent = u4
    local function surface(a3, a4, a5, a6)
        --[[
          name: surface
          line: 189
          upvalues:
            UI_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        return UI_upv_1.new("SurfaceGui", {Enabled = false, ClipsDescendants = true, LightInfluence = 0, ResetOnSpawn = false, Brightness = 1, AlwaysOnTop = false, Name = a3, Adornee = a4, Face = a5, SizingMode = Enum.SurfaceGuiSizingMode.FixedSize, CanvasSize = a6, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = a1.PlayerGui})
    end
    local u8 = surface("TR_CardFront", u5, Enum.NormalId.Back, Vector2.new(500, 700))
    local u9 = surface("TR_CardBack", u5, Enum.NormalId.Front, Vector2.new(500, 700))
    local u10 = surface("TR_CardShadow", u6, Enum.NormalId.Back, Vector2.new(200, 200))
    local u11 = surface("TR_CardBackdrop", u7, Enum.NormalId.Back, Vector2.new(640, 360))
    local u12 = UI_upv_1.new("ImageLabel", {Name = "Shadow", ImageTransparency = 0.25, Size = UDim2.fromScale(1, 1), Image = Assets_upv_1.Icons.Glow, ImageColor3 = Colors_upv_1.Void, Parent = u10})
    local u13 = UI_upv_1.new("Frame", {Name = "Dim", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Colors_upv_1.Void, Parent = u11})
    local u14 = UI_upv_1.new("ImageLabel", {Name = "Vignette", ImageTransparency = 1, ZIndex = 2, Size = UDim2.fromScale(1, 1), Image = Assets_upv_1.Fx.Vignette, ImageColor3 = Colors_upv_1.Void, Parent = u11})
    local u15 = UI_upv_1.new("ImageLabel", {Name = "Spot", ZIndex = 3, ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(420, 420), Image = Assets_upv_1.Icons.Glow, Parent = u11})
    local u16 = UI_upv_1.new("ImageLabel", {Name = "Rays", ZIndex = 3, ImageTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(620, 620), Image = Assets_upv_1.Fx.Rays, Parent = u11})
    local function text(a7)
        --[[
          name: text
          line: 271
          upvalues:
            Colors_upv_1 (copy, index: 1)
            UI_upv_1 (copy, index: 2)
        ]]
        a7.BackgroundTransparency = 1
        a7.TextXAlignment = a7.TextXAlignment or (Enum.TextXAlignment.Left)
        a7.TextColor3 = a7.TextColor3 or (Colors_upv_1.Text)
        return UI_upv_1.new("TextLabel", a7)
    end
    local function buildFace(a8)
        --[[
          name: buildFace
          line: 278
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Assets_upv_1 (copy, index: 3)
        ]]
        local v7 = UI_upv_1.new("Frame", {Name = "Card", Size = UDim2.fromOffset(500, 700), Parent = a8})
        local v8 = UI_upv_1.new("UIScale", {Parent = v7})
        local tbl_5 = {}
        tbl_5.Name = "Rim"
        tbl_5.Size = UDim2.fromScale(1, 1)
        tbl_5.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_5[1] = UI_upv_1.Corner(30)
        tbl_5.Parent = v7
        local v9 = UI_upv_1.new("Frame", tbl_5)
        local v10 = UI_upv_1.new("UIGradient", {Rotation = 62, Parent = v9})
        UI_upv_1.new("UIStroke", {Transparency = 0.3, Thickness = 2, Color = Colors_upv_1.Void, Parent = v9})
        local tbl_6 = {}
        tbl_6.Name = "Body"
        tbl_6.Position = UDim2.fromOffset(12, 12)
        tbl_6.Size = UDim2.new(1, -24, 1, -24)
        tbl_6.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_6.ClipsDescendants = true
        tbl_6[1] = UI_upv_1.Corner(21)
        tbl_6.Parent = v7
        local v11 = UI_upv_1.new("Frame", tbl_6)
        v7 = UI_upv_1.new("UIGradient", {Rotation = 90, Parent = v11})
        tbl_5 = UI_upv_1.new("UIStroke", {Thickness = 1.5, Transparency = 0.5, Parent = v11})
        local v12 = UI_upv_1.new("ImageLabel", {ImageTransparency = 0.8, Name = "Glare", ZIndex = 20, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(900, 900), Image = Assets_upv_1.Icons.Glow, ImageColor3 = Color3.new(1, 1, 1), Parent = v11})
        local tbl_7 = {}
        tbl_7.Name = "Band"
        tbl_7.AnchorPoint = Vector2.new(0.5, 0.5)
        tbl_7.Position = UDim2.fromScale(0.5, 0.5)
        tbl_7.Size = UDim2.fromOffset(1100, 150)
        tbl_7.Rotation = -28
        tbl_7.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_7.ZIndex = 20
        tbl_7[1] = UI_upv_1.new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.86), NumberSequenceKeypoint.new(1, 1)})})
        tbl_7.Parent = v11
        local tbl_8 = {}
        tbl_8.gui = a8
        tbl_8.scale = v8
        tbl_8.rimGrad = v10
        tbl_8.body = v11
        tbl_8.bodyGrad = v7
        tbl_8.bodyStroke = tbl_5
        tbl_8.glare = v12
        tbl_8.band = UI_upv_1.new("Frame", tbl_7)
        return tbl_8
    end
    local u17 = buildFace(u8)
    local u18 = buildFace(u9)
    local function xpBar(a9, a10, a11, a12)
        --[[
          name: xpBar
          line: 383
          upvalues:
            UI_upv_1 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
        ]]
        local tbl_9 = {}
        tbl_9.Name = "XpBar"
        tbl_9.Position = a10
        tbl_9.Size = UDim2.fromOffset(a11, a12)
        tbl_9.BackgroundColor3 = Colors_upv_1.Void
        tbl_9.BackgroundTransparency = 0.35
        tbl_9.ClipsDescendants = true
        tbl_9.ZIndex = 4
        tbl_9[1], tbl_9[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.85)
        tbl_9.Parent = a9
        local v13 = UI_upv_1.new("Frame", tbl_9)
        local tbl_10 = {}
        tbl_10.Name = "Fill"
        tbl_10.Size = UDim2.fromScale(0, 1)
        tbl_10.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_10.ZIndex = 5
        tbl_10[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_10.Parent = v13
        local v14 = UI_upv_1.new("Frame", tbl_10)
        tbl_10 = {}
        tbl_10.track = v13
        tbl_10.fill = v14
        tbl_10.fillGrad = UI_upv_1.new("UIGradient", {Parent = v14})
        return tbl_10
    end
    local function emblem(a13, a14, a15, a16)
        --[[
          name: emblem
          line: 341
          upvalues:
            UI_upv_1 (copy, index: 1)
            Theme_upv_1 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            Fonts_upv_1 (copy, index: 4)
        ]]
        local new_2 = UI_upv_1.new
        local tbl_11 = {}
        tbl_11.Name = "Level"
        tbl_11.AnchorPoint = a16 or (Vector2.zero)
        tbl_11.Position = a15
        tbl_11.Size = UDim2.fromOffset(a14, a14)
        tbl_11.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_11.ZIndex = 4
        tbl_11[1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill)
        tbl_11.Parent = a13
        local v15 = new_2("Frame", tbl_11)
        local v16 = UI_upv_1.new("UIGradient", {Rotation = 90, Parent = v15})
        local v17 = UI_upv_1.new("UIStroke", {Transparency = 0.25, Thickness = 2, Color = Colors_upv_1.Void, Parent = v15})
        local tbl_12 = {Text = "LV", Name = "LV", ZIndex = 5}
        tbl_12.Position = UDim2.new(0, 0, 0, math.floor(a14 * 0.12))
        tbl_12.Size = UDim2.new(1, 0, 0, math.floor(a14 * 0.2))
        tbl_12.FontFace = Fonts_upv_1.Heavy
        tbl_12.TextSize = math.floor(a14 * 0.19)
        tbl_12.TextXAlignment = Enum.TextXAlignment.Center
        tbl_12.Parent = v15
        tbl_12.BackgroundTransparency = 1
        tbl_12.TextXAlignment = tbl_12.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_12.TextColor3 = tbl_12.TextColor3 or (Colors_upv_1.Text)
        local v18 = UI_upv_1.new("TextLabel", tbl_12)
        UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.35).Parent = v18
        local tbl_13 = {Text = "1", Name = "Num", ZIndex = 5}
        tbl_13.Position = UDim2.new(0, 0, 0, math.floor(a14 * 0.26))
        tbl_13.Size = UDim2.new(1, 0, 0, math.floor(a14 * 0.62))
        tbl_13.FontFace = Fonts_upv_1.Display
        tbl_13.TextSize = math.floor(a14 * 0.5)
        tbl_13.TextXAlignment = Enum.TextXAlignment.Center
        tbl_13.Parent = v15
        tbl_13.BackgroundTransparency = 1
        tbl_13.TextXAlignment = tbl_13.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_13.TextColor3 = tbl_13.TextColor3 or (Colors_upv_1.Text)
        local v19 = UI_upv_1.new("TextLabel", tbl_13)
        UI_upv_1.TextStroke(Colors_upv_1.Void, 2, 0.2).Parent = v19
        local tbl_14 = {}
        tbl_14.frame = v15
        tbl_14.grad = v16
        tbl_14.ring = v17
        tbl_14.num = v19
        return tbl_14
    end
    local u19 = emblem(u17.body, 76, UDim2.fromOffset(14, 14))
    local tbl_15 = {AutoLocalize = false, Text = "", Name = "DisplayName", ZIndex = 4, TextSize = 38}
    tbl_15.Position = UDim2.fromOffset(102, 16)
    tbl_15.Size = UDim2.fromOffset(250, 42)
    tbl_15.FontFace = Fonts_upv_1.Display
    tbl_15.TextTruncate = Enum.TextTruncate.AtEnd
    tbl_15.Parent = u17.body
    tbl_15.BackgroundTransparency = 1
    tbl_15.TextXAlignment = tbl_15.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_15.TextColor3 = tbl_15.TextColor3 or (Colors_upv_1.Text)
    local u20 = UI_upv_1.new("TextLabel", tbl_15)
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4).Parent = u20
    local tbl_16 = {Text = "", Name = "Username", ZIndex = 4, TextSize = 22}
    tbl_16.Position = UDim2.fromOffset(103, 58)
    tbl_16.Size = UDim2.fromOffset(353, 26)
    tbl_16.FontFace = Fonts_upv_1.SemiBold
    tbl_16.TextColor3 = Colors_upv_1.TextDim
    tbl_16.TextTruncate = Enum.TextTruncate.AtEnd
    tbl_16.Parent = u17.body
    tbl_16.BackgroundTransparency = 1
    tbl_16.TextXAlignment = tbl_16.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_16.TextColor3 = tbl_16.TextColor3 or (Colors_upv_1.Text)
    local u21 = UI_upv_1.new("TextLabel", tbl_16)
    local tbl_17 = {}
    tbl_17.Name = "Tier"
    tbl_17.AnchorPoint = Vector2.new(1, 0)
    tbl_17.Position = UDim2.new(1, -14, 0, 20)
    tbl_17.Size = UDim2.fromOffset(0, 30)
    tbl_17.AutomaticSize = Enum.AutomaticSize.X
    tbl_17.BackgroundColor3 = Color3.new(1, 1, 1)
    tbl_17.ZIndex = 4
    tbl_17[1], tbl_17[2] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), UI_upv_1.Padding(0, 13, 0, 13)
    tbl_17.Parent = u17.body
    local v20 = UI_upv_1.new("Frame", tbl_17)
    local u22 = UI_upv_1.new("UIGradient", {Rotation = 90, Parent = v20})
    local tbl_18 = {Text = "ROOKIE", Name = "Label", TextSize = 16, ZIndex = 5}
    tbl_18.Size = UDim2.fromOffset(0, 30)
    tbl_18.AutomaticSize = Enum.AutomaticSize.X
    tbl_18.FontFace = Fonts_upv_1.Display
    tbl_18.TextXAlignment = Enum.TextXAlignment.Center
    tbl_18.Parent = v20
    tbl_18.BackgroundTransparency = 1
    tbl_18.TextXAlignment = tbl_18.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_18.TextColor3 = tbl_18.TextColor3 or (Colors_upv_1.Text)
    local u23 = UI_upv_1.new("TextLabel", tbl_18)
    local v21 = UI_upv_1.new("Frame", {Name = "Art", Position = UDim2.fromOffset(14, 100), Size = UDim2.fromOffset(448, 290), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, ZIndex = 2, [1] = UI_upv_1.Corner(16), Parent = u17.body})
    local u24 = UI_upv_1.new("UIGradient", {Rotation = 90, Parent = v21})
    local u25 = UI_upv_1.new("UIStroke", {Thickness = 1.5, Transparency = 0.45, Parent = v21})
    local u26 = UI_upv_1.new("ImageLabel", {Name = "Rays", ZIndex = 2, ImageTransparency = 0.85, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.42), Size = UDim2.fromOffset(640, 640), Image = Assets_upv_1.Fx.Rays, Parent = v21})
    local u27 = UI_upv_1.new("ImageLabel", {Name = "Glow", ZIndex = 2, ImageTransparency = 0.5, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromOffset(480, 480), Image = Assets_upv_1.Icons.Glow, Parent = v21})
    UI_upv_1.new("ImageLabel", {ImageTransparency = 0.4, Name = "FloorShadow", ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 1, -16), Size = UDim2.fromOffset(300, 70), Image = Assets_upv_1.Icons.Glow, ImageColor3 = Colors_upv_1.Void, Parent = v21})
    local u28 = UI_upv_1.new("ImageLabel", {Image = "", Name = "Avatar", ZIndex = 4, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 24), Size = UDim2.fromOffset(330, 330), Parent = v21})
    local u29 = UI_upv_1.new("Frame", {Name = "Fade", ZIndex = 5, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 70), BackgroundColor3 = Color3.new(1, 1, 1), Parent = v21})
    local _ = UI_upv_1.new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new(1, 0.2), Parent = u29})
    local u30 = UI_upv_1.new("UIGradient", {Rotation = 58, Color = u2, Parent = UI_upv_1.new("Frame", {Name = "Holo", ZIndex = 3, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), Parent = v21})})
    local tbl_upv_19 = {}
    local tbl_upv_20 = {}
    local u31 = 0
    local v22 = Random.new(7)
    for n_2 = 1, 14 do
        local v23 = v22:NextInteger(14, 26)
        tbl_upv_19[n_2] = UI_upv_1.new("ImageLabel", {Visible = false, ImageTransparency = 1, ZIndex = 7, Name = "Sparkle" .. n_2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(v22:NextNumber(0.06, 0.94), v22:NextNumber(0.06, 0.8)), Size = UDim2.fromOffset(v23, v23), Rotation = v22:NextInteger(0, 44), Image = Assets_upv_1.Fx.Sparkle, Parent = v21})
        tbl_upv_20[n_2] = v22:NextNumber(0, 2)
    end
    local tbl_21 = {ZIndex = 4, Name = "LevelLine", Text = "LEVEL 1", TextSize = 24}
    tbl_21.Position = UDim2.fromOffset(16, 400)
    tbl_21.Size = UDim2.fromOffset(200, 28)
    tbl_21.FontFace = Fonts_upv_1.Display
    tbl_21.Parent = u17.body
    tbl_21.BackgroundTransparency = 1
    tbl_21.TextXAlignment = tbl_21.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_21.TextColor3 = tbl_21.TextColor3 or (Colors_upv_1.Text)
    local u32 = UI_upv_1.new("TextLabel", tbl_21)
    local u33 = {Text = "", Name = "Xp", ZIndex = 4, TextSize = 20}
    u33.AnchorPoint = Vector2.new(1, 0)
    u33.Position = UDim2.new(1, -16, 0, 402)
    u33.Size = UDim2.fromOffset(260, 26)
    u33.FontFace = Fonts_upv_1.Bold
    u33.TextColor3 = Colors_upv_1.TextDim
    u33.TextXAlignment = Enum.TextXAlignment.Right
    u33.Parent = u17.body
    u33.BackgroundTransparency = 1
    u33.TextXAlignment = u33.TextXAlignment or (Enum.TextXAlignment.Left)
    u33.TextColor3 = u33.TextColor3 or (Colors_upv_1.Text)
    local u34 = UI_upv_1.new("TextLabel", u33)
    u33 = xpBar(u17.body, UDim2.fromOffset(16, 432), 444, 11)
    local tbl_upv_22 = {}
    for n_3 = 1, 6 do
        local tbl_23 = {}
        tbl_23.Name = "Stat" .. n_3
        tbl_23.Position = UDim2.fromOffset((((n_3 - 1) % 3) * 152) + 14, (((n_3 - 1) // 3) * 88) + 456)
        tbl_23.Size = UDim2.fromOffset(144, 80)
        tbl_23.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_23.BackgroundTransparency = 0.94
        tbl_23.ZIndex = 3
        tbl_23[1], tbl_23[2] = UI_upv_1.Corner(12), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.9)
        tbl_23.Parent = u17.body
        local v24 = UI_upv_1.new("Frame", tbl_23)
        local tbl_24 = {Text = "0", Name = "Value", ZIndex = 4, TextSize = 40}
        tbl_24.Position = UDim2.fromOffset(0, 6)
        tbl_24.Size = UDim2.new(1, 0, 0, 44)
        tbl_24.FontFace = Fonts_upv_1.Display
        tbl_24.TextXAlignment = Enum.TextXAlignment.Center
        tbl_24.Parent = v24
        tbl_24.BackgroundTransparency = 1
        tbl_24.TextXAlignment = tbl_24.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_24.TextColor3 = tbl_24.TextColor3 or (Colors_upv_1.Text)
        local v25 = UI_upv_1.new("TextLabel", tbl_24)
        local tbl_25 = {Text = "", Name = "Label", ZIndex = 4, TextSize = 19}
        tbl_25.Position = UDim2.fromOffset(0, 50)
        tbl_25.Size = UDim2.new(1, 0, 0, 24)
        tbl_25.FontFace = Fonts_upv_1.Heavy
        tbl_25.TextColor3 = Colors_upv_1.TextMuted
        tbl_25.TextXAlignment = Enum.TextXAlignment.Center
        tbl_25.Parent = v24
        tbl_25.BackgroundTransparency = 1
        tbl_25.TextXAlignment = tbl_25.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_25.TextColor3 = tbl_25.TextColor3 or (Colors_upv_1.Text)
        tbl_upv_22[n_3] = {value = v25, label = UI_upv_1.new("TextLabel", tbl_25)}
        local u35 = n_3
    end
    local tbl_26 = {ZIndex = 4, Name = "Brand", Text = "TRIBES", TextSize = 19}
    tbl_26.Position = UDim2.fromOffset(18, 640)
    tbl_26.Size = UDim2.fromOffset(200, 22)
    tbl_26.FontFace = Fonts_upv_1.Display
    tbl_26.Parent = u17.body
    tbl_26.BackgroundTransparency = 1
    tbl_26.TextXAlignment = tbl_26.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_26.TextColor3 = tbl_26.TextColor3 or (Colors_upv_1.Text)
    local u36 = UI_upv_1.new("TextLabel", tbl_26)
    local tbl_27 = {Text = "PLAYER CARD", Name = "Kind", ZIndex = 4, TextSize = 15}
    tbl_27.AnchorPoint = Vector2.new(1, 0)
    tbl_27.Position = UDim2.new(1, -18, 0, 642)
    tbl_27.Size = UDim2.fromOffset(220, 20)
    tbl_27.FontFace = Fonts_upv_1.Heavy
    tbl_27.TextColor3 = Colors_upv_1.TextMuted
    tbl_27.TextXAlignment = Enum.TextXAlignment.Right
    tbl_27.Parent = u17.body
    tbl_27.BackgroundTransparency = 1
    tbl_27.TextXAlignment = tbl_27.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_27.TextColor3 = tbl_27.TextColor3 or (Colors_upv_1.Text)
    local u35 = UI_upv_1.new("TextLabel", tbl_27)
    local u37 = UI_upv_1.new("ImageLabel", {Name = "Headshot", Position = UDim2.fromOffset(14, 14), Size = UDim2.fromOffset(64, 64), BackgroundColor3 = Colors_upv_1.PanelHi, Image = "", ZIndex = 4, [1] = UI_upv_1.Corner(Theme_upv_1.Radius.Pill), Parent = u18.body})
    u35 = UI_upv_1.new("UIStroke", {Thickness = 2.5, Transparency = 0.1, Parent = u37})
    local tbl_28 = {AutoLocalize = false, Text = "", Name = "DisplayName", ZIndex = 4, TextSize = 32}
    tbl_28.Position = UDim2.fromOffset(90, 14)
    tbl_28.Size = UDim2.fromOffset(300, 38)
    tbl_28.FontFace = Fonts_upv_1.Display
    tbl_28.TextTruncate = Enum.TextTruncate.AtEnd
    tbl_28.Parent = u18.body
    tbl_28.BackgroundTransparency = 1
    tbl_28.TextXAlignment = tbl_28.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_28.TextColor3 = tbl_28.TextColor3 or (Colors_upv_1.Text)
    local u38 = UI_upv_1.new("TextLabel", tbl_28)
    UI_upv_1.TextStroke(Colors_upv_1.Void, 1.5, 0.4).Parent = u38
    local tbl_29 = {Text = "", Name = "Username", ZIndex = 4, TextSize = 20}
    tbl_29.Position = UDim2.fromOffset(91, 50)
    tbl_29.Size = UDim2.fromOffset(299, 24)
    tbl_29.FontFace = Fonts_upv_1.SemiBold
    tbl_29.TextColor3 = Colors_upv_1.TextDim
    tbl_29.TextTruncate = Enum.TextTruncate.AtEnd
    tbl_29.Parent = u18.body
    tbl_29.BackgroundTransparency = 1
    tbl_29.TextXAlignment = tbl_29.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_29.TextColor3 = tbl_29.TextColor3 or (Colors_upv_1.Text)
    local u39 = UI_upv_1.new("TextLabel", tbl_29)
    local u40 = emblem(u18.body, 64, UDim2.new(1, -14, 0, 14), Vector2.new(1, 0))
    local u41 = UI_upv_1.new("Frame", {BackgroundTransparency = 0.6, Name = "Divider", ZIndex = 4, Position = UDim2.fromOffset(14, 90), Size = UDim2.new(1, -28, 0, 2), BackgroundColor3 = Color3.new(1, 1, 1), Parent = u18.body})
    local tbl_upv_30 = {}
    local tbl_upv_31 = {}
    local function section(a17, a18, a19, a20)
        --[[
          name: section
          line: 710
          upvalues:
            Fonts_upv_1 (copy, index: 1)
            u18 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
            UI_upv_1 (copy, index: 4)
            tbl_upv_30 (copy, index: 5)
            tbl_upv_31 (copy, index: 6)
        ]]
        local tbl_32 = {ZIndex = 4, TextSize = 19}
        tbl_32.Name = "Section_" .. a19
        tbl_32.Position = UDim2.fromOffset(a17, a18)
        tbl_32.Size = UDim2.fromOffset(214, 24)
        tbl_32.Text = a19
        tbl_32.FontFace = Fonts_upv_1.Display
        tbl_32.Parent = u18.body
        tbl_32.BackgroundTransparency = 1
        tbl_32.TextXAlignment = tbl_32.TextXAlignment or (Enum.TextXAlignment.Left)
        tbl_32.TextColor3 = tbl_32.TextColor3 or (Colors_upv_1.Text)
        table.insert(tbl_upv_30, (UI_upv_1.new("TextLabel", tbl_32)))
        a18 = a18 + 28
        for _, value_2 in a20 do
            local v26 = value_2[1]
            local v27 = UI_upv_1.new("Frame", {ZIndex = 4, Name = "Row_" .. v26, Position = UDim2.fromOffset(a17, a18), Size = UDim2.fromOffset(214, 35), Parent = u18.body})
            local tbl_33 = {Name = "Label", ZIndex = 4, TextSize = 20}
            tbl_33.Size = UDim2.new(0.62, 0, 1, 0)
            tbl_33.Text = value_2[2]
            tbl_33.FontFace = Fonts_upv_1.SemiBold
            tbl_33.TextColor3 = Colors_upv_1.TextDim
            tbl_33.TextTruncate = Enum.TextTruncate.AtEnd
            tbl_33.Parent = v27
            tbl_33.BackgroundTransparency = 1
            tbl_33.TextXAlignment = tbl_33.TextXAlignment or (Enum.TextXAlignment.Left)
            tbl_33.TextColor3 = tbl_33.TextColor3 or (Colors_upv_1.Text)
            local v28 = UI_upv_1.new("TextLabel", tbl_33)
            local tbl_34 = {Text = "0", Name = "Value", ZIndex = 4, TextSize = 24}
            tbl_34.AnchorPoint = Vector2.new(1, 0)
            tbl_34.Position = UDim2.fromScale(1, 0)
            tbl_34.Size = UDim2.new(0.5, 0, 1, 0)
            tbl_34.FontFace = Fonts_upv_1.Display
            tbl_34.TextXAlignment = Enum.TextXAlignment.Right
            tbl_34.Parent = v27
            tbl_34.BackgroundTransparency = 1
            tbl_34.TextXAlignment = tbl_34.TextXAlignment or (Enum.TextXAlignment.Left)
            tbl_34.TextColor3 = tbl_34.TextColor3 or (Colors_upv_1.Text)
            tbl_upv_31[v26] = UI_upv_1.new("TextLabel", tbl_34)
            UI_upv_1.new("Frame", {BackgroundTransparency = 0.92, Name = "Line", ZIndex = 4, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Color3.new(1, 1, 1), Parent = v27})
            a18 = a18 + 35
        end
        return a18
    end
    section(14, section(14, 104, "MATCHES", {{"matches", "Played"}, {"wins", "Wins"}, {"losses", "Losses"}, {"winRate", "Win rate"}, {"roundsWon", "Rounds won"}}) + 14, "STREAKS", {{"streak", "Current"}, {"bestStreak", "Best"}})
    local v28 = section(248, section(248, 104, "COMBAT", {{"kills", "Kills"}, {"deaths", "Deaths"}, {"assists", "Assists"}, {"kd", "K/D"}, {"kpm", "Kills / match"}}) + 14, "COLLECTION", {{"items", "Items"}, {"maxed", "Maxed"}, {"drops", "Drops opened"}}) + 14
    local tbl_35 = {RichText = true, Text = "ACTIVE LOADOUT", Name = "KitTitle", ZIndex = 4, TextSize = 19}
    tbl_35.Position = UDim2.fromOffset(14, v28)
    tbl_35.Size = UDim2.fromOffset(448, 24)
    tbl_35.FontFace = Fonts_upv_1.Display
    tbl_35.TextTruncate = Enum.TextTruncate.AtEnd
    tbl_35.Parent = u18.body
    tbl_35.BackgroundTransparency = 1
    tbl_35.TextXAlignment = tbl_35.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_35.TextColor3 = tbl_35.TextColor3 or (Colors_upv_1.Text)
    local u42 = UI_upv_1.new("TextLabel", tbl_35)
    local v29 = UI_upv_1.new("Frame", {Name = "Kit", Position = UDim2.fromOffset(14, v28 + 30), Size = UDim2.fromOffset(448, 57), ZIndex = 4, [1] = UI_upv_1.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center), Parent = u18.body})
    local tbl_upv_36 = {}
    for n_4 = 1, 7 do
        local tbl_37 = {}
        tbl_37.Name = "Item" .. n_4
        tbl_37.Size = UDim2.fromOffset(57, 57)
        tbl_37.BackgroundColor3 = Color3.new(1, 1, 1)
        tbl_37.BackgroundTransparency = 0.93
        tbl_37.LayoutOrder = n_4
        tbl_37.ZIndex = 4
        tbl_37[1], tbl_37[2] = UI_upv_1.Corner(10), UI_upv_1.Stroke(Colors_upv_1.Stroke, 1, 0.9)
        tbl_37.Parent = v29
        tbl_upv_36[n_4] = UI_upv_1.new("Frame", tbl_37)
        local tbl_38 = n_4
    end
    local tbl_39 = {ZIndex = 4, Name = "LevelLine", Text = "LEVEL 1", TextSize = 22}
    tbl_39.Position = UDim2.fromOffset(16, 576)
    tbl_39.Size = UDim2.fromOffset(200, 26)
    tbl_39.FontFace = Fonts_upv_1.Display
    tbl_39.Parent = u18.body
    tbl_39.BackgroundTransparency = 1
    tbl_39.TextXAlignment = tbl_39.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_39.TextColor3 = tbl_39.TextColor3 or (Colors_upv_1.Text)
    local u43 = UI_upv_1.new("TextLabel", tbl_39)
    local u44 = {Text = "", Name = "Xp", ZIndex = 4, TextSize = 19}
    u44.AnchorPoint = Vector2.new(1, 0)
    u44.Position = UDim2.new(1, -16, 0, 578)
    u44.Size = UDim2.fromOffset(280, 24)
    u44.FontFace = Fonts_upv_1.Bold
    u44.TextColor3 = Colors_upv_1.TextDim
    u44.TextXAlignment = Enum.TextXAlignment.Right
    u44.Parent = u18.body
    u44.BackgroundTransparency = 1
    u44.TextXAlignment = u44.TextXAlignment or (Enum.TextXAlignment.Left)
    u44.TextColor3 = u44.TextColor3 or (Colors_upv_1.Text)
    local u45 = UI_upv_1.new("TextLabel", u44)
    u44 = xpBar(u18.body, UDim2.fromOffset(16, 608), 444, 10)
    local tbl_40 = {ZIndex = 4, Name = "Brand", Text = "TRIBES", TextSize = 19}
    tbl_40.Position = UDim2.fromOffset(18, 640)
    tbl_40.Size = UDim2.fromOffset(200, 22)
    tbl_40.FontFace = Fonts_upv_1.Display
    tbl_40.Parent = u18.body
    tbl_40.BackgroundTransparency = 1
    tbl_40.TextXAlignment = tbl_40.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_40.TextColor3 = tbl_40.TextColor3 or (Colors_upv_1.Text)
    local u46 = UI_upv_1.new("TextLabel", tbl_40)
    local tbl_38 = {Text = "CAREER STATS", Name = "Kind", ZIndex = 4, TextSize = 15}
    tbl_38.AnchorPoint = Vector2.new(1, 0)
    tbl_38.Position = UDim2.new(1, -18, 0, 642)
    tbl_38.Size = UDim2.fromOffset(220, 20)
    tbl_38.FontFace = Fonts_upv_1.Heavy
    tbl_38.TextColor3 = Colors_upv_1.TextMuted
    tbl_38.TextXAlignment = Enum.TextXAlignment.Right
    tbl_38.Parent = u18.body
    tbl_38.BackgroundTransparency = 1
    tbl_38.TextXAlignment = tbl_38.TextXAlignment or (Enum.TextXAlignment.Left)
    tbl_38.TextColor3 = tbl_38.TextColor3 or (Colors_upv_1.Text)
    local v30 = UI_upv_1.new("TextLabel", tbl_38)
    local u47 = nil
    local u48 = tbl_upv_2[1]
    local function num(a21)
        --[[
          name: num
          line: 887
        ]]
        if type(a21) == "number" and a21 == a21 then
            return a21
        end
        return 0
    end
    local function ratio(a22, a23, a24)
        --[[
          name: ratio
          line: 890
        ]]
        if a23 > 0 then
            return string.format(a24, a22 / a23)
        elseif a22 > 0 then
            return (string.format(a24, a22))
        else
            return "\226\128\148"
        end
    end
    local function paintTier(a25)
        --[[
          name: paintTier
          line: 897
          upvalues:
            u48 (ref,  index: 1)
            u1 (copy, index: 2)
            Theme_upv_1 (copy, index: 3)
        ]]
        local rimGrad_1 = a25.rimGrad
        local v30
        if u48.prism then
            v30 = u1
        else
            local v31 = ColorSequence.new({ColorSequenceKeypoint.new(0, u48.hi), ColorSequenceKeypoint.new(0.45, u48.lo), ColorSequenceKeypoint.new(0.62, Theme_upv_1.Lighten(u48.lo, 0.12)), ColorSequenceKeypoint.new(1, u48.hi)})
            v30 = v31
        end
        rimGrad_1.Color = v30
        a25.bodyGrad.Color = ColorSequence.new(Theme_upv_1.Lighten(u48.deep, 0.05), Theme_upv_1.Darken(u48.deep, 0.45))
        a25.bodyStroke.Color = u48.hi
    end
    local function paintEmblem(a26, a27)
        --[[
          name: paintEmblem
          line: 907
          upvalues:
            u48 (ref, index: 1)
        ]]
        a26.grad.Color = ColorSequence.new(u48.hi, u48.lo)
        a26.num.Text = tostring(a27)
        local num_2 = a26.num
        local v32
        if a27 >= 100 then
            v32 = math.floor(a26.frame.Size.X.Offset * 0.4)
        else
            v32 = math.floor(a26.frame.Size.X.Offset * 0.5)
        end
        num_2.TextSize = v32
    end
    local function paintBar(a28, a29)
        --[[
          name: paintBar
          line: 912
          upvalues:
            Theme_upv_1 (copy, index: 1)
            u48 (ref,  index: 2)
        ]]
        a28.fill.Size = UDim2.fromScale(math.clamp(a29, 0, 1), 1)
        a28.fillGrad.Color = ColorSequence.new(Theme_upv_1.Lighten(u48.accent, 0.25), u48.accent)
    end
    local function hex(a30)
        --[[
          name: hex
          line: 884
        ]]
        return string.format("#%02X%02X%02X", math.floor((a30.R * 255) + 0.5), math.floor((a30.G * 255) + 0.5), math.floor((a30.B * 255) + 0.5))
    end
    local function paint()
        --[[
          name: paint
          line: 917
          upvalues:
            State_upv_1 (copy, index: 1)
            u47 (ref,  index: 2)
            u48 (ref,  index: 3)
            tbl_upv_2 (copy, index: 4)
            UI_upv_1 (copy, index: 5)
            paintTier (copy, index: 6)
            u17 (copy, index: 7)
            u18 (copy, index: 8)
            paintEmblem (copy, index: 9)
            u19 (copy, index: 10)
            u20 (copy, index: 11)
            LocalPlayer_upv_1 (copy, index: 12)
            u21 (copy, index: 13)
            u22 (copy, index: 14)
            u1 (copy, index: 15)
            u23 (copy, index: 16)
            Colors_upv_1 (copy, index: 17)
            u24 (copy, index: 18)
            Theme_upv_1 (copy, index: 19)
            u25 (copy, index: 20)
            u26 (copy, index: 21)
            u27 (copy, index: 22)
            u29 (copy, index: 23)
            u30 (copy, index: 24)
            holoBands (copy, index: 25)
            u31 (ref,  index: 26)
            tbl_upv_19 (copy, index: 27)
            u36 (copy, index: 28)
            u46 (copy, index: 29)
            u32 (copy, index: 30)
            u34 (copy, index: 31)
            u33 (copy, index: 32)
            tbl_upv_22 (copy, index: 33)
            u38 (copy, index: 34)
            u39 (copy, index: 35)
            u35 (copy, index: 36)
            u40 (copy, index: 37)
            u41 (copy, index: 38)
            tbl_upv_30 (copy, index: 39)
            WeaponInfo_upv_1 (copy, index: 40)
            Economy_upv_1 (copy, index: 41)
            tbl_upv_31 (copy, index: 42)
            u42 (copy, index: 43)
            hex (copy, index: 44)
            tbl_upv_36 (copy, index: 45)
            WeaponIcon_upv_1 (copy, index: 46)
            u43 (copy, index: 47)
            u45 (copy, index: 48)
            u44 (copy, index: 49)
            u15 (copy, index: 50)
            u16 (copy, index: 51)
        ]]
        local Profile_1 = State_upv_1.Profile
        local v33 = ((type(Profile_1.stats) ~= "table") and {}) or (Profile_1.stats)
        local v34 = u47 or (State_upv_1.Level())
        local v35 = tbl_upv_2[1]
        for _, value_3 in tbl_upv_2 do
            if value_3.min <= v34 then
                v35 = value_3
            end
        end
        u48 = v35
        v35 = State_upv_1.Xp()
        local XpToNext_1 = State_upv_1.XpToNext
        local v36
        if u47 then
            v36 = v34
        else
            v36 = nil
        end
        local v37 = XpToNext_1(v36)
        local v38 = nil
        if v34 >= 200 then
            v38 = true
        else
            v36 = false
        end
        local v39
        if v38 then
            v39 = "MAX LEVEL"
        else
            v39 = string.format("%s / %s XP", UI_upv_1.FormatNumber(v35), UI_upv_1.FormatNumber(v37))
        end
        local v40 = (v38 and 1) or (((v37 > 0) and (v35 / v37)) or 0)
        paintTier(u17)
        paintTier(u18)
        paintEmblem(u19, v34)
        u20.Text = LocalPlayer_upv_1.DisplayName
        v38 = utf8.len(LocalPlayer_upv_1.DisplayName) or (#LocalPlayer_upv_1.DisplayName)
        local v41
        if v38 <= 12 then
            v41 = 38
        else
            v41 = ((v38 <= 15) and 32) or 27
        end
        u20.TextSize = v41
        u21.Text = "@" .. LocalPlayer_upv_1.Name
        local v42
        if u48.prism then
            v42 = u1
        else
            v42 = ColorSequence.new(u48.hi, u48.lo)
        end
        u22.Color = v42
        u23.Text = u48.name
        u23.TextColor3 = Colors_upv_1.TextDark
        u24.Color = ColorSequence.new(Theme_upv_1.Darken(u48.lo, 0.2), Theme_upv_1.Darken(u48.deep, 0.2))
        u25.Color = u48.hi
        u26.ImageColor3 = u48.hi
        u27.ImageColor3 = u48.accent
        u29.BackgroundColor3 = Theme_upv_1.Darken(u48.deep, 0.15)
        u30.Transparency = holoBands(u48.holo)
        local v43 = ((not (u48.holo >= 0.45)) and 0) or (math.floor(u48.holo * 14))
        u31 = v43
        local v44 = nil
        for key_1, value_4 in tbl_upv_19 do
            v44 = key_1 <= u31
            value_4.Visible = v44
            value_4.ImageColor3 = Theme_upv_1.Lighten(u48.accent, 0.45)
        end
        u36.TextColor3 = u48.accent
        u46.TextColor3 = u48.accent
        u32.Text = "LEVEL " .. v34
        u34.Text = v39
        u33.fill.Size = UDim2.fromScale(math.clamp(v40, 0, 1), 1)
        u33.fillGrad.Color = ColorSequence.new(Theme_upv_1.Lighten(u48.accent, 0.25), u48.accent)
        local v45 = v33.matches
        local v46
        if type(v45) == "number" and v45 == v45 then
            v46 = v45
        else
            v46 = 0
        end
        local wins_1 = v33.wins
        local v47
        if type(wins_1) == "number" and wins_1 == wins_1 then
            v47 = wins_1
        else
            v47 = 0
        end
        local losses_1 = v33.losses
        local v48
        if type(losses_1) == "number" and losses_1 == losses_1 then
            v48 = losses_1
        else
            v48 = 0
        end
        local kills_1 = v33.kills
        if type(kills_1) == "number" and kills_1 == kills_1 then
            v45 = kills_1
        else
            v45 = 0
        end
        local deaths_1 = v33.deaths
        local v49
        if type(deaths_1) == "number" and deaths_1 == deaths_1 then
            v49 = deaths_1
        else
            v49 = 0
        end
        local assists_1 = v33.assists
        if type(assists_1) == "number" and assists_1 == assists_1 then
            v44 = assists_1
        else
            v44 = 0
        end
        v37 = State_upv_1.Get("Streak")
        local v50 = nil
        if type(v37) ~= "number" then
            v50 = v33.streak
            if type(v50) == "number" and v50 == v50 then
                v35 = v50
            else
                v35 = 0
            end
        else
            v35 = v37
        end
        local bestStreak_1 = v33.bestStreak
        local v51
        if type(bestStreak_1) == "number" and bestStreak_1 == bestStreak_1 then
            v51 = bestStreak_1
        else
            v51 = 0
        end
        v37 = math.max(v51, v35)
        local v52 = ((not (v46 > 0)) and "\226\128\148") or (string.format("%d%%", math.floor(((v47 / v46) * 100) + 0.5)))
        local v53
        if v49 > 0 then
            v53 = string.format("%.2f", v45 / v49)
        else
            v53 = ((not (v45 > 0)) and "\226\128\148") or (string.format("%.2f", v45))
        end
        local tbl_41 = {UI_upv_1.FormatNumber(v47), "WINS"}
        local tbl_42 = {v52, "WIN RATE"}
        local tbl_43 = {v53, "K/D"}
        local tbl_44 = {UI_upv_1.FormatNumber(v45), "KILLS"}
        local tbl_45 = {UI_upv_1.FormatNumber(v46), "MATCHES"}
        local tbl_46 = {tbl_41, tbl_42, tbl_43, tbl_44, tbl_45, {UI_upv_1.FormatNumber(v37), "BEST STREAK"}}
        for key_2, value_5 in tbl_46 do
            tbl_upv_22[key_2].value.Text = value_5[1]
            tbl_upv_22[key_2].label.Text = value_5[2]
        end
        u38.Text = LocalPlayer_upv_1.DisplayName
        u38.TextSize = ((v38 <= 12) and 32) or (((v38 <= 15) and 28) or 24)
        u39.Text = "@" .. LocalPlayer_upv_1.Name
        u35.Color = u48.hi
        paintEmblem(u40, v34)
        u41.BackgroundColor3 = u48.hi
        for _, value_6 in tbl_upv_30 do
            value_6.TextColor3 = u48.accent
        end
        local v54 = 0
        local v55 = 0
        local v56 = 0
        local v57, v58 = v54, v55
        for _, value_7 in WeaponInfo_upv_1.AllItems() do
            local v59 = v57 + 1
            if not (Economy_upv_1) then
                v57 = v59
                continue
            end
            local v60 = Economy_upv_1.Owns(value_7.id)
            if not (v60) then
                v57 = v59
                continue
            end
            local v61 = v58 + 1
            if Economy_upv_1.MaxLevel(value_7.id) > 1 then
                local v62 = Economy_upv_1.Level(value_7.id)
                v56 = ((Economy_upv_1.MaxLevel(value_7.id) <= v62) and (v56 + 1)) or v56
            end
            v57, v58 = v59, v61
        end
        local dropStats_1 = Profile_1.dropStats
        if type(dropStats_1) ~= "table" then
            v38 = 0
        else
            local v63 = dropStats_1.total
            if type(v63) == "number" and v63 == v63 then
                v38 = v63
            else
                v38 = 0
            end
        end
        local tbl_47 = {streak = 0, deaths = 0, kd = 0, drops = 0, items = 0, kills = 0, assists = 0, kpm = 0, bestStreak = 0, maxed = 0, roundsWon = 0}
        tbl_47.matches = UI_upv_1.FormatNumber(v46)
        tbl_47.wins = UI_upv_1.FormatNumber(v47)
        tbl_47.losses = UI_upv_1.FormatNumber(v48)
        tbl_47.winRate = v52
        local FormatNumber_1 = UI_upv_1.FormatNumber
        local roundsWon_1 = v33.roundsWon
        local v64
        if type(roundsWon_1) == "number" and roundsWon_1 == roundsWon_1 then
            v64 = roundsWon_1
        else
            v64 = 0
        end
        tbl_47.roundsWon = FormatNumber_1(v64)
        local v65
        if v35 >= 2 then
            v65 = "\240\159\148\165 " .. v35
        else
            v65 = tostring(v35)
        end
        tbl_47.streak = v65
        tbl_47.bestStreak = UI_upv_1.FormatNumber(v37)
        tbl_47.kills = UI_upv_1.FormatNumber(v45)
        tbl_47.deaths = UI_upv_1.FormatNumber(v49)
        tbl_47.assists = UI_upv_1.FormatNumber(v44)
        tbl_47.kd = v53
        local v66
        if v46 > 0 then
            v66 = string.format("%.1f", v45 / v46)
        else
            v66 = ((not (v45 > 0)) and "\226\128\148") or (string.format("%.1f", v45))
        end
        tbl_47.kpm = v66
        if (Economy_upv_1) and (Economy_upv_1.HasData()) then
            v66 = string.format("%d / %d", v58, v57)
        else
            v66 = "\226\128\148"
        end
        tbl_47.items = v66
        if (Economy_upv_1) and (Economy_upv_1.HasData()) then
            v66 = tostring(v56)
        else
            v66 = "\226\128\148"
        end
        tbl_47.maxed = v66
        tbl_47.drops = UI_upv_1.FormatNumber(v38)
        for key_3, value_8 in tbl_upv_31 do
            value_8.Text = tbl_47[key_3] or "\226\128\148"
        end
        v56 = State_upv_1.Loadout()
        u42.Text = string.format("<font color=\"%s\">ACTIVE LOADOUT</font>", hex(u48.accent))
        local tbl_48 = {}
        for _, value_9 in v56.items do
            if #tbl_48 < 6 then
                table.insert(tbl_48, value_9)
            end
        end
        if type(v56.armor) == "string" then
            table.insert(tbl_48, v56.armor)
        end
        for key_4, value_10 in tbl_upv_36 do
            v56 = tbl_48[key_4]
            value_10.Visible = v56 ~= nil
            WeaponIcon_upv_1.Set(value_10, v56, {})
        end
        u43.Text = "LEVEL " .. v34
        u45.Text = v39
        u44.fill.Size = UDim2.fromScale(math.clamp(v40, 0, 1), 1)
        u44.fillGrad.Color = ColorSequence.new(Theme_upv_1.Lighten(u48.accent, 0.25), u48.accent)
        u15.ImageColor3 = u48.accent
        u16.ImageColor3 = u48.hi
    end
    local function setImages()
        --[[
          name: setImages
          line: 1045
          upvalues:
            u28 (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            u37 (copy, index: 3)
        ]]
        u28.Image = string.format("rbxthumb://type=Avatar&id=%d&w=720&h=720", LocalPlayer_upv_1.UserId)
        u37.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", LocalPlayer_upv_1.UserId)
    end
    local u49 = UI_upv_1.new("Frame", {Visible = false, Name = "PlayerCard", Size = UDim2.fromScale(1, 1), Parent = a1.Canvas.Menus})
    local u50 = UI_upv_1.new("TextButton", {Visible = false, Active = true, Selectable = false, Text = "", AutoButtonColor = false, Name = "PlayerCardCatcher", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = UI_upv_1.BackdropCanvas or u49})
    local u51 = UI_upv_1.IconButton({IconName = "cross", IconScale = 0.42, Transparency = 0.2, Name = "Close", Sound = "Close", AnchorPoint = Vector2.new(1, 0), Size = UDim2.fromOffset(56, 56), Color = Colors_upv_1.Panel, Parent = u49})
    local u52 = UI_upv_1.Button({Radius = 14, Text = "FLIP", Name = "Flip", Sound = false, Style = "Dark", TextSize = 22, Size = UDim2.fromOffset(170, 54), AnchorPoint = Vector2.new(0.5, 0.5), Parent = u49})
    local RankArt_upv_1 = require(script.Parent.Parent.RankArt)
    local u53 = UI_upv_1.Button({Radius = 14, Name = "Ranks", Style = "Dark", Text = "RANKS", TextSize = 22, Size = UDim2.fromOffset(170, 54), AnchorPoint = Vector2.new(0.5, 0.5), Parent = u49})
    local u54 = RankArt_upv_1.Emblem(1, 34, {ZIndex = 3, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Parent = u53.Face})
    u53.Activated:Connect(
        function()
            --[[
              line: 1099
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.MenuManager.Open("Ranks")
        end
    )
    UI_upv_1.KeyCap("F", {Height = 24, TextSize = 15, ZIndex = 3, Gamepad = Enum.KeyCode.ButtonA, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, -1), Parent = u52.Face})
    local u55 = false
    local u56 = false
    local u57 = false
    local u58 = 0
    local u59 = 0
    local u60 = 0
    local u61 = 0
    local u62 = 0
    local u63 = 0
    local u64 = 0
    local u65 = 0
    local u66 = 0
    local u67 = 0
    local u68 = 0
    local u69 = 0
    local u70 = false
    local u71 = nil
    local X_upv_1 = 0
    local Y_upv_1 = 0
    local u72 = 0
    local u73 = 0
    local u74 = false
    local u75 = 0
    local u76 = 0
    local u77 = 0
    local u78 = 0
    local u79 = nil
    local u80 = false
    local u81 = 1
    local u82 = true
    local u83 = 0.8
    local u84 = 0.03
    local u85 = 0
    local u86 = 0
    local X_upv_2 = 0
    local Y_upv_2 = 0
    local Y_upv_3 = 0
    local u87 = 0
    local u88 = -1
    local u89 = -1
    local function layout()
        --[[
          name: layout
          line: 1138
          upvalues:
            UI_upv_1 (copy, index: 1)
            u83 (ref,  index: 2)
            u84 (ref,  index: 3)
            u51 (copy, index: 4)
            u52 (copy, index: 5)
            u53 (copy, index: 6)
            Y_upv_3 (ref,  index: 7)
            GuiService_upv_1 (copy, index: 8)
            Workspace_upv_1 (copy, index: 9)
            u85 (ref,  index: 10)
            u8 (copy, index: 11)
            u9 (copy, index: 12)
            u17 (copy, index: 13)
            u18 (copy, index: 14)
        ]]
        local v67 = UI_upv_1.CanvasSize()
        local v68 = UI_upv_1.TopInset()
        if not (UI_upv_1.Compact) or UI_upv_1.Tablet then
            u83 = 0.76
            u84 = 0.05
            u51.Position = UDim2.new(1, -24, 0, v68 + 4)
            u51.Size = UDim2.fromOffset(56, 56)
            local v69 = math.floor((v67.Y * ((0.5 - u84) + (u83 / 2)) + v67.Y) / 2)
            u52.Instance.Position = UDim2.fromOffset(math.floor(v67.X / 2) - 95, v69)
            u52.Instance.Size = UDim2.fromOffset(170, 54)
            u53.Instance.Position = UDim2.fromOffset(math.floor(v67.X / 2) + 95, v69)
            u53.Instance.Size = UDim2.fromOffset(170, 54)
        else
            u83 = 0.9
            u84 = 0
            u51.Position = UDim2.new(1, -16, 0, math.max(8, v68 - 52))
            u51.Size = UDim2.fromOffset(60, 60)
            local v70 = (v67.Y * u83) * 500 / 700
            local v71 = (v67.X / 2) + (v70 / 2) + ((v67.X / 2) - (v70 / 2)) / 2
            u52.Instance.Position = UDim2.fromOffset(math.floor(v71), math.floor(v67.Y * 0.84))
            u52.Instance.Size = UDim2.fromOffset(170, 60)
            u53.Instance.Position = UDim2.fromOffset(math.floor(v71), math.floor(v67.Y * 0.84) - 72)
            u53.Instance.Size = UDim2.fromOffset(170, 60)
        end
        Y_upv_3 = GuiService_upv_1:GetGuiInset().Y
        local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
        local v72 = math.clamp(((((not CurrentCamera_1) and 900) or (CurrentCamera_1.ViewportSize.Y)) * u83) / 700, 1, 1.8)
        if math.abs(v72 - u85) > 0.01 then
            u85 = v72
            local v73 = Vector2.new(math.floor(v72 * 500), math.floor(v72 * 700))
            u8.CanvasSize = v73
            u9.CanvasSize = v73
            u17.scale.Scale = v73.X / 500
            u18.scale.Scale = v73.X / 500
        end
    end
    local function doFlip()
        --[[
          name: doFlip
          line: 1194
          upvalues:
            u55 (ref,  index: 1)
            u56 (ref,  index: 2)
            u66 (ref,  index: 3)
            u64 (ref,  index: 4)
            u65 (ref,  index: 5)
            a1 (copy, index: 6)
        ]]
        if not u55 or (u56) then
            return
        end
        if u66 >= math.tau then
            u66 = u66 - math.tau
            u64 = u64 - math.tau
        end
        u66 = u66 + math.pi
        u65 = u65 + 1.5
        a1.Sounds.Play("Card_Flip")
    end
    local function step(a31)
        --[[
          name: step
          line: 1211
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            u70 (ref,  index: 2)
            u84 (ref,  index: 3)
            Y_upv_3 (ref,  index: 4)
            u83 (ref,  index: 5)
            u74 (ref,  index: 6)
            u68 (ref,  index: 7)
            u69 (ref,  index: 8)
            u75 (ref,  index: 9)
            u76 (ref,  index: 10)
            u77 (ref,  index: 11)
            u78 (ref,  index: 12)
            u62 (ref,  index: 13)
            u60 (ref,  index: 14)
            u63 (ref,  index: 15)
            u61 (ref,  index: 16)
            u65 (ref,  index: 17)
            u66 (ref,  index: 18)
            u64 (ref,  index: 19)
            u58 (ref,  index: 20)
            u81 (ref,  index: 21)
            u56 (ref,  index: 22)
            u59 (ref,  index: 23)
            u67 (ref,  index: 24)
            u5 (copy, index: 25)
            u6 (copy, index: 26)
            u86 (ref,  index: 27)
            X_upv_2 (ref,  index: 28)
            Y_upv_2 (ref,  index: 29)
            u7 (copy, index: 30)
            u82 (ref,  index: 31)
            u8 (copy, index: 32)
            u9 (copy, index: 33)
            u17 (copy, index: 34)
            u18 (copy, index: 35)
            u88 (ref,  index: 36)
            u89 (ref,  index: 37)
            u30 (copy, index: 38)
            u31 (ref,  index: 39)
            tbl_upv_20 (copy, index: 40)
            tbl_upv_19 (copy, index: 41)
            u28 (copy, index: 42)
            u26 (copy, index: 43)
            u87 (ref,  index: 44)
            u16 (copy, index: 45)
            u13 (copy, index: 46)
            u14 (copy, index: 47)
            u15 (copy, index: 48)
            u12 (copy, index: 49)
            u10 (copy, index: 50)
            u11 (copy, index: 51)
            u4 (copy, index: 52)
            u57 (ref,  index: 53)
            RunService_upv_1 (copy, index: 54)
        ]]
        local v74 = math.min(a31, 0.05)
        local CurrentCamera_2 = Workspace_upv_1.CurrentCamera
        if not CurrentCamera_2 then
            return
        end
        local v75 = os.clock()
        local ViewportSize_1 = CurrentCamera_2.ViewportSize
        local v76 = 0
        local v77 = 0
        if u70 then
            local v78 = ViewportSize_1.Y * (0.5 - u84) - Y_upv_3
            local v79 = ViewportSize_1.Y * u83 / 2
            local v80 = (u74 and ((v79 * 500) / 700 * 1.3)) or (ViewportSize_1.X * 0.5)
            local v81 = (u74 and (v79 * 1.3)) or (ViewportSize_1.Y * 0.5)
            v76 = math.clamp((u68 - (ViewportSize_1.X / 2)) / v80, -1, 1)
            v77 = math.clamp((u69 - v78) / v81, -1, 1)
        elseif u75 ~= 0 or u76 ~= 0 then
            v76 = u75
            v77 = u76
        end
        local v82 = (u70 and 0.35) or 1
        local v83 = (v76 * 0.12217304763960307) + u77 + (math.sin(v75 * 0.7) * 0.018) * v82
        v76 = (v77 * 0.08726646259971647) + u78 + (math.cos(v75 * 0.93) * 0.014) * v82
        u62 = u62 + ((((v83 - u60) * 90) - (u62 * 13.661039491927399)) * v74)
        u63 = u63 + ((((v76 - u61) * 90) - (u63 * 13.661039491927399)) * v74)
        u60 = u60 + (u62 * v74)
        u61 = u61 + (u63 * v74)
        u65 = u65 + ((((u66 - u64) * 120) - (u65 * 13.145341380123986)) * v74)
        u64 = u64 + (u65 * v74)
        local v84 = 0
        local v85 = 0
        local v86 = 0
        local v87 = math.clamp((v75 - u58) / (u81 * 0.62), 0, 1)
        if v87 < 1 then
            v84, v85 = -(1 - (((((v87 - 1) ^ 3) * 2.4) + 1) + (((v87 - 1) ^ 2) * 1.4))) * 1.05, -(1 - (1 - ((1 - v87) ^ 3))) * math.pi * 2
        end
        local v88 = (v75 - u58) / u81 - 0.62
        if v88 > 0 then
            v86 = ((v88 < 0.35) and (math.sin((v88 / 0.35) * math.pi) * 0.035)) or v86
        end
        if u56 then
            local v89 = math.clamp((v75 - u59) / (u81 * 0.24), 0, 1)
            local v90 = v84 - ((v89 * v89) * v89) * 1.25
            v85 = v85 + v89 * 0.7
            u67 = math.max(0, u67 - v74 / 0.24)
            v84 = v90
        else
            u67 = math.min(1, u67 + v74 / 0.3)
        end
        local v91 = math.tan(math.rad(CurrentCamera_2.FieldOfView) / 2)
        v77 = 1 / ((v91 * 2) * u83)
        local v92 = CurrentCamera_2.CFrame * CFrame.new(0, (u84 + v84) * ((v77 * 2) * v91), -v77 * (1 - v86))
        local v93 = u60 + u64 + v85
        u5.CFrame = v92 * CFrame.Angles(u61, 0, 0) * CFrame.Angles(0, v93, 0)
        local v94 = u60 / 0.12217304763960307
        local v95 = u61 / 0.08726646259971647
        u6.CFrame = v92 * CFrame.new(-v94 * 0.05, (v95 * 0.03) + -0.035, -0.14)
        local v96 = v77 + 0.4
        local v97 = (v96 * 2) * v91 * 1.2
        if math.abs(v97 - u86) > 0.001 or ViewportSize_1.X ~= X_upv_2 or ViewportSize_1.Y ~= Y_upv_2 then
            u86 = v97
            X_upv_2 = ViewportSize_1.X
            Y_upv_2 = ViewportSize_1.Y
            u7.Size = Vector3.new(((v97 * ViewportSize_1.X) / math.max(ViewportSize_1.Y, 1)) * 1.1, v97, 0.004)
            u6.Size = Vector3.new(1.0714285373687744, 1.350000023841858, 0.004000000189989805)
        end
        u7.CFrame = CurrentCamera_2.CFrame * CFrame.new(0, 0, -v96)
        if u5.CFrame.LookVector:Dot(CurrentCamera_2.CFrame.Position - u5.Position) < 0 then
            v85 = true
        else
            v85 = false
        end
        if v85 ~= u82 then
            u82 = v85
            u8.Enabled = v85
            u9.Enabled = not v85
        end
        local v98
        if v85 then
            v98 = u17
        else
            v98 = u18
        end
        local v99 = math.clamp(v94, -1.4, 1.4) * 0.55 + 0.5
        local v100 = math.clamp(v95, -1.4, 1.4) * 0.55 + 0.45
        if math.abs(v99 - u88) > 0.002 or math.abs(v100 - u89) > 0.002 then
            u88 = v99
            u89 = v100
            v98.glare.Position = UDim2.fromScale(v99, v100)
            v98.glare.ImageTransparency = 0.82 - (math.min(1, math.sqrt((v94 * v94) + (v95 * v95))) * 0.12)
            v98.band.Position = UDim2.fromScale(0.5 - (v94 * 0.6), 0.55 - (v95 * 0.3))
            v98.rimGrad.Offset = Vector2.new(v94 * 0.35, v95 * 0.35)
            if v85 then
                u30.Offset = Vector2.new(v94 * 0.6, v95 * 0.4)
                for n_5 = 1, u31 do
                    local v101 = math.cos(((v94 * 2.3) + (v95 * 1.7) + tbl_upv_20[n_5]) * math.pi)
                    tbl_upv_19[n_5].ImageTransparency = 1 - ((((v101 > 0) and (v101 ^ 10)) or 0) * 0.75)
                end
                u28.Position = UDim2.new(0.5, -v94 * 10, 1, (v95 * 5) + 24)
                u26.Position = UDim2.new(0.5, v94 * 7, 0.42, -v95 * 5)
            end
        end
        u87 = (u87 + (v74 * 5)) % 360
        if v85 then
            u26.Rotation = u87
        end
        u16.Rotation = -u87 * 0.6
        u13.BackgroundTransparency = 1 - (u67 * 0.55)
        u14.ImageTransparency = 1 - (u67 * 0.8)
        u15.ImageTransparency = 1 - (u67 * 0.3)
        u16.ImageTransparency = 1 - (u67 * 0.06)
        u12.ImageTransparency = 1 - (u67 * 0.7)
        if not u56 then
            return
        end
        if (u81 * 0.24 <= v75 - u59) then
            u56 = false
            u8.Enabled = false
            u9.Enabled = false
            u10.Enabled = false
            u11.Enabled = false
            u4.Parent = nil
            if not u57 then
                return
            end
            u57 = false
            RunService_upv_1:UnbindFromRenderStep("TR_PlayerCard")
        end
    end
    local function bind()
        --[[
          name: bind
          line: 1340
          upvalues:
            u57 (ref,  index: 1)
            RunService_upv_1 (copy, index: 2)
            step (copy, index: 3)
        ]]
        if (u57) then
            return
        end
        u57 = true
        RunService_upv_1:BindToRenderStep("TR_PlayerCard", Enum.RenderPriority.Camera.Value + 10, step)
    end
    local function cardScreenRect()
        --[[
          name: cardScreenRect
          line: 1183
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            u5 (copy, index: 2)
        ]]
        local CurrentCamera_3 = Workspace_upv_1.CurrentCamera
        local CFrame_1 = u5.CFrame
        local v102 = math.huge
        local v103 = math.huge
        local v104 = -math.huge
        local v105 = -math.huge
        for _, value_11 in {Vector3.new(-1, -1, 0), Vector3.new(1, -1, 0), Vector3.new(-1, 1, 0), Vector3.new(1, 1, 0)} do
            local v106 = CurrentCamera_3:WorldToScreenPoint((CFrame_1 * CFrame.new((value_11.X * 0.7142857142857143) / 2, (value_11.Y * 1) / 2, 0)).Position)
            v102, v103, v104, v105 = math.min(v102, v106.X), math.min(v103, v106.Y), math.max(v104, v106.X), math.max(v105, v106.Y)
        end
        return v102, v103, v104, v105
    end
    local function inRect(a32, a33)
        --[[
          name: inRect
          line: 1348
          upvalues:
            cardScreenRect (copy, index: 1)
        ]]
        local v107, v108, v109, v110 = cardScreenRect()
        return (v107 <= a32) and ((a32 <= v109) and ((v108 <= a33) and (a33 <= v110)))
    end
    u50.InputBegan:Connect(
        function(a34)
            --[[
              line: 1352
              upvalues:
                u55 (ref, index: 1)
                u56 (ref, index: 2)
                u71 (ref, index: 3)
                X_upv_1 (ref, index: 4)
                Y_upv_1 (ref, index: 5)
                u72 (ref, index: 6)
                u73 (ref, index: 7)
                u74 (ref, index: 8)
                u70 (ref, index: 9)
                u68 (ref, index: 10)
                u69 (ref, index: 11)
            ]]
            if not u55 then
                return
            end
            if not (u56) then
                local UserInputType_1 = a34.UserInputType
                if UserInputType_1 == Enum.UserInputType.MouseButton1 or UserInputType_1 == Enum.UserInputType.Touch then
                    u71 = a34
                    local v111 = os.clock()
                    X_upv_1 = a34.Position.X
                    Y_upv_1 = a34.Position.Y
                    u72 = v111
                    u73 = 0
                    if UserInputType_1 == Enum.UserInputType.Touch then
                        u74 = true
                        u70 = true
                        u68 = a34.Position.X
                        u69 = a34.Position.Y
                    end
                end
            end
        end
    )
    u50.InputChanged:Connect(
        function(a35)
            --[[
              line: 1369
              upvalues:
                u55 (ref, index: 1)
                u74 (ref, index: 2)
                u68 (ref, index: 3)
                u69 (ref, index: 4)
                u73 (ref, index: 5)
                X_upv_1 (ref, index: 6)
                Y_upv_1 (ref, index: 7)
            ]]
            if not u55 or not u74 then
                return
            end
            if a35.UserInputType == Enum.UserInputType.Touch then
                u68 = a35.Position.X
                u69 = a35.Position.Y
                u73 = math.max(u73, math.abs(u68 - X_upv_1) + math.abs(u69 - Y_upv_1))
            end
        end
    )
    UserInputService_upv_1.InputChanged:Connect(
        function(a36)
            --[[
              line: 1375
              upvalues:
                u55 (ref, index: 1)
                u74 (ref, index: 2)
                u80 (ref, index: 3)
                u68 (ref, index: 4)
                u69 (ref, index: 5)
                u70 (ref, index: 6)
                u75 (ref, index: 7)
                u76 (ref, index: 8)
            ]]
            if not u55 then
                return
            end
            local UserInputType_2 = a36.UserInputType
            if UserInputType_2 == Enum.UserInputType.MouseMovement and not (u74) and not (u80) then
                u68 = a36.Position.X
                u69 = a36.Position.Y
                u70 = true
                return
            end
            if UserInputType_2 ~= Enum.UserInputType.Gamepad1 then
                return
            end
            if a36.KeyCode == Enum.KeyCode.Thumbstick2 then
                local Position_1 = a36.Position
                if math.sqrt((Position_1.X * Position_1.X) + (Position_1.Y * Position_1.Y)) < 0.2 then
                    u75 = 0
                    u76 = 0
                else
                    u75 = Position_1.X
                    u76 = -Position_1.Y
                    u70 = false
                end
            end
        end
    )
    UserInputService_upv_1.InputEnded:Connect(
        function(a37)
            --[[
              line: 1394
              upvalues:
                u71 (ref,  index: 1)
                u74 (ref,  index: 2)
                u80 (ref,  index: 3)
                u70 (ref,  index: 4)
                u55 (ref,  index: 5)
                u56 (ref,  index: 6)
                u73 (ref,  index: 7)
                X_upv_1 (ref,  index: 8)
                Y_upv_1 (ref,  index: 9)
                u72 (ref,  index: 10)
                cardScreenRect (copy, index: 11)
                u66 (ref,  index: 12)
                u64 (ref,  index: 13)
                u65 (ref,  index: 14)
                a1 (copy, index: 15)
            ]]
            local v112 = a37.UserInputType == Enum.UserInputType.Touch
            if a37 ~= u71 and (not v112 or not u74) then
                return
            end
            u71 = nil
            if v112 then
                u74 = false
                if not (u80) then
                    u70 = false
                end
            end
            if u55 and not (u56) then
                if not (u73 + math.abs(a37.Position.X - X_upv_1) + math.abs(a37.Position.Y - Y_upv_1) > 16) and not (os.clock() - u72 > 0.45) then
                    local v113 = X_upv_1
                    local v114 = Y_upv_1
                    local v115, v116, v117, v118 = cardScreenRect()
                    if (v115 <= v113) and ((v113 <= v117) and ((v116 <= v114) and (v114 <= v118))) then
                        if u55 then
                            if not u56 then
                                if u66 >= math.tau then
                                    u66 = u66 - math.tau
                                    u64 = u64 - math.tau
                                end
                                u66 = u66 + math.pi
                                u65 = u65 + 1.5
                                a1.Sounds.Play("Card_Flip")
                            end
                            return
                        end
                    else
                        a1.MenuManager.Close("PlayerCard")
                    end
                    return
                end
                return
            end
        end
    )
    UserInputService_upv_1.InputBegan:Connect(
        function(a38, a39)
            --[[
              line: 1419
              upvalues:
                u55 (ref,  index: 1)
                u56 (ref,  index: 2)
                UserInputService_upv_1 (copy, index: 3)
                u66 (ref,  index: 4)
                u64 (ref,  index: 5)
                u65 (ref,  index: 6)
                a1 (copy, index: 7)
                GuiService_upv_1 (copy, index: 8)
            ]]
            if not u55 or (u56) or (UserInputService_upv_1:GetFocusedTextBox()) then
                return
            end
            if a38.KeyCode == Enum.KeyCode.F and not (a39) then
                if u55 and not u56 then
                    if u66 >= math.tau then
                        u66 = u66 - math.tau
                        u64 = u64 - math.tau
                    end
                    u66 = u66 + math.pi
                    u65 = u65 + 1.5
                    a1.Sounds.Play("Card_Flip")
                end
                return
            end
            if a38.KeyCode ~= Enum.KeyCode.ButtonA or GuiService_upv_1.SelectedObject ~= nil or not u55 or u56 then
                return
            end
            if u66 >= math.tau then
                u66 = u66 - math.tau
                u64 = u64 - math.tau
            end
            u66 = u66 + math.pi
            u65 = u65 + 1.5
            a1.Sounds.Play("Card_Flip")
        end
    )
    local u90 = nil
    local function setGyro(a40)
        --[[
          name: setGyro
          line: 1431
          upvalues:
            u90 (ref,  index: 1)
            u77 (ref,  index: 2)
            u78 (ref,  index: 3)
            u79 (ref,  index: 4)
            UI_upv_1 (copy, index: 5)
            UserInputService_upv_1 (copy, index: 6)
        ]]
        if u90 then
            u90:Disconnect()
            u90 = nil
        end
        u77 = 0
        u78 = 0
        u79 = nil
        if not a40 or not UI_upv_1.Touch then
            return
        end
        if UserInputService_upv_1.GyroscopeEnabled then
            local v119 = UserInputService_upv_1.DeviceRotationChanged:Connect(
                function(a41, a42)
                    --[[
                      line: 1440
                      upvalues:
                        u79 (ref, index: 1)
                        u77 (ref, index: 2)
                        u78 (ref, index: 3)
                    ]]
                    if u79 then
                        local v120 = u79:Lerp(a42, 0.03)
                        u79 = v120
                        local v121, v122 = v120:ToObjectSpace(a42):ToEulerAnglesYXZ()
                        u77 = math.clamp(-v122 * 0.5, -0.08726646259971647, 0.08726646259971647)
                        u78 = math.clamp(-v121 * 0.5, -0.06981317007977318, 0.06981317007977318)
                    else
                        u79 = a42
                    end
                end
            )
            u90 = v119
        end
    end
    u51.Activated:Connect(
        function()
            --[[
              line: 1453
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.MenuManager.Close("PlayerCard")
        end
    )
    u52.Activated:Connect(doFlip)
    local function hideOthers(a43)
        --[[
          name: hideOthers
          line: 1459
          upvalues:
            a1 (copy, index: 1)
            u3 (ref,  index: 2)
        ]]
        a1.SetHudHidden("PlayerCard", a43)
        if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
            a1.TopbarSettings.SetHidden("PlayerCard", a43)
        end
        if a43 then
            if u3 then
                return
            end
            local tbl_49 = {}
            pcall(function() end)
            u3 = tbl_49
        else
            local v123 = u3
            if not v123 then
                return
            end
            u3 = nil
            pcall(function() end)
        end
    end
    local tbl_50 = {blur = false}
    function tbl_50.open()
        --[[
          name: open
          line: 1473
          upvalues:
            u55 (ref,  index: 1)
            u56 (ref,  index: 2)
            a1 (copy, index: 3)
            u3 (ref,  index: 4)
            TextChatService_upv_1 (copy, index: 5)
            StarterGui_upv_1 (copy, index: 6)
            u28 (copy, index: 7)
            LocalPlayer_upv_1 (copy, index: 8)
            u37 (copy, index: 9)
            paint (copy, index: 10)
            RankArt_upv_1 (copy, index: 11)
            u54 (copy, index: 12)
            layout (copy, index: 13)
            u58 (ref,  index: 14)
            u60 (ref,  index: 15)
            u61 (ref,  index: 16)
            u62 (ref,  index: 17)
            u63 (ref,  index: 18)
            u64 (ref,  index: 19)
            u65 (ref,  index: 20)
            u66 (ref,  index: 21)
            u67 (ref,  index: 22)
            u88 (ref,  index: 23)
            u89 (ref,  index: 24)
            u80 (ref,  index: 25)
            u70 (ref,  index: 26)
            u74 (ref,  index: 27)
            u71 (ref,  index: 28)
            u75 (ref,  index: 29)
            u76 (ref,  index: 30)
            u82 (ref,  index: 31)
            u8 (copy, index: 32)
            u9 (copy, index: 33)
            u10 (copy, index: 34)
            u11 (copy, index: 35)
            u4 (copy, index: 36)
            Workspace_upv_1 (copy, index: 37)
            u49 (copy, index: 38)
            u50 (copy, index: 39)
            UI_upv_1 (copy, index: 40)
            u51 (copy, index: 41)
            u52 (copy, index: 42)
            setGyro (copy, index: 43)
            u57 (ref,  index: 44)
            RunService_upv_1 (copy, index: 45)
            step (copy, index: 46)
        ]]
        if u55 then
            return
        end
        u55 = true
        u56 = false
        a1.SetHudHidden("PlayerCard", true)
        if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
            a1.TopbarSettings.SetHidden("PlayerCard", true)
        end
        if not (u3) then
            local tbl_upv_51 = {}
            pcall(
                function()
                    --[[
                      line: 113
                      upvalues:
                        TextChatService_upv_1 (copy, index: 1)
                        tbl_upv_51 (copy, index: 2)
                        StarterGui_upv_1 (copy, index: 3)
                    ]]
                    local v124 = TextChatService_upv_1:FindFirstChildOfClass("ChatWindowConfiguration")
                    local v125 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                    if v124 then
                        tbl_upv_51.window = v124.Enabled
                        v124.Enabled = false
                    end
                    if v125 then
                        tbl_upv_51.bar = v125.Enabled
                        v125.Enabled = false
                    end
                    tbl_upv_51.core = StarterGui_upv_1:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                    StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                end
            )
            u3 = tbl_upv_51
        end
        u28.Image = string.format("rbxthumb://type=Avatar&id=%d&w=720&h=720", LocalPlayer_upv_1.UserId)
        u37.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", LocalPlayer_upv_1.UserId)
        paint()
        RankArt_upv_1.SetEmblem(u54, RankArt_upv_1.Ranks.RankOf(tonumber(a1.State.Get("Trophies")) or 0))
        layout()
        u58 = os.clock()
        u60 = 0
        u61 = 0
        u62 = 0
        u63 = 0
        u64 = 0
        u65 = 0
        u66 = 0
        u67 = 0
        u88 = -1
        u89 = -1
        if not (u80) then
            u70 = false
        end
        u74 = false
        u71 = nil
        u75 = 0
        u76 = 0
        u82 = true
        u8.Enabled = true
        u9.Enabled = false
        u10.Enabled = true
        u11.Enabled = true
        u4.Parent = Workspace_upv_1.CurrentCamera
        u49.Visible = true
        u50.Visible = true
        UI_upv_1.Enter(u51, Vector2.new(0, -10), 0.25)
        UI_upv_1.Enter(u52.Instance, Vector2.new(0, 14), 0.35)
        setGyro(true)
        if not (u57) then
            u57 = true
            RunService_upv_1:BindToRenderStep("TR_PlayerCard", Enum.RenderPriority.Camera.Value + 10, step)
        end
        step(0)
        a1.Sounds.Play("Card_Whoosh")
    end
    function tbl_50.close(a44)
        --[[
          name: close
          line: 1504
          upvalues:
            u55 (ref,  index: 1)
            a1 (copy, index: 2)
            u3 (ref,  index: 3)
            TextChatService_upv_1 (copy, index: 4)
            StarterGui_upv_1 (copy, index: 5)
            u49 (copy, index: 6)
            u50 (copy, index: 7)
            u90 (ref,  index: 8)
            u77 (ref,  index: 9)
            u78 (ref,  index: 10)
            u79 (ref,  index: 11)
            u56 (ref,  index: 12)
            u59 (ref,  index: 13)
            u81 (ref,  index: 14)
            step (copy, index: 15)
        ]]
        if not u55 then
            return
        end
        u55 = false
        a1.SetHudHidden("PlayerCard", false)
        if a1.TopbarSettings and a1.TopbarSettings.SetHidden then
            a1.TopbarSettings.SetHidden("PlayerCard", false)
        end
        local u91 = u3
        if u91 then
            u3 = nil
            pcall(
                function()
                    --[[
                      line: 135
                      upvalues:
                        TextChatService_upv_1 (copy, index: 1)
                        u91 (copy, index: 2)
                        StarterGui_upv_1 (copy, index: 3)
                    ]]
                    local v126 = TextChatService_upv_1:FindFirstChildOfClass("ChatWindowConfiguration")
                    local v127 = TextChatService_upv_1:FindFirstChildOfClass("ChatInputBarConfiguration")
                    if v126 and u91.window ~= nil then
                        v126.Enabled = u91.window
                    end
                    if v127 and u91.bar ~= nil then
                        v127.Enabled = u91.bar
                    end
                    if u91.core == nil then
                        return
                    end
                    StarterGui_upv_1:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, u91.core)
                end
            )
        end
        u49.Visible = false
        u50.Visible = false
        if u90 then
            u90:Disconnect()
            u90 = nil
        end
        u77 = 0
        u78 = 0
        u79 = nil
        if a44 then
            u56 = true
            local v128 = os.clock()
            u59 = v128 - (u81 * 0.24)
            step(0)
        else
            u56 = true
            u59 = os.clock()
        end
    end
    a1.MenuManager.Register("PlayerCard", tbl_50)
    State_upv_1.PlayerStateChanged:Connect(
        function(a45)
            --[[
              line: 1523
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a45 ~= "Match" or not a1.MenuManager.IsOpen("PlayerCard") then
                return
            end
            a1.MenuManager.Close("PlayerCard", true)
        end
    )
    State_upv_1.ProfileChanged:Connect(
        function()
            --[[
              line: 1528
              upvalues:
                u55 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            if not u55 then
                return
            end
            paint()
        end
    )
    State_upv_1.AttrChanged:Connect(
        function(a46)
            --[[
              line: 1533
              upvalues:
                u55 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            if not u55 or a46 ~= "Level" and a46 ~= "XP" and a46 ~= "Streak" then
                return
            end
            paint()
        end
    )
    UI_upv_1.LayoutChanged:Connect(
        function()
            --[[
              line: 1538
              upvalues:
                u55 (ref,  index: 1)
                layout (copy, index: 2)
            ]]
            if not u55 then
                return
            end
            layout()
        end
    )
    UI_upv_1.ScaleChanged:Connect(
        function()
            --[[
              line: 1543
              upvalues:
                u55 (ref,  index: 1)
                layout (copy, index: 2)
            ]]
            if not u55 then
                return
            end
            layout()
        end
    )
    a1.Debug.playerCard = function(a47, a48, a49)
        --[[
          line: 1550
          upvalues:
            a1 (copy, index: 1)
            u55 (ref,  index: 2)
            u56 (ref,  index: 3)
            u66 (ref,  index: 4)
            u64 (ref,  index: 5)
            u65 (ref,  index: 6)
            Workspace_upv_1 (copy, index: 7)
            GuiService_upv_1 (copy, index: 8)
            u80 (ref,  index: 9)
            u70 (ref,  index: 10)
            u68 (ref,  index: 11)
            u69 (ref,  index: 12)
            u84 (ref,  index: 13)
            u81 (ref,  index: 14)
            u47 (ref,  index: 15)
            paint (copy, index: 16)
            cardScreenRect (copy, index: 17)
            u57 (ref,  index: 18)
            u82 (ref,  index: 19)
            u60 (ref,  index: 20)
            u61 (ref,  index: 21)
            u48 (ref,  index: 22)
            u8 (copy, index: 23)
            u3 (ref,  index: 24)
            u74 (ref,  index: 25)
            u73 (ref,  index: 26)
            tbl_upv_22 (copy, index: 27)
            tbl_upv_31 (copy, index: 28)
        ]]
        if a47 == "open" then
            a1.MenuManager.Open("PlayerCard")
        elseif a47 == "close" then
            a1.MenuManager.Close("PlayerCard")
        elseif a47 ~= "flip" then
            if a47 ~= "tilt" then
                if a47 == "pace" then
                    local v129
                    if type(a48) == "number" and (a48 > 0) then
                        v129 = a48
                    else
                        v129 = 1
                    end
                    u81 = v129
                elseif a47 == "level" then
                    local v129
                    if type(a48) ~= "number" then
                        v129 = nil
                    else
                        v129 = a48
                    end
                    u47 = v129
                    if u55 then
                        paint()
                    end
                end
            elseif type(a48) == "number" and type(a49) == "number" then
                local ViewportSize_2 = Workspace_upv_1.CurrentCamera.ViewportSize
                local v130 = GuiService_upv_1:GetGuiInset()
                u80 = true
                u70 = true
                u68 = (ViewportSize_2.X / 2) + ((a48 * ViewportSize_2.X) * 0.4)
                u69 = (ViewportSize_2.Y * (0.5 - u84) - v130.Y) + ((a49 * ViewportSize_2.Y) * 0.4)
            else
                u80 = false
                u70 = false
            end
        elseif u55 and not (u56) then
            if u66 >= math.tau then
                u66 = u66 - math.tau
                u64 = u64 - math.tau
            end
            u66 = u66 + math.pi
            u65 = u65 + 1.5
            a1.Sounds.Play("Card_Flip")
        end
        if u55 then
            cardScreenRect()
        end
        local tbl_52 = {pitch = 0, stats = 0, canvas = 0, flip = 0, pointer = 0, chatHidden = 0, flipped = 0, rect = 0, front = 0, yaw = 0, hudHidden = 0, tier = 0}
        tbl_52.open = u55
        tbl_52.closing = u56
        tbl_52.bound = u57
        tbl_52.flipped = math.floor((u66 / math.pi) + 0.5) % 2 == 1
        tbl_52.front = u82
        tbl_52.yaw = math.floor(math.deg(u60) * 10) / 10
        tbl_52.pitch = math.floor(math.deg(u61) * 10) / 10
        tbl_52.flip = math.floor(math.deg(u64))
        tbl_52.tier = u48.name
        tbl_52.canvas = tostring(u8.CanvasSize)
        tbl_52.rect = string.format("%d,%d %d,%d", 0, 0, 0, 0)
        tbl_52.hudHidden = a1.HudHidden
        tbl_52.chatHidden = u3 ~= nil
        tbl_52.pointer = string.format("%s %s %d,%d moved %d", tostring(u70), tostring(u74), u68, u69, u73)
        tbl_52.stats = {wins = tbl_upv_22[1].value.Text, winRate = tbl_upv_22[2].value.Text, kd = tbl_upv_22[3].value.Text, items = tbl_upv_31.items.Text, drops = tbl_upv_31.drops.Text}
        return tbl_52
    end
end
return tbl_1