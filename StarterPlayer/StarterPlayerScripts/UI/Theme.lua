local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local tbl_1 = {}
local fromRGB_1 = Color3.fromRGB
local v1 = fromRGB_1(70, 170, 255)
local v2 = fromRGB_1(255, 72, 72)
local Shared_1 = ReplicatedStorage_1:FindFirstChild("Shared")
local v3 = Shared_1 and (Shared_1:FindFirstChild("Config"))
if v3 then
    local v4 = v3:IsA("ModuleScript")
    if v4 then
        local success_1, v5 = pcall(require, v3)
        if success_1 and type(v5) == "table" then
            if typeof(v5.ALLY_COLOR) == "Color3" then
                v1 = v5.ALLY_COLOR
            end
            if typeof(v5.ENEMY_COLOR) == "Color3" then
                v2 = v5.ENEMY_COLOR
            end
        end
    end
end
tbl_1.Colors = {
    Void = fromRGB_1(6, 7, 10),
    Bg = fromRGB_1(12, 13, 17),
    Panel = fromRGB_1(18, 20, 26),
    PanelHi = fromRGB_1(28, 31, 39),
    PanelLo = fromRGB_1(14, 15, 20),
    Raised = fromRGB_1(36, 40, 50),
    Inset = fromRGB_1(10, 11, 15),
    Stroke = fromRGB_1(255, 255, 255),
    StrokeSoft = fromRGB_1(64, 70, 84),
    Divider = fromRGB_1(52, 57, 70),
    Text = fromRGB_1(255, 255, 255),
    TextDim = fromRGB_1(186, 192, 206),
    TextMuted = fromRGB_1(124, 131, 148),
    TextDark = fromRGB_1(10, 12, 18),
    Accent = fromRGB_1(40, 150, 255),
    AccentDark = fromRGB_1(18, 96, 214),
    AccentDeep = fromRGB_1(10, 50, 120),
    Success = fromRGB_1(64, 214, 110),
    SuccessDark = fromRGB_1(28, 150, 70),
    Danger = fromRGB_1(245, 64, 72),
    DangerDark = fromRGB_1(170, 26, 38),
    Warning = fromRGB_1(255, 176, 40),
    Bone = fromRGB_1(228, 232, 240),
    Ally = v1,
    AllyDark = v1:Lerp(fromRGB_1(0, 0, 0), 0.5),
    Enemy = v2,
    EnemyDark = v2:Lerp(fromRGB_1(0, 0, 0), 0.5),
    Health = fromRGB_1(96, 222, 110),
    HealthLow = fromRGB_1(245, 64, 72),
    HealthTrail = fromRGB_1(255, 214, 140),
    Armor = fromRGB_1(150, 200, 255),
    Shell = fromRGB_1(255, 176, 120),
    Xp = fromRGB_1(40, 150, 255),
    Gold = fromRGB_1(255, 200, 60),
    White = fromRGB_1(255, 255, 255),
    Black = fromRGB_1(0, 0, 0)
}
tbl_1.Fonts = {
    Display = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy),
    Title = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold),
    Heavy = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold),
    Bold = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold),
    SemiBold = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold),
    Medium = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium)
}
tbl_1.Radius = {Small = UDim.new(0, 6), Medium = UDim.new(0, 10), Large = UDim.new(0, 12), Pill = UDim.new(1, 0)}
tbl_1.Tween = {
    Instant = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Fast = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Smooth = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Slow = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    Pop = TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    PopSmall = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    Close = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    Slam = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0)
}
tbl_1.DesignSize = Vector2.new(1600, 900)
tbl_1.ShowCurrency = false
function tbl_1.Lighten(a1, a2)
    --[[
      name: Lighten
      line: 113
    ]]
    return a1:Lerp(Color3.new(1, 1, 1), a2)
end
function tbl_1.Darken(a1, a2)
    --[[
      name: Darken
      line: 117
    ]]
    return a1:Lerp(Color3.new(0, 0, 0), a2)
end
return tbl_1