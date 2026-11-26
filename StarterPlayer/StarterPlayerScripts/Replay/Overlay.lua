local _ = game:GetService("GuiService")
local players = game:GetService("Players")
local textService = game:GetService("TextService")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local v7 = {}
local localPlayer = players.LocalPlayer
local Loc = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Loc"))

local function locTitle(title)
    --[[
      name: locTitle
      line: 31
      upvalues:
        Loc (copy, index: 1)
    ]]
    local parts = string.split(title, " · ")

    for partKey, part in parts do
        parts[partKey] = Loc.T(part)
    end

    return table.concat(parts, " · ")
end

local parent = script.Parent.Parent
local result = nil

local function playUI(a18: string)
    --[[
      name: playUI
      line: 41
      upvalues:
        result (ref, index: 1)
    ]]
    if not result then
        local instance = game:GetService("ReplicatedStorage"):FindFirstChild("Shared")
        instance = instance and instance:FindFirstChild("Sfx")

        if instance and instance:IsA("ModuleScript") then
            local success, result2 = pcall(require, instance)

            if not success or type(result2) ~= "table" then
                result = false
            else
                result = result2
            end
        end
    end

    if result then
        pcall(result.PlayUI, a18)
    end
end

local color3FromRGB = Color3.fromRGB
local colors = {Void = color3FromRGB(6, 7, 10), Panel = color3FromRGB(18, 20, 26), PanelHi = color3FromRGB(28, 31, 39), Text = color3FromRGB(255, 255, 255), TextDim = color3FromRGB(186, 192, 206), TextMuted = color3FromRGB(124, 131, 148), Accent = color3FromRGB(40, 150, 255), Danger = color3FromRGB(245, 64, 72), Gold = color3FromRGB(255, 200, 60), Ally = color3FromRGB(70, 170, 255), Enemy = color3FromRGB(255, 72, 72)}
local v24 = {Display = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy), Title = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold), Bold = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold), SemiBold = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold)}
local ui = parent:FindFirstChild("UI")
local theme = ui and ui:FindFirstChild("Theme")

if theme and theme:IsA("ModuleScript") then
    local success, result2 = pcall(require, theme)

    if success and type(result2) == "table" and type(result2.Colors) == "table" then
        for colorKey in colors do
            local color = result2.Colors[colorKey]

            if typeof(color) == "Color3" then
                colors[colorKey] = color
            end
        end

        if type(result2.Fonts) == "table" then
            for fontKey in v24 do
                local font = result2.Fonts[fontKey]

                if typeof(font) == "Font" then
                    v24[fontKey] = font
                end
            end
        end
    end
end

v7.Colors = colors

local function tween(instance: Instance, a35: number?, propertyTable, a37, a38)
    --[[
      name: tween
      line: 103
      upvalues:
        tweenService (copy, index: 1)
    ]]
    local newTweenInfo = TweenInfo.new
    local v40 = a37 or Enum.EasingStyle.Quint
    local v41 = a38 or Enum.EasingDirection.Out
    local tween = tweenService:Create(instance, newTweenInfo(a35, v40, v41), propertyTable)
    tween:Play()

    return tween
end

local function new(a44: string, properties, a46)
    --[[
      name: new
      line: 109
    ]]
    local parent = Instance.new(a44)

    for v48, v49 in properties do
        if v48 ~= "Parent" then
            parent[v48] = v49
        end
    end

    if a46 then
        for _, uiComponent in a46 do
            uiComponent.Parent = parent
        end
    end

    if properties.Parent then
        parent.Parent = properties.Parent
    end

    return parent
end

local function label(properties)
    --[[
      name: label
      line: 127
      upvalues:
        colors (copy, index: 1)
        v24 (copy, index: 2)
    ]]
    properties.BackgroundTransparency = 1
    properties.TextColor3 = properties.TextColor3 or colors.Text
    properties.FontFace = properties.FontFace or v24.Bold
    properties.TextXAlignment = properties.TextXAlignment or Enum.TextXAlignment.Left
    local textLabel = Instance.new("TextLabel")

    for v55, v56 in properties do
        if v55 ~= "Parent" then
            textLabel[v55] = v56
        end
    end

    if properties.Parent then
        textLabel.Parent = properties.Parent
    end

    return textLabel
end

local v57 = nil
local propertyTable = {Saturation = -0.42, Contrast = -0.18, Brightness = 0.01, TintColor = Color3.fromRGB(255, 220, 194)}
local propertyTable2 = {Saturation = 0, Contrast = 0, Brightness = 0, TintColor = Color3.new(1, 1, 1)}
local v60 = {Vector2.new(0, 0), Vector2.new(1, 0), Vector2.new(0, 1), Vector2.new(1, 1)}

local function textWidth(string: string, fontSize: number)
    --[[
      name: textWidth
      line: 187
      upvalues:
        textService (copy, index: 1)
    ]]
    local success, textSize = pcall(
        function()
            --[[
              line: 188
              upvalues:
                textService (copy, index: 1)
                string (copy, index: 2)
                fontSize (copy, index: 3)
            ]]
            return textService:GetTextSize(string, fontSize, Enum.Font.BuilderSansExtraBold, Vector2.new(4000, 400))
        end
    )
    if success then
        return textSize.X * 1.06
    end

    return (#string * fontSize) * 0.62
end

local function scaleFor(a67)
    --[[
      name: scaleFor
      line: 194
    ]]
    local y = a67.Y

    if y < 560 then
        return (math.clamp(y / 620, 0.5, 1))
    end

    return (math.clamp(y / 900, 0.6, 1.4))
end

local function build()
    --[[
      name: build
      line: 202
      upvalues:
        localPlayer (copy, index: 1)
        v60 (copy, index: 2)
        colors (copy, index: 3)
        new (copy, index: 4)
        v24 (copy, index: 5)
        color3FromRGB (copy, index: 6)
    ]]
    local playerGui = localPlayer:WaitForChild("PlayerGui")
    local v71 = {Name = "TR_Replay", DisplayOrder = 60, IgnoreGuiInset = true, ResetOnSpawn = false, Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}
    local screenGui = Instance.new("ScreenGui")

    for v73, v74 in v71 do
        if v73 ~= "Parent" then
            screenGui[v73] = v74
        end
    end

    if v71.Parent then
        screenGui.Parent = v71.Parent
    end

    pcall(
        function()
            --[[
              line: 212
              upvalues:
                screenGui (copy, index: 1)
            ]]
            screenGui.ScreenInsets = Enum.ScreenInsets.None
        end
    )
    local v75 = {Name = "TR_ReplayHud", DisplayOrder = 61, IgnoreGuiInset = true, ResetOnSpawn = false, Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}
    local screenGui2 = Instance.new("ScreenGui")

    for v77, v78 in v75 do
        if v77 ~= "Parent" then
            screenGui2[v77] = v78
        end
    end

    if v75.Parent then
        screenGui2.Parent = v75.Parent
    end

    pcall(
        function()
            --[[
              line: 223
              upvalues:
                screenGui2 (copy, index: 1)
            ]]
            screenGui2.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        end
    )
    local v79 = {Name = "TR_ReplayFrame", DisplayOrder = 62, IgnoreGuiInset = false, ResetOnSpawn = false, Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}
    local screenGui3 = Instance.new("ScreenGui")

    for v81, v82 in v79 do
        if v81 ~= "Parent" then
            screenGui3[v81] = v82
        end
    end

    if v79.Parent then
        screenGui3.Parent = v79.Parent
    end

    pcall(
        function()
            --[[
              line: 237
              upvalues:
                screenGui3 (copy, index: 1)
            ]]
            screenGui3.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
        end
    )
    local corners = {}
    local cornerLines = {}

    for v85, anchorPoint in v60 do
        local v87 = {BackgroundTransparency = 1, Name = "Corner" .. v85, AnchorPoint = anchorPoint, Parent = screenGui3}
        local parent = Instance.new("Frame")

        for v89, v90 in v87 do
            if v89 ~= "Parent" then
                parent[v89] = v90
            end
        end

        if v87.Parent then
            parent.Parent = v87.Parent
        end

        local v91 = {Name = "H", BorderSizePixel = 0, AnchorPoint = Vector2.new(0, anchorPoint.Y), Position = UDim2.fromScale(0, anchorPoint.Y), BackgroundColor3 = colors.Text, Parent = parent}
        local frame = Instance.new("Frame")

        for v93, v94 in v91 do
            if v93 ~= "Parent" then
                frame[v93] = v94
            end
        end

        if v91.Parent then
            frame.Parent = v91.Parent
        end

        local v95 = {Name = "V", BorderSizePixel = 0, AnchorPoint = Vector2.new(anchorPoint.X, 0), Position = UDim2.fromScale(anchorPoint.X, 0), BackgroundColor3 = colors.Text, Parent = parent}
        local frame2 = Instance.new("Frame")

        for v97, v98 in v95 do
            if v97 ~= "Parent" then
                frame2[v97] = v98
            end
        end

        if v95.Parent then
            frame2.Parent = v95.Parent
        end

        table.insert(corners, parent)
        table.insert(cornerLines, frame)
        table.insert(cornerLines, frame2)
    end

    local properties = {Name = "Rec", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), AutomaticSize = Enum.AutomaticSize.X, Parent = screenGui3}
    local v100 = {}
    local v101 = {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder}
    local uiListLayout = Instance.new("UIListLayout")

    for v103, v104 in v101 do
        if v103 ~= "Parent" then
            uiListLayout[v103] = v104
        end
    end

    if v101.Parent then
        uiListLayout.Parent = v101.Parent
    end

    v100[1] = uiListLayout
    local instance = new("Frame", properties, v100)
    local properties2 = {Name = "Dot", BorderSizePixel = 0, LayoutOrder = 1, BackgroundColor3 = colors.Danger, Parent = instance}
    local v107 = {}
    local v108 = {CornerRadius = UDim.new(1, 0)}
    local uiCorner = Instance.new("UICorner")

    for v110, udim in v108 do
        if v110 ~= "Parent" then
            uiCorner[v110] = udim
        end
    end

    if v108.Parent then
        uiCorner.Parent = v108.Parent
    end

    v107[1] = uiCorner
    local recDot = new("Frame", properties2, v107)
    local v113 = {Name = "Text", Text = "REC", TextStrokeTransparency = 0.85, LayoutOrder = 2, FontFace = v24.Title, AutomaticSize = Enum.AutomaticSize.X, TextStrokeColor3 = colors.Void, Parent = instance, BackgroundTransparency = 1}
    v113.TextColor3 = v113.TextColor3 or colors.Text
    v113.FontFace = v113.FontFace or v24.Bold
    v113.TextXAlignment = v113.TextXAlignment or Enum.TextXAlignment.Left
    local recText = Instance.new("TextLabel")

    for v115, v116 in v113 do
        if v115 ~= "Parent" then
            recText[v115] = v116
        end
    end

    if v113.Parent then
        recText.Parent = v113.Parent
    end

    local v117 = {Name = "Cover", BorderSizePixel = 0, ZIndex = 10, BackgroundColor3 = colors.Void, Size = UDim2.fromScale(1, 1), Parent = screenGui}
    local frame = Instance.new("Frame")

    for v119, v120 in v117 do
        if v119 ~= "Parent" then
            frame[v119] = v120
        end
    end

    if v117.Parent then
        frame.Parent = v117.Parent
    end

    local v121 = {Rotation = 90, Color = ColorSequence.new(color3FromRGB(22, 26, 36), colors.Void), Parent = frame}
    local uiGradient = Instance.new("UIGradient")

    for v123, v124 in v121 do
        if v123 ~= "Parent" then
            uiGradient[v123] = v124
        end
    end

    if v121.Parent then
        uiGradient.Parent = v121.Parent
    end

    local v125 = {Name = "Card", BackgroundTransparency = 1, ZIndex = 11, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(1180, 260), Parent = frame}
    local frame3 = Instance.new("Frame")

    for v127, v128 in v125 do
        if v127 ~= "Parent" then
            frame3[v127] = v128
        end
    end

    if v125.Parent then
        frame3.Parent = v125.Parent
    end

    local v129 = {Parent = frame3}
    local cardScale = Instance.new("UIScale")

    for v131, frame4 in v129 do
        if v131 ~= "Parent" then
            cardScale[v131] = frame4
        end
    end

    if v129.Parent then
        cardScale.Parent = v129.Parent
    end

    local v133 = {Name = "Label", Text = "PLAY OF THE GAME", TextSize = 30, ZIndex = 12, FontFace = v24.Title, TextColor3 = colors.Accent, Position = UDim2.fromOffset(196, 8), Size = UDim2.fromOffset(700, 34), Parent = frame3, BackgroundTransparency = 1}
    v133.TextColor3 = v133.TextColor3 or colors.Text
    v133.FontFace = v133.FontFace or v24.Bold
    v133.TextXAlignment = v133.TextXAlignment or Enum.TextXAlignment.Left
    local cardLabel = Instance.new("TextLabel")

    for v135, v136 in v133 do
        if v135 ~= "Parent" then
            cardLabel[v135] = v136
        end
    end

    if v133.Parent then
        cardLabel.Parent = v133.Parent
    end

    local v137 = {Name = "Bar", BorderSizePixel = 0, ZIndex = 12, BackgroundColor3 = colors.Accent, Position = UDim2.fromOffset(198, 48), Size = UDim2.fromOffset(0, 5), Parent = frame3}
    local cardBar = Instance.new("Frame")

    for v139, v140 in v137 do
        if v139 ~= "Parent" then
            cardBar[v139] = v140
        end
    end

    if v137.Parent then
        cardBar.Parent = v137.Parent
    end

    local v141 = {Name = "Stripe", BorderSizePixel = 0, ZIndex = 12, BackgroundColor3 = colors.Ally, Position = UDim2.fromOffset(198, 66), Size = UDim2.fromOffset(6, 104), Parent = frame3}
    local cardStripe = Instance.new("Frame")

    for v143, v144 in v141 do
        if v143 ~= "Parent" then
            cardStripe[v143] = v144
        end
    end

    if v141.Parent then
        cardStripe.Parent = v141.Parent
    end

    local v145 = {Name = "PlayerName", Text = "", AutoLocalize = false, TextSize = 104, ZIndex = 12, FontFace = v24.Display, Position = UDim2.fromOffset(222, 60), Size = UDim2.fromOffset(950, 112), Parent = frame3, BackgroundTransparency = 1}
    v145.TextColor3 = v145.TextColor3 or colors.Text
    v145.FontFace = v145.FontFace or v24.Bold
    v145.TextXAlignment = v145.TextXAlignment or Enum.TextXAlignment.Left
    local cardName = Instance.new("TextLabel")

    for v147, v148 in v145 do
        if v147 ~= "Parent" then
            cardName[v147] = v148
        end
    end

    if v145.Parent then
        cardName.Parent = v145.Parent
    end

    local v149 = {Name = "Title", Text = "", AutoLocalize = false, TextSize = 30, ZIndex = 12, FontFace = v24.Bold, TextColor3 = colors.TextDim, Position = UDim2.fromOffset(224, 178), Size = UDim2.fromOffset(950, 36), Parent = frame3, BackgroundTransparency = 1}
    v149.TextColor3 = v149.TextColor3 or colors.Text
    v149.FontFace = v149.FontFace or v24.Bold
    v149.TextXAlignment = v149.TextXAlignment or Enum.TextXAlignment.Left
    local cardTitle = Instance.new("TextLabel")

    for v151, v152 in v149 do
        if v151 ~= "Parent" then
            cardTitle[v151] = v152
        end
    end

    if v149.Parent then
        cardTitle.Parent = v149.Parent
    end

    local properties3 = {Name = "Portrait", BackgroundTransparency = 0, LightDirection = Vector3.new(-0.6000000238418579, -1, -0.800000011920929), ZIndex = 12, BackgroundColor3 = colors.PanelHi, Position = UDim2.fromOffset(0, 40), Size = UDim2.fromOffset(170, 170), Ambient = color3FromRGB(170, 172, 182), LightColor = color3FromRGB(255, 250, 240), Parent = frame3}
    local v154 = {}
    local v155 = {CornerRadius = UDim.new(0, 14)}
    local uiCorner2 = Instance.new("UICorner")

    for v157, udim in v155 do
        if v157 ~= "Parent" then
            uiCorner2[v157] = udim
        end
    end

    if v155.Parent then
        uiCorner2.Parent = v155.Parent
    end

    local v159 = {Transparency = 0.82, Thickness = 2, Color = colors.Text}
    local uiStroke = Instance.new("UIStroke")

    for v161, v162 in v159 do
        if v161 ~= "Parent" then
            uiStroke[v161] = v162
        end
    end

    if v159.Parent then
        uiStroke.Parent = v159.Parent
    end

    v154[1], v154[2] = uiCorner2, uiStroke
    local instance2 = new("ViewportFrame", properties3, v154)
    local v164 = {Parent = instance2}
    local portraitScale = Instance.new("UIScale")

    for v166, instance3 in v164 do
        if v166 ~= "Parent" then
            portraitScale[v166] = instance3
        end
    end

    if v164.Parent then
        portraitScale.Parent = v164.Parent
    end

    local v168 = {Name = "Canvas", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = screenGui2}
    local frame5 = Instance.new("Frame")

    for v170, v171 in v168 do
        if v170 ~= "Parent" then
            frame5[v170] = v171
        end
    end

    if v168.Parent then
        frame5.Parent = v168.Parent
    end

    local v172 = {Parent = frame5}
    local hudScale = Instance.new("UIScale")

    for v174, frame6 in v172 do
        if v174 ~= "Parent" then
            hudScale[v174] = frame6
        end
    end

    if v172.Parent then
        hudScale.Parent = v172.Parent
    end

    local properties4 = {Name = "Tag", BackgroundTransparency = 0.12, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 28, 1, -22), Size = UDim2.fromOffset(0, 74), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = colors.Panel, Parent = frame5}
    local v177 = {}
    local v178 = {CornerRadius = UDim.new(0, 10)}
    local uiCorner3 = Instance.new("UICorner")

    for v180, udim in v178 do
        if v180 ~= "Parent" then
            uiCorner3[v180] = udim
        end
    end

    if v178.Parent then
        uiCorner3.Parent = v178.Parent
    end

    local v182 = {Transparency = 0.9, Thickness = 1, Color = colors.Text}
    local uiStroke2 = Instance.new("UIStroke")

    for v184, v185 in v182 do
        if v184 ~= "Parent" then
            uiStroke2[v184] = v185
        end
    end

    if v182.Parent then
        uiStroke2.Parent = v182.Parent
    end

    local v186 = {PaddingLeft = UDim.new(0, 22), PaddingRight = UDim.new(0, 20)}
    local uiPadding = Instance.new("UIPadding")

    for v188, udim in v186 do
        if v188 ~= "Parent" then
            uiPadding[v188] = udim
        end
    end

    if v186.Parent then
        uiPadding.Parent = v186.Parent
    end

    v177[1], v177[2], v177[3] = uiCorner3, uiStroke2, uiPadding
    local instance4 = new("Frame", properties4, v177)
    local properties5 = {Name = "Stripe", BorderSizePixel = 0, BackgroundColor3 = colors.Accent, Position = UDim2.new(0, -22, 0, 0), Size = UDim2.new(0, 5, 1, 0), Parent = instance4}
    local v192 = {}
    local v193 = {CornerRadius = UDim.new(0, 3)}
    local uiCorner4 = Instance.new("UICorner")

    for v195, udim in v193 do
        if v195 ~= "Parent" then
            uiCorner4[v195] = udim
        end
    end

    if v193.Parent then
        uiCorner4.Parent = v193.Parent
    end

    v192[1] = uiCorner4
    local tagStripe = new("Frame", properties5, v192)
    local v198 = {Name = "Label", Text = "PLAY OF THE GAME", TextSize = 15, FontFace = v24.Title, TextColor3 = colors.Accent, Position = UDim2.fromOffset(0, 9), Size = UDim2.fromOffset(0, 16), AutomaticSize = Enum.AutomaticSize.X, Parent = instance4, BackgroundTransparency = 1}
    v198.TextColor3 = v198.TextColor3 or colors.Text
    v198.FontFace = v198.FontFace or v24.Bold
    v198.TextXAlignment = v198.TextXAlignment or Enum.TextXAlignment.Left
    local textLabel = Instance.new("TextLabel")

    for v200, v201 in v198 do
        if v200 ~= "Parent" then
            textLabel[v200] = v201
        end
    end

    if v198.Parent then
        textLabel.Parent = v198.Parent
    end

    local v202 = {Name = "PlayerName", Text = "", AutoLocalize = false, TextSize = 30, FontFace = v24.Display, Position = UDim2.fromOffset(0, 26), Size = UDim2.fromOffset(0, 30), AutomaticSize = Enum.AutomaticSize.X, Parent = instance4, BackgroundTransparency = 1}
    v202.TextColor3 = v202.TextColor3 or colors.Text
    v202.FontFace = v202.FontFace or v24.Bold
    v202.TextXAlignment = v202.TextXAlignment or Enum.TextXAlignment.Left
    local tagName = Instance.new("TextLabel")

    for v204, v205 in v202 do
        if v204 ~= "Parent" then
            tagName[v204] = v205
        end
    end

    if v202.Parent then
        tagName.Parent = v202.Parent
    end

    local v206 = {Name = "Title", Text = "", AutoLocalize = false, TextSize = 14, FontFace = v24.Bold, TextColor3 = colors.TextDim, Position = UDim2.fromOffset(0, 55), Size = UDim2.fromOffset(0, 14), AutomaticSize = Enum.AutomaticSize.X, Parent = instance4, BackgroundTransparency = 1}
    v206.TextColor3 = v206.TextColor3 or colors.Text
    v206.FontFace = v206.FontFace or v24.Bold
    v206.TextXAlignment = v206.TextXAlignment or Enum.TextXAlignment.Left
    local tagTitle = Instance.new("TextLabel")

    for v208, v209 in v206 do
        if v208 ~= "Parent" then
            tagTitle[v208] = v209
        end
    end

    if v206.Parent then
        tagTitle.Parent = v206.Parent
    end

    local properties6 = {Name = "Skip", BackgroundTransparency = 0.12, AutoButtonColor = true, Text = "SKIP  ›", Visible = true, TextSize = 22, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -28, 1, -26), Size = UDim2.fromOffset(128, 52), BackgroundColor3 = colors.Panel, FontFace = v24.Display, TextColor3 = colors.Text, Parent = frame5}
    local v211 = {}
    local v212 = {CornerRadius = UDim.new(0, 10)}
    local uiCorner5 = Instance.new("UICorner")

    for v214, udim in v212 do
        if v214 ~= "Parent" then
            uiCorner5[v214] = udim
        end
    end

    if v212.Parent then
        uiCorner5.Parent = v212.Parent
    end

    local v216 = {Transparency = 0.8, Thickness = 1, Color = colors.Text, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}
    local uiStroke3 = Instance.new("UIStroke")

    for v218, v219 in v216 do
        if v218 ~= "Parent" then
            uiStroke3[v218] = v219
        end
    end

    if v216.Parent then
        uiStroke3.Parent = v216.Parent
    end

    v211[1], v211[2] = uiCorner5, uiStroke3
    local skip = new("TextButton", properties6, v211)
    local v221 = {Name = "Pop", BackgroundTransparency = 1, Visible = false, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.22), Size = UDim2.fromOffset(900, 90), Parent = frame5}
    local frame7 = Instance.new("Frame")

    for v223, v224 in v221 do
        if v223 ~= "Parent" then
            frame7[v223] = v224
        end
    end

    if v221.Parent then
        frame7.Parent = v221.Parent
    end

    local v225 = {Name = "Top", Text = "ELIMINATED", TextSize = 22, TextStrokeTransparency = 0.7, FontFace = v24.Title, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 26), Parent = frame7, BackgroundTransparency = 1}
    v225.TextColor3 = v225.TextColor3 or colors.Text
    v225.FontFace = v225.FontFace or v24.Bold
    v225.TextXAlignment = v225.TextXAlignment or Enum.TextXAlignment.Left
    local popTop = Instance.new("TextLabel")

    for v227, v228 in v225 do
        if v227 ~= "Parent" then
            popTop[v227] = v228
        end
    end

    if v225.Parent then
        popTop.Parent = v225.Parent
    end

    local v229 = {Name = "Name", Text = "", AutoLocalize = false, TextSize = 44, TextStrokeTransparency = 0.6, FontFace = v24.Display, TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.fromOffset(0, 26), Size = UDim2.new(1, 0, 0, 50), Parent = frame7, BackgroundTransparency = 1}
    v229.TextColor3 = v229.TextColor3 or colors.Text
    v229.FontFace = v229.FontFace or v24.Bold
    v229.TextXAlignment = v229.TextXAlignment or Enum.TextXAlignment.Left
    local popName = Instance.new("TextLabel")

    for v231, v232 in v229 do
        if v231 ~= "Parent" then
            popName[v231] = v232
        end
    end

    if v229.Parent then
        popName.Parent = v229.Parent
    end

    screenGui.Parent = playerGui
    screenGui2.Parent = playerGui
    screenGui3.Parent = playerGui

    return {
        gui = screenGui,
        hud = screenGui2,
        frame = screenGui3,
        cover = frame,
        card = frame3,
        cardScale = cardScale,
        cardLabel = cardLabel,
        cardBar = cardBar,
        cardName = cardName,
        cardTitle = cardTitle,
        cardStripe = cardStripe,
        portrait = instance2,
        portraitScale = portraitScale,
        corners = corners,
        cornerLines = cornerLines,
        rec = instance,
        recDot = recDot,
        recText = recText,
        hudCanvas = frame5,
        hudScale = hudScale,
        tag = instance4,
        tagName = tagName,
        tagTitle = tagTitle,
        tagStripe = tagStripe,
        skip = skip,
        pop = frame7,
        popTop = popTop,
        popName = popName
    }
end

local function get()
    --[[
      name: get
      line: 543
      upvalues:
        v57 (ref,  index: 1)
        build (copy, index: 2)
    ]]
    v57 = v57 or build()
    return v57
end

local v234 = {inX = 24, inY = 20, arm = 40, stroke = 3, recX = 35, recY = 48}

local function cornerPos(key, a237)
    --[[
      name: cornerPos
      line: 554
      upvalues:
        v60 (copy, index: 1)
        v234 (copy, index: 2)
    ]]
    local v238
    local vector2 = v60[key]
    local newUDim2 = UDim2.new
    local x = vector2.X

    if vector2.X ~= 0 then
        v238 = -1
    else
        v238 = 1
    end

    local v242 = v238 * v234.inX * a237
    local y = vector2.Y
    local v244 = vector2.Y ~= 0 and -1 or 1

    return newUDim2(x, v242, y, (v244 * v234.inY) * a237)
end

local function recPos(a246)
    --[[
      name: recPos
      line: 559
      upvalues:
        v234 (copy, index: 1)
    ]]
    return UDim2.new(1, -(v234.inX * a246 + v234.recX), 0, v234.inY * a246 + v234.recY)
end

local function round(a248)
    --[[
      name: round
      line: 564
    ]]
    return (math.floor(a248 + 0.5))
end

local function applyScale(a250)
    --[[
      name: applyScale
      line: 568
      upvalues:
        workspace (copy, index: 1)
        v234 (copy, index: 2)
    ]]
    local vector2 = if const camera = workspace.CurrentCamera then camera.ViewportSize else Vector2.new(1600, 900)
    local y = vector2.Y
    local scale = if y < 560 then math.clamp(y / 620, 0.5, 1) else math.clamp(y / 900, 0.6, 1.4)
    a250.cardScale.Scale = scale
    a250.hudScale.Scale = scale
    a250.hudCanvas.Size = UDim2.fromScale(1 / scale, 1 / scale)
    v234.inX = math.floor(math.clamp(vector2.X * 0.0225, 12, 44) + 0.5)
    v234.inY = math.floor(math.clamp(vector2.Y * 0.03, 10, 30) + 0.5)
    v234.arm = math.floor((scale * 50) + 0.5)
    v234.stroke = math.max(2, (math.floor((scale * 4) + 0.5)))

    for v255, corner in a250.corners do
        corner.Size = UDim2.fromOffset(v234.arm, v234.arm)
        a250.cornerLines[(v255 * 2) - 1].Size = UDim2.new(1, 0, 0, v234.stroke)
        a250.cornerLines[v255 * 2].Size = UDim2.new(0, v234.stroke, 1, 0)
    end

    local flooredValue = math.floor((scale * 34) + 0.5)
    a250.recDot.Size = UDim2.fromOffset(flooredValue, flooredValue)
    a250.recText.TextSize = math.floor((scale * 40) + 0.5)
    a250.recText.Size = UDim2.fromOffset(0, flooredValue)
    a250.rec.Size = UDim2.fromOffset(0, flooredValue)

    if const uiListLayout = a250.rec:FindFirstChildOfClass("UIListLayout") then
        uiListLayout.Padding = UDim.new(0, (math.floor((flooredValue * 0.45) + 0.5)))
    end

    v234.recX = math.floor((v234.arm * 1.2 - (flooredValue / 2)) + 0.5)
    v234.recY = math.floor((v234.arm * 1.2) + 0.5)
    local v259 = v234.arm * 0.5
    a250.tag.Position = UDim2.new(0, (v234.inX + v259) / scale, 1, -(v234.inY + v259) / scale)
    a250.skip.Position = UDim2.new(1, -(v234.inX + v259) / scale, 1, -(v234.inY + v259) / scale)
end

local function frameTo(a261, a262: number, a263: number, a264: number, out3: Enum.EasingDirection, a266)
    --[[
      name: frameTo
      line: 604
      upvalues:
        v60 (copy, index: 1)
        v234 (copy, index: 2)
        tweenService (copy, index: 3)
    ]]
    local v267

    for v268, instance in a261.corners do
        if not (0 < a264) then
            local v270
            local vector2 = v60[v268]
            local newUDim2 = UDim2.new
            local x = vector2.X

            if vector2.X == 0 then
                v270 = 1
            else
                v270 = -1
            end

            local v274 = v270 * v234.inX * a262
            local y = vector2.Y
            local v276 = vector2.Y ~= 0 and -1 or 1
            instance.Position = newUDim2(x, v274, y, (v276 * v234.inY) * a262)
        else
            local v277
            local propertyTable = {}
            local vector2 = v60[v268]
            local newUDim2 = UDim2.new
            local x = vector2.X

            if vector2.X == 0 then
                v277 = 1
            else
                v277 = -1
            end

            local v282 = v277 * v234.inX * a262
            local y = vector2.Y
            v267 = vector2.Y ~= 0 and -1 or 1
            propertyTable.Position = newUDim2(x, v282, y, (v267 * v234.inY) * a262)
            local quint = Enum.EasingStyle.Quint
            local newTweenInfo = TweenInfo.new
            local quint2 = quint or Enum.EasingStyle.Quint
            local out = out3 or Enum.EasingDirection.Out
            local tween = tweenService:Create(instance, newTweenInfo(a264, quint2, out), propertyTable)
            tween:Play()
        end
    end

    for _, instance in a261.cornerLines do
        if not (0 < a264) then
            instance.BackgroundTransparency = 1 - a263
        else
            local v291 = a264 * 0.8
            local propertyTable = {BackgroundTransparency = 1 - a263}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo = TweenInfo.new
            local easingStyle = quad or Enum.EasingStyle.Quint
            v267 = out3 or Enum.EasingDirection.Out
            local tween = tweenService:Create(instance, newTweenInfo(v291, easingStyle, v267), propertyTable)
            tween:Play()
        end
    end

    local propertyTable = {TextTransparency = 1 - a263, TextStrokeTransparency = 1 - (a263 * 0.15)}

    if not (0 < a264) then
        a261.rec.Position = UDim2.new(1, -(v234.inX * a262 + v234.recX), 0, v234.inY * a262 + v234.recY)
        a261.recDot.BackgroundTransparency = 1 - a263
        a261.recText.TextTransparency = propertyTable.TextTransparency
        a261.recText.TextStrokeTransparency = propertyTable.TextStrokeTransparency

        return
    end

    local rec = a261.rec
    local propertyTable2 = {Position = UDim2.new(1, -(v234.inX * a262 + v234.recX), 0, v234.inY * a262 + v234.recY)}
    local quint = Enum.EasingStyle.Quint
    local newTweenInfo = TweenInfo.new
    local quint3 = quint or Enum.EasingStyle.Quint
    local out = out3 or Enum.EasingDirection.Out
    tweenService:Create(rec, newTweenInfo(a264, quint3, out), propertyTable2):Play()

    local function fadeRec()
        --[[
          name: fadeRec
          line: 622
          upvalues:
            a261 (copy, index: 1)
            a264 (copy, index: 2)
            a263 (copy, index: 3)
            out3 (copy, index: 4)
            tweenService (copy, index: 5)
            propertyTable (copy, index: 6)
        ]]
        local recDot = a261.recDot
        local v306 = a264 * 0.7
        local propertyTable2 = {BackgroundTransparency = 1 - a263}
        local quad = Enum.EasingStyle.Quad
        local newTweenInfo = TweenInfo.new
        local easingStyle = quad or Enum.EasingStyle.Quint
        local out = out3 or Enum.EasingDirection.Out
        tweenService:Create(recDot, newTweenInfo(v306, easingStyle, out), propertyTable2):Play()
        local recText = a261.recText
        local v313 = a264 * 0.7
        local quad2 = Enum.EasingStyle.Quad
        newTweenInfo = TweenInfo.new
        local easingStyle2 = quad2 or Enum.EasingStyle.Quint
        local out2 = out3 or Enum.EasingDirection.Out
        tweenService:Create(recText, newTweenInfo(v313, easingStyle2, out2), propertyTable):Play()
    end

    if a266 and 0 < a266 then
        task.delay(a266, fadeRec)
        return
    end

    fadeRec()
end

local colorCorrectionEffect = nil

local function ensureGrade()
    --[[
      name: ensureGrade
      line: 641
      upvalues:
        colorCorrectionEffect (ref,  index: 1)
        propertyTable2 (copy, index: 2)
        workspace (copy, index: 3)
    ]]
    local trReplayGrade = colorCorrectionEffect
    if not trReplayGrade then
        trReplayGrade = Instance.new("ColorCorrectionEffect")
        trReplayGrade.Name = "TR_ReplayGrade"

        for v320, v321 in propertyTable2 do
            trReplayGrade[v320] = v321
        end

        colorCorrectionEffect = trReplayGrade
    end

    local camera = workspace.CurrentCamera

    if camera and trReplayGrade.Parent ~= camera then
        trReplayGrade.Parent = camera
    end

    return trReplayGrade
end

local function gradeTo(a324, a325: number?)
    --[[
      name: gradeTo
      line: 659
      upvalues:
        colorCorrectionEffect (ref,  index: 1)
        propertyTable2 (copy, index: 2)
        workspace (copy, index: 3)
        propertyTable (copy, index: 4)
        tweenService (copy, index: 5)
    ]]
    if not a324 then
        if colorCorrectionEffect then
            local colorCorrectionEffect2 = colorCorrectionEffect
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo = TweenInfo.new
            local easingStyle = quad or Enum.EasingStyle.Quint
            local tween = tweenService:Create(colorCorrectionEffect2, newTweenInfo(a325, easingStyle, Enum.EasingDirection.Out), propertyTable2)
            tween:Play()
        end

        return
    end

    local trReplayGrade = colorCorrectionEffect
    if not trReplayGrade then
        trReplayGrade = Instance.new("ColorCorrectionEffect")
        trReplayGrade.Name = "TR_ReplayGrade"

        for v332, v333 in propertyTable2 do
            trReplayGrade[v332] = v333
        end

        colorCorrectionEffect = trReplayGrade
    end

    local camera = workspace.CurrentCamera

    if camera and trReplayGrade.Parent ~= camera then
        trReplayGrade.Parent = camera
    end

    local quad = Enum.EasingStyle.Quad
    local newTweenInfo = TweenInfo.new
    local easingStyle = quad or Enum.EasingStyle.Quint
    tweenService:Create(trReplayGrade, newTweenInfo(a325, easingStyle, Enum.EasingDirection.Out), propertyTable):Play()
end

local function gradeClear()
    --[[
      name: gradeClear
      line: 667
      upvalues:
        colorCorrectionEffect (ref, index: 1)
    ]]
    if colorCorrectionEffect then
        colorCorrectionEffect:Destroy()
        colorCorrectionEffect = nil
    end
end

local function setPortrait(portrait, a341)
    --[[
      name: setPortrait
      line: 676
      upvalues:
        setPortrait (copy, index: 1)
    ]]
    for _, child in portrait.portrait:GetChildren() do
        if child:IsA("WorldModel") or child:IsA("Camera") then
            child:Destroy()
        end
    end

    if not a341 then
        return
    end

    local head = a341:FindFirstChild("Head")

    if head
        and head:IsA("BasePart")
        and not pcall(
            function()
                --[[
                  line: 689
                  upvalues:
                    a341 (copy, index: 1)
                    portrait (copy, index: 2)
                ]]
                local vector3
                local parent = Instance.new("WorldModel")
                local v347 = a341:Clone()

                for _, descendant in v347:GetDescendants() do
                    if descendant:IsA("Tool") or descendant:IsA("Highlight") then
                        descendant:Destroy()
                    end
                end

                local v350 = v347:FindFirstChild("HumanoidRootPart")

                if v350 and v350:IsA("BasePart") then
                    v347.PrimaryPart = v350
                end

                v347:PivotTo(CFrame.new(0, 0, 0))
                v347.Parent = parent
                parent.Parent = portrait.portrait
                v350 = v347:FindFirstChild("Head")
                local position = v350.Position
                local lookVector = v350.CFrame.LookVector
                local vector32 = Vector3.new(lookVector.X, 0, lookVector.Z)

                if not (0.2 < vector32.Magnitude) then
                    vector3 = Vector3.new(0, 0, -1)
                else
                    vector3 = vector32.Unit
                end

                local vector33 = vector3:Cross(Vector3.new(0, 1, 0))
                local currentCamera = Instance.new("Camera")
                currentCamera.FieldOfView = 30
                currentCamera.CFrame = CFrame.lookAt(((position + (vector3 * 4)) + (vector33 * 0.9)) + Vector3.new(0, 0.30000001192092896, 0), position + Vector3.new(0, -0.25, 0))
                currentCamera.Parent = portrait.portrait
                portrait.portrait.CurrentCamera = currentCamera
            end
        )
    then
        setPortrait(portrait, nil)
    end
end

local v356 = nil
local inputBeganConnection = nil
local count = 0

function v7.ShowIntro(a359)
    --[[
      name: ShowIntro
      line: 732
      upvalues:
        v57 (ref,  index: 1)
        build (copy, index: 2)
        applyScale (copy, index: 3)
        textService (copy, index: 4)
        locTitle (copy, index: 5)
        colors (copy, index: 6)
        setPortrait (copy, index: 7)
        playUI (copy, index: 8)
        tweenService (copy, index: 9)
    ]]
    local v360
    local textSize
    local v362
    local v363
    v57 = v57 or build()
    local portrait = v57
    applyScale(portrait)
    portrait.gui.Enabled = true
    portrait.hud.Enabled = false
    portrait.cover.Visible = true
    portrait.cover.BackgroundTransparency = 0
    portrait.card.Visible = true
    portrait.frame.Enabled = false
    local string2 = string.upper(a359.name)
    local fontSize = 104
    local success, v368 = pcall(
        function()
            --[[
              line: 188
              upvalues:
                textService (copy, index: 1)
                string2 (copy, index: 2)
                fontSize (copy, index: 3)
            ]]
            return textService:GetTextSize(string2, fontSize, Enum.Font.BuilderSansExtraBold, Vector2.new(4000, 400))
        end
    )

    if success then
        v360 = v368.X * 1.06
    else
        v360 = #string2 * fontSize * 0.62
    end

    if not (940 < v360) then
        textSize = fontSize
    else
        local fontSize2 = math.max(48, (math.floor((fontSize * 940) / v360)))
        local success2, textSize2 = pcall(
            function()
                --[[
                  line: 188
                  upvalues:
                    textService (copy, index: 1)
                    string2 (copy, index: 2)
                    fontSize2 (copy, index: 3)
                ]]
                return textService:GetTextSize(string2, fontSize2, Enum.Font.BuilderSansExtraBold, Vector2.new(4000, 400))
            end
        )

        if success2 then
            v360 = textSize2.X * 1.06
            textSize = fontSize2
        else
            v360 = #string2 * fontSize2 * 0.62
            textSize = fontSize2
        end
    end

    local string3 = locTitle(a359.title)
    portrait.cardName.TextSize = textSize
    portrait.cardName.Text = string2
    portrait.cardTitle.Text = string3
    local card = portrait.card
    v368 = UDim2.fromOffset
    local fontSize3 = 30
    local success3, textSize3 = pcall(
        function()
            --[[
              line: 188
              upvalues:
                textService (copy, index: 1)
                string3 (copy, index: 2)
                fontSize3 (copy, index: 3)
            ]]
            return textService:GetTextSize(string3, fontSize3, Enum.Font.BuilderSansExtraBold, Vector2.new(4000, 400))
        end
    )

    if success3 then
        v362 = textSize3.X * 1.06
    else
        v362 = #string3 * 30 * 0.62
    end

    card.Size = v368(math.max(v360, v362 * 0.85, 440) + 222, 260)
    local cardStripe = portrait.cardStripe

    if a359.ally then
        v363 = colors.Ally
    else
        v363 = colors.Enemy
    end

    cardStripe.BackgroundColor3 = v363
    setPortrait(portrait, a359.portrait)
    portrait.cardLabel.TextTransparency = 1
    portrait.cardLabel.Position = UDim2.fromOffset(166, 8)
    portrait.cardBar.Size = UDim2.fromOffset(0, 5)
    portrait.cardName.TextTransparency = 1
    portrait.cardName.Position = UDim2.fromOffset(222, 84)
    portrait.cardTitle.TextTransparency = 1
    portrait.cardStripe.Size = UDim2.fromOffset(6, 0)
    portrait.portrait.ImageTransparency = 1
    portrait.portrait.BackgroundTransparency = 1
    portrait.portraitScale.Scale = 0.82

    if const uiStroke = portrait.portrait:FindFirstChildOfClass("UIStroke") then
        uiStroke.Transparency = 0.82
    end

    task.delay(
        0.05,
        function()
            --[[
              line: 771
              upvalues:
                playUI (copy, index: 1)
                portrait (copy, index: 2)
                tweenService (copy, index: 3)
            ]]
            playUI("UI/Whoosh")
            local cardLabel = portrait.cardLabel
            local propertyTable = {TextTransparency = 0, Position = UDim2.fromOffset(196, 8)}
            tweenService:Create(cardLabel, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable):Play()
            local cardBar = portrait.cardBar
            local propertyTable2 = {Size = UDim2.fromOffset(150, 5)}
            tweenService:Create(cardBar, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable2):Play()
        end
    )

    task.delay(
        0.18,
        function()
            --[[
              line: 776
              upvalues:
                portrait (copy, index: 1)
                tweenService (copy, index: 2)
            ]]
            local propertyTable = {ImageTransparency = 0, BackgroundTransparency = 0}
            tweenService:Create(portrait.portrait, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable):Play()
            local portraitScale = portrait.portraitScale
            local propertyTable2 = {Scale = 1}
            local back = Enum.EasingStyle.Back
            local newTweenInfo = TweenInfo.new
            local easingStyle = back or Enum.EasingStyle.Quint
            tweenService:Create(portraitScale, newTweenInfo(0.4, easingStyle, Enum.EasingDirection.Out), propertyTable2):Play()
            local cardStripe = portrait.cardStripe
            local propertyTable3 = {Size = UDim2.fromOffset(6, 104)}
            tweenService:Create(cardStripe, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable3):Play()
        end
    )

    task.delay(
        0.26,
        function()
            --[[
              line: 781
              upvalues:
                portrait (copy, index: 1)
                tweenService (copy, index: 2)
            ]]
            local cardName = portrait.cardName
            local propertyTable = {TextTransparency = 0, Position = UDim2.fromOffset(222, 60)}
            tweenService:Create(cardName, TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable):Play()
        end
    )

    task.delay(
        0.5,
        function()
            --[[
              line: 784
              upvalues:
                portrait (copy, index: 1)
                tweenService (copy, index: 2)
            ]]
            local propertyTable = {TextTransparency = 0}
            tweenService:Create(portrait.cardTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable):Play()
        end
    )

    portrait.tagName.Text = string.upper(a359.name)
    portrait.tagTitle.Text = string3
    portrait.tagStripe.BackgroundColor3 = if a359.ally then colors.Ally else colors.Enemy
end

function v7.Reveal()
    --[[
      name: Reveal
      line: 794
      upvalues:
        v57 (ref,  index: 1)
        build (copy, index: 2)
        applyScale (copy, index: 3)
        v60 (copy, index: 4)
        v234 (copy, index: 5)
        frameTo (copy, index: 6)
        colorCorrectionEffect (ref,  index: 7)
        propertyTable2 (copy, index: 8)
        workspace (copy, index: 9)
        propertyTable (copy, index: 10)
        tweenService (copy, index: 11)
        playUI (copy, index: 12)
    ]]
    v57 = v57 or build()
    local v394 = v57
    applyScale(v394)
    v394.frame.Enabled = true
    local _ = Enum.EasingDirection.Out

    for v396, corner in v394.corners do
        local v398
        local vector2 = v60[v396]
        local newUDim2 = UDim2.new
        local x = vector2.X

        if vector2.X == 0 then
            v398 = 1
        else
            v398 = -1
        end

        local v402 = v398 * v234.inX * 0
        local y = vector2.Y
        local v404 = vector2.Y ~= 0 and -1 or 1
        corner.Position = newUDim2(x, v402, y, (v404 * v234.inY) * 0)
    end

    for _, cornerLine in v394.cornerLines do
        cornerLine.BackgroundTransparency = 1
    end

    local v407 = {TextTransparency = 1, TextStrokeTransparency = 1}
    v394.rec.Position = UDim2.new(1, -(v234.inX * 0 + v234.recX), 0, v234.inY * 0 + v234.recY)
    v394.recDot.BackgroundTransparency = 1
    v394.recText.TextTransparency = v407.TextTransparency
    v394.recText.TextStrokeTransparency = v407.TextStrokeTransparency
    frameTo(v394, 1, 1, 0.4, Enum.EasingDirection.Out, 0.08)
    local trReplayGrade = colorCorrectionEffect
    if not trReplayGrade then
        trReplayGrade = Instance.new("ColorCorrectionEffect")
        trReplayGrade.Name = "TR_ReplayGrade"

        for v409, v410 in propertyTable2 do
            trReplayGrade[v409] = v410
        end

        colorCorrectionEffect = trReplayGrade
    end

    local camera = workspace.CurrentCamera

    if camera and trReplayGrade.Parent ~= camera then
        trReplayGrade.Parent = camera
    end

    local quad = Enum.EasingStyle.Quad
    local newTweenInfo = TweenInfo.new
    local easingStyle = quad or Enum.EasingStyle.Quint
    tweenService:Create(trReplayGrade, newTweenInfo(0.4, easingStyle, Enum.EasingDirection.Out), propertyTable):Play()
    local card = v394.card
    local propertyTable3 = {Position = UDim2.new(0.5, -60, 0.5, 0)}
    local quad2 = Enum.EasingStyle.Quad
    local inValue = Enum.EasingDirection.In
    local newTweenInfo2 = TweenInfo.new
    local easingStyle2 = quad2 or Enum.EasingStyle.Quint
    local easingDirection = inValue or Enum.EasingDirection.Out
    tweenService:Create(card, newTweenInfo2(0.3, easingStyle2, easingDirection), propertyTable3):Play()

    for _, instance in {v394.cardLabel, v394.cardName, v394.cardTitle} do
        local propertyTable4 = {TextTransparency = 1}
        local tween = tweenService:Create(instance, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable4)
        tween:Play()
    end

    local propertyTable5 = {ImageTransparency = 1, BackgroundTransparency = 1}
    tweenService:Create(v394.portrait, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable5):Play()

    if const uiStroke = v394.portrait:FindFirstChildOfClass("UIStroke") then
        local propertyTable6 = {Transparency = 1}
        tweenService:Create(uiStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable6):Play()
    end

    local propertyTable7 = {BackgroundTransparency = 1}
    tweenService:Create(v394.cardBar, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable7):Play()
    local propertyTable8 = {BackgroundTransparency = 1}
    tweenService:Create(v394.cardStripe, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable8):Play()
    local cover = v394.cover
    local propertyTable9 = {BackgroundTransparency = 1}
    local quad3 = Enum.EasingStyle.Quad
    local newTweenInfo3 = TweenInfo.new
    local easingStyle3 = quad3 or Enum.EasingStyle.Quint
    tweenService:Create(cover, newTweenInfo3(0.45, easingStyle3, Enum.EasingDirection.Out), propertyTable9):Play()
    playUI("UI/Whoosh")

    task.delay(
        0.46,
        function()
            --[[
              line: 814
              upvalues:
                v394 (copy, index: 1)
            ]]
            if 0.99 <= v394.cover.BackgroundTransparency then
                v394.card.Visible = false
                v394.card.Position = UDim2.fromScale(0.5, 0.5)
                v394.cardBar.BackgroundTransparency = 0
                v394.cardStripe.BackgroundTransparency = 0
            end
        end
    )

    v394.hud.Enabled = true
    v394.tag.BackgroundTransparency = 1
    local propertyTable10 = {BackgroundTransparency = 0.12}
    tweenService:Create(v394.tag, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable10):Play()
end

function v7.Kill(text: string, a438, a439)
    --[[
      name: Kill
      line: 828
      upvalues:
        v57 (ref,  index: 1)
        build (copy, index: 2)
        count (ref,  index: 3)
        colors (copy, index: 4)
        Loc (copy, index: 5)
        tweenService (copy, index: 6)
    ]]
    v57 = v57 or build()
    local v440 = v57
    count += 1
    local v441 = count
    local text2 = 3 <= a438 and "TRIPLE ELIMINATION" or a438 ~= 2 and "ELIMINATED" or "DOUBLE ELIMINATION"
    v440.popTop.Text = text2
    v440.popTop.TextColor3 = if 2 <= a438 then colors.Gold else colors.TextDim
    local popName = v440.popName
    local uppercaseText = string.upper(text)
    local v445 = not a439 and "" or "  ·  " .. Loc.T("HEADSHOT")
    popName.Text = uppercaseText .. v445
    v440.pop.Visible = true
    v440.pop.Position = UDim2.new(0.5, 0, 0.22, 14)
    v440.popTop.TextTransparency = 1
    v440.popName.TextTransparency = 1
    local pop = v440.pop
    local propertyTable = {Position = UDim2.fromScale(0.5, 0.22)}
    tweenService:Create(pop, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable):Play()
    local propertyTable2 = {TextTransparency = 0}
    tweenService:Create(v440.popTop, TweenInfo.new(0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable2):Play()
    local propertyTable3 = {TextTransparency = 0}
    tweenService:Create(v440.popName, TweenInfo.new(0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable3):Play()

    task.delay(
        1.5,
        function()
            --[[
              line: 843
              upvalues:
                v441 (copy, index: 1)
                count (ref,  index: 2)
                v440 (copy, index: 3)
                tweenService (copy, index: 4)
            ]]
            if v441 ~= count then
                return
            end

            local propertyTable = {TextTransparency = 1}
            tweenService:Create(v440.popTop, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable):Play()
            local propertyTable2 = {TextTransparency = 1}
            tweenService:Create(v440.popName, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable2):Play()

            task.delay(
                0.32,
                function()
                    --[[
                      line: 849
                      upvalues:
                        v441 (copy, index: 1)
                        count (ref,  index: 2)
                        v440 (copy, index: 3)
                    ]]
                    if v441 == count then
                        v440.pop.Visible = false
                    end
                end
            )
        end
    )
end

function v7.Outro(a452, a453)
    --[[
      name: Outro
      line: 859
      upvalues:
        v57 (ref,  index: 1)
        build (copy, index: 2)
        frameTo (copy, index: 3)
        colorCorrectionEffect (ref,  index: 4)
        propertyTable2 (copy, index: 5)
        tweenService (copy, index: 6)
    ]]
    v57 = v57 or build()
    local v454 = v57
    local v455 = math.max(0.15, a453 * 0.45)
    v454.cover.Visible = true
    v454.card.Visible = false
    frameTo(v454, 0, 0, v455, Enum.EasingDirection.Out)

    if colorCorrectionEffect then
        local colorCorrectionEffect2 = colorCorrectionEffect
        local quad = Enum.EasingStyle.Quad
        local newTweenInfo = TweenInfo.new
        local easingStyle = quad or Enum.EasingStyle.Quint
        local tween = tweenService:Create(colorCorrectionEffect2, newTweenInfo(v455, easingStyle, Enum.EasingDirection.Out), propertyTable2)
        tween:Play()
    end

    local cover = v454.cover
    local propertyTable = {BackgroundTransparency = 0}
    local quad = Enum.EasingStyle.Quad
    local inValue = Enum.EasingDirection.In
    local newTweenInfo = TweenInfo.new
    local easingStyle = quad or Enum.EasingStyle.Quint
    local easingDirection = inValue or Enum.EasingDirection.Out
    tweenService:Create(cover, newTweenInfo(v455, easingStyle, easingDirection), propertyTable):Play()

    task.delay(
        v455 + 0.02,
        function()
            --[[
              line: 868
              upvalues:
                v454 (copy, index: 1)
                colorCorrectionEffect (ref,  index: 2)
                a452 (copy, index: 3)
                a453 (copy, index: 4)
                v455 (copy, index: 5)
                tweenService (copy, index: 6)
            ]]
            v454.hud.Enabled = false
            v454.frame.Enabled = false

            if colorCorrectionEffect then
                colorCorrectionEffect:Destroy()
                colorCorrectionEffect = nil
            end

            pcall(a452)
            local cover = v454.cover
            local v469 = math.max(0.15, a453 - v455)
            local propertyTable = {BackgroundTransparency = 1}
            local quad = Enum.EasingStyle.Quad
            local newTweenInfo = TweenInfo.new
            local easingStyle = quad or Enum.EasingStyle.Quint
            tweenService:Create(cover, newTweenInfo(v469, easingStyle, Enum.EasingDirection.Out), propertyTable):Play()

            task.delay(
                math.max(0.15, a453 - v455) + 0.02,
                function()
                    --[[
                      line: 874
                      upvalues:
                        v454 (copy, index: 1)
                    ]]
                    if 0.99 <= v454.cover.BackgroundTransparency then
                        v454.gui.Enabled = false
                    end
                end
            )
        end
    )
end

function v7.Hide()
    --[[
      name: Hide
      line: 883
      upvalues:
        v57 (ref,  index: 1)
        colorCorrectionEffect (ref,  index: 2)
        setPortrait (copy, index: 3)
    ]]
    local portrait = v57
    if not portrait then
        return
    end

    portrait.gui.Enabled = false
    portrait.hud.Enabled = false
    portrait.frame.Enabled = false

    if colorCorrectionEffect then
        colorCorrectionEffect:Destroy()
        colorCorrectionEffect = nil
    end

    portrait.pop.Visible = false
    setPortrait(portrait, nil)
end

function v7.BindSkip(callback)
    --[[
      name: BindSkip
      line: 898
      upvalues:
        v7 (copy, index: 1)
        v57 (ref,  index: 2)
        build (copy, index: 3)
        v356 (ref,  index: 4)
        inputBeganConnection (ref,  index: 5)
        userInputService (copy, index: 6)
    ]]
    v7.UnbindSkip()
    v57 = v57 or build()
    local v476 = v57
    local v477 = os.clock() + 0.5

    v356 = v476.skip.Activated:Connect(
        function()
            --[[
              line: 902
              upvalues:
                v477 (copy, index: 1)
                callback (copy, index: 2)
            ]]
            if v477 <= os.clock() then
                callback()
            end
        end
    )

    inputBeganConnection = userInputService.InputBegan:Connect(
        function(input: InputObject, gameProcessedEvent: boolean)
            --[[
              line: 907
              upvalues:
                v477 (copy, index: 1)
                userInputService (copy, index: 2)
                callback (copy, index: 3)
            ]]
            if not (os.clock() < v477)
                and not userInputService:GetFocusedTextBox()
                and input.KeyCode == Enum.KeyCode.ButtonB
                and not gameProcessedEvent
            then
                callback()
            end
        end
    )
end

function v7.UnbindSkip()
    --[[
      name: UnbindSkip
      line: 917
      upvalues:
        v356 (ref, index: 1)
        inputBeganConnection (ref, index: 2)
    ]]
    if v356 then
        v356:Disconnect()
        v356 = nil
    end

    if inputBeganConnection then
        inputBeganConnection:Disconnect()
        inputBeganConnection = nil
    end
end

function v7.DebugFrame(a480)
    --[[
      name: DebugFrame
      line: 930
      upvalues:
        v57 (ref,  index: 1)
        build (copy, index: 2)
        applyScale (copy, index: 3)
        v60 (copy, index: 4)
        v234 (copy, index: 5)
        colorCorrectionEffect (ref,  index: 6)
        propertyTable2 (copy, index: 7)
        workspace (copy, index: 8)
        propertyTable (copy, index: 9)
    ]]
    v57 = v57 or build()
    local v481 = v57
    local alpha = math.clamp((a480 or 1), 0, 1)
    applyScale(v481)
    v481.frame.Enabled = true
    local _ = Enum.EasingDirection.Out

    for v484, corner in v481.corners do
        local v486
        local vector2 = v60[v484]
        local newUDim2 = UDim2.new
        local x = vector2.X

        if vector2.X == 0 then
            v486 = 1
        else
            v486 = -1
        end

        local v490 = v486 * v234.inX * alpha
        local y = vector2.Y
        local v492 = vector2.Y ~= 0 and -1 or 1
        corner.Position = newUDim2(x, v490, y, (v492 * v234.inY) * alpha)
    end

    for _, cornerLine in v481.cornerLines do
        cornerLine.BackgroundTransparency = 1 - alpha
    end

    local v495 = {TextTransparency = 1 - alpha, TextStrokeTransparency = 1 - (alpha * 0.15)}
    v481.rec.Position = UDim2.new(1, -(v234.inX * alpha + v234.recX), 0, v234.inY * alpha + v234.recY)
    v481.recDot.BackgroundTransparency = 1 - alpha
    v481.recText.TextTransparency = v495.TextTransparency
    v481.recText.TextStrokeTransparency = v495.TextStrokeTransparency
    local trReplayGrade = colorCorrectionEffect
    if not trReplayGrade then
        trReplayGrade = Instance.new("ColorCorrectionEffect")
        trReplayGrade.Name = "TR_ReplayGrade"

        for v497, v498 in propertyTable2 do
            trReplayGrade[v497] = v498
        end

        colorCorrectionEffect = trReplayGrade
    end

    local camera = workspace.CurrentCamera

    if camera and trReplayGrade.Parent ~= camera then
        trReplayGrade.Parent = camera
    end

    trReplayGrade.TintColor = propertyTable2.TintColor:Lerp(propertyTable.TintColor, alpha)
    trReplayGrade.Saturation = propertyTable.Saturation * alpha
    trReplayGrade.Contrast = propertyTable.Contrast * alpha

    return {k = alpha, inX = v234.inX, inY = v234.inY, arm = v234.arm, stroke = v234.stroke, recX = v234.recX, recY = v234.recY, abs = v481.frame.AbsoluteSize}
end

function v7.Gui()
    --[[
      name: Gui
      line: 943
      upvalues:
        v57 (ref, index: 1)
    ]]
    if v57 then
        return v57.gui
    end

    return nil
end

function v7.HudGui()
    --[[
      name: HudGui
      line: 947
      upvalues:
        v57 (ref, index: 1)
    ]]
    if v57 then
        return v57.hud
    end

    return nil
end

return v7