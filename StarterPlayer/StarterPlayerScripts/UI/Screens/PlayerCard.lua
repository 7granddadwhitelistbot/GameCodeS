local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local starterGui = game:GetService("StarterGui")
local textChatService = game:GetService("TextChatService")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local v8 = {}
local color3FromRGB = Color3.fromRGB
local v10 = {
    {min = 1, name = "ROOKIE", holo = 0.15, hi = color3FromRGB(178, 188, 206), lo = color3FromRGB(78, 86, 104), accent = color3FromRGB(168, 184, 210), deep = color3FromRGB(22, 26, 34)},
    {min = 5, name = "BRONZE", holo = 0.3, hi = color3FromRGB(238, 168, 108), lo = color3FromRGB(116, 62, 30), accent = color3FromRGB(240, 158, 92), deep = color3FromRGB(34, 22, 15)},
    {min = 10, name = "SILVER", holo = 0.45, hi = color3FromRGB(210, 220, 236), lo = color3FromRGB(98, 110, 134), accent = color3FromRGB(190, 206, 232), deep = color3FromRGB(22, 27, 38)},
    {min = 20, name = "GOLD", holo = 0.6, hi = color3FromRGB(255, 214, 98), lo = color3FromRGB(160, 98, 18), accent = color3FromRGB(255, 194, 60), deep = color3FromRGB(36, 27, 10)},
    {min = 35, name = "DIAMOND", holo = 0.8, hi = color3FromRGB(140, 234, 255), lo = color3FromRGB(26, 100, 192), accent = color3FromRGB(92, 206, 255), deep = color3FromRGB(10, 25, 44)},
    {min = 50, name = "MYTHIC", holo = 1, prism = true, hi = color3FromRGB(236, 146, 255), lo = color3FromRGB(66, 38, 156), accent = color3FromRGB(196, 132, 255), deep = color3FromRGB(25, 14, 44)}
}

local function tierFor(a12)
    --[[
      name: tierFor
      line: 68
      upvalues:
        v10 (copy, index: 1)
    ]]
    local v13 = v10[1]

    for _, v15 in v10 do
        if v15.min <= a12 then
            v13 = v15
        end
    end

    return v13
end

local colorSequence = ColorSequence.new({ColorSequenceKeypoint.new(0, color3FromRGB(255, 120, 190)), ColorSequenceKeypoint.new(0.2, color3FromRGB(190, 120, 255)), ColorSequenceKeypoint.new(0.4, color3FromRGB(100, 190, 255)), ColorSequenceKeypoint.new(0.6, color3FromRGB(110, 240, 190)), ColorSequenceKeypoint.new(0.8, color3FromRGB(255, 222, 110)), ColorSequenceKeypoint.new(1, color3FromRGB(255, 130, 170))})
local color = ColorSequence.new({ColorSequenceKeypoint.new(0, color3FromRGB(255, 90, 170)), ColorSequenceKeypoint.new(0.17, color3FromRGB(255, 200, 90)), ColorSequenceKeypoint.new(0.34, color3FromRGB(120, 255, 150)), ColorSequenceKeypoint.new(0.5, color3FromRGB(90, 220, 255)), ColorSequenceKeypoint.new(0.67, color3FromRGB(150, 120, 255)), ColorSequenceKeypoint.new(0.84, color3FromRGB(255, 110, 210)), ColorSequenceKeypoint.new(1, color3FromRGB(255, 200, 90))})

local function holoBands(holo)
    --[[
      name: holoBands
      line: 96
    ]]
    local v20 = 1 - math.clamp(holo, 0, 1) * 0.22
    local v21 = {}

    for index = 0, 6 do
        local newNumberSequenceKeypoint = NumberSequenceKeypoint.new
        local v24 = index / 6
        local v25 = index % 2 == 0 and 1 or v20
        table.insert(v21, newNumberSequenceKeypoint(v24, v25))
    end

    return NumberSequence.new(v21)
end

local v26 = nil

local function hideChat()
    --[[
      name: hideChat
      line: 108
      upvalues:
        v26 (ref,  index: 1)
        textChatService (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    if v26 then
        return
    end

    local v28 = {}

    pcall(
        function()
            --[[
              line: 113
              upvalues:
                textChatService (copy, index: 1)
                v28 (copy, index: 2)
                starterGui (copy, index: 3)
            ]]
            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatWindowConfiguration then
                v28.window = chatWindowConfiguration.Enabled
                chatWindowConfiguration.Enabled = false
            end

            if chatInputBarConfiguration then
                v28.bar = chatInputBarConfiguration.Enabled
                chatInputBarConfiguration.Enabled = false
            end

            v28.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
            starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        end
    )

    v26 = v28
end

local function restoreChat()
    --[[
      name: restoreChat
      line: 129
      upvalues:
        v26 (ref,  index: 1)
        textChatService (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    local v32 = v26
    if not v32 then
        return
    end

    v26 = nil

    pcall(
        function()
            --[[
              line: 135
              upvalues:
                textChatService (copy, index: 1)
                v32 (copy, index: 2)
                starterGui (copy, index: 3)
            ]]
            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatWindowConfiguration and v32.window ~= nil then
                chatWindowConfiguration.Enabled = v32.window
            end

            if chatInputBarConfiguration and v32.bar ~= nil then
                chatInputBarConfiguration.Enabled = v32.bar
            end

            if v32.core ~= nil then
                starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v32.core)
            end
        end
    )
end

local function easeOutBack(a36)
    --[[
      name: easeOutBack
      line: 150
    ]]
    return (((a36 - 1) ^ 3) * 2.4) + 1 + (((a36 - 1) ^ 2) * 1.4)
end

local function easeOutCubic(a38)
    --[[
      name: easeOutCubic
      line: 154
    ]]
    return 1 - ((1 - a38) ^ 3)
end

local function easeInCubic(a40)
    --[[
      name: easeInCubic
      line: 157
    ]]
    return (a40 * a40) * a40
end

function v8.Init(a41)
    --[[
      name: Init
      line: 161
      upvalues:
        players (copy, index: 1)
        color (copy, index: 2)
        v10 (copy, index: 3)
        colorSequence (copy, index: 4)
        holoBands (copy, index: 5)
        guiService (copy, index: 6)
        workspace (copy, index: 7)
        runService (copy, index: 8)
        userInputService (copy, index: 9)
        v26 (ref,  index: 10)
        textChatService (copy, index: 11)
        starterGui (copy, index: 12)
    ]]
    local ui = a41.UI
    local theme = a41.Theme
    local state = a41.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local economy = a41.Economy
    local weaponInfo = a41.WeaponInfo
    local weaponIcon = a41.WeaponIcon
    local localPlayer = players.LocalPlayer
    local assets = ui.Assets
    local trPlayerCard = Instance.new("Model")
    trPlayerCard.Name = "TR_PlayerCard"

    do
        local function plane(name: string)
            --[[
              name: plane
              line: 172
              upvalues:
                trPlayerCard (copy, index: 1)
            ]]
            local part = Instance.new("Part")
            part.Name = name
            part.Anchored = true
            part.CanCollide = false
            part.CanQuery = false
            part.CanTouch = false
            part.CastShadow = false
            part.Transparency = 1
            part.Size = Vector3.new(0.7142857313156128, 1, 0.004000000189989805)
            part.Parent = trPlayerCard
            return part
        end
    end

    local card = Instance.new("Part")
    card.Name = "Card"
    card.Anchored = true
    card.CanCollide = false
    card.CanQuery = false
    card.CanTouch = false
    card.CastShadow = false
    card.Transparency = 1
    card.Size = Vector3.new(0.7142857313156128, 1, 0.004000000189989805)
    card.Parent = trPlayerCard

    local shadow = Instance.new("Part")
    shadow.Name = "Shadow"
    shadow.Anchored = true
    shadow.CanCollide = false
    shadow.CanQuery = false
    shadow.CanTouch = false
    shadow.CastShadow = false
    shadow.Transparency = 1
    shadow.Size = Vector3.new(0.7142857313156128, 1, 0.004000000189989805)
    shadow.Parent = trPlayerCard

    local backdrop = Instance.new("Part")
    backdrop.Name = "Backdrop"
    backdrop.Anchored = true
    backdrop.CanCollide = false
    backdrop.CanQuery = false
    backdrop.CanTouch = false
    backdrop.CastShadow = false
    backdrop.Transparency = 1
    backdrop.Size = Vector3.new(0.7142857313156128, 1, 0.004000000189989805)
    backdrop.Parent = trPlayerCard

    local function surface(name: string, adornee: Part, face: Enum.NormalId, canvasSize: Vector2)
        --[[
          name: surface
          line: 189
          upvalues:
            ui (copy, index: 1)
            a41 (copy, index: 2)
        ]]
        return ui.new("SurfaceGui", {AlwaysOnTop = false, LightInfluence = 0, Brightness = 1, ClipsDescendants = true, ResetOnSpawn = false, Enabled = false, Name = name, Adornee = adornee, Face = face, SizingMode = Enum.SurfaceGuiSizingMode.FixedSize, CanvasSize = canvasSize, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = a41.PlayerGui})
    end

    local v64 = surface("TR_CardFront", card, Enum.NormalId.Back, Vector2.new(500, 700))
    local v65 = surface("TR_CardBack", card, Enum.NormalId.Front, Vector2.new(500, 700))
    local parent = surface("TR_CardShadow", shadow, Enum.NormalId.Back, Vector2.new(200, 200))
    local parent2 = surface("TR_CardBackdrop", backdrop, Enum.NormalId.Back, Vector2.new(640, 360))
    local ui2 = ui.new("ImageLabel", {Name = "Shadow", ImageTransparency = 0.25, Size = UDim2.fromScale(1, 1), Image = assets.Icons.Glow, ImageColor3 = colors.Void, Parent = parent})
    local ui3 = ui.new("Frame", {Name = "Dim", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = parent2})
    local ui4 = ui.new("ImageLabel", {Name = "Vignette", ImageTransparency = 1, ZIndex = 2, Size = UDim2.fromScale(1, 1), Image = assets.Fx.Vignette, ImageColor3 = colors.Void, Parent = parent2})
    local ui5 = ui.new("ImageLabel", {Name = "Spot", ImageTransparency = 1, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(420, 420), Image = assets.Icons.Glow, Parent = parent2})
    local ui6 = ui.new("ImageLabel", {Name = "Rays", ImageTransparency = 1, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(620, 620), Image = assets.Fx.Rays, Parent = parent2})

    do
        local function text(a74)
            --[[
              name: text
              line: 271
              upvalues:
                colors (copy, index: 1)
                ui (copy, index: 2)
            ]]
            a74.BackgroundTransparency = 1
            a74.TextXAlignment = a74.TextXAlignment or Enum.TextXAlignment.Left
            a74.TextColor3 = a74.TextColor3 or colors.Text

            return ui.new("TextLabel", a74)
        end
    end

    local function buildFace(a76)
        --[[
          name: buildFace
          line: 278
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            assets (copy, index: 3)
        ]]
        local parent = ui.new("Frame", {Name = "Card", Size = UDim2.fromOffset(500, 700), Parent = a76})
        local scale = ui.new("UIScale", {Parent = parent})
        local parent2 = ui.new("Frame", {Name = "Rim", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), (ui.Corner(30)), Parent = parent})
        local rimGrad = ui.new("UIGradient", {Rotation = 62, Parent = parent2})
        ui.new("UIStroke", {Thickness = 2, Transparency = 0.3, Color = colors.Void, Parent = parent2})
        local ui2 = ui.new("Frame", {Name = "Body", Position = UDim2.fromOffset(12, 12), Size = UDim2.new(1, -24, 1, -24), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, (ui.Corner(21)), Parent = parent})
        local bodyGrad = ui.new("UIGradient", {Rotation = 90, Parent = ui2})
        local bodyStroke = ui.new("UIStroke", {Thickness = 1.5, Transparency = 0.5, Parent = ui2})
        local glare = ui.new("ImageLabel", {Name = "Glare", ImageTransparency = 0.8, ZIndex = 20, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(900, 900), Image = assets.Icons.Glow, ImageColor3 = Color3.new(1, 1, 1), Parent = ui2})
        local newUi = ui.new
        local newUi2 = ui.new
        local v87 = {Rotation = 90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.86), NumberSequenceKeypoint.new(1, 1)})}
        local band = newUi("Frame", {Name = "Band", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1100, 150), Rotation = -28, BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 20, (newUi2("UIGradient", v87)), Parent = ui2})

        return {gui = a76, scale = scale, rimGrad = rimGrad, body = ui2, bodyGrad = bodyGrad, bodyStroke = bodyStroke, glare = glare, band = band}
    end

    local v89 = buildFace(v64)
    local v90 = buildFace(v65)

    local function emblem(parent, a93: number, position: UDim2, vector2: Vector2?)
        --[[
          name: emblem
          line: 341
          upvalues:
            ui (copy, index: 1)
            theme (copy, index: 2)
            colors (copy, index: 3)
            fonts (copy, index: 4)
        ]]
        local newUi = ui.new
        local v97 = {Name = "Level", AnchorPoint = vector2 or Vector2.zero, Position = position, Size = UDim2.fromOffset(a93, a93), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 4, [1] = (ui.Corner(theme.Radius.Pill)), Parent = parent}
        local ui2 = newUi("Frame", v97)
        local grad = ui.new("UIGradient", {Rotation = 90, Parent = ui2})
        local ring = ui.new("UIStroke", {Thickness = 2, Transparency = 0.25, Color = colors.Void, Parent = ui2})
        local v101 = {Name = "LV", Text = "LV", ZIndex = 5, Position = UDim2.new(0, 0, 0, (math.floor(a93 * 0.12))), Size = UDim2.new(1, 0, 0, (math.floor(a93 * 0.2))), FontFace = fonts.Heavy, TextSize = math.floor(a93 * 0.19), TextXAlignment = Enum.TextXAlignment.Center, Parent = ui2, BackgroundTransparency = 1}
        v101.TextXAlignment = v101.TextXAlignment or Enum.TextXAlignment.Left
        v101.TextColor3 = v101.TextColor3 or colors.Text
        local parent2 = ui.new("TextLabel", v101)
        ui.TextStroke(colors.Void, 1.5, 0.35).Parent = parent2
        local v103 = {Name = "Num", Text = "1", ZIndex = 5, Position = UDim2.new(0, 0, 0, (math.floor(a93 * 0.26))), Size = UDim2.new(1, 0, 0, (math.floor(a93 * 0.62))), FontFace = fonts.Display, TextSize = math.floor(a93 * 0.5), TextXAlignment = Enum.TextXAlignment.Center, Parent = ui2, BackgroundTransparency = 1}
        v103.TextXAlignment = v103.TextXAlignment or Enum.TextXAlignment.Left
        v103.TextColor3 = v103.TextColor3 or colors.Text
        local ui3 = ui.new("TextLabel", v103)
        ui.TextStroke(colors.Void, 2, 0.2).Parent = ui3

        return {frame = ui2, grad = grad, ring = ring, num = ui3}
    end

    local function xpBar(parent, position: UDim2, a108: number, a109: number)
        --[[
          name: xpBar
          line: 383
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            theme (copy, index: 3)
        ]]
        local ui2 = ui.new("Frame", {Name = "XpBar", Position = position, Size = UDim2.fromOffset(a108, a109), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.35, ClipsDescendants = true, ZIndex = 4, ui.Corner(theme.Radius.Pill), (ui.Stroke(colors.Stroke, 1, 0.85)), Parent = parent})
        local ui3 = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 5, (ui.Corner(theme.Radius.Pill)), Parent = ui2})
        local fillGrad = ui.new("UIGradient", {Parent = ui3})

        return {track = ui2, fill = ui3, fillGrad = fillGrad}
    end

    local v113 = emblem(v89.body, 76, UDim2.fromOffset(14, 14))
    local v114 = {Name = "DisplayName", AutoLocalize = false, Text = "", TextSize = 38, ZIndex = 4, Position = UDim2.fromOffset(102, 16), Size = UDim2.fromOffset(250, 42), FontFace = fonts.Display, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v89.body, BackgroundTransparency = 1}
    v114.TextXAlignment = v114.TextXAlignment or Enum.TextXAlignment.Left
    v114.TextColor3 = v114.TextColor3 or colors.Text
    local parent3 = ui.new("TextLabel", v114)
    ui.TextStroke(colors.Void, 1.5, 0.4).Parent = parent3
    local v116 = {Name = "Username", Text = "", TextSize = 22, ZIndex = 4, Position = UDim2.fromOffset(103, 58), Size = UDim2.fromOffset(353, 26), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v89.body, BackgroundTransparency = 1}
    v116.TextXAlignment = v116.TextXAlignment or Enum.TextXAlignment.Left
    v116.TextColor3 = v116.TextColor3 or colors.Text
    local ui7 = ui.new("TextLabel", v116)
    local parent4 = ui.new("Frame", {Name = "Tier", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 20), Size = UDim2.fromOffset(0, 30), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 4, ui.Corner(theme.Radius.Pill), (ui.Padding(0, 13, 0, 13)), Parent = v89.body})
    local ui8 = ui.new("UIGradient", {Rotation = 90, Parent = parent4})
    local v120 = {Name = "Label", Text = "ROOKIE", TextSize = 16, ZIndex = 5, Size = UDim2.fromOffset(0, 30), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Center, Parent = parent4, BackgroundTransparency = 1}
    v120.TextXAlignment = v120.TextXAlignment or Enum.TextXAlignment.Left
    v120.TextColor3 = v120.TextColor3 or colors.Text
    local ui9 = ui.new("TextLabel", v120)
    local parent5 = ui.new("Frame", {Name = "Art", Position = UDim2.fromOffset(14, 100), Size = UDim2.fromOffset(448, 290), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, ZIndex = 2, (ui.Corner(16)), Parent = v89.body})
    local ui10 = ui.new("UIGradient", {Rotation = 90, Parent = parent5})
    local ui11 = ui.new("UIStroke", {Thickness = 1.5, Transparency = 0.45, Parent = parent5})
    local ui12 = ui.new("ImageLabel", {Name = "Rays", ImageTransparency = 0.85, ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.42), Size = UDim2.fromOffset(640, 640), Image = assets.Fx.Rays, Parent = parent5})
    local ui13 = ui.new("ImageLabel", {Name = "Glow", ImageTransparency = 0.5, ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromOffset(480, 480), Image = assets.Icons.Glow, Parent = parent5})
    ui.new("ImageLabel", {Name = "FloorShadow", ImageTransparency = 0.4, ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 1, -16), Size = UDim2.fromOffset(300, 70), Image = assets.Icons.Glow, ImageColor3 = colors.Void, Parent = parent5})
    local ui14 = ui.new("ImageLabel", {Name = "Avatar", Image = "", ZIndex = 4, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 24), Size = UDim2.fromOffset(330, 330), Parent = parent5})
    local parent6 = ui.new("Frame", {Name = "Fade", ZIndex = 5, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 70), BackgroundColor3 = Color3.new(1, 1, 1), Parent = parent5})
    ui.new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new(1, 0.2), Parent = parent6})
    local parent7 = ui.new("Frame", {Name = "Holo", ZIndex = 3, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), Parent = parent5})
    local ui15 = ui.new("UIGradient", {Rotation = 58, Color = color, Parent = parent7})
    local v131 = {}
    local v132 = {}
    local v133 = 0

    do
        local random = Random.new(7)

        for index = 1, 14 do
            do
                local v136 = random:NextInteger(14, 26)
                v131[index] = ui.new("ImageLabel", {ImageTransparency = 1, Visible = false, ZIndex = 7, Name = "Sparkle" .. index, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(random:NextNumber(0.06, 0.94), random:NextNumber(0.06, 0.8)), Size = UDim2.fromOffset(v136, v136), Rotation = random:NextInteger(0, 44), Image = assets.Fx.Sparkle, Parent = parent5})
            end

            v132[index] = random:NextNumber(0, 2)
        end
    end

    local v137 = {Name = "LevelLine", Text = "LEVEL 1", TextSize = 24, ZIndex = 4, Position = UDim2.fromOffset(16, 400), Size = UDim2.fromOffset(200, 28), FontFace = fonts.Display, Parent = v89.body, BackgroundTransparency = 1}

    do
        local v138 = v137.TextXAlignment or Enum.TextXAlignment.Left
        v137.TextXAlignment = v138
    end

    v137.TextColor3 = v137.TextColor3 or colors.Text
    local ui16 = ui.new("TextLabel", v137)
    local v140 = {Name = "Xp", Text = "", TextSize = 20, ZIndex = 4, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 402), Size = UDim2.fromOffset(260, 26), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = v89.body, BackgroundTransparency = 1}
    v140.TextXAlignment = v140.TextXAlignment or Enum.TextXAlignment.Left
    v140.TextColor3 = v140.TextColor3 or colors.Text
    local ui17 = ui.new("TextLabel", v140)
    local v142 = xpBar(v89.body, UDim2.fromOffset(16, 432), 444, 11)
    local v143 = {}

    for index = 1, 6 do
        local v145 = (index - 1) % 3
        local v146 = (index - 1) // 3
        local newUi = ui.new
        local v148 = {Name = "Stat" .. index, Position = UDim2.fromOffset((v145 * 152) + 14, (v146 * 88) + 456), Size = UDim2.fromOffset(144, 80), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.94, ZIndex = 3}
        v148[1], v148[2] = ui.Corner(12), (ui.Stroke(colors.Stroke, 1, 0.9))
        v148.Parent = v89.body
        local parent8 = newUi("Frame", v148)
        local v150 = {Name = "Value", Text = "0", TextSize = 40, ZIndex = 4, Position = UDim2.fromOffset(0, 6), Size = UDim2.new(1, 0, 0, 44), FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Center, Parent = parent8, BackgroundTransparency = 1}
        v150.TextXAlignment = v150.TextXAlignment or Enum.TextXAlignment.Left
        v150.TextColor3 = v150.TextColor3 or colors.Text

        do
            local ui18 = ui.new("TextLabel", v150)
            local v152 = {Name = "Label", Text = "", TextSize = 19, ZIndex = 4, Position = UDim2.fromOffset(0, 50), Size = UDim2.new(1, 0, 0, 24), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Center, Parent = parent8, BackgroundTransparency = 1}
            v152.TextXAlignment = v152.TextXAlignment or Enum.TextXAlignment.Left
            v152.TextColor3 = v152.TextColor3 or colors.Text
            v143[index] = {value = ui18, label = ui.new("TextLabel", v152)}
        end
    end

    local v153 = {Name = "Brand", Text = "TRIBES", TextSize = 19, ZIndex = 4, Position = UDim2.fromOffset(18, 640), Size = UDim2.fromOffset(200, 22), FontFace = fonts.Display, Parent = v89.body, BackgroundTransparency = 1}

    do
        local v154 = v153.TextXAlignment or Enum.TextXAlignment.Left
        v153.TextXAlignment = v154
    end

    v153.TextColor3 = v153.TextColor3 or colors.Text
    local ui19 = ui.new("TextLabel", v153)

    do
        local v156 = {Name = "Kind", Text = "PLAYER CARD", TextSize = 15, ZIndex = 4, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -18, 0, 642), Size = UDim2.fromOffset(220, 20), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Right, Parent = v89.body, BackgroundTransparency = 1}
        v156.TextXAlignment = v156.TextXAlignment or Enum.TextXAlignment.Left
        v156.TextColor3 = v156.TextColor3 or colors.Text
        ui.new("TextLabel", v156)
    end

    local parent9 = ui.new("ImageLabel", {Name = "Headshot", Position = UDim2.fromOffset(14, 14), Size = UDim2.fromOffset(64, 64), BackgroundColor3 = colors.PanelHi, Image = "", ZIndex = 4, (ui.Corner(theme.Radius.Pill)), Parent = v90.body})
    local ui20 = ui.new("UIStroke", {Thickness = 2.5, Transparency = 0.1, Parent = parent9})
    local v159 = {Name = "DisplayName", AutoLocalize = false, Text = "", TextSize = 32, ZIndex = 4, Position = UDim2.fromOffset(90, 14), Size = UDim2.fromOffset(300, 38), FontFace = fonts.Display, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v90.body, BackgroundTransparency = 1}
    v159.TextXAlignment = v159.TextXAlignment or Enum.TextXAlignment.Left
    v159.TextColor3 = v159.TextColor3 or colors.Text
    local parent10 = ui.new("TextLabel", v159)
    ui.TextStroke(colors.Void, 1.5, 0.4).Parent = parent10
    local v161 = {Name = "Username", Text = "", TextSize = 20, ZIndex = 4, Position = UDim2.fromOffset(91, 50), Size = UDim2.fromOffset(299, 24), FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v90.body, BackgroundTransparency = 1}
    v161.TextXAlignment = v161.TextXAlignment or Enum.TextXAlignment.Left
    v161.TextColor3 = v161.TextColor3 or colors.Text
    local ui21 = ui.new("TextLabel", v161)
    local v163 = emblem(v90.body, 64, UDim2.new(1, -14, 0, 14), Vector2.new(1, 0))
    local ui22 = ui.new("Frame", {Name = "Divider", BackgroundTransparency = 0.6, ZIndex = 4, Position = UDim2.fromOffset(14, 90), Size = UDim2.new(1, -28, 0, 2), BackgroundColor3 = Color3.new(1, 1, 1), Parent = v90.body})
    local v165 = {}
    local v166 = {}

    local function section(a168: number, a169: number, text: string, a171)
        --[[
          name: section
          line: 710
          upvalues:
            fonts (copy, index: 1)
            v90 (copy, index: 2)
            colors (copy, index: 3)
            ui (copy, index: 4)
            v165 (copy, index: 5)
            v166 (copy, index: 6)
        ]]
        local v172 = {TextSize = 19, ZIndex = 4, Name = "Section_" .. text, Position = UDim2.fromOffset(a168, a169), Size = UDim2.fromOffset(214, 24), Text = text, FontFace = fonts.Display, Parent = v90.body, BackgroundTransparency = 1}
        v172.TextXAlignment = v172.TextXAlignment or Enum.TextXAlignment.Left
        v172.TextColor3 = v172.TextColor3 or colors.Text
        table.insert(v165, (ui.new("TextLabel", v172)))
        a169 += 28

        for _, v174 in a171 do
            local v175 = v174[1]
            local text2 = v174[2]
            local parent = ui.new("Frame", {ZIndex = 4, Name = "Row_" .. v175, Position = UDim2.fromOffset(a168, a169), Size = UDim2.fromOffset(214, 35), Parent = v90.body})
            local v178 = {Name = "Label", TextSize = 20, ZIndex = 4, Size = UDim2.new(0.62, 0, 1, 0), Text = text2, FontFace = fonts.SemiBold, TextColor3 = colors.TextDim, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent, BackgroundTransparency = 1}
            v178.TextXAlignment = v178.TextXAlignment or Enum.TextXAlignment.Left
            v178.TextColor3 = v178.TextColor3 or colors.Text
            local _ = ui.new("TextLabel", v178)
            local v180 = {Name = "Value", Text = "0", TextSize = 24, ZIndex = 4, AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0.5, 0, 1, 0), FontFace = fonts.Display, TextXAlignment = Enum.TextXAlignment.Right, Parent = parent, BackgroundTransparency = 1}
            v180.TextXAlignment = v180.TextXAlignment or Enum.TextXAlignment.Left
            v180.TextColor3 = v180.TextColor3 or colors.Text
            v166[v175] = ui.new("TextLabel", v180)
            ui.new("Frame", {Name = "Line", BackgroundTransparency = 0.92, ZIndex = 4, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Color3.new(1, 1, 1), Parent = parent})
            a169 += 35
        end

        return a169
    end

    do
        local v181 = {"matches", "Played"}
        local v182 = {"wins", "Wins"}
        local v183 = {"losses", "Losses"}
        local v184 = {"winRate", "Win rate"}
        local v185 = {"streak", "Current"}
        section(14, section(14, 104, "MATCHES", {v181, v182, v183, v184, {"roundsWon", "Rounds won"}}) + 14, "STREAKS", {v185, {"bestStreak", "Best"}})
    end

    local v186 = {"kills", "Kills"}
    local v187 = {"deaths", "Deaths"}
    local v188 = {"assists", "Assists"}
    local v189 = {"kd", "K/D"}
    local v190 = {"items", "Items"}
    local v191 = {"maxed", "Maxed"}
    local v192 = section(248, section(248, 104, "COMBAT", {v186, v187, v188, v189, {"kpm", "Kills / match"}}) + 14, "COLLECTION", {v190, v191, {"drops", "Drops opened"}}) + 14
    local v193 = {Name = "KitTitle", Text = "ACTIVE LOADOUT", RichText = true, TextSize = 19, ZIndex = 4, Position = UDim2.fromOffset(14, v192), Size = UDim2.fromOffset(448, 24), FontFace = fonts.Display, TextTruncate = Enum.TextTruncate.AtEnd, Parent = v90.body, BackgroundTransparency = 1}
    v193.TextXAlignment = v193.TextXAlignment or Enum.TextXAlignment.Left
    v193.TextColor3 = v193.TextColor3 or colors.Text
    local ui23 = ui.new("TextLabel", v193)
    local parent11 = ui.new("Frame", {Name = "Kit", Position = UDim2.fromOffset(14, v192 + 30), Size = UDim2.fromOffset(448, 57), ZIndex = 4, (ui.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = v90.body})
    local v196 = {}

    for layoutOrder = 1, 7 do
        v196[layoutOrder] = ui.new("Frame", {Name = "Item" .. layoutOrder, Size = UDim2.fromOffset(57, 57), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.93, LayoutOrder = layoutOrder, ZIndex = 4, ui.Corner(10), (ui.Stroke(colors.Stroke, 1, 0.9)), Parent = parent11})
    end

    local v198 = {Name = "LevelLine", Text = "LEVEL 1", TextSize = 22, ZIndex = 4, Position = UDim2.fromOffset(16, 576), Size = UDim2.fromOffset(200, 26), FontFace = fonts.Display, Parent = v90.body, BackgroundTransparency = 1}

    do
        local v199 = v198.TextXAlignment or Enum.TextXAlignment.Left
        v198.TextXAlignment = v199
    end

    v198.TextColor3 = v198.TextColor3 or colors.Text
    local ui24 = ui.new("TextLabel", v198)
    local v201 = {Name = "Xp", Text = "", TextSize = 19, ZIndex = 4, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 578), Size = UDim2.fromOffset(280, 24), FontFace = fonts.Bold, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Right, Parent = v90.body, BackgroundTransparency = 1}
    v201.TextXAlignment = v201.TextXAlignment or Enum.TextXAlignment.Left
    v201.TextColor3 = v201.TextColor3 or colors.Text
    local ui25 = ui.new("TextLabel", v201)
    local v203 = xpBar(v90.body, UDim2.fromOffset(16, 608), 444, 10)
    local v204 = {Name = "Brand", Text = "TRIBES", TextSize = 19, ZIndex = 4, Position = UDim2.fromOffset(18, 640), Size = UDim2.fromOffset(200, 22), FontFace = fonts.Display, Parent = v90.body, BackgroundTransparency = 1}
    v204.TextXAlignment = v204.TextXAlignment or Enum.TextXAlignment.Left
    v204.TextColor3 = v204.TextColor3 or colors.Text
    local ui26 = ui.new("TextLabel", v204)
    local v206 = {Name = "Kind", Text = "CAREER STATS", TextSize = 15, ZIndex = 4, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -18, 0, 642), Size = UDim2.fromOffset(220, 20), FontFace = fonts.Heavy, TextColor3 = colors.TextMuted, TextXAlignment = Enum.TextXAlignment.Right, Parent = v90.body, BackgroundTransparency = 1}
    v206.TextXAlignment = v206.TextXAlignment or Enum.TextXAlignment.Left
    v206.TextColor3 = v206.TextColor3 or colors.Text
    ui.new("TextLabel", v206)

    do
        local v207 = nil
        local v208 = v10[1]

        local function hex(accent)
            --[[
              name: hex
              line: 884
            ]]
            return string.format("#%02X%02X%02X", math.floor((accent.R * 255) + 0.5), math.floor((accent.G * 255) + 0.5), (math.floor((accent.B * 255) + 0.5)))
        end

        do
            local function num(a212)
                --[[
                  name: num
                  line: 887
                ]]
                if type(a212) == "number" and a212 == a212 then
                    return a212
                end

                return 0
            end
        end

        do
            local function ratio(a214, a215, formatString: string)
                --[[
                  name: ratio
                  line: 890
                ]]
                if 0 < a215 then
                    return string.format(formatString, a214 / a215)
                end
                if 0 < a214 then
                    return (string.format(formatString, a214))
                end

                return "—"
            end
        end

        local function paintTier(a218)
            --[[
              name: paintTier
              line: 897
              upvalues:
                v208 (ref,  index: 1)
                colorSequence (copy, index: 2)
                theme (copy, index: 3)
            ]]
            a218.rimGrad.Color = if v208.prism then colorSequence else ColorSequence.new({ColorSequenceKeypoint.new(0, v208.hi), ColorSequenceKeypoint.new(0.45, v208.lo), ColorSequenceKeypoint.new(0.62, theme.Lighten(v208.lo, 0.12)), ColorSequenceKeypoint.new(1, v208.hi)})
            a218.bodyGrad.Color = ColorSequence.new(theme.Lighten(v208.deep, 0.05), theme.Darken(v208.deep, 0.45))
            a218.bodyStroke.Color = v208.hi
        end

        local function paintEmblem(a220, a221)
            --[[
              name: paintEmblem
              line: 907
              upvalues:
                v208 (ref, index: 1)
            ]]
            local textSize
            a220.grad.Color = ColorSequence.new(v208.hi, v208.lo)
            a220.num.Text = tostring(a221)
            local num = a220.num

            if not (100 <= a221) then
                textSize = math.floor(a220.frame.Size.X.Offset * 0.5)
            else
                textSize = math.floor(a220.frame.Size.X.Offset * 0.4)
            end

            num.TextSize = textSize
        end

        do
            local function paintBar(a225, a226: number)
                --[[
                  name: paintBar
                  line: 912
                  upvalues:
                    theme (copy, index: 1)
                    v208 (ref,  index: 2)
                ]]
                a225.fill.Size = UDim2.fromScale(math.clamp(a226, 0, 1), 1)
                a225.fillGrad.Color = ColorSequence.new(theme.Lighten(v208.accent, 0.25), v208.accent)
            end
        end

        local function paint()
            --[[
              name: paint
              line: 917
              upvalues:
                state (copy, index: 1)
                v207 (ref,  index: 2)
                v208 (ref,  index: 3)
                v10 (copy, index: 4)
                ui (copy, index: 5)
                paintTier (copy, index: 6)
                v89 (copy, index: 7)
                v90 (copy, index: 8)
                paintEmblem (copy, index: 9)
                v113 (copy, index: 10)
                parent3 (copy, index: 11)
                localPlayer (copy, index: 12)
                ui7 (copy, index: 13)
                ui8 (copy, index: 14)
                colorSequence (copy, index: 15)
                ui9 (copy, index: 16)
                colors (copy, index: 17)
                ui10 (copy, index: 18)
                theme (copy, index: 19)
                ui11 (copy, index: 20)
                ui12 (copy, index: 21)
                ui13 (copy, index: 22)
                parent6 (copy, index: 23)
                ui15 (copy, index: 24)
                holoBands (copy, index: 25)
                v133 (ref,  index: 26)
                v131 (copy, index: 27)
                ui19 (copy, index: 28)
                ui26 (copy, index: 29)
                ui16 (copy, index: 30)
                ui17 (copy, index: 31)
                v142 (copy, index: 32)
                v143 (copy, index: 33)
                parent10 (copy, index: 34)
                ui21 (copy, index: 35)
                ui20 (copy, index: 36)
                v163 (copy, index: 37)
                ui22 (copy, index: 38)
                v165 (copy, index: 39)
                weaponInfo (copy, index: 40)
                economy (copy, index: 41)
                v166 (copy, index: 42)
                ui23 (copy, index: 43)
                hex (copy, index: 44)
                v196 (copy, index: 45)
                weaponIcon (copy, index: 46)
                ui24 (copy, index: 47)
                ui25 (copy, index: 48)
                v203 (copy, index: 49)
                ui5 (copy, index: 50)
                ui6 (copy, index: 51)
            ]]
            local v228
            local matches
            local wins
            local losses
            local kills
            local deaths
            local assists
            local v235
            local bestStreak
            local winRate
            local kd
            local total
            local total2
            local roundsWon
            local kpm
            local profile = state.Profile

            if type(profile.stats) ~= "table" then
                v228 = {}
            else
                v228 = profile.stats
            end

            local v244 = v207 or state.Level()
            local v245 = v10[1]

            for _, v247 in v10 do
                if v247.min <= v244 then
                    v245 = v247
                end
            end

            v208 = v245
            local v248 = state.Xp()
            local xpToNext = state.XpToNext
            local v250 = if v207 then v244 else nil
            local v251 = xpToNext(v250)
            local v252 = 200 <= v244
            local text = v252 and "MAX LEVEL"
                or string.format("%s / %s XP", ui.FormatNumber(v248), ui.FormatNumber(v251))
            local v254 = v252 and 1 or not (0 < v251) and 0 or v248 / v251
            paintTier(v89)
            paintTier(v90)
            paintEmblem(v113, v244)
            parent3.Text = localPlayer.DisplayName
            local v255 = utf8.len(localPlayer.DisplayName) or #localPlayer.DisplayName
            parent3.TextSize = v255 <= 12 and 38 or v255 <= 15 and 32 or 27
            ui7.Text = "@" .. localPlayer.Name
            ui8.Color = if v208.prism then colorSequence else ColorSequence.new(v208.hi, v208.lo)
            ui9.Text = v208.name
            ui9.TextColor3 = colors.TextDark
            ui10.Color = ColorSequence.new(theme.Darken(v208.lo, 0.2), theme.Darken(v208.deep, 0.2))
            ui11.Color = v208.hi
            ui12.ImageColor3 = v208.hi
            ui13.ImageColor3 = v208.accent
            parent6.BackgroundColor3 = theme.Darken(v208.deep, 0.15)
            ui15.Transparency = holoBands(v208.holo)
            v133 = not (0.45 <= v208.holo) and 0 or math.floor(v208.holo * 14)

            for v256, v257 in v131 do
                local visible = v256 <= v133
                v257.Visible = visible
                v257.ImageColor3 = theme.Lighten(v208.accent, 0.45)
            end

            ui19.TextColor3 = v208.accent
            ui26.TextColor3 = v208.accent
            ui16.Text = "LEVEL " .. v244
            ui17.Text = text
            v142.fill.Size = UDim2.fromScale(math.clamp(v254, 0, 1), 1)
            v142.fillGrad.Color = ColorSequence.new(theme.Lighten(v208.accent, 0.25), v208.accent)
            local matches2 = v228.matches

            if type(matches2) ~= "number" or matches2 ~= matches2 then
                matches = 0
            else
                matches = matches2
            end

            local wins2 = v228.wins

            if type(wins2) ~= "number" or wins2 ~= wins2 then
                wins = 0
            else
                wins = wins2
            end

            local losses2 = v228.losses

            if type(losses2) ~= "number" or losses2 ~= losses2 then
                losses = 0
            else
                losses = losses2
            end

            local kills2 = v228.kills

            if type(kills2) ~= "number" or kills2 ~= kills2 then
                kills = 0
            else
                kills = kills2
            end

            local deaths2 = v228.deaths

            if type(deaths2) ~= "number" or deaths2 ~= deaths2 then
                deaths = 0
            else
                deaths = deaths2
            end

            local assists2 = v228.assists

            if type(assists2) ~= "number" or assists2 ~= assists2 then
                assists = 0
            else
                assists = assists2
            end

            local v265 = state.Get("Streak")

            if type(v265) ~= "number" then
                local streak = v228.streak

                if type(streak) ~= "number" or streak ~= streak then
                    v235 = 0
                else
                    v235 = streak
                end
            else
                v235 = v265
            end

            local bestStreak2 = v228.bestStreak

            if type(bestStreak2) ~= "number" or bestStreak2 ~= bestStreak2 then
                bestStreak = 0
            else
                bestStreak = bestStreak2
            end

            local v268 = math.max(bestStreak, v235)

            if not (0 < matches) then
                winRate = "—"
            else
                winRate = string.format("%d%%", (math.floor(((wins / matches) * 100) + 0.5)))
            end

            if not (0 < deaths) then
                kd = not (0 < kills) and "—" or string.format("%.2f", kills)
            else
                kd = string.format("%.2f", kills / deaths)
            end

            local v269 = {{ui.FormatNumber(wins), "WINS"}, {winRate, "WIN RATE"}, {kd, "K/D"}, {ui.FormatNumber(kills), "KILLS"}, {ui.FormatNumber(matches), "MATCHES"}, {ui.FormatNumber(v268), "BEST STREAK"}}

            for v270, v271 in v269 do
                v143[v270].value.Text = v271[1]
                v143[v270].label.Text = v271[2]
            end

            parent10.Text = localPlayer.DisplayName
            parent10.TextSize = v255 <= 12 and 32 or not (v255 <= 15) and 24 or 28
            ui21.Text = "@" .. localPlayer.Name
            ui20.Color = v208.hi
            paintEmblem(v163, v244)
            ui22.BackgroundColor3 = v208.hi

            for _, v273 in v165 do
                v273.TextColor3 = v208.accent
            end

            local count = 0
            local count2 = 0
            local count3 = 0

            for _, v278 in weaponInfo.AllItems() do
                count += 1

                if economy and economy.Owns(v278.id) then
                    count2 += 1

                    if 1 < economy.MaxLevel(v278.id) then
                        local v279 = economy.Level(v278.id)

                        if economy.MaxLevel(v278.id) <= v279 then
                            count3 += 1
                        end
                    end
                end
            end

            local dropStats = profile.dropStats

            if type(dropStats) ~= "table" then
                total2 = 0
            else
                total = dropStats.total

                if type(total) ~= "number" or total ~= total then
                    total2 = 0
                else
                    total2 = total
                end
            end

            local v281 = {matches = ui.FormatNumber(matches), wins = ui.FormatNumber(wins), losses = ui.FormatNumber(losses), winRate = winRate}
            local formatNumber = ui.FormatNumber
            local roundsWon2 = v228.roundsWon

            if type(roundsWon2) ~= "number" or roundsWon2 ~= roundsWon2 then
                roundsWon = 0
            else
                roundsWon = roundsWon2
            end

            v281.roundsWon = formatNumber(roundsWon)
            v281.streak = if 2 <= v235 then "🔥 " .. v235 else tostring(v235)
            v281.bestStreak = ui.FormatNumber(v268)
            v281.kills = ui.FormatNumber(kills)
            v281.deaths = ui.FormatNumber(deaths)
            v281.assists = ui.FormatNumber(assists)
            v281.kd = kd

            if not (0 < matches) then
                kpm = not (0 < kills) and "—" or string.format("%.1f", kills)
            else
                kpm = string.format("%.1f", kills / matches)
            end

            v281.kpm = kpm
            v281.items = if economy and economy.HasData() then string.format("%d / %d", count2, count) else "—"
            v281.maxed = if economy and economy.HasData() then tostring(count3) else "—"
            v281.drops = ui.FormatNumber(total2)

            for v284, v285 in v166 do
                v285.Text = v281[v284] or "—"
            end

            local v286 = state.Loadout()
            ui23.Text = string.format("<font color=\"%s\">ACTIVE LOADOUT</font>", hex(v208.accent))
            local v287 = {}

            for _, item in v286.items do
                if #v287 < 6 then
                    table.insert(v287, item)
                end
            end

            if type(v286.armor) == "string" then
                table.insert(v287, v286.armor)
            end

            for v290, v291 in v196 do
                local v292 = v287[v290]
                v291.Visible = v292 ~= nil
                weaponIcon.Set(v291, v292, {})
            end

            ui24.Text = "LEVEL " .. v244
            ui25.Text = text
            v203.fill.Size = UDim2.fromScale(math.clamp(v254, 0, 1), 1)
            v203.fillGrad.Color = ColorSequence.new(theme.Lighten(v208.accent, 0.25), v208.accent)
            ui5.ImageColor3 = v208.accent
            ui6.ImageColor3 = v208.hi
        end

        do
            local function setImages()
                --[[
                  name: setImages
                  line: 1045
                  upvalues:
                    ui14 (copy, index: 1)
                    localPlayer (copy, index: 2)
                    parent9 (copy, index: 3)
                ]]
                ui14.Image = string.format("rbxthumb://type=Avatar&id=%d&w=720&h=720", localPlayer.UserId)
                parent9.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", localPlayer.UserId)
            end
        end

        local parent12 = ui.new("Frame", {Name = "PlayerCard", Visible = false, Size = UDim2.fromScale(1, 1), Parent = a41.Canvas.Menus})
        local ui27 = ui.new("TextButton", {Name = "PlayerCardCatcher", BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Selectable = false, Active = true, Visible = false, Size = UDim2.fromScale(1, 1), Parent = ui.BackdropCanvas
            or parent12})
        local v296 = ui.IconButton({Name = "Close", IconName = "cross", IconScale = 0.42, Transparency = 0.2, Sound = "Close", AnchorPoint = Vector2.new(1, 0), Size = UDim2.fromOffset(56, 56), Color = colors.Panel, Parent = parent12})
        local v297 = ui.Button({Name = "Flip", Text = "FLIP", TextSize = 22, Style = "Dark", Radius = 14, Sound = false, Size = UDim2.fromOffset(170, 54), AnchorPoint = Vector2.new(0.5, 0.5), Parent = parent12})
        local RankArt = require(script.Parent.Parent.RankArt)
        local v299 = ui.Button({Name = "Ranks", Text = "RANKS", TextSize = 22, Style = "Dark", Radius = 14, Size = UDim2.fromOffset(170, 54), AnchorPoint = Vector2.new(0.5, 0.5), Parent = parent12})
        local v300 = RankArt.Emblem(1, 34, {ZIndex = 3, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Parent = v299.Face})
        v299.Activated:Connect(
            function()
                --[[
                  line: 1099
                  upvalues:
                    a41 (copy, index: 1)
                ]]
                a41.MenuManager.Open("Ranks")
            end
        )
        ui.KeyCap("F", {Height = 24, TextSize = 15, ZIndex = 3, Gamepad = Enum.KeyCode.ButtonA, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, -1), Parent = v297.Face})
        local isBusy = false
        local closing = false
        local bound = false
        local timestamp = 0
        local v305 = 0
        local v306 = 0
        local rotationX = 0
        local v308 = 0
        local v309 = 0
        local v310 = 0
        local v311 = 0
        local v312 = 0
        local v313 = 0
        local v314 = 0
        local v315 = 0
        local v316 = false
        local v317 = nil
        local x = 0
        local y = 0
        local timestamp2 = 0
        local v321 = 0
        local v322 = false
        local x2 = 0
        local v324 = 0
        local clampedValue = 0
        local clampedValue2 = 0
        local startValue = nil
        local v328 = false
        local v329 = 1
        local front = true
        local v331 = 0.8
        local v332 = 0.03
        local clampedValue3 = 0
        local v334 = 0
        local x3 = 0
        local y2 = 0
        local y3 = 0
        local rotation = 0
        local v339 = -1
        local v340 = -1

        local function layout()
            --[[
              name: layout
              line: 1138
              upvalues:
                ui (copy, index: 1)
                v331 (ref,  index: 2)
                v332 (ref,  index: 3)
                v296 (copy, index: 4)
                v297 (copy, index: 5)
                v299 (copy, index: 6)
                y3 (ref,  index: 7)
                guiService (copy, index: 8)
                workspace (copy, index: 9)
                clampedValue3 (ref,  index: 10)
                v64 (copy, index: 11)
                v65 (copy, index: 12)
                v89 (copy, index: 13)
                v90 (copy, index: 14)
            ]]
            local v342 = ui.CanvasSize()
            local v343 = ui.TopInset()

            if not ui.Compact or ui.Tablet then
                v331 = 0.76
                v332 = 0.05
                v296.Position = UDim2.new(1, -24, 0, v343 + 4)
                v296.Size = UDim2.fromOffset(56, 56)
                local flooredValue = math.floor((v342.Y * (0.5 - v332 + (v331 / 2)) + v342.Y) / 2)
                v297.Instance.Position = UDim2.fromOffset(math.floor(v342.X / 2) - 95, flooredValue)
                v297.Instance.Size = UDim2.fromOffset(170, 54)
                v299.Instance.Position = UDim2.fromOffset(math.floor(v342.X / 2) + 95, flooredValue)
                v299.Instance.Size = UDim2.fromOffset(170, 54)
            else
                v331 = 0.9
                v332 = 0
                v296.Position = UDim2.new(1, -16, 0, (math.max(8, v343 - 52)))
                v296.Size = UDim2.fromOffset(60, 60)
                local v345 = (v342.Y * v331) * 500 / 700
                local v346 = (v342.X / 2) + (v345 / 2) + (v342.X / 2 - (v345 / 2)) / 2
                v297.Instance.Position = UDim2.fromOffset(math.floor(v346), (math.floor(v342.Y * 0.84)))
                v297.Instance.Size = UDim2.fromOffset(170, 60)
                v299.Instance.Position = UDim2.fromOffset(math.floor(v346), math.floor(v342.Y * 0.84) - 72)
                v299.Instance.Size = UDim2.fromOffset(170, 60)
            end

            y3 = guiService:GetGuiInset().Y
            local v348 = if const camera = workspace.CurrentCamera then camera.ViewportSize.Y else 900
            local clampedValue = math.clamp((v348 * v331) / 700, 1, 1.8)

            if 0.01 < math.abs(clampedValue - clampedValue3) then
                clampedValue3 = clampedValue
                local canvasSize = Vector2.new(math.floor(clampedValue * 500), (math.floor(clampedValue * 700)))
                v64.CanvasSize = canvasSize
                v65.CanvasSize = canvasSize
                v89.scale.Scale = canvasSize.X / 500
                v90.scale.Scale = canvasSize.X / 500
            end
        end

        local function cardScreenRect()
            --[[
              name: cardScreenRect
              line: 1183
              upvalues:
                workspace (copy, index: 1)
                card (copy, index: 2)
            ]]
            local camera = workspace.CurrentCamera
            local cFrame = card.CFrame
            local v354 = math.huge
            local v355 = math.huge
            local v356 = -math.huge
            local v357 = -math.huge

            for _, vector3 in {Vector3.new(-1, -1, 0), Vector3.new(1, -1, 0), Vector3.new(-1, 1, 0), Vector3.new(1, 1, 0)} do
                local v360 = camera:WorldToScreenPoint((cFrame * CFrame.new((vector3.X * 0.7142857142857143) / 2, (vector3.Y * 1) / 2, 0)).Position)
                v354 = math.min(v354, v360.X)
                v355 = math.min(v355, v360.Y)
                v356 = math.max(v356, v360.X)
                v357 = math.max(v357, v360.Y)
            end

            return v354, v355, v356, v357
        end

        do
            local function doFlip()
                --[[
                  name: doFlip
                  line: 1194
                  upvalues:
                    isBusy (ref,  index: 1)
                    closing (ref,  index: 2)
                    v312 (ref,  index: 3)
                    v310 (ref,  index: 4)
                    v311 (ref,  index: 5)
                    a41 (copy, index: 6)
                ]]
                if not isBusy or closing then
                    return
                end

                if math.tau <= v312 then
                    v312 -= math.tau
                    v310 -= math.tau
                end

                v312 += math.pi
                v311 += 1.5
                a41.Sounds.Play("Card_Flip")
            end

            local function step(a363: number)
                --[[
                  name: step
                  line: 1211
                  upvalues:
                    workspace (copy, index: 1)
                    v316 (ref,  index: 2)
                    v332 (ref,  index: 3)
                    y3 (ref,  index: 4)
                    v331 (ref,  index: 5)
                    v322 (ref,  index: 6)
                    v314 (ref,  index: 7)
                    v315 (ref,  index: 8)
                    x2 (ref,  index: 9)
                    v324 (ref,  index: 10)
                    clampedValue (ref,  index: 11)
                    clampedValue2 (ref,  index: 12)
                    v308 (ref,  index: 13)
                    v306 (ref,  index: 14)
                    v309 (ref,  index: 15)
                    rotationX (ref,  index: 16)
                    v311 (ref,  index: 17)
                    v312 (ref,  index: 18)
                    v310 (ref,  index: 19)
                    timestamp (ref,  index: 20)
                    v329 (ref,  index: 21)
                    closing (ref,  index: 22)
                    v305 (ref,  index: 23)
                    v313 (ref,  index: 24)
                    card (copy, index: 25)
                    shadow (copy, index: 26)
                    v334 (ref,  index: 27)
                    x3 (ref,  index: 28)
                    y2 (ref,  index: 29)
                    backdrop (copy, index: 30)
                    front (ref,  index: 31)
                    v64 (copy, index: 32)
                    v65 (copy, index: 33)
                    v89 (copy, index: 34)
                    v90 (copy, index: 35)
                    v339 (ref,  index: 36)
                    v340 (ref,  index: 37)
                    ui15 (copy, index: 38)
                    v133 (ref,  index: 39)
                    v132 (copy, index: 40)
                    v131 (copy, index: 41)
                    ui14 (copy, index: 42)
                    ui12 (copy, index: 43)
                    rotation (ref,  index: 44)
                    ui6 (copy, index: 45)
                    ui3 (copy, index: 46)
                    ui4 (copy, index: 47)
                    ui5 (copy, index: 48)
                    ui2 (copy, index: 49)
                    parent (copy, index: 50)
                    parent2 (copy, index: 51)
                    trPlayerCard (copy, index: 52)
                    bound (ref,  index: 53)
                    runService (copy, index: 54)
                ]]
                local v364 = math.min(a363, 0.05)
                local camera = workspace.CurrentCamera
                if not camera then
                    return
                end

                local timestamp2 = os.clock()
                local viewportSize = camera.ViewportSize
                local v368 = 0
                local v369 = 0

                if v316 then
                    local v370 = viewportSize.X / 2
                    local v371 = viewportSize.Y * (0.5 - v332) - y3
                    local v372 = viewportSize.Y * v331 / 2
                    local v373 = if v322 then (v372 * 500) / 700 * 1.3 else viewportSize.X * 0.5
                    local v374 = if v322 then v372 * 1.3 else viewportSize.Y * 0.5
                    v368 = math.clamp((v314 - v370) / v373, -1, 1)
                    v369 = math.clamp((v315 - v371) / v374, -1, 1)
                elseif x2 ~= 0 or v324 ~= 0 then
                    v368 = x2
                    v369 = v324
                end

                local v375 = v316 and 0.35 or 1
                local v376 = (v368 * 0.12217304763960307) + clampedValue + (math.sin(timestamp2 * 0.7) * 0.018) * v375
                local v377 = (v369 * 0.08726646259971647) + clampedValue2 + (math.cos(timestamp2 * 0.93) * 0.014) * v375
                v308 += (((v376 - v306) * 90 - (v308 * 13.661039491927399)) * v364)
                v309 += (((v377 - rotationX) * 90 - (v309 * 13.661039491927399)) * v364)
                v306 += (v308 * v364)
                rotationX += (v309 * v364)
                v311 += (((v312 - v310) * 120 - (v311 * 13.145341380123986)) * v364)
                v310 += (v311 * v364)
                local v378 = 0
                local v379 = 0
                local v380 = 0
                local clampedValue3 = math.clamp((timestamp2 - timestamp) / (v329 * 0.62), 0, 1)

                if clampedValue3 < 1 then
                    v378 = -(1 - ((((function(...) return (...) ^ 3 end)(((clampedValue3 - 1)))) * 2.4) + 1 + (((function(...) return (...) ^ 2 end)(((clampedValue3 - 1)))) * 1.4))) * 1.05
                    v379 = -(1 - (1 - ((function(...) return (...) ^ 3 end)(((1 - clampedValue3)))))) * math.pi * 2
                end

                local v382 = (timestamp2 - timestamp) / v329 - 0.62

                if 0 < v382 and v382 < 0.35 then
                    v380 = math.sin((v382 / 0.35) * math.pi) * 0.035
                end

                if closing then
                    local clampedValue4 = math.clamp((timestamp2 - v305) / (v329 * 0.24), 0, 1)
                    v378 -= ((clampedValue4 * clampedValue4) * clampedValue4) * 1.25
                    v379 += clampedValue4 * 0.7
                    v313 = math.max(0, v313 - v364 / 0.24)
                else
                    v313 = math.min(1, v313 + v364 / 0.3)
                end

                local v384 = math.tan(math.rad(camera.FieldOfView) / 2)
                local v385 = 1 / (v384 * 2 * v331)
                local v386 = v385 * 2 * v384
                local cframe = camera.CFrame * CFrame.new(0, (v332 + v378) * v386, -v385 * (1 - v380))
                local rotationY = v306 + v310 + v379
                card.CFrame = cframe * CFrame.Angles(rotationX, 0, 0) * CFrame.Angles(0, rotationY, 0)
                local v389 = v306 / 0.12217304763960307
                local v390 = rotationX / 0.08726646259971647
                shadow.CFrame = cframe * CFrame.new(-v389 * 0.05, (v390 * 0.03) + -0.035, -0.14)
                local v391 = v385 + 0.4
                local y4 = (v391 * 2) * v384 * 1.2

                if 0.001 < math.abs(y4 - v334) or viewportSize.X ~= x3 or viewportSize.Y ~= y2 then
                    local x = viewportSize.X
                    local y = viewportSize.Y
                    v334 = y4
                    x3 = x
                    y2 = y
                    backdrop.Size = Vector3.new((y4 * viewportSize.X / math.max(viewportSize.Y, 1)) * 1.1, y4, 0.004)
                    shadow.Size = Vector3.new(1.0714285373687744, 1.350000023841858, 0.004000000189989805)
                end

                backdrop.CFrame = camera.CFrame * CFrame.new(0, 0, -v391)
                local enabled = card.CFrame.LookVector:Dot(camera.CFrame.Position - card.Position) < 0

                if enabled ~= front then
                    front = enabled
                    v64.Enabled = enabled
                    v65.Enabled = not enabled
                end

                local v396 = if enabled then v89 else v90
                local v397 = math.clamp(v389, -1.4, 1.4) * 0.55 + 0.5
                local v398 = math.clamp(v390, -1.4, 1.4) * 0.55 + 0.45

                if 0.002 < math.abs(v397 - v339) or 0.002 < math.abs(v398 - v340) then
                    v339 = v397
                    v340 = v398
                    v396.glare.Position = UDim2.fromScale(v397, v398)
                    v396.glare.ImageTransparency = 0.82 - (math.min(1, (math.sqrt((v389 * v389) + (v390 * v390)))) * 0.12)
                    v396.band.Position = UDim2.fromScale(0.5 - (v389 * 0.6), 0.55 - (v390 * 0.3))
                    v396.rimGrad.Offset = Vector2.new(v389 * 0.35, v390 * 0.35)

                    if enabled then
                        ui15.Offset = Vector2.new(v389 * 0.6, v390 * 0.4)
                        local v399 = v389 * 2.3 + v390 * 1.7

                        for index = 1, v133 do
                            local v401
                            local v402 = math.cos((v399 + v132[index]) * math.pi)

                            if not (0 < v402) then
                                v401 = 0
                            else
                                v401 = v402 ^ 10
                            end

                            v131[index].ImageTransparency = 1 - (v401 * 0.75)
                        end

                        ui14.Position = UDim2.new(0.5, -v389 * 10, 1, (v390 * 5) + 24)
                        ui12.Position = UDim2.new(0.5, v389 * 7, 0.42, -v390 * 5)
                    end
                end

                rotation = (rotation + (v364 * 5)) % 360

                if enabled then
                    ui12.Rotation = rotation
                end

                ui6.Rotation = -rotation * 0.6
                ui3.BackgroundTransparency = 1 - (v313 * 0.55)
                ui4.ImageTransparency = 1 - (v313 * 0.8)
                ui5.ImageTransparency = 1 - (v313 * 0.3)
                ui6.ImageTransparency = 1 - (v313 * 0.06)
                ui2.ImageTransparency = 1 - (v313 * 0.7)

                if closing then
                    local v403 = timestamp2 - v305

                    if v329 * 0.24 <= v403 then
                        closing = false
                        v64.Enabled = false
                        v65.Enabled = false
                        parent.Enabled = false
                        parent2.Enabled = false
                        trPlayerCard.Parent = nil

                        if bound then
                            bound = false
                            runService:UnbindFromRenderStep("TR_PlayerCard")
                        end
                    end
                end
            end

            do
                local function bind()
                    --[[
                      name: bind
                      line: 1340
                      upvalues:
                        bound (ref,  index: 1)
                        runService (copy, index: 2)
                        step (copy, index: 3)
                    ]]
                    if not bound then
                        bound = true
                        runService:BindToRenderStep("TR_PlayerCard", Enum.RenderPriority.Camera.Value + 10, step)
                    end
                end
            end

            do
                local function inRect(a406, a407)
                    --[[
                      name: inRect
                      line: 1348
                      upvalues:
                        cardScreenRect (copy, index: 1)
                    ]]
                    local v408, v409, v410, v411 = cardScreenRect()
                    return v408 <= a406 and a406 <= v410 and v409 <= a407 and (a407 <= v411)
                end
            end

            ui27.InputBegan:Connect(
                function(a412)
                    --[[
                      line: 1352
                      upvalues:
                        isBusy (ref, index: 1)
                        closing (ref, index: 2)
                        v317 (ref, index: 3)
                        x (ref, index: 4)
                        y (ref, index: 5)
                        timestamp2 (ref, index: 6)
                        v321 (ref, index: 7)
                        v322 (ref, index: 8)
                        v316 (ref, index: 9)
                        v314 (ref, index: 10)
                        v315 (ref, index: 11)
                    ]]
                    if not isBusy or closing then
                        return
                    end

                    local userInputType = a412.UserInputType

                    if userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch then
                        v317 = a412
                        local x2 = a412.Position.X
                        local y2 = a412.Position.Y
                        local timestamp = os.clock()
                        x = x2
                        y = y2
                        timestamp2 = timestamp
                        v321 = 0

                        if userInputType == Enum.UserInputType.Touch then
                            v322 = true
                            v316 = true
                            local x3 = a412.Position.X
                            local y3 = a412.Position.Y
                            v314 = x3
                            v315 = y3
                        end
                    end
                end
            )

            ui27.InputChanged:Connect(
                function(a419)
                    --[[
                      line: 1369
                      upvalues:
                        isBusy (ref, index: 1)
                        v322 (ref, index: 2)
                        v314 (ref, index: 3)
                        v315 (ref, index: 4)
                        v321 (ref, index: 5)
                        x (ref, index: 6)
                        y (ref, index: 7)
                    ]]
                    if isBusy and v322 and a419.UserInputType == Enum.UserInputType.Touch then
                        local x2 = a419.Position.X
                        local y2 = a419.Position.Y
                        v314 = x2
                        v315 = y2
                        v321 = math.max(v321, math.abs(v314 - x) + math.abs(v315 - y))
                    end
                end
            )

            userInputService.InputChanged:Connect(
                function(input: InputObject)
                    --[[
                      line: 1375
                      upvalues:
                        isBusy (ref, index: 1)
                        v322 (ref, index: 2)
                        v328 (ref, index: 3)
                        v314 (ref, index: 4)
                        v315 (ref, index: 5)
                        v316 (ref, index: 6)
                        x2 (ref, index: 7)
                        v324 (ref, index: 8)
                    ]]
                    if not isBusy then
                        return
                    end

                    local userInputType = input.UserInputType

                    if userInputType == Enum.UserInputType.MouseMovement and not v322 and not v328 then
                        local x = input.Position.X
                        local y = input.Position.Y
                        v314 = x
                        v315 = y
                        v316 = true

                        return
                    end

                    if userInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.Thumbstick2 then
                        local position = input.Position

                        if math.sqrt(position.X * position.X + (position.Y * position.Y)) < 0.2 then
                            x2 = 0
                            v324 = 0

                            return
                        end

                        local x = position.X
                        local v428 = -position.Y
                        x2 = x
                        v324 = v428
                        v316 = false
                    end
                end
            )

            userInputService.InputEnded:Connect(
                function(input: InputObject)
                    --[[
                      line: 1394
                      upvalues:
                        v317 (ref,  index: 1)
                        v322 (ref,  index: 2)
                        v328 (ref,  index: 3)
                        v316 (ref,  index: 4)
                        isBusy (ref,  index: 5)
                        closing (ref,  index: 6)
                        v321 (ref,  index: 7)
                        x (ref,  index: 8)
                        y (ref,  index: 9)
                        timestamp2 (ref,  index: 10)
                        cardScreenRect (copy, index: 11)
                        v312 (ref,  index: 12)
                        v310 (ref,  index: 13)
                        v311 (ref,  index: 14)
                        a41 (copy, index: 15)
                    ]]
                    local isTouch = input.UserInputType == Enum.UserInputType.Touch

                    repeat
                        if input ~= v317 then
                            if not isTouch then
                                break
                            end
                            if not v322 then
                                break
                            end
                        end

                        v317 = nil

                        if isTouch then
                            v322 = false

                            if not v328 then
                                v316 = false
                            end
                        end

                        if isBusy
                            and not closing
                            and not (16 < v321 + math.abs(input.Position.X - x) + math.abs(input.Position.Y - y))
                            and not (0.45 < os.clock() - timestamp2)
                        then
                            local x2 = x
                            local y2 = y
                            local v433, v434, v435, v436 = cardScreenRect()

                            if v433 <= x2 and x2 <= v435 and v434 <= y2 and (y2 <= v436) then
                                if isBusy then
                                    if closing then
                                        return
                                    end

                                    if math.tau <= v312 then
                                        v312 -= math.tau
                                        v310 -= math.tau
                                    end

                                    v312 += math.pi
                                    v311 += 1.5
                                    a41.Sounds.Play("Card_Flip")
                                end
                            else
                                a41.MenuManager.Close("PlayerCard")
                            end
                        end

                        return
                    until true
                end
            )

            userInputService.InputBegan:Connect(
                function(input: InputObject, gameProcessedEvent: boolean)
                    --[[
                      line: 1419
                      upvalues:
                        isBusy (ref,  index: 1)
                        closing (ref,  index: 2)
                        userInputService (copy, index: 3)
                        v312 (ref,  index: 4)
                        v310 (ref,  index: 5)
                        v311 (ref,  index: 6)
                        a41 (copy, index: 7)
                        guiService (copy, index: 8)
                    ]]
                    if not isBusy or closing or userInputService:GetFocusedTextBox() then
                        return
                    end

                    if input.KeyCode == Enum.KeyCode.F and not gameProcessedEvent then
                        if isBusy then
                            if closing then
                                return
                            end

                            if math.tau <= v312 then
                                v312 -= math.tau
                                v310 -= math.tau
                            end

                            v312 += math.pi
                            v311 += 1.5
                            a41.Sounds.Play("Card_Flip")
                        end
                    elseif input.KeyCode == Enum.KeyCode.ButtonA and guiService.SelectedObject == nil and isBusy then
                        if closing then
                            return
                        end

                        if math.tau <= v312 then
                            v312 -= math.tau
                            v310 -= math.tau
                        end

                        v312 += math.pi
                        v311 += 1.5
                        a41.Sounds.Play("Card_Flip")
                    end
                end
            )

            local deviceRotationChangedConnection = nil

            local function setGyro(gyro: boolean)
                --[[
                  name: setGyro
                  line: 1431
                  upvalues:
                    deviceRotationChangedConnection (ref,  index: 1)
                    clampedValue (ref,  index: 2)
                    clampedValue2 (ref,  index: 3)
                    startValue (ref,  index: 4)
                    ui (copy, index: 5)
                    userInputService (copy, index: 6)
                ]]
                if deviceRotationChangedConnection then
                    deviceRotationChangedConnection:Disconnect()
                    deviceRotationChangedConnection = nil
                end

                clampedValue = 0
                clampedValue2 = 0
                startValue = nil

                if not gyro or not ui.Touch or not userInputService.GyroscopeEnabled then
                    return
                end

                deviceRotationChangedConnection = userInputService.DeviceRotationChanged:Connect(
                    function(rotation: InputObject, cframe: CFrame)
                        --[[
                          line: 1440
                          upvalues:
                            startValue (ref, index: 1)
                            clampedValue (ref, index: 2)
                            clampedValue2 (ref, index: 3)
                        ]]
                        if not startValue then
                            startValue = cframe
                            return
                        end

                        local interpolatedValue = startValue:Lerp(cframe, 0.03)
                        startValue = interpolatedValue
                        local v445, v446 = interpolatedValue:ToObjectSpace(cframe):ToEulerAnglesYXZ()
                        clampedValue = math.clamp(-v446 * 0.5, -0.08726646259971647, 0.08726646259971647)
                        clampedValue2 = math.clamp(-v445 * 0.5, -0.06981317007977318, 0.06981317007977318)
                    end
                )
            end

            v296.Activated:Connect(
                function()
                    --[[
                      line: 1453
                      upvalues:
                        a41 (copy, index: 1)
                    ]]
                    a41.MenuManager.Close("PlayerCard")
                end
            )
            v297.Activated:Connect(doFlip)

            do
                local function hideOthers(a448)
                    --[[
                      name: hideOthers
                      line: 1459
                      upvalues:
                        a41 (copy, index: 1)
                        v26 (ref,  index: 2)
                        textChatService (copy, index: 3)
                        starterGui (copy, index: 4)
                    ]]
                    a41.SetHudHidden("PlayerCard", a448)

                    if a41.TopbarSettings and a41.TopbarSettings.SetHidden then
                        a41.TopbarSettings.SetHidden("PlayerCard", a448)
                    end

                    if a448 then
                        if v26 then
                            return
                        end

                        local v449 = {}

                        pcall(
                            function()
                                --[[
                                  line: 113
                                  upvalues:
                                    textChatService (copy, index: 1)
                                    v449 (copy, index: 2)
                                    starterGui (copy, index: 3)
                                ]]
                                local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                                local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                                if chatWindowConfiguration then
                                    v449.window = chatWindowConfiguration.Enabled
                                    chatWindowConfiguration.Enabled = false
                                end

                                if chatInputBarConfiguration then
                                    v449.bar = chatInputBarConfiguration.Enabled
                                    chatInputBarConfiguration.Enabled = false
                                end

                                v449.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                                starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                            end
                        )

                        v26 = v449

                        return
                    end

                    local v452 = v26
                    if not v452 then
                        return
                    end

                    v26 = nil

                    pcall(
                        function()
                            --[[
                              line: 135
                              upvalues:
                                textChatService (copy, index: 1)
                                v452 (copy, index: 2)
                                starterGui (copy, index: 3)
                            ]]
                            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                            if chatWindowConfiguration and v452.window ~= nil then
                                chatWindowConfiguration.Enabled = v452.window
                            end

                            if chatInputBarConfiguration and v452.bar ~= nil then
                                chatInputBarConfiguration.Enabled = v452.bar
                            end

                            if v452.core ~= nil then
                                starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v452.core)
                            end
                        end
                    )
                end
            end

            a41.MenuManager.Register(
                "PlayerCard",
                {
                    blur = false,
                    open = (function()
                        --[[
                          name: open
                          line: 1473
                          upvalues:
                            isBusy (ref,  index: 1)
                            closing (ref,  index: 2)
                            a41 (copy, index: 3)
                            v26 (ref,  index: 4)
                            textChatService (copy, index: 5)
                            starterGui (copy, index: 6)
                            ui14 (copy, index: 7)
                            localPlayer (copy, index: 8)
                            parent9 (copy, index: 9)
                            paint (copy, index: 10)
                            RankArt (copy, index: 11)
                            v300 (copy, index: 12)
                            layout (copy, index: 13)
                            timestamp (ref,  index: 14)
                            v306 (ref,  index: 15)
                            rotationX (ref,  index: 16)
                            v308 (ref,  index: 17)
                            v309 (ref,  index: 18)
                            v310 (ref,  index: 19)
                            v311 (ref,  index: 20)
                            v312 (ref,  index: 21)
                            v313 (ref,  index: 22)
                            v339 (ref,  index: 23)
                            v340 (ref,  index: 24)
                            v328 (ref,  index: 25)
                            v316 (ref,  index: 26)
                            v322 (ref,  index: 27)
                            v317 (ref,  index: 28)
                            x2 (ref,  index: 29)
                            v324 (ref,  index: 30)
                            front (ref,  index: 31)
                            v64 (copy, index: 32)
                            v65 (copy, index: 33)
                            parent (copy, index: 34)
                            parent2 (copy, index: 35)
                            trPlayerCard (copy, index: 36)
                            workspace (copy, index: 37)
                            parent12 (copy, index: 38)
                            ui27 (copy, index: 39)
                            ui (copy, index: 40)
                            v296 (copy, index: 41)
                            v297 (copy, index: 42)
                            setGyro (copy, index: 43)
                            bound (ref,  index: 44)
                            runService (copy, index: 45)
                            step (copy, index: 46)
                        ]]
                        if isBusy then
                            return
                        end

                        isBusy = true
                        closing = false
                        a41.SetHudHidden("PlayerCard", true)

                        if a41.TopbarSettings and a41.TopbarSettings.SetHidden then
                            a41.TopbarSettings.SetHidden("PlayerCard", true)
                        end

                        if not v26 then
                            local v455 = {}

                            pcall(
                                function()
                                    --[[
                                      line: 113
                                      upvalues:
                                        textChatService (copy, index: 1)
                                        v455 (copy, index: 2)
                                        starterGui (copy, index: 3)
                                    ]]
                                    local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                                    local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                                    if chatWindowConfiguration then
                                        v455.window = chatWindowConfiguration.Enabled
                                        chatWindowConfiguration.Enabled = false
                                    end

                                    if chatInputBarConfiguration then
                                        v455.bar = chatInputBarConfiguration.Enabled
                                        chatInputBarConfiguration.Enabled = false
                                    end

                                    v455.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                                    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                                end
                            )

                            v26 = v455
                        end

                        ui14.Image = string.format("rbxthumb://type=Avatar&id=%d&w=720&h=720", localPlayer.UserId)
                        parent9.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", localPlayer.UserId)
                        paint()
                        RankArt.SetEmblem(v300, RankArt.Ranks.RankOf(tonumber(a41.State.Get("Trophies")) or 0))
                        layout()
                        timestamp = os.clock()
                        v306 = 0
                        rotationX = 0
                        v308 = 0
                        v309 = 0
                        v310 = 0
                        v311 = 0
                        v312 = 0
                        v313 = 0
                        v339 = -1
                        v340 = -1

                        if not v328 then
                            v316 = false
                        end

                        v322 = false
                        v317 = nil
                        x2 = 0
                        v324 = 0
                        front = true
                        v64.Enabled = true
                        v65.Enabled = false
                        parent.Enabled = true
                        parent2.Enabled = true
                        trPlayerCard.Parent = workspace.CurrentCamera
                        parent12.Visible = true
                        ui27.Visible = true
                        ui.Enter(v296, Vector2.new(0, -10), 0.25)
                        ui.Enter(v297.Instance, Vector2.new(0, 14), 0.35)
                        setGyro(true)

                        if not bound then
                            bound = true
                            runService:BindToRenderStep("TR_PlayerCard", Enum.RenderPriority.Camera.Value + 10, step)
                        end

                        step(0)
                        a41.Sounds.Play("Card_Whoosh")
                    end),
                    close = (function(a458)
                        --[[
                          name: close
                          line: 1504
                          upvalues:
                            isBusy (ref,  index: 1)
                            a41 (copy, index: 2)
                            v26 (ref,  index: 3)
                            textChatService (copy, index: 4)
                            starterGui (copy, index: 5)
                            parent12 (copy, index: 6)
                            ui27 (copy, index: 7)
                            deviceRotationChangedConnection (ref,  index: 8)
                            clampedValue (ref,  index: 9)
                            clampedValue2 (ref,  index: 10)
                            startValue (ref,  index: 11)
                            closing (ref,  index: 12)
                            v305 (ref,  index: 13)
                            v329 (ref,  index: 14)
                            step (copy, index: 15)
                        ]]
                        if not isBusy then
                            return
                        end

                        isBusy = false
                        a41.SetHudHidden("PlayerCard", false)

                        if a41.TopbarSettings and a41.TopbarSettings.SetHidden then
                            a41.TopbarSettings.SetHidden("PlayerCard", false)
                        end

                        if const v459 = v26 then
                            v26 = nil

                            pcall(
                                function()
                                    --[[
                                      line: 135
                                      upvalues:
                                        textChatService (copy, index: 1)
                                        v459 (copy, index: 2)
                                        starterGui (copy, index: 3)
                                    ]]
                                    local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                                    local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                                    if chatWindowConfiguration and v459.window ~= nil then
                                        chatWindowConfiguration.Enabled = v459.window
                                    end

                                    if chatInputBarConfiguration and v459.bar ~= nil then
                                        chatInputBarConfiguration.Enabled = v459.bar
                                    end

                                    if v459.core ~= nil then
                                        starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v459.core)
                                    end
                                end
                            )
                        end

                        parent12.Visible = false
                        ui27.Visible = false

                        if deviceRotationChangedConnection then
                            deviceRotationChangedConnection:Disconnect()
                            deviceRotationChangedConnection = nil
                        end

                        clampedValue = 0
                        clampedValue2 = 0
                        startValue = nil

                        if a458 then
                            closing = true
                            v305 = os.clock() - (v329 * 0.24)
                            step(0)

                            return
                        end

                        closing = true
                        v305 = os.clock()
                    end)
                }
            )
        end

        state.PlayerStateChanged:Connect(
            function(a462)
                --[[
                  line: 1523
                  upvalues:
                    a41 (copy, index: 1)
                ]]
                if a462 == "Match" and a41.MenuManager.IsOpen("PlayerCard") then
                    a41.MenuManager.Close("PlayerCard", true)
                end
            end
        )

        state.ProfileChanged:Connect(
            function()
                --[[
                  line: 1528
                  upvalues:
                    isBusy (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                if isBusy then
                    paint()
                end
            end
        )

        state.AttrChanged:Connect(
            function(a463)
                --[[
                  line: 1533
                  upvalues:
                    isBusy (ref,  index: 1)
                    paint (copy, index: 2)
                ]]
                if isBusy and (a463 == "Level" or a463 == "XP" or a463 == "Streak") then
                    paint()
                end
            end
        )

        ui.LayoutChanged:Connect(
            function()
                --[[
                  line: 1538
                  upvalues:
                    isBusy (ref,  index: 1)
                    layout (copy, index: 2)
                ]]
                if isBusy then
                    layout()
                end
            end
        )

        ui.ScaleChanged:Connect(
            function()
                --[[
                  line: 1543
                  upvalues:
                    isBusy (ref,  index: 1)
                    layout (copy, index: 2)
                ]]
                if isBusy then
                    layout()
                end
            end
        )

        a41.Debug.playerCard = function(a464, a465, a466)
            --[[
              line: 1550
              upvalues:
                a41 (copy, index: 1)
                isBusy (ref,  index: 2)
                closing (ref,  index: 3)
                v312 (ref,  index: 4)
                v310 (ref,  index: 5)
                v311 (ref,  index: 6)
                workspace (copy, index: 7)
                guiService (copy, index: 8)
                v328 (ref,  index: 9)
                v316 (ref,  index: 10)
                v314 (ref,  index: 11)
                v315 (ref,  index: 12)
                v332 (ref,  index: 13)
                v329 (ref,  index: 14)
                v207 (ref,  index: 15)
                paint (copy, index: 16)
                cardScreenRect (copy, index: 17)
                bound (ref,  index: 18)
                front (ref,  index: 19)
                v306 (ref,  index: 20)
                rotationX (ref,  index: 21)
                v208 (ref,  index: 22)
                v64 (copy, index: 23)
                v26 (ref,  index: 24)
                v322 (ref,  index: 25)
                v321 (ref,  index: 26)
                v143 (copy, index: 27)
                v166 (copy, index: 28)
            ]]
            if a464 == "open" then
                a41.MenuManager.Open("PlayerCard")
            elseif a464 == "close" then
                a41.MenuManager.Close("PlayerCard")
            elseif a464 == "flip" then
                if isBusy and not closing then
                    if math.tau <= v312 then
                        v312 -= math.tau
                        v310 -= math.tau
                    end

                    v312 += math.pi
                    v311 += 1.5
                    a41.Sounds.Play("Card_Flip")
                end
            elseif a464 == "tilt" then
                if type(a465) ~= "number" or type(a466) ~= "number" then
                    v328 = false
                    v316 = false
                else
                    local camera = workspace.CurrentCamera
                    local viewportSize = camera.ViewportSize
                    local guiInset = guiService:GetGuiInset()
                    v328 = true
                    v316 = true
                    v314 = viewportSize.X / 2 + ((a465 * viewportSize.X) * 0.4)
                    v315 = (viewportSize.Y * (0.5 - v332)) - guiInset.Y + ((a466 * viewportSize.Y) * 0.4)
                end
            elseif a464 == "pace" then
                if type(a465) ~= "number" or not (0 < a465) then
                    v329 = 1
                else
                    v329 = a465
                end
            elseif a464 == "level" then
                if type(a465) ~= "number" then
                    v207 = nil
                else
                    v207 = a465
                end

                if isBusy then
                    paint()
                end
            end

            local v470 = 0
            local v471 = 0
            local v472 = 0
            local v473 = 0

            if isBusy then
                v470, v471, v472, v473 = cardScreenRect()
            end

            local v474 = {open = isBusy, closing = closing, bound = bound}
            local flipped = math.floor((v312 / math.pi) + 0.5) % 2 == 1
            v474.flipped = flipped
            v474.front = front
            v474.yaw = math.floor(math.deg(v306) * 10) / 10
            v474.pitch = math.floor(math.deg(rotationX) * 10) / 10
            v474.flip = math.floor((math.deg(v310)))
            v474.tier = v208.name
            v474.canvas = tostring(v64.CanvasSize)
            v474.rect = string.format("%d,%d %d,%d", v470, v471, v472, v473)
            v474.hudHidden = a41.HudHidden
            local chatHidden = v26 ~= nil
            v474.chatHidden = chatHidden
            v474.pointer = string.format("%s %s %d,%d moved %d", tostring(v316), tostring(v322), v314, v315, v321)
            v474.stats = {wins = v143[1].value.Text, winRate = v143[2].value.Text, kd = v143[3].value.Text, items = v166.items.Text, drops = v166.drops.Text}

            return v474
        end
    end
end

return v8