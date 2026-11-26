local replicatedStorage = game:GetService("ReplicatedStorage")
local v2 = {}
local color3FromRGB = Color3.fromRGB
local v4 = color3FromRGB(70, 170, 255)
local v5 = color3FromRGB(255, 72, 72)
local shared = replicatedStorage:FindFirstChild("Shared")
local config = shared and shared:FindFirstChild("Config")

if config and config:IsA("ModuleScript") then
    local success, result = pcall(require, config)

    if success and type(result) == "table" then
        if typeof(result.ALLY_COLOR) == "Color3" then
            v4 = result.ALLY_COLOR
        end

        if typeof(result.ENEMY_COLOR) == "Color3" then
            v5 = result.ENEMY_COLOR
        end
    end
end

v2.Colors = {
    Void = color3FromRGB(6, 7, 10),
    Bg = color3FromRGB(12, 13, 17),
    Panel = color3FromRGB(18, 20, 26),
    PanelHi = color3FromRGB(28, 31, 39),
    PanelLo = color3FromRGB(14, 15, 20),
    Raised = color3FromRGB(36, 40, 50),
    Inset = color3FromRGB(10, 11, 15),
    Stroke = color3FromRGB(255, 255, 255),
    StrokeSoft = color3FromRGB(64, 70, 84),
    Divider = color3FromRGB(52, 57, 70),
    Text = color3FromRGB(255, 255, 255),
    TextDim = color3FromRGB(186, 192, 206),
    TextMuted = color3FromRGB(124, 131, 148),
    TextDark = color3FromRGB(10, 12, 18),
    Accent = color3FromRGB(40, 150, 255),
    AccentDark = color3FromRGB(18, 96, 214),
    AccentDeep = color3FromRGB(10, 50, 120),
    Success = color3FromRGB(64, 214, 110),
    SuccessDark = color3FromRGB(28, 150, 70),
    Danger = color3FromRGB(245, 64, 72),
    DangerDark = color3FromRGB(170, 26, 38),
    Warning = color3FromRGB(255, 176, 40),
    Bone = color3FromRGB(228, 232, 240),
    Ally = v4,
    AllyDark = v4:Lerp(color3FromRGB(0, 0, 0), 0.5),
    Enemy = v5,
    EnemyDark = v5:Lerp(color3FromRGB(0, 0, 0), 0.5),
    Health = color3FromRGB(96, 222, 110),
    HealthLow = color3FromRGB(245, 64, 72),
    HealthTrail = color3FromRGB(255, 214, 140),
    Armor = color3FromRGB(150, 200, 255),
    Xp = color3FromRGB(40, 150, 255),
    Gold = color3FromRGB(255, 200, 60),
    White = color3FromRGB(255, 255, 255),
    Black = color3FromRGB(0, 0, 0)
}
v2.Fonts = {
    Display = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy),
    Title = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold),
    Heavy = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold),
    Bold = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold),
    SemiBold = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold),
    Medium = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium)
}
v2.Radius = {Small = UDim.new(0, 6), Medium = UDim.new(0, 10), Large = UDim.new(0, 12), Pill = UDim.new(1, 0)}
v2.Tween = {
    Instant = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Fast = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Smooth = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Slow = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Pop = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    PopSmall = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    Close = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    Slam = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0)
}
v2.DesignSize = Vector2.new(1600, 900)

function v2.Lighten(startValue, alpha)
    --[[
      name: Lighten
      line: 108
    ]]
    return startValue:Lerp(Color3.new(1, 1, 1), alpha)
end

function v2.Darken(startValue, alpha)
    --[[
      name: Darken
      line: 112
    ]]
    return startValue:Lerp(Color3.new(0, 0, 0), alpha)
end

return v2