local Lighting_upv_1 = game:GetService("Lighting")
local Players_1 = game:GetService("Players")
local ReplicatedStorage_upv_1 = game:GetService("ReplicatedStorage")
local RunService_1 = game:GetService("RunService")
local TweenService_upv_1 = game:GetService("TweenService")
local Workspace_upv_1 = game:GetService("Workspace")
local Config_1 = require(ReplicatedStorage_upv_1.Shared.Config)
require(ReplicatedStorage_upv_1.Shared:WaitForChild("Loc")).Install()
local UIAssets_upv_1 = require(ReplicatedStorage_upv_1.Shared.UIAssets)
local Theme_1 = require(script.Parent.Parent.UI.Theme)
local UPDATE_COUNTDOWN_upv_1 = Config_1.UPDATE_COUNTDOWN
if not UPDATE_COUNTDOWN_upv_1 then
    return
end
local function emblem(a1)
    --[[
      name: emblem
      line: 43
      upvalues:
        UIAssets_upv_1 (copy, index: 1)
    ]]
    local Ranks_1 = UIAssets_upv_1.Ranks
    local v1 = (Ranks_1 and (Ranks_1[string.lower(a1.name)])) or (a1.img or "")
    return v1
end
local Sfx_upv_1 = nil
pcall(
    function()
        --[[
          line: 48
          upvalues:
            Sfx_upv_1 (ref,  index: 1)
            ReplicatedStorage_upv_1 (copy, index: 2)
        ]]
        Sfx_upv_1 = require(ReplicatedStorage_upv_1.Shared.Sfx)
    end
)
local Colors_upv_1 = Theme_1.Colors
local fromRGB_upv_1 = Color3.fromRGB
local u1 = UPDATE_COUNTDOWN_upv_1.skyHours * 3600
local u2 = UPDATE_COUNTDOWN_upv_1.goldenHours * 3600
local Gold_upv_1 = Colors_upv_1.Gold
local u3 = fromRGB_upv_1(12, 16, 30)
local v2 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local v3 = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.ExtraBold)
local LocalPlayer_upv_1 = Players_1.LocalPlayer
local CurrentCamera_1 = Workspace_upv_1.CurrentCamera
local v4 = os.clock()
while LocalPlayer_upv_1:GetAttribute("LoadingShownMs") == nil do
    if os.clock() - v4 < 30 then
        task.wait(0.2)
        continue
    else
        break
    end
end
local function shipped()
    --[[
      name: shipped
      line: 85
      upvalues:
        Workspace_upv_1 (copy, index: 1)
        UPDATE_COUNTDOWN_upv_1 (copy, index: 2)
        ReplicatedStorage_upv_1 (copy, index: 3)
    ]]
    if Workspace_upv_1:GetAttribute("CountdownPreviewShipped") == true then
        return true
    end
    local v5 = (UPDATE_COUNTDOWN_upv_1.shipped ~= nil) and (ReplicatedStorage_upv_1.Shared:FindFirstChild(UPDATE_COUNTDOWN_upv_1.shipped) ~= nil)
    return v5
end
if UPDATE_COUNTDOWN_upv_1.shipped then
    if ReplicatedStorage_upv_1.Shared:FindFirstChild(UPDATE_COUNTDOWN_upv_1.shipped) then
        if Workspace_upv_1:GetAttribute("CountdownPreview") ~= nil then
            local function inLobby()
                --[[
                  name: inLobby
                  line: 100
                  upvalues:
                    LocalPlayer_upv_1 (copy, index: 1)
                ]]
                local v6 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                return v6
            end
            local function now()
                --[[
                  name: now
                  line: 105
                  upvalues:
                    Workspace_upv_1 (copy, index: 1)
                    UPDATE_COUNTDOWN_upv_1 (copy, index: 2)
                ]]
                local v7 = Workspace_upv_1:GetServerTimeNow()
                local v8 = Workspace_upv_1:GetAttribute("CountdownPreview")
                local v9 = Workspace_upv_1:GetAttribute("CountdownPreviewAt")
                if type(v8) == "number" and type(v9) == "number" then
                    return (UPDATE_COUNTDOWN_upv_1.at - v8) + (v7 - v9)
                end
                return v7
            end
            local function play(a1)
                --[[
                  name: play
                  line: 114
                  upvalues:
                    Sfx_upv_1 (ref, index: 1)
                ]]
                if not Sfx_upv_1 then
                    return
                end
                pcall(Sfx_upv_1.PlayUI, a1)
            end
            local u4 = Instance.new("Part")
            u4.Name = "UpdateCountdownSky"
            u4.Anchored = true
            u4.CanCollide = false
            u4.CanQuery = false
            u4.CanTouch = false
            u4.CastShadow = false
            u4.Transparency = 1
            u4.Size = Vector3.new(357, 64, 0.20000000298023224)
            u4.CFrame = CFrame.lookAt(Vector3.new(0, 66, -135), Vector3.new(0, 9, 120))
            u4.Parent = Workspace_upv_1
            local u5 = Instance.new("SurfaceGui")
            u5.Name = "UpdateCountdown"
            u5.Adornee = u4
            u5.Face = Enum.NormalId.Front
            u5.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
            u5.PixelsPerStud = 3.361344537815126
            u5.LightInfluence = 0
            u5.Brightness = 1.25
            u5.MaxDistance = 2000
            u5.ResetOnSpawn = false
            u5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            local u6 = Instance.new("Frame")
            u6.Name = "Root"
            u6.BackgroundTransparency = 1
            u6.Size = UDim2.fromScale(1, 1)
            u6.Parent = u5
            local v10 = Instance.new("ImageLabel")
            v10.Name = "Plate"
            v10.BackgroundTransparency = 1
            v10.Image = "rbxassetid://90962482350826"
            v10.ImageColor3 = u3
            v10.ImageTransparency = 0.3
            v10.ScaleType = Enum.ScaleType.Stretch
            v10.AnchorPoint = Vector2.new(0.5, 0.5)
            v10.Position = UDim2.fromOffset(600, 112)
            v10.Size = UDim2.fromOffset(1240, 300)
            v10.Parent = u6
            local function text(a1, a2, a3, a4, a5, a6, a7, a8)
                --[[
                  name: text
                  line: 155
                  upvalues:
                    u6 (copy, index: 1)
                    u3 (copy, index: 2)
                    Colors_upv_1 (copy, index: 3)
                ]]
                local u7 = Instance.new("Frame")
                u7.Name = a1
                u7.BackgroundTransparency = 1
                u7.AnchorPoint = Vector2.new(0.5, 0.5)
                u7.Position = UDim2.fromOffset(a2, a3)
                u7.Size = UDim2.fromOffset(a4, a5)
                u7.Parent = a8 or u6
                local v12 = Instance.new("UIScale")
                v12.Parent = u7
                local function mk_1(a9, a10, a11, a12, a13)
                    --[[
                      name: mk
                      line: 165
                      upvalues:
                        a6 (copy, index: 1)
                        u7 (copy, index: 2)
                    ]]
                    local v13 = Instance.new("TextLabel")
                    v13.Name = a9
                    v13.BackgroundTransparency = 1
                    v13.TextScaled = true
                    v13.FontFace = a6
                    v13.TextColor3 = a11
                    v13.TextTransparency = a12
                    v13.Position = UDim2.fromOffset(0, a10)
                    v13.Size = UDim2.fromScale(1, 1)
                    v13.Text = ""
                    v13.ZIndex = a13
                    v13.Parent = u7
                    return v13
                end
                local v14 = mk_1("Shadow", a7, u3, 0.45, 1)
                local tbl_1 = {}
                tbl_1.label = mk_1("Text", 0, Colors_upv_1.White, 0, 2)
                tbl_1.shadow = v14
                tbl_1.holder = u7
                tbl_1.scale = v12
                return tbl_1
            end
            local u8 = text("Title", 600, 82, 1000, 84, v2, 4)
            u8.label.Text = UPDATE_COUNTDOWN_upv_1.title
            u8.shadow.Text = UPDATE_COUNTDOWN_upv_1.title
            local u9 = text("Timer", 600, 168, 480, 74, v2, 4)
            local u10 = text("When", 600, 22, 600, 24, v3, 2)
            local u11 = u4:Clone()
            u11.Name = "UpdateCountdownSkyBig"
            u11.CFrame = u4.CFrame * CFrame.new(0, 0, -0.3)
            u11.Parent = Workspace_upv_1
            local u12 = u5:Clone()
            u12.Name = "UpdateCountdownBig"
            u12.Adornee = u11
            u12.PixelsPerStud = 1.680672268907563
            u12:ClearAllChildren()
            local v15 = Instance.new("Frame")
            v15.Name = "Root"
            v15.BackgroundTransparency = 1
            v15.Size = UDim2.fromScale(1, 1)
            v15.Parent = u12
            local u13 = text("Big", 300, 62, 560, 84, v2, 4, v15)
            u13.holder.Visible = false
            local tbl_upv_2 = {u8, u9, u10}
            local tbl_upv_3 = {}
            local v16 = math.ceil(#UPDATE_COUNTDOWN_upv_1.ranks / 2)
            for key_1, value_1 in UPDATE_COUNTDOWN_upv_1.ranks do
                local v17 = ((key_1 <= v16) and (310 - (v16 - key_1) * 74)) or (890 + ((key_1 - v16) - 1) * 74)
                local v18 = Instance.new("Frame")
                v18.Name = value_1.name
                v18.BackgroundTransparency = 1
                v18.AnchorPoint = Vector2.new(0.5, 0.5)
                v18.Position = UDim2.fromOffset(v17, 168)
                v18.Size = UDim2.fromOffset(62, 62)
                v18.Parent = u6
                local v19 = Instance.new("ImageLabel")
                v19.Name = "Emblem"
                v19.BackgroundTransparency = 1
                local Ranks_2 = UIAssets_upv_1.Ranks
                local v20 = (Ranks_2 and (Ranks_2[string.lower(value_1.name)])) or (value_1.img or "")
                v19.Image = v20
                v19.ScaleType = Enum.ScaleType.Fit
                v19.Size = UDim2.fromScale(1, 1)
                v19.Parent = v18
                local v21 = Instance.new("UIScale")
                v21.Parent = v18
                table.insert(tbl_upv_3, {cell = v18, img = v19, scale = v21})
            end
            local u14 = Instance.new("Frame")
            u14.Name = "Hero"
            u14.BackgroundTransparency = 1
            u14.AnchorPoint = Vector2.new(0.5, 0.5)
            u14.Position = UDim2.fromOffset(640, 120)
            u14.Size = UDim2.fromOffset(620, 210)
            u14.Visible = false
            u14.ZIndex = 3
            u14.Parent = u6
            local u15 = Instance.new("UIScale")
            u15.Parent = u14
            local u16 = Instance.new("ImageLabel")
            u16.Name = "Glow"
            u16.BackgroundTransparency = 1
            u16.Image = "rbxassetid://90962482350826"
            u16.ImageTransparency = 1
            u16.ScaleType = Enum.ScaleType.Stretch
            u16.AnchorPoint = Vector2.new(0.5, 0.5)
            u16.Position = UDim2.fromOffset(100, 105)
            u16.Size = UDim2.fromOffset(300, 300)
            u16.Parent = u14
            local u17 = Instance.new("UIScale")
            u17.Parent = u16
            local u18 = Instance.new("ImageLabel")
            u18.Name = "Emblem"
            u18.BackgroundTransparency = 1
            u18.ScaleType = Enum.ScaleType.Fit
            u18.AnchorPoint = Vector2.new(0.5, 0.5)
            u18.Position = UDim2.fromOffset(100, 105)
            u18.Size = UDim2.fromOffset(180, 180)
            u18.ZIndex = 4
            u18.Parent = u14
            local u19 = text("Kicker", 370, 66, 320, 30, v3, 2, u14)
            local u20 = text("HeroName", 370, 124, 320, 80, v2, 4, u14)
            for _, value_2 in {u19, u20} do
                value_2.label.TextXAlignment = Enum.TextXAlignment.Left
                value_2.shadow.TextXAlignment = Enum.TextXAlignment.Left
                value_2.label.ZIndex = 5
                value_2.shadow.ZIndex = 4
            end
            u19.label.Text = "NEW RANK REVEALED"
            u19.shadow.Text = "NEW RANK REVEALED"
            u19.label.TextColor3 = Gold_upv_1
            local u21 = Instance.new("ImageLabel")
            u21.Name = "Flyer"
            u21.BackgroundTransparency = 1
            u21.ScaleType = Enum.ScaleType.Fit
            u21.AnchorPoint = Vector2.new(0.5, 0.5)
            u21.Visible = false
            u21.ZIndex = 6
            u21.Parent = u6
            u5.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
            u12.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
            local u22 = Instance.new("ScreenGui")
            u22.Name = "UpdateCountdownBanner"
            u22.ResetOnSpawn = false
            u22.DisplayOrder = 30
            u22.IgnoreGuiInset = false
            u22.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
            local u23 = Instance.new("Frame")
            u23.Name = "Banner"
            u23.AnchorPoint = Vector2.new(0.5, 1)
            u23.Position = UDim2.new(0.5, 0, 0, -10)
            u23.Size = UDim2.fromOffset(420, 92)
            u23.BackgroundColor3 = fromRGB_upv_1(14, 17, 24)
            u23.BackgroundTransparency = 0.08
            u23.Visible = false
            u23.Parent = u22
            local u24 = Instance.new("UICorner")
            u24.CornerRadius = UDim.new(0, 14)
            u24.Parent = u23
            u24 = Instance.new("UIStroke")
            u24.Thickness = 2
            u24.Color = Gold_upv_1
            u24.Transparency = 0.25
            u24.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            u24.Parent = u23
            u24 = Instance.new("ImageLabel")
            u24.BackgroundTransparency = 1
            u24.ScaleType = Enum.ScaleType.Fit
            u24.Position = UDim2.fromOffset(12, 10)
            u24.Size = UDim2.fromOffset(72, 72)
            u24.Parent = u23
            local v22 = Instance.new("TextLabel")
            v22.BackgroundTransparency = 1
            v22.Position = UDim2.fromOffset(98, 14)
            v22.Size = UDim2.new(1, -110, 0, 22)
            v22.FontFace = v3
            v22.TextSize = 17
            v22.TextColor3 = Gold_upv_1
            v22.TextXAlignment = Enum.TextXAlignment.Left
            v22.Text = "NEW RANK REVEALED"
            v22.Parent = u23
            local u25 = Instance.new("TextLabel")
            u25.BackgroundTransparency = 1
            u25.Position = UDim2.fromOffset(98, 38)
            u25.Size = UDim2.new(1, -110, 0, 40)
            u25.FontFace = v2
            u25.TextScaled = true
            u25.TextColor3 = Colors_upv_1.White
            u25.TextXAlignment = Enum.TextXAlignment.Left
            u25.Parent = u23
            local u26 = 0
            local function showBanner(a1)
                --[[
                  name: showBanner
                  line: 368
                  upvalues:
                    u26 (ref,  index: 1)
                    u24 (copy, index: 2)
                    UIAssets_upv_1 (copy, index: 3)
                    u25 (copy, index: 4)
                    u23 (copy, index: 5)
                    TweenService_upv_1 (copy, index: 6)
                ]]
                u26 = u26 + 1
                local u27 = u26
                local Ranks_3 = UIAssets_upv_1.Ranks
                u24.Image = Ranks_3 and Ranks_3[string.lower(a1.name)] or a1.img or ""
                u25.Text = a1.name
                u23.Position = UDim2.new(0.5, 0, 0, -10)
                u23.Visible = true
                local v24 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                local tbl_4 = {}
                tbl_4.Position = UDim2.new(0.5, 0, 0, 110)
                TweenService_upv_1:Create(u23, v24, tbl_4):Play()
                task.delay(
                    4.2,
                    function()
                        --[[
                          line: 376
                          upvalues:
                            u26 (ref,  index: 1)
                            u27 (copy, index: 2)
                            TweenService_upv_1 (copy, index: 3)
                            u23 (copy, index: 4)
                        ]]
                        if u26 == u27 then
                            local v25 = TweenService_upv_1:Create(u23, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0, -10)})
                            v25.Completed:Once(
                                function()
                                    --[[
                                      line: 379
                                      upvalues:
                                        u26 (ref,  index: 1)
                                        u27 (copy, index: 2)
                                        u23 (copy, index: 3)
                                    ]]
                                    if u26 ~= u27 then
                                        return
                                    end
                                    u23.Visible = false
                                end
                            )
                            v25:Play()
                        end
                    end
                )
            end
            local u28 = Instance.new("Folder")
            u28.Name = "UpdateCountdownFx"
            u28.Parent = Workspace_upv_1
            local u29 = Random.new()
            local RightVector_upv_1 = u4.CFrame.RightVector
            local UpVector_upv_1 = u4.CFrame.UpVector
            local u30 = -u4.CFrame.LookVector
            local function around(a1, a2, a3)
                --[[
                  name: around
                  line: 401
                  upvalues:
                    RightVector_upv_1 (copy, index: 1)
                    UpVector_upv_1 (copy, index: 2)
                    u30 (copy, index: 3)
                ]]
                return ((Vector3.new(0, 66, -135) + (RightVector_upv_1 * a1)) + (UpVector_upv_1 * a2)) + (u30 * (a3 or 30))
            end
            local tbl_upv_5 = {}
            local function fwSound(a1, a2, a3, a4)
                --[[
                  name: fwSound
                  line: 410
                  upvalues:
                    Sfx_upv_1 (ref,  index: 1)
                    tbl_upv_5 (copy, index: 2)
                    u29 (copy, index: 3)
                ]]
                if not Sfx_upv_1 or (os.clock() - (tbl_upv_5[a1] or 0) < a2) then
                    return
                end
                tbl_upv_5[a1] = os.clock()
                task.delay(
                    a3,
                    function()
                        --[[
                          line: 415
                          upvalues:
                            Sfx_upv_1 (ref,  index: 1)
                            a1 (copy, index: 2)
                            a4 (copy, index: 3)
                            u29 (copy, index: 4)
                        ]]
                        pcall(Sfx_upv_1.Play, a1, nil, {volume = a4, pitch = u29:NextNumber(0.94, 1.06)})
                    end
                )
            end
            local function boom(a1)
                --[[
                  name: boom
                  line: 419
                  upvalues:
                    fwSound (copy, index: 1)
                ]]
                fwSound("Firework/Explode", 0.25, 0.15, 1)
                fwSound("Firework/Crackle", 0.6, 0.45, 1)
            end
            local function burst(a1, a2, a3)
                --[[
                  name: burst
                  line: 424
                  upvalues:
                    u28 (copy, index: 1)
                    Colors_upv_1 (copy, index: 2)
                ]]
                local u31 = Instance.new("Part")
                u31.Anchored = true
                u31.CanCollide = false
                u31.CanQuery = false
                u31.CanTouch = false
                u31.Transparency = 1
                u31.Size = Vector3.new(1, 1, 1)
                u31.CFrame = CFrame.new(a1)
                u31.Parent = u28
                local function emitter_1(a4, a5, a6, a7, a8, a9)
                    --[[
                      name: emitter
                      line: 434
                      upvalues:
                        a2 (copy, index: 1)
                        u31 (copy, index: 2)
                    ]]
                    local v26 = Instance.new("ParticleEmitter")
                    v26.Texture = "rbxasset://textures/particles/sparkles_main.dds"
                    v26.LightEmission = 1
                    v26.LightInfluence = 0
                    v26.Brightness = a9
                    v26.Color = ColorSequence.new(a8, a2)
                    v26.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a5), NumberSequenceKeypoint.new(0.7, a5 * 0.6), NumberSequenceKeypoint.new(1, 0)})
                    v26.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.75, 0.15), NumberSequenceKeypoint.new(1, 1)})
                    v26.Lifetime = NumberRange.new(a7 * 0.75, a7)
                    v26.Speed = NumberRange.new(a6 * 0.8, a6)
                    v26.SpreadAngle = Vector2.new(180, 180)
                    v26.Acceleration = Vector3.new(0, -22, 0)
                    v26.Drag = 1.6
                    v26.Rate = 0
                    v26.RotSpeed = NumberRange.new(-180, 180)
                    v26.Parent = u31
                    v26:Emit(a4)
                end
                emitter_1(math.floor(a3 * 120), a3 * 8, a3 * 72, 2, a2:Lerp(Colors_upv_1.White, 0.1), 3)
                emitter_1(math.floor(a3 * 26), a3 * 4, a3 * 36, 2.6, a2:Lerp(Colors_upv_1.White, 0.6), 2)
                task.delay(
                    4,
                    function()
                        --[[
                          line: 456
                          upvalues:
                            u31 (copy, index: 1)
                        ]]
                        u31:Destroy()
                    end
                )
            end
            local tbl_upv_6 = {fromRGB_upv_1(255, 204, 64), fromRGB_upv_1(255, 92, 92), fromRGB_upv_1(86, 202, 255), fromRGB_upv_1(186, 116, 255), fromRGB_upv_1(120, 236, 150), fromRGB_upv_1(255, 150, 80)}
            local function rocket(a1, a2, a3)
                --[[
                  name: rocket
                  line: 462
                  upvalues:
                    u29 (copy, index: 1)
                    Colors_upv_1 (copy, index: 2)
                    u28 (copy, index: 3)
                    TweenService_upv_1 (copy, index: 4)
                    burst (copy, index: 5)
                    fwSound (copy, index: 6)
                ]]
                local v27 = Vector3.new(a1.X + u29:NextNumber(-20, 20), 30, a1.Z + u29:NextNumber(-10, 10))
                local u32 = Instance.new("Part")
                u32.Anchored = true
                u32.CanCollide = false
                u32.CanQuery = false
                u32.CanTouch = false
                u32.CastShadow = false
                u32.Material = Enum.Material.Neon
                u32.Color = a2:Lerp(Colors_upv_1.White, 0.5)
                u32.Size = Vector3.new(1.600000023841858, 1.600000023841858, 1.600000023841858)
                u32.Shape = Enum.PartType.Ball
                u32.CFrame = CFrame.new(v27)
                v27 = Instance.new("Attachment")
                v27.Position = Vector3.new(0, 0.800000011920929, 0)
                v27.Parent = u32
                local v28 = Instance.new("Attachment")
                v28.Position = Vector3.new(0, -0.800000011920929, 0)
                v28.Parent = u32
                local v29 = Instance.new("Trail")
                v29.Attachment0 = v27
                v29.Attachment1 = v28
                v29.Lifetime = 0.45
                v29.LightEmission = 1
                v29.FaceCamera = true
                v29.Color = ColorSequence.new(a2:Lerp(Colors_upv_1.White, 0.6), a2)
                v29.Transparency = NumberSequence.new(0, 1)
                v29.WidthScale = NumberSequence.new(1, 0)
                v29.Parent = u32
                u32.Parent = u28
                local v30 = TweenService_upv_1:Create(u32, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(a1)})
                v30.Completed:Once(
                    function()
                        --[[
                          line: 493
                          upvalues:
                            u32 (copy, index: 1)
                            burst (copy, index: 2)
                            a1 (copy, index: 3)
                            a2 (copy, index: 4)
                            a3 (copy, index: 5)
                            fwSound (copy, index: 6)
                        ]]
                        u32.Transparency = 1
                        burst(a1, a2, a3)
                        fwSound("Firework/Explode", 0.25, 0.15, 1)
                        fwSound("Firework/Crackle", 0.6, 0.45, 1)
                        task.delay(
                            0.6,
                            function()
                                --[[
                                  line: 497
                                  upvalues:
                                    u32 (copy, index: 1)
                                ]]
                                u32:Destroy()
                            end
                        )
                    end
                )
                v30:Play()
            end
            local Lighting_2 = ReplicatedStorage_upv_1:FindFirstChild("Lighting")
            local u33 = Lighting_2 and (Lighting_2:FindFirstChild("Lobby"))
            local function base(a1, a2)
                --[[
                  name: base
                  line: 529
                  upvalues:
                    u33 (copy, index: 1)
                ]]
                local v31
                if u33 then
                    v31 = u33:GetAttribute(a1)
                else
                    v31 = u33
                end
                if v31 == nil then
                    return a2
                end
                return v31
            end
            local v32 = u33 and (u33:FindFirstChildOfClass("Atmosphere"))
            local tbl_upv_7 = {atmColor = 0, atmGlare = 0, atmHaze = 0, rays = 0, atmDensity = 0, outdoor = 0, clock = 0, brightness = 0, atmDecay = 0, shiftTop = 0}
            local v33 = u33 and (u33:GetAttribute("ClockTime"))
            local u34
            if v33 == nil then
                u34 = 16.3
            else
                u34 = v33
            end
            tbl_upv_7.clock = u34
            local v34 = fromRGB_upv_1(214, 184, 140)
            local v35 = u33 and (u33:GetAttribute("ColorShift_Top"))
            if v35 == nil then
                u34 = v34
            else
                u34 = v35
            end
            tbl_upv_7.shiftTop = u34
            local v36 = u33 and (u33:GetAttribute("Brightness"))
            if v36 == nil then
                u34 = 2.5
            else
                u34 = v36
            end
            tbl_upv_7.brightness = u34
            local v37 = fromRGB_upv_1(136, 128, 126)
            local v38 = u33 and (u33:GetAttribute("OutdoorAmbient"))
            if v38 == nil then
                u34 = v37
            else
                u34 = v38
            end
            tbl_upv_7.outdoor = u34
            if v32 then
                u34 = v32.Color
            else
                u34 = fromRGB_upv_1(224, 210, 190)
            end
            tbl_upv_7.atmColor = u34
            if v32 then
                u34 = v32.Decay
            else
                u34 = fromRGB_upv_1(170, 160, 178)
            end
            tbl_upv_7.atmDecay = u34
            tbl_upv_7.atmHaze = ((not v32) and 1.2) or (v32.Haze)
            tbl_upv_7.atmDensity = ((not v32) and 0.24) or (v32.Density)
            tbl_upv_7.atmGlare = ((not v32) and 0.08) or (v32.Glare)
            local v39 = u33 and (u33:FindFirstChildOfClass("SunRaysEffect"))
            if v39 then
                u34 = v39.Intensity
            else
                u34 = 0.035
            end
            tbl_upv_7.rays = u34
            local tbl_upv_8 = {bright = 2.9, density = 0.27, rays = 0.14, clock = 17.35, glare = 2.2, haze = 1.6}
            tbl_upv_8.shiftTop = fromRGB_upv_1(255, 176, 110)
            tbl_upv_8.atmColor = fromRGB_upv_1(255, 178, 130)
            tbl_upv_8.atmDecay = fromRGB_upv_1(232, 128, 140)
            tbl_upv_8.outdoor = fromRGB_upv_1(170, 132, 118)
            local tbl_upv_9 = {bright = 2.6, density = 0.29, rays = 0.2, clock = 17.62, glare = 3, haze = 1.9}
            tbl_upv_9.shiftTop = fromRGB_upv_1(255, 140, 100)
            tbl_upv_9.atmColor = fromRGB_upv_1(255, 150, 120)
            tbl_upv_9.atmDecay = fromRGB_upv_1(196, 98, 150)
            tbl_upv_9.outdoor = fromRGB_upv_1(156, 112, 128)
            u34 = Instance.new("ColorCorrectionEffect")
            u34.Name = "UpdateCountdownGrade"
            u34.Enabled = false
            u34.Parent = CurrentCamera_1
            local LightingController_upv_1 = nil
            pcall(
                function()
                    --[[
                      line: 560
                      upvalues:
                        LightingController_upv_1 (ref, index: 1)
                    ]]
                    LightingController_upv_1 = require(script.Parent.Parent.Core.LightingController)
                end
            )
            local function lobbyLit()
                --[[
                  name: lobbyLit
                  line: 563
                  upvalues:
                    LightingController_upv_1 (ref, index: 1)
                ]]
                if not LightingController_upv_1 then
                    return true
                end
                local success_1, v40 = pcall(LightingController_upv_1.Current)
                return success_1 and (v40 == "Lobby")
            end
            local tbl_upv_10 = {w = 0, d = 0}
            local u35 = false
            local function paintSky(a1, a2)
                --[[
                  name: paintSky
                  line: 573
                  upvalues:
                    LocalPlayer_upv_1 (copy, index: 1)
                    LightingController_upv_1 (ref,  index: 2)
                    u34 (copy, index: 3)
                    u35 (ref,  index: 4)
                    Lighting_upv_1 (copy, index: 5)
                    tbl_upv_7 (copy, index: 6)
                    tbl_upv_8 (copy, index: 7)
                    tbl_upv_9 (copy, index: 8)
                    Colors_upv_1 (copy, index: 9)
                    fromRGB_upv_1 (copy, index: 10)
                ]]
                local v41 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                if v41 then
                    if LightingController_upv_1 then
                        local success_2, v42 = pcall(LightingController_upv_1.Current)
                        v41 = success_2 and (v42 == "Lobby")
                    else
                        v41 = true
                    end
                    if v41 then
                        if a1 <= 0.001 and a2 <= 0.001 then
                            if u35 then
                                Lighting_upv_1.ClockTime = tbl_upv_7.clock
                                Lighting_upv_1.ColorShift_Top = tbl_upv_7.shiftTop
                                Lighting_upv_1.Brightness = tbl_upv_7.brightness
                                Lighting_upv_1.OutdoorAmbient = tbl_upv_7.outdoor
                                v41 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                                if v41 then
                                    v41.Color = tbl_upv_7.atmColor
                                    v41.Decay = tbl_upv_7.atmDecay
                                    v41.Haze = tbl_upv_7.atmHaze
                                    v41.Density = tbl_upv_7.atmDensity
                                    v41.Glare = tbl_upv_7.atmGlare
                                end
                                v41 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                                if v41 then
                                    v41.Intensity = tbl_upv_7.rays
                                end
                                u35 = false
                            end
                            u34.Enabled = false
                            return
                        end
                        u35 = true
                        local function mix_1(a3, a4, a5)
                            --[[
                              name: mix
                              line: 600
                              upvalues:
                                a1 (copy, index: 1)
                                a2 (copy, index: 2)
                            ]]
                            if typeof(a3) == "Color3" then
                                return a3:Lerp(a4, a1):Lerp(a5, a2)
                            end
                            local v43 = a3 + (a4 - a3) * a1
                            return v43 + ((a5 - v43) * a2)
                        end
                        local clock_1 = tbl_upv_7.clock
                        local clock_2 = tbl_upv_8.clock
                        local clock_3 = tbl_upv_9.clock
                        local v42
                        if typeof(clock_1) ~= "Color3" then
                            local _ = clock_1 + (clock_2 - clock_1) * a1
                            v42 = clock_1 + (clock_2 - clock_1) * a1 + (clock_3 - (clock_1 + (clock_2 - clock_1) * a1)) * a2
                        else
                            v42 = clock_1:Lerp(clock_2, a1):Lerp(clock_3, a2)
                        end
                        Lighting_upv_1.ClockTime = v42
                        local shiftTop_1 = tbl_upv_7.shiftTop
                        local shiftTop_2 = tbl_upv_8.shiftTop
                        local shiftTop_3 = tbl_upv_9.shiftTop
                        if typeof(shiftTop_1) ~= "Color3" then
                            local _ = shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1
                            v42 = shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1 + (shiftTop_3 - (shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1)) * a2
                        else
                            v42 = shiftTop_1:Lerp(shiftTop_2, a1):Lerp(shiftTop_3, a2)
                        end
                        Lighting_upv_1.ColorShift_Top = v42
                        local brightness_1 = tbl_upv_7.brightness
                        local bright_1 = tbl_upv_8.bright
                        local bright_2 = tbl_upv_9.bright
                        if typeof(brightness_1) ~= "Color3" then
                            local _ = brightness_1 + (bright_1 - brightness_1) * a1
                            v42 = brightness_1 + (bright_1 - brightness_1) * a1 + (bright_2 - (brightness_1 + (bright_1 - brightness_1) * a1)) * a2
                        else
                            v42 = brightness_1:Lerp(bright_1, a1):Lerp(bright_2, a2)
                        end
                        Lighting_upv_1.Brightness = v42
                        local v44 = tbl_upv_7.outdoor
                        local outdoor_1 = tbl_upv_8.outdoor
                        local outdoor_2 = tbl_upv_9.outdoor
                        if typeof(v44) ~= "Color3" then
                            local _ = v44 + (outdoor_1 - v44) * a1
                            v42 = v44 + (outdoor_1 - v44) * a1 + (outdoor_2 - (v44 + (outdoor_1 - v44) * a1)) * a2
                        else
                            v42 = v44:Lerp(outdoor_1, a1):Lerp(outdoor_2, a2)
                        end
                        Lighting_upv_1.OutdoorAmbient = v42
                        local v45 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                        local v46 = nil
                        if v45 then
                            v46 = tbl_upv_7.rays
                            local rays_1 = tbl_upv_8.rays
                            local rays_2 = tbl_upv_9.rays
                            if typeof(v46) ~= "Color3" then
                                local _ = v46 + (rays_1 - v46) * a1
                                v42 = v46 + (rays_1 - v46) * a1 + (rays_2 - (v46 + (rays_1 - v46) * a1)) * a2
                            else
                                v42 = v46:Lerp(rays_1, a1):Lerp(rays_2, a2)
                            end
                            v45.Intensity = v42
                        end
                        local v47 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                        local v48, v49, v50, v51, v52 = nil, nil, nil, nil, nil
                        if v47 then
                            v48 = tbl_upv_7.atmColor
                            local atmColor_1 = tbl_upv_8.atmColor
                            local atmColor_2 = tbl_upv_9.atmColor
                            if typeof(v48) ~= "Color3" then
                                local _ = v48 + (atmColor_1 - v48) * a1
                                v42 = v48 + (atmColor_1 - v48) * a1 + (atmColor_2 - (v48 + (atmColor_1 - v48) * a1)) * a2
                            else
                                v42 = v48:Lerp(atmColor_1, a1):Lerp(atmColor_2, a2)
                            end
                            v47.Color = v42
                            v49 = tbl_upv_7.atmDecay
                            local atmDecay_1 = tbl_upv_8.atmDecay
                            local atmDecay_2 = tbl_upv_9.atmDecay
                            if typeof(v49) ~= "Color3" then
                                local _ = v49 + (atmDecay_1 - v49) * a1
                                v42 = v49 + (atmDecay_1 - v49) * a1 + (atmDecay_2 - (v49 + (atmDecay_1 - v49) * a1)) * a2
                            else
                                v42 = v49:Lerp(atmDecay_1, a1):Lerp(atmDecay_2, a2)
                            end
                            v47.Decay = v42
                            v50 = tbl_upv_7.atmHaze
                            local haze_1 = tbl_upv_8.haze
                            local haze_2 = tbl_upv_9.haze
                            if typeof(v50) ~= "Color3" then
                                local _ = v50 + (haze_1 - v50) * a1
                                v42 = v50 + (haze_1 - v50) * a1 + (haze_2 - (v50 + (haze_1 - v50) * a1)) * a2
                            else
                                v42 = v50:Lerp(haze_1, a1):Lerp(haze_2, a2)
                            end
                            v47.Haze = v42
                            v51 = tbl_upv_7.atmDensity
                            local density_1 = tbl_upv_8.density
                            local density_2 = tbl_upv_9.density
                            if typeof(v51) ~= "Color3" then
                                local _ = v51 + (density_1 - v51) * a1
                                v42 = v51 + (density_1 - v51) * a1 + (density_2 - (v51 + (density_1 - v51) * a1)) * a2
                            else
                                v42 = v51:Lerp(density_1, a1):Lerp(density_2, a2)
                            end
                            v47.Density = v42
                            v52 = tbl_upv_7.atmGlare
                            local glare_1 = tbl_upv_8.glare
                            local glare_2 = tbl_upv_9.glare
                            if typeof(v52) ~= "Color3" then
                                local _ = v52 + (glare_1 - v52) * a1
                                v42 = v52 + (glare_1 - v52) * a1 + (glare_2 - (v52 + (glare_1 - v52) * a1)) * a2
                            else
                                v42 = v52:Lerp(glare_1, a1):Lerp(glare_2, a2)
                            end
                            v47.Glare = v42
                        end
                        u34.Enabled = true
                        local White_1 = Colors_upv_1.White
                        local v53 = fromRGB_upv_1(255, 238, 222)
                        local v54 = fromRGB_upv_1(255, 228, 226)
                        if typeof(White_1) ~= "Color3" then
                            local _ = White_1 + (v53 - White_1) * a1
                            v44 = White_1 + (v53 - White_1) * a1 + (v54 - (White_1 + (v53 - White_1) * a1)) * a2
                        else
                            v44 = White_1:Lerp(v53, a1):Lerp(v54, a2)
                        end
                        u34.TintColor = v44
                        u34.Saturation = a1 * 0.12
                        u34.Contrast = a1 * 0.05
                        u34.Brightness = a1 * 0.03
                        return
                    end
                end
                u34.Enabled = false
                u35 = false
            end
            local function localTime(a1)
                --[[
                  name: localTime
                  line: 644
                ]]
                local success_3, v55 = pcall(function() end)
                if success_3 then
                    return string.upper(v55) .. " YOUR TIME"
                end
                return ""
            end
            local at_upv_1 = UPDATE_COUNTDOWN_upv_1.at
            local success_4, v56 = pcall(
                function()
                    --[[
                      line: 645
                      upvalues:
                        at_upv_1 (copy, index: 1)
                    ]]
                    return DateTime.fromUnixTimestamp(at_upv_1):FormatLocalTime("dddd h:mm A", "en-us")
                end
            )
            local u36 = (success_4 and (string.upper(v56) .. " YOUR TIME")) or ""
            local tbl_upv_11 = {}
            local function set(a1, a2)
                --[[
                  name: set
                  line: 653
                  upvalues:
                    tbl_upv_11 (copy, index: 1)
                ]]
                if tbl_upv_11[a1] == a2 then
                    return
                end
                tbl_upv_11[a1] = a2
                a1.label.Text = a2
                a1.shadow.Text = a2
            end
            local function paintSlot(a1, a2)
                --[[
                  name: paintSlot
                  line: 668
                  upvalues:
                    tbl_upv_3 (copy, index: 1)
                    Colors_upv_1 (copy, index: 3)
                    u3 (copy, index: 4)
                ]]
                local v57 = tbl_upv_3[a1]
                v57.out = a2
                if a2 then
                    v57.img.ImageColor3 = Colors_upv_1.White
                    v57.img.ImageTransparency = 0
                else
                    v57.img.ImageColor3 = u3
                    v57.img.ImageTransparency = 0.15
                end
            end
            local u37 = false
            local u38 = 0
            local function fadeText(a1, a2)
                --[[
                  name: fadeText
                  line: 661
                  upvalues:
                    tbl_upv_2 (copy, index: 1)
                    TweenService_upv_1 (copy, index: 2)
                ]]
                for _, value_3 in tbl_upv_2 do
                    local tbl_12 = {}
                    tbl_12.TextTransparency = a1
                    TweenService_upv_1:Create(value_3.label, TweenInfo.new(a2), tbl_12):Play()
                    local v58 = TweenInfo.new(a2)
                    local tbl_13 = {}
                    tbl_13.TextTransparency = math.max(a1, 0.45)
                    TweenService_upv_1:Create(value_3.shadow, v58, tbl_13):Play()
                end
            end
            local function volley(a1, a2, a3, a4)
                --[[
                  name: volley
                  line: 507
                  upvalues:
                    u29 (copy, index: 1)
                    LocalPlayer_upv_1 (copy, index: 2)
                    rocket (copy, index: 3)
                    RightVector_upv_1 (copy, index: 4)
                    UpVector_upv_1 (copy, index: 5)
                    u30 (copy, index: 6)
                    tbl_upv_6 (copy, index: 7)
                ]]
                for n_upv_1 = 1, a1 do
                    task.delay(
                        (((n_upv_1 - 1) / math.max(1, a1 - 1)) * a2) + u29:NextNumber(0, 0.15),
                        function()
                            --[[
                              line: 509
                              upvalues:
                                LocalPlayer_upv_1 (copy, index: 1)
                                n_upv_1 (copy, index: 2)
                                u29 (copy, index: 3)
                                rocket (copy, index: 4)
                                RightVector_upv_1 (copy, index: 5)
                                UpVector_upv_1 (copy, index: 6)
                                u30 (copy, index: 7)
                                a3 (copy, index: 8)
                                tbl_upv_6 (copy, index: 9)
                                a4 (copy, index: 10)
                            ]]
                            local v59 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                            if not v59 then
                                return
                            end
                            local v60 = (((n_upv_1 % 2 ~= 0) and -1) or 1) * u29:NextNumber(150, 260)
                            v59 = u29:NextNumber(10, 80)
                            if n_upv_1 % 3 == 0 then
                                v60, v59 = u29:NextNumber(-140, 140), u29:NextNumber(70, 110)
                            end
                            local v61 = a3 or (tbl_upv_6[u29:NextInteger(1, #tbl_upv_6)])
                            rocket(((Vector3.new(0, 66, -135) + (RightVector_upv_1 * v60)) + (UpVector_upv_1 * v59)) + (u30 * 30), v61, a4)
                        end
                    )
                end
            end
            local function reveal(a1)
                --[[
                  name: reveal
                  line: 685
                  upvalues:
                    UPDATE_COUNTDOWN_upv_1 (copy, index: 1)
                    Gold_upv_1 (copy, index: 2)
                    u37 (ref,  index: 3)
                    u38 (ref,  index: 4)
                    tbl_upv_3 (copy, index: 5)
                    u3 (copy, index: 6)
                    u18 (copy, index: 7)
                    UIAssets_upv_1 (copy, index: 8)
                    u20 (copy, index: 9)
                    tbl_upv_11 (copy, index: 10)
                    Colors_upv_1 (copy, index: 11)
                    u19 (copy, index: 12)
                    u14 (copy, index: 13)
                    u15 (copy, index: 14)
                    fadeText (copy, index: 15)
                    TweenService_upv_1 (copy, index: 16)
                    u16 (copy, index: 17)
                    u17 (copy, index: 18)
                    Sfx_upv_1 (ref,  index: 19)
                    volley (copy, index: 20)
                    showBanner (copy, index: 21)
                    u21 (copy, index: 22)
                ]]
                local u39 = UPDATE_COUNTDOWN_upv_1.ranks[a1]
                local v62 = u39.color or Gold_upv_1
                local v63 = a1 == #UPDATE_COUNTDOWN_upv_1.ranks
                u37 = true
                u38 = a1
                local v64 = tbl_upv_3[a1]
                v64.out = false
                v64.img.ImageColor3 = u3
                v64.img.ImageTransparency = 0.15
                local Ranks_4 = UIAssets_upv_1.Ranks
                u18.Image = Ranks_4 and Ranks_4[string.lower(u39.name)] or u39.img or ""
                u18.ImageTransparency = 0
                local name_1 = u39.name
                if tbl_upv_11[u20] ~= name_1 then
                    tbl_upv_11[u20] = name_1
                    u20.label.Text = name_1
                    u20.shadow.Text = name_1
                end
                u20.label.TextColor3 = v62:Lerp(Colors_upv_1.White, 0.35)
                for _, value_4 in {u20, u19} do
                    value_4.label.TextTransparency = 0
                    value_4.shadow.TextTransparency = 0.45
                end
                u14.Position = UDim2.fromOffset(640, 120)
                u14.Visible = true
                u15.Scale = 0.3
                fadeText(1, 0.2)
                local tbl_14 = {Scale = 1}
                TweenService_upv_1:Create(u15, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_14):Play()
                u16.ImageColor3 = v62
                u16.ImageTransparency = 0
                u17.Scale = 0.4
                local tbl_15 = {ImageTransparency = 0.55}
                TweenService_upv_1:Create(u16, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_15):Play()
                local tbl_16 = {Scale = 1.3}
                TweenService_upv_1:Create(u17, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_16):Play()
                if Sfx_upv_1 then
                    pcall(Sfx_upv_1.PlayUI, "UI/Unlock")
                end
                if v63 then
                    task.delay(
                        0.15,
                        function()
                            --[[
                              line: 712
                              upvalues:
                                Sfx_upv_1 (ref, index: 1)
                            ]]
                            if not Sfx_upv_1 then
                                return
                            end
                            pcall(Sfx_upv_1.PlayUI, "UI/NewItem_Fanfare")
                        end
                    )
                end
                volley((v63 and 14) or 8, 2.4, v62, (v63 and 1.35) or 1.1)
                showBanner(u39)
                task.delay(
                    3.4,
                    function()
                        --[[
                          line: 718
                          upvalues:
                            tbl_upv_3 (copy, index: 1)
                            a1 (copy, index: 2)
                            u21 (copy, index: 3)
                            u39 (copy, index: 4)
                            UIAssets_upv_1 (copy, index: 5)
                            u14 (copy, index: 6)
                            u16 (copy, index: 7)
                            TweenService_upv_1 (copy, index: 8)
                            Colors_upv_1 (copy, index: 10)
                            Sfx_upv_1 (ref,  index: 11)
                            fadeText (copy, index: 12)
                            u37 (ref,  index: 13)
                            u38 (ref,  index: 14)
                        ]]
                        local v66 = tbl_upv_3[a1]
                        local v67 = Vector2.new(430, 120)
                        local Ranks_5 = UIAssets_upv_1.Ranks
                        u21.Image = Ranks_5 and Ranks_5[string.lower(u39.name)] or u39.img or ""
                        u21.Position = UDim2.fromOffset(v67.X, v67.Y)
                        u21.Size = UDim2.fromOffset(180, 180)
                        u21.Visible = true
                        u14.Visible = false
                        u16.ImageTransparency = 1
                        local v69 = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                        local tbl_17 = {}
                        tbl_17.Position = v66.cell.Position
                        tbl_17.Size = UDim2.fromOffset(62, 62)
                        TweenService_upv_1:Create(u21, v69, tbl_17):Play()
                        task.wait(0.55)
                        u21.Visible = false
                        local v70 = tbl_upv_3[a1]
                        v70.out = true
                        v70.img.ImageColor3 = Colors_upv_1.White
                        v70.img.ImageTransparency = 0
                        v66.scale.Scale = 1.6
                        local tbl_18 = {Scale = 1}
                        TweenService_upv_1:Create(v66.scale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_18):Play()
                        if Sfx_upv_1 then
                            pcall(Sfx_upv_1.PlayUI, "UI/Card_Reveal")
                        end
                        fadeText(0, 0.35)
                        u37 = false
                        u38 = 0
                    end
                )
            end
            local u40 = -1
            local u41 = ""
            local u42 = false
            local u43 = os.clock()
            local u44 = nil
            local u45 = 0
            local tbl_upv_19 = {}
            Workspace_upv_1:GetAttributeChangedSignal("CountdownPreviewAt"):Connect(
                function()
                    --[[
                      line: 754
                      upvalues:
                        u42 (ref,  index: 1)
                        u41 (ref,  index: 2)
                        u44 (ref,  index: 3)
                        tbl_upv_19 (copy, index: 4)
                    ]]
                    u42 = false
                    u41 = ""
                    u44 = nil
                    table.clear(tbl_upv_19)
                end
            )
            local function clock_4(a1)
                --[[
                  name: clock
                  line: 633
                ]]
                local v71 = a1 // 86400
                local v72 = a1 // 3600 % 24
                local v73 = a1 // 60 % 60
                local v74 = a1 % 60
                if v71 > 0 then
                    return string.format("%dD %02d:%02d:%02d", v71, v72, v73, v74)
                elseif v72 > 0 then
                    return string.format("%d:%02d:%02d", v72, v73, v74)
                else
                    return string.format("%d:%02d", v73, v74)
                end
            end
            local function step(a1)
                --[[
                  name: step
                  line: 761
                  upvalues:
                    Workspace_upv_1 (copy, index: 1)
                    UPDATE_COUNTDOWN_upv_1 (copy, index: 2)
                    LocalPlayer_upv_1 (copy, index: 3)
                    u5 (copy, index: 4)
                    u12 (copy, index: 5)
                    u22 (copy, index: 6)
                    tbl_upv_3 (copy, index: 7)
                    u42 (ref,  index: 8)
                    Colors_upv_1 (copy, index: 9)
                    u3 (copy, index: 10)
                    tbl_upv_19 (copy, index: 11)
                    u38 (ref,  index: 12)
                    u43 (copy, index: 13)
                    u37 (ref,  index: 14)
                    reveal (copy, index: 15)
                    u1 (copy, index: 16)
                    u2 (copy, index: 17)
                    ReplicatedStorage_upv_1 (copy, index: 18)
                    tbl_upv_10 (copy, index: 19)
                    paintSky (copy, index: 20)
                    u8 (copy, index: 21)
                    Gold_upv_1 (copy, index: 22)
                    u9 (copy, index: 23)
                    u10 (copy, index: 24)
                    tbl_upv_11 (copy, index: 25)
                    u13 (copy, index: 26)
                    u40 (ref,  index: 27)
                    TweenService_upv_1 (copy, index: 28)
                    Sfx_upv_1 (ref,  index: 29)
                    u36 (copy, index: 30)
                    clock_4 (copy, index: 31)
                    u41 (ref,  index: 32)
                    u44 (ref,  index: 33)
                    volley (copy, index: 34)
                    u45 (ref,  index: 35)
                    u29 (copy, index: 36)
                ]]
                local v75 = Workspace_upv_1:GetServerTimeNow()
                local v76 = Workspace_upv_1:GetAttribute("CountdownPreview")
                local v77 = Workspace_upv_1:GetAttribute("CountdownPreviewAt")
                local v78
                if type(v76) == "number" and type(v77) == "number" then
                    v78 = UPDATE_COUNTDOWN_upv_1.at - v76 + (v75 - v77)
                else
                    v78 = v75
                end
                local v79 = UPDATE_COUNTDOWN_upv_1.at - v78
                local v80 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                u5.Enabled = v80
                u12.Enabled = v80
                u22.Enabled = v80
                for key_2, value_5 in UPDATE_COUNTDOWN_upv_1.ranks do
                    local v81 = UPDATE_COUNTDOWN_upv_1.at - value_5.hours * 3600
                    local v82 = v81 <= v78
                    local v83 = tbl_upv_3[key_2]
                    if v83.out == nil or not (u42) then
                        local v84 = tbl_upv_3[key_2]
                        v84.out = v82
                        if v82 then
                            v84.img.ImageColor3 = Colors_upv_1.White
                            v84.img.ImageTransparency = 0
                        else
                            v84.img.ImageColor3 = u3
                            v84.img.ImageTransparency = 0.15
                        end
                        continue
                    end
                    if v82 then
                        if v83.out or table.find(tbl_upv_19, key_2) or u38 == key_2 then
                            if v82 then
                                continue
                            end
                            if v83.out then
                                local v85 = tbl_upv_3[key_2]
                                v85.out = false
                                v85.img.ImageColor3 = u3
                                v85.img.ImageTransparency = 0.15
                            end
                        else
                            if not (v78 - v81 < 4) then
                                local v86 = tbl_upv_3[key_2]
                                v86.out = true
                                v86.img.ImageColor3 = Colors_upv_1.White
                                v86.img.ImageTransparency = 0
                                continue
                            end
                            if os.clock() - u43 > 6 then
                                table.insert(tbl_upv_19, key_2)
                            else
                                local v86 = tbl_upv_3[key_2]
                                v86.out = true
                                v86.img.ImageColor3 = Colors_upv_1.White
                                v86.img.ImageTransparency = 0
                            end
                        end
                    else
                        if v82 then
                            continue
                        end
                        if v83.out then
                            local v85 = tbl_upv_3[key_2]
                            v85.out = false
                            v85.img.ImageColor3 = u3
                            v85.img.ImageTransparency = 0.15
                        end
                    end
                end
                u42 = true
                if not (u37) and #tbl_upv_19 > 0 then
                    local v87 = table.remove(tbl_upv_19, 1)
                    if v80 then
                        reveal(v87)
                    else
                        local v88 = tbl_upv_3[v87]
                        v88.out = true
                        v88.img.ImageColor3 = Colors_upv_1.White
                        v88.img.ImageTransparency = 0
                    end
                end
                local v89 = 0
                local v90 = 0
                if (v79 > 0) and (v79 <= u1) then
                    if u2 < v79 then
                        local _ = (u1 - v79) / (u1 - u2)
                        v89 = 0.6 * ((u1 - v79) / (u1 - u2)) * ((u1 - v79) / (u1 - u2)) * (3 - 2 * ((u1 - v79) / (u1 - u2)))
                    else
                        v89 = 0.6 + 0.4 * (1 - (math.max(0, v79 - 60) / (u2 - 60)))
                    end
                    v90 = ((v79 <= 60) and (1 - v79 / 60)) or 0
                elseif v79 <= 0 then
                    local v91 = ((Workspace_upv_1:GetAttribute("CountdownPreviewShipped") == true) and true) or ((UPDATE_COUNTDOWN_upv_1.shipped ~= nil) and (ReplicatedStorage_upv_1.Shared:FindFirstChild(UPDATE_COUNTDOWN_upv_1.shipped) ~= nil))
                    if not v91 then
                        v89, v90 = 1, 1
                    end
                end
                local v92 = ((os.clock() - u43 < 0.4) and 1) or (math.min(1, a1 * 0.6))
                tbl_upv_10.w = tbl_upv_10.w + ((v89 - tbl_upv_10.w) * v92)
                tbl_upv_10.d = tbl_upv_10.d + ((v90 - tbl_upv_10.d) * v92)
                paintSky(tbl_upv_10.w, tbl_upv_10.d)
                local v93 = nil
                if v79 > 0 then
                    local v94 = math.ceil(v79)
                    v90 = ((v79 <= 60) and "final") or (((v79 <= u2) and "close") or "far")
                    for _, value_6 in tbl_upv_3 do
                        value_6.cell.Visible = true
                    end
                    v89 = v90 ~= "far"
                    local label_1 = u8.label
                    local v95
                    if v89 then
                        v95 = Gold_upv_1
                    else
                        v95 = Colors_upv_1.White
                    end
                    label_1.TextColor3 = v95
                    local label_2 = u9.label
                    local v96
                    if v89 then
                        v96 = Gold_upv_1
                    else
                        v96 = Colors_upv_1.White
                    end
                    label_2.TextColor3 = v96
                    local v97, v98, v99 = nil, nil, nil
                    if v90 ~= "final" then
                        v97 = u36
                        if tbl_upv_11[u10] ~= v97 then
                            tbl_upv_11[u10] = v97
                            u10.label.Text = v97
                            u10.shadow.Text = v97
                        end
                        u10.label.TextColor3 = Colors_upv_1.White
                        u8.holder.Visible = true
                        u9.holder.Visible = true
                        u13.holder.Visible = false
                        v98 = clock_4(v94)
                        if tbl_upv_11[u9] ~= v98 then
                            tbl_upv_11[u9] = v98
                            u9.label.Text = v98
                            u9.shadow.Text = v98
                        end
                    else
                        v99 = string.upper(UPDATE_COUNTDOWN_upv_1.title) .. " IN"
                        if tbl_upv_11[u10] ~= v99 then
                            tbl_upv_11[u10] = v99
                            u10.label.Text = v99
                            u10.shadow.Text = v99
                        end
                        u10.label.TextColor3 = Gold_upv_1
                        u8.holder.Visible = false
                        u9.holder.Visible = false
                        u13.holder.Visible = not u37
                        local label_3 = u13.label
                        local v100
                        if v94 <= 10 then
                            v100 = Colors_upv_1.White
                        else
                            v100 = Gold_upv_1
                        end
                        label_3.TextColor3 = v100
                        local v101 = nil
                        if v94 ~= u40 then
                            v101 = tostring(v94)
                            if tbl_upv_11[u13] ~= v101 then
                                tbl_upv_11[u13] = v101
                                u13.label.Text = v101
                                u13.shadow.Text = v101
                            end
                            u13.scale.Scale = ((v94 <= 10) and 1.2) or 1.12
                            local tbl_20 = {Scale = 1}
                            TweenService_upv_1:Create(u13.scale, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_20):Play()
                            if v80 then
                                local v102 = ((v94 <= 3) and "Match/Countdown_1") or "Match/Countdown_Tick"
                                if Sfx_upv_1 then
                                    pcall(Sfx_upv_1.PlayUI, v102)
                                end
                            end
                        end
                    end
                    u40 = v94
                    u41 = v90
                else
                    if u41 == "final" or u41 == "close" then
                        u44 = os.clock()
                        if v80 then
                            if Sfx_upv_1 then
                                pcall(Sfx_upv_1.PlayUI, "Match/Victory")
                            end
                            volley(16, 7, nil, 1.5)
                            task.delay(
                                7.5,
                                function()
                                    --[[
                                      line: 863
                                      upvalues:
                                        volley (copy, index: 1)
                                    ]]
                                    volley(10, 3, nil, 1.8)
                                end
                            )
                        end
                    end
                    if u41 ~= "done" then
                        u13.scale.Scale = 0.4
                        local tbl_21 = {Scale = 1}
                        TweenService_upv_1:Create(u13.scale, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_21):Play()
                    end
                    u41 = "done"
                    for _, value_7 in tbl_upv_3 do
                        value_7.cell.Visible = false
                    end
                    u8.holder.Visible = false
                    u9.holder.Visible = false
                    u10.holder.Visible = true
                    u13.holder.Visible = true
                    u10.label.TextColor3 = Gold_upv_1
                    v93 = string.upper(UPDATE_COUNTDOWN_upv_1.title)
                    if tbl_upv_11[u10] ~= v93 then
                        tbl_upv_11[u10] = v93
                        u10.label.Text = v93
                        u10.shadow.Text = v93
                    end
                    local v103 = ((Workspace_upv_1:GetAttribute("CountdownPreviewShipped") == true) and true) or ((UPDATE_COUNTDOWN_upv_1.shipped ~= nil) and (ReplicatedStorage_upv_1.Shared:FindFirstChild(UPDATE_COUNTDOWN_upv_1.shipped) ~= nil))
                    if v103 then
                        if UPDATE_COUNTDOWN_upv_1.OUT_FOR < -v79 then
                            return false
                        end
                        if tbl_upv_11[u13] ~= "OUT NOW!" then
                            tbl_upv_11[u13] = "OUT NOW!"
                            u13.label.Text = "OUT NOW!"
                            u13.shadow.Text = "OUT NOW!"
                        end
                        u13.label.TextColor3 = Gold_upv_1
                        if v80 then
                            local v104 = os.clock()
                            if u45 <= v104 and -v79 < 7200 then
                                u45 = os.clock() + u29:NextNumber(25, 40)
                                if u44 == nil or os.clock() - u44 > 15 then
                                    volley(5, 2.5, nil, 1.1)
                                end
                            end
                        end
                    else
                        if tbl_upv_11[u13] ~= "SERVERS RESTARTING..." then
                            tbl_upv_11[u13] = "SERVERS RESTARTING..."
                            u13.label.Text = "SERVERS RESTARTING..."
                            u13.shadow.Text = "SERVERS RESTARTING..."
                        end
                        u13.label.TextColor3 = Colors_upv_1.White
                    end
                end
                return true
            end
            local u46 = nil
            local u47 = 0
            local v105 = RunService_1.Heartbeat:Connect(
                function(a1)
                    --[[
                      line: 904
                      upvalues:
                        u47 (ref,  index: 1)
                        step (copy, index: 2)
                        u46 (ref,  index: 3)
                        LocalPlayer_upv_1 (copy, index: 4)
                        LightingController_upv_1 (ref,  index: 5)
                        u34 (copy, index: 6)
                        u35 (ref,  index: 7)
                        Lighting_upv_1 (copy, index: 8)
                        tbl_upv_7 (copy, index: 9)
                        u5 (copy, index: 10)
                        u12 (copy, index: 11)
                        u22 (copy, index: 12)
                        u4 (copy, index: 13)
                        u11 (copy, index: 14)
                        u28 (copy, index: 15)
                    ]]
                    u47 = u47 + a1
                    if u47 < 0.05 then
                        return
                    end
                    local success_5, v106 = pcall(step, u47)
                    u47 = 0
                    if success_5 and v106 == false then
                        if u46 then
                            u46:Disconnect()
                        end
                        local v107 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                        if v107 then
                            if LightingController_upv_1 then
                                local success_6, v108 = pcall(LightingController_upv_1.Current)
                                v107 = success_6 and (v108 == "Lobby")
                            else
                                v107 = true
                            end
                            if v107 then
                                if u35 then
                                    Lighting_upv_1.ClockTime = tbl_upv_7.clock
                                    Lighting_upv_1.ColorShift_Top = tbl_upv_7.shiftTop
                                    Lighting_upv_1.Brightness = tbl_upv_7.brightness
                                    Lighting_upv_1.OutdoorAmbient = tbl_upv_7.outdoor
                                    v107 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                                    if v107 then
                                        v107.Color = tbl_upv_7.atmColor
                                        v107.Decay = tbl_upv_7.atmDecay
                                        v107.Haze = tbl_upv_7.atmHaze
                                        v107.Density = tbl_upv_7.atmDensity
                                        v107.Glare = tbl_upv_7.atmGlare
                                    end
                                    v107 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                                    if v107 then
                                        v107.Intensity = tbl_upv_7.rays
                                    end
                                    u35 = false
                                end
                                u34.Enabled = false
                            else
                                u34.Enabled = false
                                u35 = false
                            end
                        else
                            u34.Enabled = false
                            u35 = false
                        end
                        u5:Destroy()
                        u12:Destroy()
                        u22:Destroy()
                        u4:Destroy()
                        u11:Destroy()
                        u28:Destroy()
                        u34:Destroy()
                        return
                    end
                    if (success_5) then
                        return
                    end
                    warn("[UpdateCountdown] " .. tostring(v106))
                end
            )
            u46 = v105
        elseif Workspace_upv_1:GetAttribute("CountdownPreviewAt") ~= nil then
            local function inLobby()
                --[[
                  name: inLobby
                  line: 100
                  upvalues:
                    LocalPlayer_upv_1 (copy, index: 1)
                ]]
                local v6 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                return v6
            end
            local function now()
                --[[
                  name: now
                  line: 105
                  upvalues:
                    Workspace_upv_1 (copy, index: 1)
                    UPDATE_COUNTDOWN_upv_1 (copy, index: 2)
                ]]
                local v7 = Workspace_upv_1:GetServerTimeNow()
                local v8 = Workspace_upv_1:GetAttribute("CountdownPreview")
                local v9 = Workspace_upv_1:GetAttribute("CountdownPreviewAt")
                if type(v8) == "number" and type(v9) == "number" then
                    return (UPDATE_COUNTDOWN_upv_1.at - v8) + (v7 - v9)
                end
                return v7
            end
            local function play(a1)
                --[[
                  name: play
                  line: 114
                  upvalues:
                    Sfx_upv_1 (ref, index: 1)
                ]]
                if not Sfx_upv_1 then
                    return
                end
                pcall(Sfx_upv_1.PlayUI, a1)
            end
            local u4 = Instance.new("Part")
            u4.Name = "UpdateCountdownSky"
            u4.Anchored = true
            u4.CanCollide = false
            u4.CanQuery = false
            u4.CanTouch = false
            u4.CastShadow = false
            u4.Transparency = 1
            u4.Size = Vector3.new(357, 64, 0.20000000298023224)
            u4.CFrame = CFrame.lookAt(Vector3.new(0, 66, -135), Vector3.new(0, 9, 120))
            u4.Parent = Workspace_upv_1
            local u5 = Instance.new("SurfaceGui")
            u5.Name = "UpdateCountdown"
            u5.Adornee = u4
            u5.Face = Enum.NormalId.Front
            u5.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
            u5.PixelsPerStud = 3.361344537815126
            u5.LightInfluence = 0
            u5.Brightness = 1.25
            u5.MaxDistance = 2000
            u5.ResetOnSpawn = false
            u5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            local u6 = Instance.new("Frame")
            u6.Name = "Root"
            u6.BackgroundTransparency = 1
            u6.Size = UDim2.fromScale(1, 1)
            u6.Parent = u5
            local v10 = Instance.new("ImageLabel")
            v10.Name = "Plate"
            v10.BackgroundTransparency = 1
            v10.Image = "rbxassetid://90962482350826"
            v10.ImageColor3 = u3
            v10.ImageTransparency = 0.3
            v10.ScaleType = Enum.ScaleType.Stretch
            v10.AnchorPoint = Vector2.new(0.5, 0.5)
            v10.Position = UDim2.fromOffset(600, 112)
            v10.Size = UDim2.fromOffset(1240, 300)
            v10.Parent = u6
            local function text(a1, a2, a3, a4, a5, a6, a7, a8)
                --[[
                  name: text
                  line: 155
                  upvalues:
                    u6 (copy, index: 1)
                    u3 (copy, index: 2)
                    Colors_upv_1 (copy, index: 3)
                ]]
                local u7 = Instance.new("Frame")
                u7.Name = a1
                u7.BackgroundTransparency = 1
                u7.AnchorPoint = Vector2.new(0.5, 0.5)
                u7.Position = UDim2.fromOffset(a2, a3)
                u7.Size = UDim2.fromOffset(a4, a5)
                u7.Parent = a8 or u6
                local v12 = Instance.new("UIScale")
                v12.Parent = u7
                local function mk_1(a9, a10, a11, a12, a13)
                    --[[
                      name: mk
                      line: 165
                      upvalues:
                        a6 (copy, index: 1)
                        u7 (copy, index: 2)
                    ]]
                    local v13 = Instance.new("TextLabel")
                    v13.Name = a9
                    v13.BackgroundTransparency = 1
                    v13.TextScaled = true
                    v13.FontFace = a6
                    v13.TextColor3 = a11
                    v13.TextTransparency = a12
                    v13.Position = UDim2.fromOffset(0, a10)
                    v13.Size = UDim2.fromScale(1, 1)
                    v13.Text = ""
                    v13.ZIndex = a13
                    v13.Parent = u7
                    return v13
                end
                local v14 = mk_1("Shadow", a7, u3, 0.45, 1)
                local tbl_1 = {}
                tbl_1.label = mk_1("Text", 0, Colors_upv_1.White, 0, 2)
                tbl_1.shadow = v14
                tbl_1.holder = u7
                tbl_1.scale = v12
                return tbl_1
            end
            local u8 = text("Title", 600, 82, 1000, 84, v2, 4)
            u8.label.Text = UPDATE_COUNTDOWN_upv_1.title
            u8.shadow.Text = UPDATE_COUNTDOWN_upv_1.title
            local u9 = text("Timer", 600, 168, 480, 74, v2, 4)
            local u10 = text("When", 600, 22, 600, 24, v3, 2)
            local u11 = u4:Clone()
            u11.Name = "UpdateCountdownSkyBig"
            u11.CFrame = u4.CFrame * CFrame.new(0, 0, -0.3)
            u11.Parent = Workspace_upv_1
            local u12 = u5:Clone()
            u12.Name = "UpdateCountdownBig"
            u12.Adornee = u11
            u12.PixelsPerStud = 1.680672268907563
            u12:ClearAllChildren()
            local v15 = Instance.new("Frame")
            v15.Name = "Root"
            v15.BackgroundTransparency = 1
            v15.Size = UDim2.fromScale(1, 1)
            v15.Parent = u12
            local u13 = text("Big", 300, 62, 560, 84, v2, 4, v15)
            u13.holder.Visible = false
            local tbl_upv_2 = {u8, u9, u10}
            local tbl_upv_3 = {}
            local v16 = math.ceil(#UPDATE_COUNTDOWN_upv_1.ranks / 2)
            for key_1, value_1 in UPDATE_COUNTDOWN_upv_1.ranks do
                local v17 = ((key_1 <= v16) and (310 - (v16 - key_1) * 74)) or (890 + ((key_1 - v16) - 1) * 74)
                local v18 = Instance.new("Frame")
                v18.Name = value_1.name
                v18.BackgroundTransparency = 1
                v18.AnchorPoint = Vector2.new(0.5, 0.5)
                v18.Position = UDim2.fromOffset(v17, 168)
                v18.Size = UDim2.fromOffset(62, 62)
                v18.Parent = u6
                local v19 = Instance.new("ImageLabel")
                v19.Name = "Emblem"
                v19.BackgroundTransparency = 1
                local Ranks_2 = UIAssets_upv_1.Ranks
                local v20 = (Ranks_2 and (Ranks_2[string.lower(value_1.name)])) or (value_1.img or "")
                v19.Image = v20
                v19.ScaleType = Enum.ScaleType.Fit
                v19.Size = UDim2.fromScale(1, 1)
                v19.Parent = v18
                local v21 = Instance.new("UIScale")
                v21.Parent = v18
                table.insert(tbl_upv_3, {cell = v18, img = v19, scale = v21})
            end
            local u14 = Instance.new("Frame")
            u14.Name = "Hero"
            u14.BackgroundTransparency = 1
            u14.AnchorPoint = Vector2.new(0.5, 0.5)
            u14.Position = UDim2.fromOffset(640, 120)
            u14.Size = UDim2.fromOffset(620, 210)
            u14.Visible = false
            u14.ZIndex = 3
            u14.Parent = u6
            local u15 = Instance.new("UIScale")
            u15.Parent = u14
            local u16 = Instance.new("ImageLabel")
            u16.Name = "Glow"
            u16.BackgroundTransparency = 1
            u16.Image = "rbxassetid://90962482350826"
            u16.ImageTransparency = 1
            u16.ScaleType = Enum.ScaleType.Stretch
            u16.AnchorPoint = Vector2.new(0.5, 0.5)
            u16.Position = UDim2.fromOffset(100, 105)
            u16.Size = UDim2.fromOffset(300, 300)
            u16.Parent = u14
            local u17 = Instance.new("UIScale")
            u17.Parent = u16
            local u18 = Instance.new("ImageLabel")
            u18.Name = "Emblem"
            u18.BackgroundTransparency = 1
            u18.ScaleType = Enum.ScaleType.Fit
            u18.AnchorPoint = Vector2.new(0.5, 0.5)
            u18.Position = UDim2.fromOffset(100, 105)
            u18.Size = UDim2.fromOffset(180, 180)
            u18.ZIndex = 4
            u18.Parent = u14
            local u19 = text("Kicker", 370, 66, 320, 30, v3, 2, u14)
            local u20 = text("HeroName", 370, 124, 320, 80, v2, 4, u14)
            for _, value_2 in {u19, u20} do
                value_2.label.TextXAlignment = Enum.TextXAlignment.Left
                value_2.shadow.TextXAlignment = Enum.TextXAlignment.Left
                value_2.label.ZIndex = 5
                value_2.shadow.ZIndex = 4
            end
            u19.label.Text = "NEW RANK REVEALED"
            u19.shadow.Text = "NEW RANK REVEALED"
            u19.label.TextColor3 = Gold_upv_1
            local u21 = Instance.new("ImageLabel")
            u21.Name = "Flyer"
            u21.BackgroundTransparency = 1
            u21.ScaleType = Enum.ScaleType.Fit
            u21.AnchorPoint = Vector2.new(0.5, 0.5)
            u21.Visible = false
            u21.ZIndex = 6
            u21.Parent = u6
            u5.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
            u12.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
            local u22 = Instance.new("ScreenGui")
            u22.Name = "UpdateCountdownBanner"
            u22.ResetOnSpawn = false
            u22.DisplayOrder = 30
            u22.IgnoreGuiInset = false
            u22.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
            local u23 = Instance.new("Frame")
            u23.Name = "Banner"
            u23.AnchorPoint = Vector2.new(0.5, 1)
            u23.Position = UDim2.new(0.5, 0, 0, -10)
            u23.Size = UDim2.fromOffset(420, 92)
            u23.BackgroundColor3 = fromRGB_upv_1(14, 17, 24)
            u23.BackgroundTransparency = 0.08
            u23.Visible = false
            u23.Parent = u22
            local u24 = Instance.new("UICorner")
            u24.CornerRadius = UDim.new(0, 14)
            u24.Parent = u23
            u24 = Instance.new("UIStroke")
            u24.Thickness = 2
            u24.Color = Gold_upv_1
            u24.Transparency = 0.25
            u24.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            u24.Parent = u23
            u24 = Instance.new("ImageLabel")
            u24.BackgroundTransparency = 1
            u24.ScaleType = Enum.ScaleType.Fit
            u24.Position = UDim2.fromOffset(12, 10)
            u24.Size = UDim2.fromOffset(72, 72)
            u24.Parent = u23
            local v22 = Instance.new("TextLabel")
            v22.BackgroundTransparency = 1
            v22.Position = UDim2.fromOffset(98, 14)
            v22.Size = UDim2.new(1, -110, 0, 22)
            v22.FontFace = v3
            v22.TextSize = 17
            v22.TextColor3 = Gold_upv_1
            v22.TextXAlignment = Enum.TextXAlignment.Left
            v22.Text = "NEW RANK REVEALED"
            v22.Parent = u23
            local u25 = Instance.new("TextLabel")
            u25.BackgroundTransparency = 1
            u25.Position = UDim2.fromOffset(98, 38)
            u25.Size = UDim2.new(1, -110, 0, 40)
            u25.FontFace = v2
            u25.TextScaled = true
            u25.TextColor3 = Colors_upv_1.White
            u25.TextXAlignment = Enum.TextXAlignment.Left
            u25.Parent = u23
            local u26 = 0
            local function showBanner(a1)
                --[[
                  name: showBanner
                  line: 368
                  upvalues:
                    u26 (ref,  index: 1)
                    u24 (copy, index: 2)
                    UIAssets_upv_1 (copy, index: 3)
                    u25 (copy, index: 4)
                    u23 (copy, index: 5)
                    TweenService_upv_1 (copy, index: 6)
                ]]
                u26 = u26 + 1
                local u27 = u26
                local Ranks_3 = UIAssets_upv_1.Ranks
                u24.Image = Ranks_3 and Ranks_3[string.lower(a1.name)] or a1.img or ""
                u25.Text = a1.name
                u23.Position = UDim2.new(0.5, 0, 0, -10)
                u23.Visible = true
                local v24 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                local tbl_4 = {}
                tbl_4.Position = UDim2.new(0.5, 0, 0, 110)
                TweenService_upv_1:Create(u23, v24, tbl_4):Play()
                task.delay(
                    4.2,
                    function()
                        --[[
                          line: 376
                          upvalues:
                            u26 (ref,  index: 1)
                            u27 (copy, index: 2)
                            TweenService_upv_1 (copy, index: 3)
                            u23 (copy, index: 4)
                        ]]
                        if u26 == u27 then
                            local v25 = TweenService_upv_1:Create(u23, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0, -10)})
                            v25.Completed:Once(
                                function()
                                    --[[
                                      line: 379
                                      upvalues:
                                        u26 (ref,  index: 1)
                                        u27 (copy, index: 2)
                                        u23 (copy, index: 3)
                                    ]]
                                    if u26 ~= u27 then
                                        return
                                    end
                                    u23.Visible = false
                                end
                            )
                            v25:Play()
                        end
                    end
                )
            end
            local u28 = Instance.new("Folder")
            u28.Name = "UpdateCountdownFx"
            u28.Parent = Workspace_upv_1
            local u29 = Random.new()
            local RightVector_upv_1 = u4.CFrame.RightVector
            local UpVector_upv_1 = u4.CFrame.UpVector
            local u30 = -u4.CFrame.LookVector
            local function around(a1, a2, a3)
                --[[
                  name: around
                  line: 401
                  upvalues:
                    RightVector_upv_1 (copy, index: 1)
                    UpVector_upv_1 (copy, index: 2)
                    u30 (copy, index: 3)
                ]]
                return ((Vector3.new(0, 66, -135) + (RightVector_upv_1 * a1)) + (UpVector_upv_1 * a2)) + (u30 * (a3 or 30))
            end
            local tbl_upv_5 = {}
            local function fwSound(a1, a2, a3, a4)
                --[[
                  name: fwSound
                  line: 410
                  upvalues:
                    Sfx_upv_1 (ref,  index: 1)
                    tbl_upv_5 (copy, index: 2)
                    u29 (copy, index: 3)
                ]]
                if not Sfx_upv_1 or (os.clock() - (tbl_upv_5[a1] or 0) < a2) then
                    return
                end
                tbl_upv_5[a1] = os.clock()
                task.delay(
                    a3,
                    function()
                        --[[
                          line: 415
                          upvalues:
                            Sfx_upv_1 (ref,  index: 1)
                            a1 (copy, index: 2)
                            a4 (copy, index: 3)
                            u29 (copy, index: 4)
                        ]]
                        pcall(Sfx_upv_1.Play, a1, nil, {volume = a4, pitch = u29:NextNumber(0.94, 1.06)})
                    end
                )
            end
            local function boom(a1)
                --[[
                  name: boom
                  line: 419
                  upvalues:
                    fwSound (copy, index: 1)
                ]]
                fwSound("Firework/Explode", 0.25, 0.15, 1)
                fwSound("Firework/Crackle", 0.6, 0.45, 1)
            end
            local function burst(a1, a2, a3)
                --[[
                  name: burst
                  line: 424
                  upvalues:
                    u28 (copy, index: 1)
                    Colors_upv_1 (copy, index: 2)
                ]]
                local u31 = Instance.new("Part")
                u31.Anchored = true
                u31.CanCollide = false
                u31.CanQuery = false
                u31.CanTouch = false
                u31.Transparency = 1
                u31.Size = Vector3.new(1, 1, 1)
                u31.CFrame = CFrame.new(a1)
                u31.Parent = u28
                local function emitter_1(a4, a5, a6, a7, a8, a9)
                    --[[
                      name: emitter
                      line: 434
                      upvalues:
                        a2 (copy, index: 1)
                        u31 (copy, index: 2)
                    ]]
                    local v26 = Instance.new("ParticleEmitter")
                    v26.Texture = "rbxasset://textures/particles/sparkles_main.dds"
                    v26.LightEmission = 1
                    v26.LightInfluence = 0
                    v26.Brightness = a9
                    v26.Color = ColorSequence.new(a8, a2)
                    v26.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a5), NumberSequenceKeypoint.new(0.7, a5 * 0.6), NumberSequenceKeypoint.new(1, 0)})
                    v26.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.75, 0.15), NumberSequenceKeypoint.new(1, 1)})
                    v26.Lifetime = NumberRange.new(a7 * 0.75, a7)
                    v26.Speed = NumberRange.new(a6 * 0.8, a6)
                    v26.SpreadAngle = Vector2.new(180, 180)
                    v26.Acceleration = Vector3.new(0, -22, 0)
                    v26.Drag = 1.6
                    v26.Rate = 0
                    v26.RotSpeed = NumberRange.new(-180, 180)
                    v26.Parent = u31
                    v26:Emit(a4)
                end
                emitter_1(math.floor(a3 * 120), a3 * 8, a3 * 72, 2, a2:Lerp(Colors_upv_1.White, 0.1), 3)
                emitter_1(math.floor(a3 * 26), a3 * 4, a3 * 36, 2.6, a2:Lerp(Colors_upv_1.White, 0.6), 2)
                task.delay(
                    4,
                    function()
                        --[[
                          line: 456
                          upvalues:
                            u31 (copy, index: 1)
                        ]]
                        u31:Destroy()
                    end
                )
            end
            local tbl_upv_6 = {fromRGB_upv_1(255, 204, 64), fromRGB_upv_1(255, 92, 92), fromRGB_upv_1(86, 202, 255), fromRGB_upv_1(186, 116, 255), fromRGB_upv_1(120, 236, 150), fromRGB_upv_1(255, 150, 80)}
            local function rocket(a1, a2, a3)
                --[[
                  name: rocket
                  line: 462
                  upvalues:
                    u29 (copy, index: 1)
                    Colors_upv_1 (copy, index: 2)
                    u28 (copy, index: 3)
                    TweenService_upv_1 (copy, index: 4)
                    burst (copy, index: 5)
                    fwSound (copy, index: 6)
                ]]
                local v27 = Vector3.new(a1.X + u29:NextNumber(-20, 20), 30, a1.Z + u29:NextNumber(-10, 10))
                local u32 = Instance.new("Part")
                u32.Anchored = true
                u32.CanCollide = false
                u32.CanQuery = false
                u32.CanTouch = false
                u32.CastShadow = false
                u32.Material = Enum.Material.Neon
                u32.Color = a2:Lerp(Colors_upv_1.White, 0.5)
                u32.Size = Vector3.new(1.600000023841858, 1.600000023841858, 1.600000023841858)
                u32.Shape = Enum.PartType.Ball
                u32.CFrame = CFrame.new(v27)
                v27 = Instance.new("Attachment")
                v27.Position = Vector3.new(0, 0.800000011920929, 0)
                v27.Parent = u32
                local v28 = Instance.new("Attachment")
                v28.Position = Vector3.new(0, -0.800000011920929, 0)
                v28.Parent = u32
                local v29 = Instance.new("Trail")
                v29.Attachment0 = v27
                v29.Attachment1 = v28
                v29.Lifetime = 0.45
                v29.LightEmission = 1
                v29.FaceCamera = true
                v29.Color = ColorSequence.new(a2:Lerp(Colors_upv_1.White, 0.6), a2)
                v29.Transparency = NumberSequence.new(0, 1)
                v29.WidthScale = NumberSequence.new(1, 0)
                v29.Parent = u32
                u32.Parent = u28
                local v30 = TweenService_upv_1:Create(u32, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(a1)})
                v30.Completed:Once(
                    function()
                        --[[
                          line: 493
                          upvalues:
                            u32 (copy, index: 1)
                            burst (copy, index: 2)
                            a1 (copy, index: 3)
                            a2 (copy, index: 4)
                            a3 (copy, index: 5)
                            fwSound (copy, index: 6)
                        ]]
                        u32.Transparency = 1
                        burst(a1, a2, a3)
                        fwSound("Firework/Explode", 0.25, 0.15, 1)
                        fwSound("Firework/Crackle", 0.6, 0.45, 1)
                        task.delay(
                            0.6,
                            function()
                                --[[
                                  line: 497
                                  upvalues:
                                    u32 (copy, index: 1)
                                ]]
                                u32:Destroy()
                            end
                        )
                    end
                )
                v30:Play()
            end
            local Lighting_2 = ReplicatedStorage_upv_1:FindFirstChild("Lighting")
            local u33 = Lighting_2 and (Lighting_2:FindFirstChild("Lobby"))
            local function base(a1, a2)
                --[[
                  name: base
                  line: 529
                  upvalues:
                    u33 (copy, index: 1)
                ]]
                local v31
                if u33 then
                    v31 = u33:GetAttribute(a1)
                else
                    v31 = u33
                end
                if v31 == nil then
                    return a2
                end
                return v31
            end
            local v32 = u33 and (u33:FindFirstChildOfClass("Atmosphere"))
            local tbl_upv_7 = {atmColor = 0, atmGlare = 0, atmHaze = 0, rays = 0, atmDensity = 0, outdoor = 0, clock = 0, brightness = 0, atmDecay = 0, shiftTop = 0}
            local v33 = u33 and (u33:GetAttribute("ClockTime"))
            local u34
            if v33 == nil then
                u34 = 16.3
            else
                u34 = v33
            end
            tbl_upv_7.clock = u34
            local v34 = fromRGB_upv_1(214, 184, 140)
            local v35 = u33 and (u33:GetAttribute("ColorShift_Top"))
            if v35 == nil then
                u34 = v34
            else
                u34 = v35
            end
            tbl_upv_7.shiftTop = u34
            local v36 = u33 and (u33:GetAttribute("Brightness"))
            if v36 == nil then
                u34 = 2.5
            else
                u34 = v36
            end
            tbl_upv_7.brightness = u34
            local v37 = fromRGB_upv_1(136, 128, 126)
            local v38 = u33 and (u33:GetAttribute("OutdoorAmbient"))
            if v38 == nil then
                u34 = v37
            else
                u34 = v38
            end
            tbl_upv_7.outdoor = u34
            if v32 then
                u34 = v32.Color
            else
                u34 = fromRGB_upv_1(224, 210, 190)
            end
            tbl_upv_7.atmColor = u34
            if v32 then
                u34 = v32.Decay
            else
                u34 = fromRGB_upv_1(170, 160, 178)
            end
            tbl_upv_7.atmDecay = u34
            tbl_upv_7.atmHaze = ((not v32) and 1.2) or (v32.Haze)
            tbl_upv_7.atmDensity = ((not v32) and 0.24) or (v32.Density)
            tbl_upv_7.atmGlare = ((not v32) and 0.08) or (v32.Glare)
            local v39 = u33 and (u33:FindFirstChildOfClass("SunRaysEffect"))
            if v39 then
                u34 = v39.Intensity
            else
                u34 = 0.035
            end
            tbl_upv_7.rays = u34
            local tbl_upv_8 = {bright = 2.9, density = 0.27, rays = 0.14, clock = 17.35, glare = 2.2, haze = 1.6}
            tbl_upv_8.shiftTop = fromRGB_upv_1(255, 176, 110)
            tbl_upv_8.atmColor = fromRGB_upv_1(255, 178, 130)
            tbl_upv_8.atmDecay = fromRGB_upv_1(232, 128, 140)
            tbl_upv_8.outdoor = fromRGB_upv_1(170, 132, 118)
            local tbl_upv_9 = {bright = 2.6, density = 0.29, rays = 0.2, clock = 17.62, glare = 3, haze = 1.9}
            tbl_upv_9.shiftTop = fromRGB_upv_1(255, 140, 100)
            tbl_upv_9.atmColor = fromRGB_upv_1(255, 150, 120)
            tbl_upv_9.atmDecay = fromRGB_upv_1(196, 98, 150)
            tbl_upv_9.outdoor = fromRGB_upv_1(156, 112, 128)
            u34 = Instance.new("ColorCorrectionEffect")
            u34.Name = "UpdateCountdownGrade"
            u34.Enabled = false
            u34.Parent = CurrentCamera_1
            local LightingController_upv_1 = nil
            pcall(
                function()
                    --[[
                      line: 560
                      upvalues:
                        LightingController_upv_1 (ref, index: 1)
                    ]]
                    LightingController_upv_1 = require(script.Parent.Parent.Core.LightingController)
                end
            )
            local function lobbyLit()
                --[[
                  name: lobbyLit
                  line: 563
                  upvalues:
                    LightingController_upv_1 (ref, index: 1)
                ]]
                if not LightingController_upv_1 then
                    return true
                end
                local success_1, v40 = pcall(LightingController_upv_1.Current)
                return success_1 and (v40 == "Lobby")
            end
            local tbl_upv_10 = {w = 0, d = 0}
            local u35 = false
            local function paintSky(a1, a2)
                --[[
                  name: paintSky
                  line: 573
                  upvalues:
                    LocalPlayer_upv_1 (copy, index: 1)
                    LightingController_upv_1 (ref,  index: 2)
                    u34 (copy, index: 3)
                    u35 (ref,  index: 4)
                    Lighting_upv_1 (copy, index: 5)
                    tbl_upv_7 (copy, index: 6)
                    tbl_upv_8 (copy, index: 7)
                    tbl_upv_9 (copy, index: 8)
                    Colors_upv_1 (copy, index: 9)
                    fromRGB_upv_1 (copy, index: 10)
                ]]
                local v41 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                if v41 then
                    if LightingController_upv_1 then
                        local success_2, v42 = pcall(LightingController_upv_1.Current)
                        v41 = success_2 and (v42 == "Lobby")
                    else
                        v41 = true
                    end
                    if v41 then
                        if a1 <= 0.001 and a2 <= 0.001 then
                            if u35 then
                                Lighting_upv_1.ClockTime = tbl_upv_7.clock
                                Lighting_upv_1.ColorShift_Top = tbl_upv_7.shiftTop
                                Lighting_upv_1.Brightness = tbl_upv_7.brightness
                                Lighting_upv_1.OutdoorAmbient = tbl_upv_7.outdoor
                                v41 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                                if v41 then
                                    v41.Color = tbl_upv_7.atmColor
                                    v41.Decay = tbl_upv_7.atmDecay
                                    v41.Haze = tbl_upv_7.atmHaze
                                    v41.Density = tbl_upv_7.atmDensity
                                    v41.Glare = tbl_upv_7.atmGlare
                                end
                                v41 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                                if v41 then
                                    v41.Intensity = tbl_upv_7.rays
                                end
                                u35 = false
                            end
                            u34.Enabled = false
                            return
                        end
                        u35 = true
                        local function mix_1(a3, a4, a5)
                            --[[
                              name: mix
                              line: 600
                              upvalues:
                                a1 (copy, index: 1)
                                a2 (copy, index: 2)
                            ]]
                            if typeof(a3) == "Color3" then
                                return a3:Lerp(a4, a1):Lerp(a5, a2)
                            end
                            local v43 = a3 + (a4 - a3) * a1
                            return v43 + ((a5 - v43) * a2)
                        end
                        local clock_1 = tbl_upv_7.clock
                        local clock_2 = tbl_upv_8.clock
                        local clock_3 = tbl_upv_9.clock
                        local v42
                        if typeof(clock_1) ~= "Color3" then
                            local _ = clock_1 + (clock_2 - clock_1) * a1
                            v42 = clock_1 + (clock_2 - clock_1) * a1 + (clock_3 - (clock_1 + (clock_2 - clock_1) * a1)) * a2
                        else
                            v42 = clock_1:Lerp(clock_2, a1):Lerp(clock_3, a2)
                        end
                        Lighting_upv_1.ClockTime = v42
                        local shiftTop_1 = tbl_upv_7.shiftTop
                        local shiftTop_2 = tbl_upv_8.shiftTop
                        local shiftTop_3 = tbl_upv_9.shiftTop
                        if typeof(shiftTop_1) ~= "Color3" then
                            local _ = shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1
                            v42 = shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1 + (shiftTop_3 - (shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1)) * a2
                        else
                            v42 = shiftTop_1:Lerp(shiftTop_2, a1):Lerp(shiftTop_3, a2)
                        end
                        Lighting_upv_1.ColorShift_Top = v42
                        local brightness_1 = tbl_upv_7.brightness
                        local bright_1 = tbl_upv_8.bright
                        local bright_2 = tbl_upv_9.bright
                        if typeof(brightness_1) ~= "Color3" then
                            local _ = brightness_1 + (bright_1 - brightness_1) * a1
                            v42 = brightness_1 + (bright_1 - brightness_1) * a1 + (bright_2 - (brightness_1 + (bright_1 - brightness_1) * a1)) * a2
                        else
                            v42 = brightness_1:Lerp(bright_1, a1):Lerp(bright_2, a2)
                        end
                        Lighting_upv_1.Brightness = v42
                        local v44 = tbl_upv_7.outdoor
                        local outdoor_1 = tbl_upv_8.outdoor
                        local outdoor_2 = tbl_upv_9.outdoor
                        if typeof(v44) ~= "Color3" then
                            local _ = v44 + (outdoor_1 - v44) * a1
                            v42 = v44 + (outdoor_1 - v44) * a1 + (outdoor_2 - (v44 + (outdoor_1 - v44) * a1)) * a2
                        else
                            v42 = v44:Lerp(outdoor_1, a1):Lerp(outdoor_2, a2)
                        end
                        Lighting_upv_1.OutdoorAmbient = v42
                        local v45 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                        local v46 = nil
                        if v45 then
                            v46 = tbl_upv_7.rays
                            local rays_1 = tbl_upv_8.rays
                            local rays_2 = tbl_upv_9.rays
                            if typeof(v46) ~= "Color3" then
                                local _ = v46 + (rays_1 - v46) * a1
                                v42 = v46 + (rays_1 - v46) * a1 + (rays_2 - (v46 + (rays_1 - v46) * a1)) * a2
                            else
                                v42 = v46:Lerp(rays_1, a1):Lerp(rays_2, a2)
                            end
                            v45.Intensity = v42
                        end
                        local v47 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                        local v48, v49, v50, v51, v52 = nil, nil, nil, nil, nil
                        if v47 then
                            v48 = tbl_upv_7.atmColor
                            local atmColor_1 = tbl_upv_8.atmColor
                            local atmColor_2 = tbl_upv_9.atmColor
                            if typeof(v48) ~= "Color3" then
                                local _ = v48 + (atmColor_1 - v48) * a1
                                v42 = v48 + (atmColor_1 - v48) * a1 + (atmColor_2 - (v48 + (atmColor_1 - v48) * a1)) * a2
                            else
                                v42 = v48:Lerp(atmColor_1, a1):Lerp(atmColor_2, a2)
                            end
                            v47.Color = v42
                            v49 = tbl_upv_7.atmDecay
                            local atmDecay_1 = tbl_upv_8.atmDecay
                            local atmDecay_2 = tbl_upv_9.atmDecay
                            if typeof(v49) ~= "Color3" then
                                local _ = v49 + (atmDecay_1 - v49) * a1
                                v42 = v49 + (atmDecay_1 - v49) * a1 + (atmDecay_2 - (v49 + (atmDecay_1 - v49) * a1)) * a2
                            else
                                v42 = v49:Lerp(atmDecay_1, a1):Lerp(atmDecay_2, a2)
                            end
                            v47.Decay = v42
                            v50 = tbl_upv_7.atmHaze
                            local haze_1 = tbl_upv_8.haze
                            local haze_2 = tbl_upv_9.haze
                            if typeof(v50) ~= "Color3" then
                                local _ = v50 + (haze_1 - v50) * a1
                                v42 = v50 + (haze_1 - v50) * a1 + (haze_2 - (v50 + (haze_1 - v50) * a1)) * a2
                            else
                                v42 = v50:Lerp(haze_1, a1):Lerp(haze_2, a2)
                            end
                            v47.Haze = v42
                            v51 = tbl_upv_7.atmDensity
                            local density_1 = tbl_upv_8.density
                            local density_2 = tbl_upv_9.density
                            if typeof(v51) ~= "Color3" then
                                local _ = v51 + (density_1 - v51) * a1
                                v42 = v51 + (density_1 - v51) * a1 + (density_2 - (v51 + (density_1 - v51) * a1)) * a2
                            else
                                v42 = v51:Lerp(density_1, a1):Lerp(density_2, a2)
                            end
                            v47.Density = v42
                            v52 = tbl_upv_7.atmGlare
                            local glare_1 = tbl_upv_8.glare
                            local glare_2 = tbl_upv_9.glare
                            if typeof(v52) ~= "Color3" then
                                local _ = v52 + (glare_1 - v52) * a1
                                v42 = v52 + (glare_1 - v52) * a1 + (glare_2 - (v52 + (glare_1 - v52) * a1)) * a2
                            else
                                v42 = v52:Lerp(glare_1, a1):Lerp(glare_2, a2)
                            end
                            v47.Glare = v42
                        end
                        u34.Enabled = true
                        local White_1 = Colors_upv_1.White
                        local v53 = fromRGB_upv_1(255, 238, 222)
                        local v54 = fromRGB_upv_1(255, 228, 226)
                        if typeof(White_1) ~= "Color3" then
                            local _ = White_1 + (v53 - White_1) * a1
                            v44 = White_1 + (v53 - White_1) * a1 + (v54 - (White_1 + (v53 - White_1) * a1)) * a2
                        else
                            v44 = White_1:Lerp(v53, a1):Lerp(v54, a2)
                        end
                        u34.TintColor = v44
                        u34.Saturation = a1 * 0.12
                        u34.Contrast = a1 * 0.05
                        u34.Brightness = a1 * 0.03
                        return
                    end
                end
                u34.Enabled = false
                u35 = false
            end
            local function localTime(a1)
                --[[
                  name: localTime
                  line: 644
                ]]
                local success_3, v55 = pcall(function() end)
                if success_3 then
                    return string.upper(v55) .. " YOUR TIME"
                end
                return ""
            end
            local at_upv_1 = UPDATE_COUNTDOWN_upv_1.at
            local success_4, v56 = pcall(
                function()
                    --[[
                      line: 645
                      upvalues:
                        at_upv_1 (copy, index: 1)
                    ]]
                    return DateTime.fromUnixTimestamp(at_upv_1):FormatLocalTime("dddd h:mm A", "en-us")
                end
            )
            local u36 = (success_4 and (string.upper(v56) .. " YOUR TIME")) or ""
            local tbl_upv_11 = {}
            local function set(a1, a2)
                --[[
                  name: set
                  line: 653
                  upvalues:
                    tbl_upv_11 (copy, index: 1)
                ]]
                if tbl_upv_11[a1] == a2 then
                    return
                end
                tbl_upv_11[a1] = a2
                a1.label.Text = a2
                a1.shadow.Text = a2
            end
            local function paintSlot(a1, a2)
                --[[
                  name: paintSlot
                  line: 668
                  upvalues:
                    tbl_upv_3 (copy, index: 1)
                    Colors_upv_1 (copy, index: 3)
                    u3 (copy, index: 4)
                ]]
                local v57 = tbl_upv_3[a1]
                v57.out = a2
                if a2 then
                    v57.img.ImageColor3 = Colors_upv_1.White
                    v57.img.ImageTransparency = 0
                else
                    v57.img.ImageColor3 = u3
                    v57.img.ImageTransparency = 0.15
                end
            end
            local u37 = false
            local u38 = 0
            local function fadeText(a1, a2)
                --[[
                  name: fadeText
                  line: 661
                  upvalues:
                    tbl_upv_2 (copy, index: 1)
                    TweenService_upv_1 (copy, index: 2)
                ]]
                for _, value_3 in tbl_upv_2 do
                    local tbl_12 = {}
                    tbl_12.TextTransparency = a1
                    TweenService_upv_1:Create(value_3.label, TweenInfo.new(a2), tbl_12):Play()
                    local v58 = TweenInfo.new(a2)
                    local tbl_13 = {}
                    tbl_13.TextTransparency = math.max(a1, 0.45)
                    TweenService_upv_1:Create(value_3.shadow, v58, tbl_13):Play()
                end
            end
            local function volley(a1, a2, a3, a4)
                --[[
                  name: volley
                  line: 507
                  upvalues:
                    u29 (copy, index: 1)
                    LocalPlayer_upv_1 (copy, index: 2)
                    rocket (copy, index: 3)
                    RightVector_upv_1 (copy, index: 4)
                    UpVector_upv_1 (copy, index: 5)
                    u30 (copy, index: 6)
                    tbl_upv_6 (copy, index: 7)
                ]]
                for n_upv_1 = 1, a1 do
                    task.delay(
                        (((n_upv_1 - 1) / math.max(1, a1 - 1)) * a2) + u29:NextNumber(0, 0.15),
                        function()
                            --[[
                              line: 509
                              upvalues:
                                LocalPlayer_upv_1 (copy, index: 1)
                                n_upv_1 (copy, index: 2)
                                u29 (copy, index: 3)
                                rocket (copy, index: 4)
                                RightVector_upv_1 (copy, index: 5)
                                UpVector_upv_1 (copy, index: 6)
                                u30 (copy, index: 7)
                                a3 (copy, index: 8)
                                tbl_upv_6 (copy, index: 9)
                                a4 (copy, index: 10)
                            ]]
                            local v59 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                            if not v59 then
                                return
                            end
                            local v60 = (((n_upv_1 % 2 ~= 0) and -1) or 1) * u29:NextNumber(150, 260)
                            v59 = u29:NextNumber(10, 80)
                            if n_upv_1 % 3 == 0 then
                                v60, v59 = u29:NextNumber(-140, 140), u29:NextNumber(70, 110)
                            end
                            local v61 = a3 or (tbl_upv_6[u29:NextInteger(1, #tbl_upv_6)])
                            rocket(((Vector3.new(0, 66, -135) + (RightVector_upv_1 * v60)) + (UpVector_upv_1 * v59)) + (u30 * 30), v61, a4)
                        end
                    )
                end
            end
            local function reveal(a1)
                --[[
                  name: reveal
                  line: 685
                  upvalues:
                    UPDATE_COUNTDOWN_upv_1 (copy, index: 1)
                    Gold_upv_1 (copy, index: 2)
                    u37 (ref,  index: 3)
                    u38 (ref,  index: 4)
                    tbl_upv_3 (copy, index: 5)
                    u3 (copy, index: 6)
                    u18 (copy, index: 7)
                    UIAssets_upv_1 (copy, index: 8)
                    u20 (copy, index: 9)
                    tbl_upv_11 (copy, index: 10)
                    Colors_upv_1 (copy, index: 11)
                    u19 (copy, index: 12)
                    u14 (copy, index: 13)
                    u15 (copy, index: 14)
                    fadeText (copy, index: 15)
                    TweenService_upv_1 (copy, index: 16)
                    u16 (copy, index: 17)
                    u17 (copy, index: 18)
                    Sfx_upv_1 (ref,  index: 19)
                    volley (copy, index: 20)
                    showBanner (copy, index: 21)
                    u21 (copy, index: 22)
                ]]
                local u39 = UPDATE_COUNTDOWN_upv_1.ranks[a1]
                local v62 = u39.color or Gold_upv_1
                local v63 = a1 == #UPDATE_COUNTDOWN_upv_1.ranks
                u37 = true
                u38 = a1
                local v64 = tbl_upv_3[a1]
                v64.out = false
                v64.img.ImageColor3 = u3
                v64.img.ImageTransparency = 0.15
                local Ranks_4 = UIAssets_upv_1.Ranks
                u18.Image = Ranks_4 and Ranks_4[string.lower(u39.name)] or u39.img or ""
                u18.ImageTransparency = 0
                local name_1 = u39.name
                if tbl_upv_11[u20] ~= name_1 then
                    tbl_upv_11[u20] = name_1
                    u20.label.Text = name_1
                    u20.shadow.Text = name_1
                end
                u20.label.TextColor3 = v62:Lerp(Colors_upv_1.White, 0.35)
                for _, value_4 in {u20, u19} do
                    value_4.label.TextTransparency = 0
                    value_4.shadow.TextTransparency = 0.45
                end
                u14.Position = UDim2.fromOffset(640, 120)
                u14.Visible = true
                u15.Scale = 0.3
                fadeText(1, 0.2)
                local tbl_14 = {Scale = 1}
                TweenService_upv_1:Create(u15, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_14):Play()
                u16.ImageColor3 = v62
                u16.ImageTransparency = 0
                u17.Scale = 0.4
                local tbl_15 = {ImageTransparency = 0.55}
                TweenService_upv_1:Create(u16, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_15):Play()
                local tbl_16 = {Scale = 1.3}
                TweenService_upv_1:Create(u17, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_16):Play()
                if Sfx_upv_1 then
                    pcall(Sfx_upv_1.PlayUI, "UI/Unlock")
                end
                if v63 then
                    task.delay(
                        0.15,
                        function()
                            --[[
                              line: 712
                              upvalues:
                                Sfx_upv_1 (ref, index: 1)
                            ]]
                            if not Sfx_upv_1 then
                                return
                            end
                            pcall(Sfx_upv_1.PlayUI, "UI/NewItem_Fanfare")
                        end
                    )
                end
                volley((v63 and 14) or 8, 2.4, v62, (v63 and 1.35) or 1.1)
                showBanner(u39)
                task.delay(
                    3.4,
                    function()
                        --[[
                          line: 718
                          upvalues:
                            tbl_upv_3 (copy, index: 1)
                            a1 (copy, index: 2)
                            u21 (copy, index: 3)
                            u39 (copy, index: 4)
                            UIAssets_upv_1 (copy, index: 5)
                            u14 (copy, index: 6)
                            u16 (copy, index: 7)
                            TweenService_upv_1 (copy, index: 8)
                            Colors_upv_1 (copy, index: 10)
                            Sfx_upv_1 (ref,  index: 11)
                            fadeText (copy, index: 12)
                            u37 (ref,  index: 13)
                            u38 (ref,  index: 14)
                        ]]
                        local v66 = tbl_upv_3[a1]
                        local v67 = Vector2.new(430, 120)
                        local Ranks_5 = UIAssets_upv_1.Ranks
                        u21.Image = Ranks_5 and Ranks_5[string.lower(u39.name)] or u39.img or ""
                        u21.Position = UDim2.fromOffset(v67.X, v67.Y)
                        u21.Size = UDim2.fromOffset(180, 180)
                        u21.Visible = true
                        u14.Visible = false
                        u16.ImageTransparency = 1
                        local v69 = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                        local tbl_17 = {}
                        tbl_17.Position = v66.cell.Position
                        tbl_17.Size = UDim2.fromOffset(62, 62)
                        TweenService_upv_1:Create(u21, v69, tbl_17):Play()
                        task.wait(0.55)
                        u21.Visible = false
                        local v70 = tbl_upv_3[a1]
                        v70.out = true
                        v70.img.ImageColor3 = Colors_upv_1.White
                        v70.img.ImageTransparency = 0
                        v66.scale.Scale = 1.6
                        local tbl_18 = {Scale = 1}
                        TweenService_upv_1:Create(v66.scale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_18):Play()
                        if Sfx_upv_1 then
                            pcall(Sfx_upv_1.PlayUI, "UI/Card_Reveal")
                        end
                        fadeText(0, 0.35)
                        u37 = false
                        u38 = 0
                    end
                )
            end
            local u40 = -1
            local u41 = ""
            local u42 = false
            local u43 = os.clock()
            local u44 = nil
            local u45 = 0
            local tbl_upv_19 = {}
            Workspace_upv_1:GetAttributeChangedSignal("CountdownPreviewAt"):Connect(
                function()
                    --[[
                      line: 754
                      upvalues:
                        u42 (ref,  index: 1)
                        u41 (ref,  index: 2)
                        u44 (ref,  index: 3)
                        tbl_upv_19 (copy, index: 4)
                    ]]
                    u42 = false
                    u41 = ""
                    u44 = nil
                    table.clear(tbl_upv_19)
                end
            )
            local function clock_4(a1)
                --[[
                  name: clock
                  line: 633
                ]]
                local v71 = a1 // 86400
                local v72 = a1 // 3600 % 24
                local v73 = a1 // 60 % 60
                local v74 = a1 % 60
                if v71 > 0 then
                    return string.format("%dD %02d:%02d:%02d", v71, v72, v73, v74)
                elseif v72 > 0 then
                    return string.format("%d:%02d:%02d", v72, v73, v74)
                else
                    return string.format("%d:%02d", v73, v74)
                end
            end
            local function step(a1)
                --[[
                  name: step
                  line: 761
                  upvalues:
                    Workspace_upv_1 (copy, index: 1)
                    UPDATE_COUNTDOWN_upv_1 (copy, index: 2)
                    LocalPlayer_upv_1 (copy, index: 3)
                    u5 (copy, index: 4)
                    u12 (copy, index: 5)
                    u22 (copy, index: 6)
                    tbl_upv_3 (copy, index: 7)
                    u42 (ref,  index: 8)
                    Colors_upv_1 (copy, index: 9)
                    u3 (copy, index: 10)
                    tbl_upv_19 (copy, index: 11)
                    u38 (ref,  index: 12)
                    u43 (copy, index: 13)
                    u37 (ref,  index: 14)
                    reveal (copy, index: 15)
                    u1 (copy, index: 16)
                    u2 (copy, index: 17)
                    ReplicatedStorage_upv_1 (copy, index: 18)
                    tbl_upv_10 (copy, index: 19)
                    paintSky (copy, index: 20)
                    u8 (copy, index: 21)
                    Gold_upv_1 (copy, index: 22)
                    u9 (copy, index: 23)
                    u10 (copy, index: 24)
                    tbl_upv_11 (copy, index: 25)
                    u13 (copy, index: 26)
                    u40 (ref,  index: 27)
                    TweenService_upv_1 (copy, index: 28)
                    Sfx_upv_1 (ref,  index: 29)
                    u36 (copy, index: 30)
                    clock_4 (copy, index: 31)
                    u41 (ref,  index: 32)
                    u44 (ref,  index: 33)
                    volley (copy, index: 34)
                    u45 (ref,  index: 35)
                    u29 (copy, index: 36)
                ]]
                local v75 = Workspace_upv_1:GetServerTimeNow()
                local v76 = Workspace_upv_1:GetAttribute("CountdownPreview")
                local v77 = Workspace_upv_1:GetAttribute("CountdownPreviewAt")
                local v78
                if type(v76) == "number" and type(v77) == "number" then
                    v78 = UPDATE_COUNTDOWN_upv_1.at - v76 + (v75 - v77)
                else
                    v78 = v75
                end
                local v79 = UPDATE_COUNTDOWN_upv_1.at - v78
                local v80 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                u5.Enabled = v80
                u12.Enabled = v80
                u22.Enabled = v80
                for key_2, value_5 in UPDATE_COUNTDOWN_upv_1.ranks do
                    local v81 = UPDATE_COUNTDOWN_upv_1.at - value_5.hours * 3600
                    local v82 = v81 <= v78
                    local v83 = tbl_upv_3[key_2]
                    if v83.out == nil or not (u42) then
                        local v84 = tbl_upv_3[key_2]
                        v84.out = v82
                        if v82 then
                            v84.img.ImageColor3 = Colors_upv_1.White
                            v84.img.ImageTransparency = 0
                        else
                            v84.img.ImageColor3 = u3
                            v84.img.ImageTransparency = 0.15
                        end
                        continue
                    end
                    if v82 then
                        if v83.out or table.find(tbl_upv_19, key_2) or u38 == key_2 then
                            if v82 then
                                continue
                            end
                            if v83.out then
                                local v85 = tbl_upv_3[key_2]
                                v85.out = false
                                v85.img.ImageColor3 = u3
                                v85.img.ImageTransparency = 0.15
                            end
                        else
                            if not (v78 - v81 < 4) then
                                local v86 = tbl_upv_3[key_2]
                                v86.out = true
                                v86.img.ImageColor3 = Colors_upv_1.White
                                v86.img.ImageTransparency = 0
                                continue
                            end
                            if os.clock() - u43 > 6 then
                                table.insert(tbl_upv_19, key_2)
                            else
                                local v86 = tbl_upv_3[key_2]
                                v86.out = true
                                v86.img.ImageColor3 = Colors_upv_1.White
                                v86.img.ImageTransparency = 0
                            end
                        end
                    else
                        if v82 then
                            continue
                        end
                        if v83.out then
                            local v85 = tbl_upv_3[key_2]
                            v85.out = false
                            v85.img.ImageColor3 = u3
                            v85.img.ImageTransparency = 0.15
                        end
                    end
                end
                u42 = true
                if not (u37) and #tbl_upv_19 > 0 then
                    local v87 = table.remove(tbl_upv_19, 1)
                    if v80 then
                        reveal(v87)
                    else
                        local v88 = tbl_upv_3[v87]
                        v88.out = true
                        v88.img.ImageColor3 = Colors_upv_1.White
                        v88.img.ImageTransparency = 0
                    end
                end
                local v89 = 0
                local v90 = 0
                if (v79 > 0) and (v79 <= u1) then
                    if u2 < v79 then
                        local _ = (u1 - v79) / (u1 - u2)
                        v89 = 0.6 * ((u1 - v79) / (u1 - u2)) * ((u1 - v79) / (u1 - u2)) * (3 - 2 * ((u1 - v79) / (u1 - u2)))
                    else
                        v89 = 0.6 + 0.4 * (1 - (math.max(0, v79 - 60) / (u2 - 60)))
                    end
                    v90 = ((v79 <= 60) and (1 - v79 / 60)) or 0
                elseif v79 <= 0 then
                    local v91 = ((Workspace_upv_1:GetAttribute("CountdownPreviewShipped") == true) and true) or ((UPDATE_COUNTDOWN_upv_1.shipped ~= nil) and (ReplicatedStorage_upv_1.Shared:FindFirstChild(UPDATE_COUNTDOWN_upv_1.shipped) ~= nil))
                    if not v91 then
                        v89, v90 = 1, 1
                    end
                end
                local v92 = ((os.clock() - u43 < 0.4) and 1) or (math.min(1, a1 * 0.6))
                tbl_upv_10.w = tbl_upv_10.w + ((v89 - tbl_upv_10.w) * v92)
                tbl_upv_10.d = tbl_upv_10.d + ((v90 - tbl_upv_10.d) * v92)
                paintSky(tbl_upv_10.w, tbl_upv_10.d)
                local v93 = nil
                if v79 > 0 then
                    local v94 = math.ceil(v79)
                    v90 = ((v79 <= 60) and "final") or (((v79 <= u2) and "close") or "far")
                    for _, value_6 in tbl_upv_3 do
                        value_6.cell.Visible = true
                    end
                    v89 = v90 ~= "far"
                    local label_1 = u8.label
                    local v95
                    if v89 then
                        v95 = Gold_upv_1
                    else
                        v95 = Colors_upv_1.White
                    end
                    label_1.TextColor3 = v95
                    local label_2 = u9.label
                    local v96
                    if v89 then
                        v96 = Gold_upv_1
                    else
                        v96 = Colors_upv_1.White
                    end
                    label_2.TextColor3 = v96
                    local v97, v98, v99 = nil, nil, nil
                    if v90 ~= "final" then
                        v97 = u36
                        if tbl_upv_11[u10] ~= v97 then
                            tbl_upv_11[u10] = v97
                            u10.label.Text = v97
                            u10.shadow.Text = v97
                        end
                        u10.label.TextColor3 = Colors_upv_1.White
                        u8.holder.Visible = true
                        u9.holder.Visible = true
                        u13.holder.Visible = false
                        v98 = clock_4(v94)
                        if tbl_upv_11[u9] ~= v98 then
                            tbl_upv_11[u9] = v98
                            u9.label.Text = v98
                            u9.shadow.Text = v98
                        end
                    else
                        v99 = string.upper(UPDATE_COUNTDOWN_upv_1.title) .. " IN"
                        if tbl_upv_11[u10] ~= v99 then
                            tbl_upv_11[u10] = v99
                            u10.label.Text = v99
                            u10.shadow.Text = v99
                        end
                        u10.label.TextColor3 = Gold_upv_1
                        u8.holder.Visible = false
                        u9.holder.Visible = false
                        u13.holder.Visible = not u37
                        local label_3 = u13.label
                        local v100
                        if v94 <= 10 then
                            v100 = Colors_upv_1.White
                        else
                            v100 = Gold_upv_1
                        end
                        label_3.TextColor3 = v100
                        local v101 = nil
                        if v94 ~= u40 then
                            v101 = tostring(v94)
                            if tbl_upv_11[u13] ~= v101 then
                                tbl_upv_11[u13] = v101
                                u13.label.Text = v101
                                u13.shadow.Text = v101
                            end
                            u13.scale.Scale = ((v94 <= 10) and 1.2) or 1.12
                            local tbl_20 = {Scale = 1}
                            TweenService_upv_1:Create(u13.scale, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_20):Play()
                            if v80 then
                                local v102 = ((v94 <= 3) and "Match/Countdown_1") or "Match/Countdown_Tick"
                                if Sfx_upv_1 then
                                    pcall(Sfx_upv_1.PlayUI, v102)
                                end
                            end
                        end
                    end
                    u40 = v94
                    u41 = v90
                else
                    if u41 == "final" or u41 == "close" then
                        u44 = os.clock()
                        if v80 then
                            if Sfx_upv_1 then
                                pcall(Sfx_upv_1.PlayUI, "Match/Victory")
                            end
                            volley(16, 7, nil, 1.5)
                            task.delay(
                                7.5,
                                function()
                                    --[[
                                      line: 863
                                      upvalues:
                                        volley (copy, index: 1)
                                    ]]
                                    volley(10, 3, nil, 1.8)
                                end
                            )
                        end
                    end
                    if u41 ~= "done" then
                        u13.scale.Scale = 0.4
                        local tbl_21 = {Scale = 1}
                        TweenService_upv_1:Create(u13.scale, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_21):Play()
                    end
                    u41 = "done"
                    for _, value_7 in tbl_upv_3 do
                        value_7.cell.Visible = false
                    end
                    u8.holder.Visible = false
                    u9.holder.Visible = false
                    u10.holder.Visible = true
                    u13.holder.Visible = true
                    u10.label.TextColor3 = Gold_upv_1
                    v93 = string.upper(UPDATE_COUNTDOWN_upv_1.title)
                    if tbl_upv_11[u10] ~= v93 then
                        tbl_upv_11[u10] = v93
                        u10.label.Text = v93
                        u10.shadow.Text = v93
                    end
                    local v103 = ((Workspace_upv_1:GetAttribute("CountdownPreviewShipped") == true) and true) or ((UPDATE_COUNTDOWN_upv_1.shipped ~= nil) and (ReplicatedStorage_upv_1.Shared:FindFirstChild(UPDATE_COUNTDOWN_upv_1.shipped) ~= nil))
                    if v103 then
                        if UPDATE_COUNTDOWN_upv_1.OUT_FOR < -v79 then
                            return false
                        end
                        if tbl_upv_11[u13] ~= "OUT NOW!" then
                            tbl_upv_11[u13] = "OUT NOW!"
                            u13.label.Text = "OUT NOW!"
                            u13.shadow.Text = "OUT NOW!"
                        end
                        u13.label.TextColor3 = Gold_upv_1
                        if v80 then
                            local v104 = os.clock()
                            if u45 <= v104 and -v79 < 7200 then
                                u45 = os.clock() + u29:NextNumber(25, 40)
                                if u44 == nil or os.clock() - u44 > 15 then
                                    volley(5, 2.5, nil, 1.1)
                                end
                            end
                        end
                    else
                        if tbl_upv_11[u13] ~= "SERVERS RESTARTING..." then
                            tbl_upv_11[u13] = "SERVERS RESTARTING..."
                            u13.label.Text = "SERVERS RESTARTING..."
                            u13.shadow.Text = "SERVERS RESTARTING..."
                        end
                        u13.label.TextColor3 = Colors_upv_1.White
                    end
                end
                return true
            end
            local u46 = nil
            local u47 = 0
            local v105 = RunService_1.Heartbeat:Connect(
                function(a1)
                    --[[
                      line: 904
                      upvalues:
                        u47 (ref,  index: 1)
                        step (copy, index: 2)
                        u46 (ref,  index: 3)
                        LocalPlayer_upv_1 (copy, index: 4)
                        LightingController_upv_1 (ref,  index: 5)
                        u34 (copy, index: 6)
                        u35 (ref,  index: 7)
                        Lighting_upv_1 (copy, index: 8)
                        tbl_upv_7 (copy, index: 9)
                        u5 (copy, index: 10)
                        u12 (copy, index: 11)
                        u22 (copy, index: 12)
                        u4 (copy, index: 13)
                        u11 (copy, index: 14)
                        u28 (copy, index: 15)
                    ]]
                    u47 = u47 + a1
                    if u47 < 0.05 then
                        return
                    end
                    local success_5, v106 = pcall(step, u47)
                    u47 = 0
                    if success_5 and v106 == false then
                        if u46 then
                            u46:Disconnect()
                        end
                        local v107 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                        if v107 then
                            if LightingController_upv_1 then
                                local success_6, v108 = pcall(LightingController_upv_1.Current)
                                v107 = success_6 and (v108 == "Lobby")
                            else
                                v107 = true
                            end
                            if v107 then
                                if u35 then
                                    Lighting_upv_1.ClockTime = tbl_upv_7.clock
                                    Lighting_upv_1.ColorShift_Top = tbl_upv_7.shiftTop
                                    Lighting_upv_1.Brightness = tbl_upv_7.brightness
                                    Lighting_upv_1.OutdoorAmbient = tbl_upv_7.outdoor
                                    v107 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                                    if v107 then
                                        v107.Color = tbl_upv_7.atmColor
                                        v107.Decay = tbl_upv_7.atmDecay
                                        v107.Haze = tbl_upv_7.atmHaze
                                        v107.Density = tbl_upv_7.atmDensity
                                        v107.Glare = tbl_upv_7.atmGlare
                                    end
                                    v107 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                                    if v107 then
                                        v107.Intensity = tbl_upv_7.rays
                                    end
                                    u35 = false
                                end
                                u34.Enabled = false
                            else
                                u34.Enabled = false
                                u35 = false
                            end
                        else
                            u34.Enabled = false
                            u35 = false
                        end
                        u5:Destroy()
                        u12:Destroy()
                        u22:Destroy()
                        u4:Destroy()
                        u11:Destroy()
                        u28:Destroy()
                        u34:Destroy()
                        return
                    end
                    if (success_5) then
                        return
                    end
                    warn("[UpdateCountdown] " .. tostring(v106))
                end
            )
            u46 = v105
        end
    else
        local function inLobby()
            --[[
              name: inLobby
              line: 100
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
            ]]
            local v6 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
            return v6
        end
        local function now()
            --[[
              name: now
              line: 105
              upvalues:
                Workspace_upv_1 (copy, index: 1)
                UPDATE_COUNTDOWN_upv_1 (copy, index: 2)
            ]]
            local v7 = Workspace_upv_1:GetServerTimeNow()
            local v8 = Workspace_upv_1:GetAttribute("CountdownPreview")
            local v9 = Workspace_upv_1:GetAttribute("CountdownPreviewAt")
            if type(v8) == "number" and type(v9) == "number" then
                return (UPDATE_COUNTDOWN_upv_1.at - v8) + (v7 - v9)
            end
            return v7
        end
        local function play(a1)
            --[[
              name: play
              line: 114
              upvalues:
                Sfx_upv_1 (ref, index: 1)
            ]]
            if not Sfx_upv_1 then
                return
            end
            pcall(Sfx_upv_1.PlayUI, a1)
        end
        local u4 = Instance.new("Part")
        u4.Name = "UpdateCountdownSky"
        u4.Anchored = true
        u4.CanCollide = false
        u4.CanQuery = false
        u4.CanTouch = false
        u4.CastShadow = false
        u4.Transparency = 1
        u4.Size = Vector3.new(357, 64, 0.20000000298023224)
        u4.CFrame = CFrame.lookAt(Vector3.new(0, 66, -135), Vector3.new(0, 9, 120))
        u4.Parent = Workspace_upv_1
        local u5 = Instance.new("SurfaceGui")
        u5.Name = "UpdateCountdown"
        u5.Adornee = u4
        u5.Face = Enum.NormalId.Front
        u5.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
        u5.PixelsPerStud = 3.361344537815126
        u5.LightInfluence = 0
        u5.Brightness = 1.25
        u5.MaxDistance = 2000
        u5.ResetOnSpawn = false
        u5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        local u6 = Instance.new("Frame")
        u6.Name = "Root"
        u6.BackgroundTransparency = 1
        u6.Size = UDim2.fromScale(1, 1)
        u6.Parent = u5
        local v10 = Instance.new("ImageLabel")
        v10.Name = "Plate"
        v10.BackgroundTransparency = 1
        v10.Image = "rbxassetid://90962482350826"
        v10.ImageColor3 = u3
        v10.ImageTransparency = 0.3
        v10.ScaleType = Enum.ScaleType.Stretch
        v10.AnchorPoint = Vector2.new(0.5, 0.5)
        v10.Position = UDim2.fromOffset(600, 112)
        v10.Size = UDim2.fromOffset(1240, 300)
        v10.Parent = u6
        local function text(a1, a2, a3, a4, a5, a6, a7, a8)
            --[[
              name: text
              line: 155
              upvalues:
                u6 (copy, index: 1)
                u3 (copy, index: 2)
                Colors_upv_1 (copy, index: 3)
            ]]
            local u7 = Instance.new("Frame")
            u7.Name = a1
            u7.BackgroundTransparency = 1
            u7.AnchorPoint = Vector2.new(0.5, 0.5)
            u7.Position = UDim2.fromOffset(a2, a3)
            u7.Size = UDim2.fromOffset(a4, a5)
            u7.Parent = a8 or u6
            local v12 = Instance.new("UIScale")
            v12.Parent = u7
            local function mk_1(a9, a10, a11, a12, a13)
                --[[
                  name: mk
                  line: 165
                  upvalues:
                    a6 (copy, index: 1)
                    u7 (copy, index: 2)
                ]]
                local v13 = Instance.new("TextLabel")
                v13.Name = a9
                v13.BackgroundTransparency = 1
                v13.TextScaled = true
                v13.FontFace = a6
                v13.TextColor3 = a11
                v13.TextTransparency = a12
                v13.Position = UDim2.fromOffset(0, a10)
                v13.Size = UDim2.fromScale(1, 1)
                v13.Text = ""
                v13.ZIndex = a13
                v13.Parent = u7
                return v13
            end
            local v14 = mk_1("Shadow", a7, u3, 0.45, 1)
            local tbl_1 = {}
            tbl_1.label = mk_1("Text", 0, Colors_upv_1.White, 0, 2)
            tbl_1.shadow = v14
            tbl_1.holder = u7
            tbl_1.scale = v12
            return tbl_1
        end
        local u8 = text("Title", 600, 82, 1000, 84, v2, 4)
        u8.label.Text = UPDATE_COUNTDOWN_upv_1.title
        u8.shadow.Text = UPDATE_COUNTDOWN_upv_1.title
        local u9 = text("Timer", 600, 168, 480, 74, v2, 4)
        local u10 = text("When", 600, 22, 600, 24, v3, 2)
        local u11 = u4:Clone()
        u11.Name = "UpdateCountdownSkyBig"
        u11.CFrame = u4.CFrame * CFrame.new(0, 0, -0.3)
        u11.Parent = Workspace_upv_1
        local u12 = u5:Clone()
        u12.Name = "UpdateCountdownBig"
        u12.Adornee = u11
        u12.PixelsPerStud = 1.680672268907563
        u12:ClearAllChildren()
        local v15 = Instance.new("Frame")
        v15.Name = "Root"
        v15.BackgroundTransparency = 1
        v15.Size = UDim2.fromScale(1, 1)
        v15.Parent = u12
        local u13 = text("Big", 300, 62, 560, 84, v2, 4, v15)
        u13.holder.Visible = false
        local tbl_upv_2 = {u8, u9, u10}
        local tbl_upv_3 = {}
        local v16 = math.ceil(#UPDATE_COUNTDOWN_upv_1.ranks / 2)
        for key_1, value_1 in UPDATE_COUNTDOWN_upv_1.ranks do
            local v17 = ((key_1 <= v16) and (310 - (v16 - key_1) * 74)) or (890 + ((key_1 - v16) - 1) * 74)
            local v18 = Instance.new("Frame")
            v18.Name = value_1.name
            v18.BackgroundTransparency = 1
            v18.AnchorPoint = Vector2.new(0.5, 0.5)
            v18.Position = UDim2.fromOffset(v17, 168)
            v18.Size = UDim2.fromOffset(62, 62)
            v18.Parent = u6
            local v19 = Instance.new("ImageLabel")
            v19.Name = "Emblem"
            v19.BackgroundTransparency = 1
            local Ranks_2 = UIAssets_upv_1.Ranks
            local v20 = (Ranks_2 and (Ranks_2[string.lower(value_1.name)])) or (value_1.img or "")
            v19.Image = v20
            v19.ScaleType = Enum.ScaleType.Fit
            v19.Size = UDim2.fromScale(1, 1)
            v19.Parent = v18
            local v21 = Instance.new("UIScale")
            v21.Parent = v18
            table.insert(tbl_upv_3, {cell = v18, img = v19, scale = v21})
        end
        local u14 = Instance.new("Frame")
        u14.Name = "Hero"
        u14.BackgroundTransparency = 1
        u14.AnchorPoint = Vector2.new(0.5, 0.5)
        u14.Position = UDim2.fromOffset(640, 120)
        u14.Size = UDim2.fromOffset(620, 210)
        u14.Visible = false
        u14.ZIndex = 3
        u14.Parent = u6
        local u15 = Instance.new("UIScale")
        u15.Parent = u14
        local u16 = Instance.new("ImageLabel")
        u16.Name = "Glow"
        u16.BackgroundTransparency = 1
        u16.Image = "rbxassetid://90962482350826"
        u16.ImageTransparency = 1
        u16.ScaleType = Enum.ScaleType.Stretch
        u16.AnchorPoint = Vector2.new(0.5, 0.5)
        u16.Position = UDim2.fromOffset(100, 105)
        u16.Size = UDim2.fromOffset(300, 300)
        u16.Parent = u14
        local u17 = Instance.new("UIScale")
        u17.Parent = u16
        local u18 = Instance.new("ImageLabel")
        u18.Name = "Emblem"
        u18.BackgroundTransparency = 1
        u18.ScaleType = Enum.ScaleType.Fit
        u18.AnchorPoint = Vector2.new(0.5, 0.5)
        u18.Position = UDim2.fromOffset(100, 105)
        u18.Size = UDim2.fromOffset(180, 180)
        u18.ZIndex = 4
        u18.Parent = u14
        local u19 = text("Kicker", 370, 66, 320, 30, v3, 2, u14)
        local u20 = text("HeroName", 370, 124, 320, 80, v2, 4, u14)
        for _, value_2 in {u19, u20} do
            value_2.label.TextXAlignment = Enum.TextXAlignment.Left
            value_2.shadow.TextXAlignment = Enum.TextXAlignment.Left
            value_2.label.ZIndex = 5
            value_2.shadow.ZIndex = 4
        end
        u19.label.Text = "NEW RANK REVEALED"
        u19.shadow.Text = "NEW RANK REVEALED"
        u19.label.TextColor3 = Gold_upv_1
        local u21 = Instance.new("ImageLabel")
        u21.Name = "Flyer"
        u21.BackgroundTransparency = 1
        u21.ScaleType = Enum.ScaleType.Fit
        u21.AnchorPoint = Vector2.new(0.5, 0.5)
        u21.Visible = false
        u21.ZIndex = 6
        u21.Parent = u6
        u5.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
        u12.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
        local u22 = Instance.new("ScreenGui")
        u22.Name = "UpdateCountdownBanner"
        u22.ResetOnSpawn = false
        u22.DisplayOrder = 30
        u22.IgnoreGuiInset = false
        u22.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
        local u23 = Instance.new("Frame")
        u23.Name = "Banner"
        u23.AnchorPoint = Vector2.new(0.5, 1)
        u23.Position = UDim2.new(0.5, 0, 0, -10)
        u23.Size = UDim2.fromOffset(420, 92)
        u23.BackgroundColor3 = fromRGB_upv_1(14, 17, 24)
        u23.BackgroundTransparency = 0.08
        u23.Visible = false
        u23.Parent = u22
        local u24 = Instance.new("UICorner")
        u24.CornerRadius = UDim.new(0, 14)
        u24.Parent = u23
        u24 = Instance.new("UIStroke")
        u24.Thickness = 2
        u24.Color = Gold_upv_1
        u24.Transparency = 0.25
        u24.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        u24.Parent = u23
        u24 = Instance.new("ImageLabel")
        u24.BackgroundTransparency = 1
        u24.ScaleType = Enum.ScaleType.Fit
        u24.Position = UDim2.fromOffset(12, 10)
        u24.Size = UDim2.fromOffset(72, 72)
        u24.Parent = u23
        local v22 = Instance.new("TextLabel")
        v22.BackgroundTransparency = 1
        v22.Position = UDim2.fromOffset(98, 14)
        v22.Size = UDim2.new(1, -110, 0, 22)
        v22.FontFace = v3
        v22.TextSize = 17
        v22.TextColor3 = Gold_upv_1
        v22.TextXAlignment = Enum.TextXAlignment.Left
        v22.Text = "NEW RANK REVEALED"
        v22.Parent = u23
        local u25 = Instance.new("TextLabel")
        u25.BackgroundTransparency = 1
        u25.Position = UDim2.fromOffset(98, 38)
        u25.Size = UDim2.new(1, -110, 0, 40)
        u25.FontFace = v2
        u25.TextScaled = true
        u25.TextColor3 = Colors_upv_1.White
        u25.TextXAlignment = Enum.TextXAlignment.Left
        u25.Parent = u23
        local u26 = 0
        local function showBanner(a1)
            --[[
              name: showBanner
              line: 368
              upvalues:
                u26 (ref,  index: 1)
                u24 (copy, index: 2)
                UIAssets_upv_1 (copy, index: 3)
                u25 (copy, index: 4)
                u23 (copy, index: 5)
                TweenService_upv_1 (copy, index: 6)
            ]]
            u26 = u26 + 1
            local u27 = u26
            local Ranks_3 = UIAssets_upv_1.Ranks
            u24.Image = Ranks_3 and Ranks_3[string.lower(a1.name)] or a1.img or ""
            u25.Text = a1.name
            u23.Position = UDim2.new(0.5, 0, 0, -10)
            u23.Visible = true
            local v24 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            local tbl_4 = {}
            tbl_4.Position = UDim2.new(0.5, 0, 0, 110)
            TweenService_upv_1:Create(u23, v24, tbl_4):Play()
            task.delay(
                4.2,
                function()
                    --[[
                      line: 376
                      upvalues:
                        u26 (ref,  index: 1)
                        u27 (copy, index: 2)
                        TweenService_upv_1 (copy, index: 3)
                        u23 (copy, index: 4)
                    ]]
                    if u26 == u27 then
                        local v25 = TweenService_upv_1:Create(u23, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0, -10)})
                        v25.Completed:Once(
                            function()
                                --[[
                                  line: 379
                                  upvalues:
                                    u26 (ref,  index: 1)
                                    u27 (copy, index: 2)
                                    u23 (copy, index: 3)
                                ]]
                                if u26 ~= u27 then
                                    return
                                end
                                u23.Visible = false
                            end
                        )
                        v25:Play()
                    end
                end
            )
        end
        local u28 = Instance.new("Folder")
        u28.Name = "UpdateCountdownFx"
        u28.Parent = Workspace_upv_1
        local u29 = Random.new()
        local RightVector_upv_1 = u4.CFrame.RightVector
        local UpVector_upv_1 = u4.CFrame.UpVector
        local u30 = -u4.CFrame.LookVector
        local function around(a1, a2, a3)
            --[[
              name: around
              line: 401
              upvalues:
                RightVector_upv_1 (copy, index: 1)
                UpVector_upv_1 (copy, index: 2)
                u30 (copy, index: 3)
            ]]
            return ((Vector3.new(0, 66, -135) + (RightVector_upv_1 * a1)) + (UpVector_upv_1 * a2)) + (u30 * (a3 or 30))
        end
        local tbl_upv_5 = {}
        local function fwSound(a1, a2, a3, a4)
            --[[
              name: fwSound
              line: 410
              upvalues:
                Sfx_upv_1 (ref,  index: 1)
                tbl_upv_5 (copy, index: 2)
                u29 (copy, index: 3)
            ]]
            if not Sfx_upv_1 or (os.clock() - (tbl_upv_5[a1] or 0) < a2) then
                return
            end
            tbl_upv_5[a1] = os.clock()
            task.delay(
                a3,
                function()
                    --[[
                      line: 415
                      upvalues:
                        Sfx_upv_1 (ref,  index: 1)
                        a1 (copy, index: 2)
                        a4 (copy, index: 3)
                        u29 (copy, index: 4)
                    ]]
                    pcall(Sfx_upv_1.Play, a1, nil, {volume = a4, pitch = u29:NextNumber(0.94, 1.06)})
                end
            )
        end
        local function boom(a1)
            --[[
              name: boom
              line: 419
              upvalues:
                fwSound (copy, index: 1)
            ]]
            fwSound("Firework/Explode", 0.25, 0.15, 1)
            fwSound("Firework/Crackle", 0.6, 0.45, 1)
        end
        local function burst(a1, a2, a3)
            --[[
              name: burst
              line: 424
              upvalues:
                u28 (copy, index: 1)
                Colors_upv_1 (copy, index: 2)
            ]]
            local u31 = Instance.new("Part")
            u31.Anchored = true
            u31.CanCollide = false
            u31.CanQuery = false
            u31.CanTouch = false
            u31.Transparency = 1
            u31.Size = Vector3.new(1, 1, 1)
            u31.CFrame = CFrame.new(a1)
            u31.Parent = u28
            local function emitter_1(a4, a5, a6, a7, a8, a9)
                --[[
                  name: emitter
                  line: 434
                  upvalues:
                    a2 (copy, index: 1)
                    u31 (copy, index: 2)
                ]]
                local v26 = Instance.new("ParticleEmitter")
                v26.Texture = "rbxasset://textures/particles/sparkles_main.dds"
                v26.LightEmission = 1
                v26.LightInfluence = 0
                v26.Brightness = a9
                v26.Color = ColorSequence.new(a8, a2)
                v26.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a5), NumberSequenceKeypoint.new(0.7, a5 * 0.6), NumberSequenceKeypoint.new(1, 0)})
                v26.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.75, 0.15), NumberSequenceKeypoint.new(1, 1)})
                v26.Lifetime = NumberRange.new(a7 * 0.75, a7)
                v26.Speed = NumberRange.new(a6 * 0.8, a6)
                v26.SpreadAngle = Vector2.new(180, 180)
                v26.Acceleration = Vector3.new(0, -22, 0)
                v26.Drag = 1.6
                v26.Rate = 0
                v26.RotSpeed = NumberRange.new(-180, 180)
                v26.Parent = u31
                v26:Emit(a4)
            end
            emitter_1(math.floor(a3 * 120), a3 * 8, a3 * 72, 2, a2:Lerp(Colors_upv_1.White, 0.1), 3)
            emitter_1(math.floor(a3 * 26), a3 * 4, a3 * 36, 2.6, a2:Lerp(Colors_upv_1.White, 0.6), 2)
            task.delay(
                4,
                function()
                    --[[
                      line: 456
                      upvalues:
                        u31 (copy, index: 1)
                    ]]
                    u31:Destroy()
                end
            )
        end
        local tbl_upv_6 = {fromRGB_upv_1(255, 204, 64), fromRGB_upv_1(255, 92, 92), fromRGB_upv_1(86, 202, 255), fromRGB_upv_1(186, 116, 255), fromRGB_upv_1(120, 236, 150), fromRGB_upv_1(255, 150, 80)}
        local function rocket(a1, a2, a3)
            --[[
              name: rocket
              line: 462
              upvalues:
                u29 (copy, index: 1)
                Colors_upv_1 (copy, index: 2)
                u28 (copy, index: 3)
                TweenService_upv_1 (copy, index: 4)
                burst (copy, index: 5)
                fwSound (copy, index: 6)
            ]]
            local v27 = Vector3.new(a1.X + u29:NextNumber(-20, 20), 30, a1.Z + u29:NextNumber(-10, 10))
            local u32 = Instance.new("Part")
            u32.Anchored = true
            u32.CanCollide = false
            u32.CanQuery = false
            u32.CanTouch = false
            u32.CastShadow = false
            u32.Material = Enum.Material.Neon
            u32.Color = a2:Lerp(Colors_upv_1.White, 0.5)
            u32.Size = Vector3.new(1.600000023841858, 1.600000023841858, 1.600000023841858)
            u32.Shape = Enum.PartType.Ball
            u32.CFrame = CFrame.new(v27)
            v27 = Instance.new("Attachment")
            v27.Position = Vector3.new(0, 0.800000011920929, 0)
            v27.Parent = u32
            local v28 = Instance.new("Attachment")
            v28.Position = Vector3.new(0, -0.800000011920929, 0)
            v28.Parent = u32
            local v29 = Instance.new("Trail")
            v29.Attachment0 = v27
            v29.Attachment1 = v28
            v29.Lifetime = 0.45
            v29.LightEmission = 1
            v29.FaceCamera = true
            v29.Color = ColorSequence.new(a2:Lerp(Colors_upv_1.White, 0.6), a2)
            v29.Transparency = NumberSequence.new(0, 1)
            v29.WidthScale = NumberSequence.new(1, 0)
            v29.Parent = u32
            u32.Parent = u28
            local v30 = TweenService_upv_1:Create(u32, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(a1)})
            v30.Completed:Once(
                function()
                    --[[
                      line: 493
                      upvalues:
                        u32 (copy, index: 1)
                        burst (copy, index: 2)
                        a1 (copy, index: 3)
                        a2 (copy, index: 4)
                        a3 (copy, index: 5)
                        fwSound (copy, index: 6)
                    ]]
                    u32.Transparency = 1
                    burst(a1, a2, a3)
                    fwSound("Firework/Explode", 0.25, 0.15, 1)
                    fwSound("Firework/Crackle", 0.6, 0.45, 1)
                    task.delay(
                        0.6,
                        function()
                            --[[
                              line: 497
                              upvalues:
                                u32 (copy, index: 1)
                            ]]
                            u32:Destroy()
                        end
                    )
                end
            )
            v30:Play()
        end
        local Lighting_2 = ReplicatedStorage_upv_1:FindFirstChild("Lighting")
        local u33 = Lighting_2 and (Lighting_2:FindFirstChild("Lobby"))
        local function base(a1, a2)
            --[[
              name: base
              line: 529
              upvalues:
                u33 (copy, index: 1)
            ]]
            local v31
            if u33 then
                v31 = u33:GetAttribute(a1)
            else
                v31 = u33
            end
            if v31 == nil then
                return a2
            end
            return v31
        end
        local v32 = u33 and (u33:FindFirstChildOfClass("Atmosphere"))
        local tbl_upv_7 = {atmColor = 0, atmGlare = 0, atmHaze = 0, rays = 0, atmDensity = 0, outdoor = 0, clock = 0, brightness = 0, atmDecay = 0, shiftTop = 0}
        local v33 = u33 and (u33:GetAttribute("ClockTime"))
        local u34
        if v33 == nil then
            u34 = 16.3
        else
            u34 = v33
        end
        tbl_upv_7.clock = u34
        local v34 = fromRGB_upv_1(214, 184, 140)
        local v35 = u33 and (u33:GetAttribute("ColorShift_Top"))
        if v35 == nil then
            u34 = v34
        else
            u34 = v35
        end
        tbl_upv_7.shiftTop = u34
        local v36 = u33 and (u33:GetAttribute("Brightness"))
        if v36 == nil then
            u34 = 2.5
        else
            u34 = v36
        end
        tbl_upv_7.brightness = u34
        local v37 = fromRGB_upv_1(136, 128, 126)
        local v38 = u33 and (u33:GetAttribute("OutdoorAmbient"))
        if v38 == nil then
            u34 = v37
        else
            u34 = v38
        end
        tbl_upv_7.outdoor = u34
        if v32 then
            u34 = v32.Color
        else
            u34 = fromRGB_upv_1(224, 210, 190)
        end
        tbl_upv_7.atmColor = u34
        if v32 then
            u34 = v32.Decay
        else
            u34 = fromRGB_upv_1(170, 160, 178)
        end
        tbl_upv_7.atmDecay = u34
        tbl_upv_7.atmHaze = ((not v32) and 1.2) or (v32.Haze)
        tbl_upv_7.atmDensity = ((not v32) and 0.24) or (v32.Density)
        tbl_upv_7.atmGlare = ((not v32) and 0.08) or (v32.Glare)
        local v39 = u33 and (u33:FindFirstChildOfClass("SunRaysEffect"))
        if v39 then
            u34 = v39.Intensity
        else
            u34 = 0.035
        end
        tbl_upv_7.rays = u34
        local tbl_upv_8 = {bright = 2.9, density = 0.27, rays = 0.14, clock = 17.35, glare = 2.2, haze = 1.6}
        tbl_upv_8.shiftTop = fromRGB_upv_1(255, 176, 110)
        tbl_upv_8.atmColor = fromRGB_upv_1(255, 178, 130)
        tbl_upv_8.atmDecay = fromRGB_upv_1(232, 128, 140)
        tbl_upv_8.outdoor = fromRGB_upv_1(170, 132, 118)
        local tbl_upv_9 = {bright = 2.6, density = 0.29, rays = 0.2, clock = 17.62, glare = 3, haze = 1.9}
        tbl_upv_9.shiftTop = fromRGB_upv_1(255, 140, 100)
        tbl_upv_9.atmColor = fromRGB_upv_1(255, 150, 120)
        tbl_upv_9.atmDecay = fromRGB_upv_1(196, 98, 150)
        tbl_upv_9.outdoor = fromRGB_upv_1(156, 112, 128)
        u34 = Instance.new("ColorCorrectionEffect")
        u34.Name = "UpdateCountdownGrade"
        u34.Enabled = false
        u34.Parent = CurrentCamera_1
        local LightingController_upv_1 = nil
        pcall(
            function()
                --[[
                  line: 560
                  upvalues:
                    LightingController_upv_1 (ref, index: 1)
                ]]
                LightingController_upv_1 = require(script.Parent.Parent.Core.LightingController)
            end
        )
        local function lobbyLit()
            --[[
              name: lobbyLit
              line: 563
              upvalues:
                LightingController_upv_1 (ref, index: 1)
            ]]
            if not LightingController_upv_1 then
                return true
            end
            local success_1, v40 = pcall(LightingController_upv_1.Current)
            return success_1 and (v40 == "Lobby")
        end
        local tbl_upv_10 = {w = 0, d = 0}
        local u35 = false
        local function paintSky(a1, a2)
            --[[
              name: paintSky
              line: 573
              upvalues:
                LocalPlayer_upv_1 (copy, index: 1)
                LightingController_upv_1 (ref,  index: 2)
                u34 (copy, index: 3)
                u35 (ref,  index: 4)
                Lighting_upv_1 (copy, index: 5)
                tbl_upv_7 (copy, index: 6)
                tbl_upv_8 (copy, index: 7)
                tbl_upv_9 (copy, index: 8)
                Colors_upv_1 (copy, index: 9)
                fromRGB_upv_1 (copy, index: 10)
            ]]
            local v41 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
            if v41 then
                if LightingController_upv_1 then
                    local success_2, v42 = pcall(LightingController_upv_1.Current)
                    v41 = success_2 and (v42 == "Lobby")
                else
                    v41 = true
                end
                if v41 then
                    if a1 <= 0.001 and a2 <= 0.001 then
                        if u35 then
                            Lighting_upv_1.ClockTime = tbl_upv_7.clock
                            Lighting_upv_1.ColorShift_Top = tbl_upv_7.shiftTop
                            Lighting_upv_1.Brightness = tbl_upv_7.brightness
                            Lighting_upv_1.OutdoorAmbient = tbl_upv_7.outdoor
                            v41 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                            if v41 then
                                v41.Color = tbl_upv_7.atmColor
                                v41.Decay = tbl_upv_7.atmDecay
                                v41.Haze = tbl_upv_7.atmHaze
                                v41.Density = tbl_upv_7.atmDensity
                                v41.Glare = tbl_upv_7.atmGlare
                            end
                            v41 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                            if v41 then
                                v41.Intensity = tbl_upv_7.rays
                            end
                            u35 = false
                        end
                        u34.Enabled = false
                        return
                    end
                    u35 = true
                    local function mix_1(a3, a4, a5)
                        --[[
                          name: mix
                          line: 600
                          upvalues:
                            a1 (copy, index: 1)
                            a2 (copy, index: 2)
                        ]]
                        if typeof(a3) == "Color3" then
                            return a3:Lerp(a4, a1):Lerp(a5, a2)
                        end
                        local v43 = a3 + (a4 - a3) * a1
                        return v43 + ((a5 - v43) * a2)
                    end
                    local clock_1 = tbl_upv_7.clock
                    local clock_2 = tbl_upv_8.clock
                    local clock_3 = tbl_upv_9.clock
                    local v42
                    if typeof(clock_1) ~= "Color3" then
                        local _ = clock_1 + (clock_2 - clock_1) * a1
                        v42 = clock_1 + (clock_2 - clock_1) * a1 + (clock_3 - (clock_1 + (clock_2 - clock_1) * a1)) * a2
                    else
                        v42 = clock_1:Lerp(clock_2, a1):Lerp(clock_3, a2)
                    end
                    Lighting_upv_1.ClockTime = v42
                    local shiftTop_1 = tbl_upv_7.shiftTop
                    local shiftTop_2 = tbl_upv_8.shiftTop
                    local shiftTop_3 = tbl_upv_9.shiftTop
                    if typeof(shiftTop_1) ~= "Color3" then
                        local _ = shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1
                        v42 = shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1 + (shiftTop_3 - (shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1)) * a2
                    else
                        v42 = shiftTop_1:Lerp(shiftTop_2, a1):Lerp(shiftTop_3, a2)
                    end
                    Lighting_upv_1.ColorShift_Top = v42
                    local brightness_1 = tbl_upv_7.brightness
                    local bright_1 = tbl_upv_8.bright
                    local bright_2 = tbl_upv_9.bright
                    if typeof(brightness_1) ~= "Color3" then
                        local _ = brightness_1 + (bright_1 - brightness_1) * a1
                        v42 = brightness_1 + (bright_1 - brightness_1) * a1 + (bright_2 - (brightness_1 + (bright_1 - brightness_1) * a1)) * a2
                    else
                        v42 = brightness_1:Lerp(bright_1, a1):Lerp(bright_2, a2)
                    end
                    Lighting_upv_1.Brightness = v42
                    local v44 = tbl_upv_7.outdoor
                    local outdoor_1 = tbl_upv_8.outdoor
                    local outdoor_2 = tbl_upv_9.outdoor
                    if typeof(v44) ~= "Color3" then
                        local _ = v44 + (outdoor_1 - v44) * a1
                        v42 = v44 + (outdoor_1 - v44) * a1 + (outdoor_2 - (v44 + (outdoor_1 - v44) * a1)) * a2
                    else
                        v42 = v44:Lerp(outdoor_1, a1):Lerp(outdoor_2, a2)
                    end
                    Lighting_upv_1.OutdoorAmbient = v42
                    local v45 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                    local v46 = nil
                    if v45 then
                        v46 = tbl_upv_7.rays
                        local rays_1 = tbl_upv_8.rays
                        local rays_2 = tbl_upv_9.rays
                        if typeof(v46) ~= "Color3" then
                            local _ = v46 + (rays_1 - v46) * a1
                            v42 = v46 + (rays_1 - v46) * a1 + (rays_2 - (v46 + (rays_1 - v46) * a1)) * a2
                        else
                            v42 = v46:Lerp(rays_1, a1):Lerp(rays_2, a2)
                        end
                        v45.Intensity = v42
                    end
                    local v47 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                    local v48, v49, v50, v51, v52 = nil, nil, nil, nil, nil
                    if v47 then
                        v48 = tbl_upv_7.atmColor
                        local atmColor_1 = tbl_upv_8.atmColor
                        local atmColor_2 = tbl_upv_9.atmColor
                        if typeof(v48) ~= "Color3" then
                            local _ = v48 + (atmColor_1 - v48) * a1
                            v42 = v48 + (atmColor_1 - v48) * a1 + (atmColor_2 - (v48 + (atmColor_1 - v48) * a1)) * a2
                        else
                            v42 = v48:Lerp(atmColor_1, a1):Lerp(atmColor_2, a2)
                        end
                        v47.Color = v42
                        v49 = tbl_upv_7.atmDecay
                        local atmDecay_1 = tbl_upv_8.atmDecay
                        local atmDecay_2 = tbl_upv_9.atmDecay
                        if typeof(v49) ~= "Color3" then
                            local _ = v49 + (atmDecay_1 - v49) * a1
                            v42 = v49 + (atmDecay_1 - v49) * a1 + (atmDecay_2 - (v49 + (atmDecay_1 - v49) * a1)) * a2
                        else
                            v42 = v49:Lerp(atmDecay_1, a1):Lerp(atmDecay_2, a2)
                        end
                        v47.Decay = v42
                        v50 = tbl_upv_7.atmHaze
                        local haze_1 = tbl_upv_8.haze
                        local haze_2 = tbl_upv_9.haze
                        if typeof(v50) ~= "Color3" then
                            local _ = v50 + (haze_1 - v50) * a1
                            v42 = v50 + (haze_1 - v50) * a1 + (haze_2 - (v50 + (haze_1 - v50) * a1)) * a2
                        else
                            v42 = v50:Lerp(haze_1, a1):Lerp(haze_2, a2)
                        end
                        v47.Haze = v42
                        v51 = tbl_upv_7.atmDensity
                        local density_1 = tbl_upv_8.density
                        local density_2 = tbl_upv_9.density
                        if typeof(v51) ~= "Color3" then
                            local _ = v51 + (density_1 - v51) * a1
                            v42 = v51 + (density_1 - v51) * a1 + (density_2 - (v51 + (density_1 - v51) * a1)) * a2
                        else
                            v42 = v51:Lerp(density_1, a1):Lerp(density_2, a2)
                        end
                        v47.Density = v42
                        v52 = tbl_upv_7.atmGlare
                        local glare_1 = tbl_upv_8.glare
                        local glare_2 = tbl_upv_9.glare
                        if typeof(v52) ~= "Color3" then
                            local _ = v52 + (glare_1 - v52) * a1
                            v42 = v52 + (glare_1 - v52) * a1 + (glare_2 - (v52 + (glare_1 - v52) * a1)) * a2
                        else
                            v42 = v52:Lerp(glare_1, a1):Lerp(glare_2, a2)
                        end
                        v47.Glare = v42
                    end
                    u34.Enabled = true
                    local White_1 = Colors_upv_1.White
                    local v53 = fromRGB_upv_1(255, 238, 222)
                    local v54 = fromRGB_upv_1(255, 228, 226)
                    if typeof(White_1) ~= "Color3" then
                        local _ = White_1 + (v53 - White_1) * a1
                        v44 = White_1 + (v53 - White_1) * a1 + (v54 - (White_1 + (v53 - White_1) * a1)) * a2
                    else
                        v44 = White_1:Lerp(v53, a1):Lerp(v54, a2)
                    end
                    u34.TintColor = v44
                    u34.Saturation = a1 * 0.12
                    u34.Contrast = a1 * 0.05
                    u34.Brightness = a1 * 0.03
                    return
                end
            end
            u34.Enabled = false
            u35 = false
        end
        local function localTime(a1)
            --[[
              name: localTime
              line: 644
            ]]
            local success_3, v55 = pcall(function() end)
            if success_3 then
                return string.upper(v55) .. " YOUR TIME"
            end
            return ""
        end
        local at_upv_1 = UPDATE_COUNTDOWN_upv_1.at
        local success_4, v56 = pcall(
            function()
                --[[
                  line: 645
                  upvalues:
                    at_upv_1 (copy, index: 1)
                ]]
                return DateTime.fromUnixTimestamp(at_upv_1):FormatLocalTime("dddd h:mm A", "en-us")
            end
        )
        local u36 = (success_4 and (string.upper(v56) .. " YOUR TIME")) or ""
        local tbl_upv_11 = {}
        local function set(a1, a2)
            --[[
              name: set
              line: 653
              upvalues:
                tbl_upv_11 (copy, index: 1)
            ]]
            if tbl_upv_11[a1] == a2 then
                return
            end
            tbl_upv_11[a1] = a2
            a1.label.Text = a2
            a1.shadow.Text = a2
        end
        local function paintSlot(a1, a2)
            --[[
              name: paintSlot
              line: 668
              upvalues:
                tbl_upv_3 (copy, index: 1)
                Colors_upv_1 (copy, index: 3)
                u3 (copy, index: 4)
            ]]
            local v57 = tbl_upv_3[a1]
            v57.out = a2
            if a2 then
                v57.img.ImageColor3 = Colors_upv_1.White
                v57.img.ImageTransparency = 0
            else
                v57.img.ImageColor3 = u3
                v57.img.ImageTransparency = 0.15
            end
        end
        local u37 = false
        local u38 = 0
        local function fadeText(a1, a2)
            --[[
              name: fadeText
              line: 661
              upvalues:
                tbl_upv_2 (copy, index: 1)
                TweenService_upv_1 (copy, index: 2)
            ]]
            for _, value_3 in tbl_upv_2 do
                local tbl_12 = {}
                tbl_12.TextTransparency = a1
                TweenService_upv_1:Create(value_3.label, TweenInfo.new(a2), tbl_12):Play()
                local v58 = TweenInfo.new(a2)
                local tbl_13 = {}
                tbl_13.TextTransparency = math.max(a1, 0.45)
                TweenService_upv_1:Create(value_3.shadow, v58, tbl_13):Play()
            end
        end
        local function volley(a1, a2, a3, a4)
            --[[
              name: volley
              line: 507
              upvalues:
                u29 (copy, index: 1)
                LocalPlayer_upv_1 (copy, index: 2)
                rocket (copy, index: 3)
                RightVector_upv_1 (copy, index: 4)
                UpVector_upv_1 (copy, index: 5)
                u30 (copy, index: 6)
                tbl_upv_6 (copy, index: 7)
            ]]
            for n_upv_1 = 1, a1 do
                task.delay(
                    (((n_upv_1 - 1) / math.max(1, a1 - 1)) * a2) + u29:NextNumber(0, 0.15),
                    function()
                        --[[
                          line: 509
                          upvalues:
                            LocalPlayer_upv_1 (copy, index: 1)
                            n_upv_1 (copy, index: 2)
                            u29 (copy, index: 3)
                            rocket (copy, index: 4)
                            RightVector_upv_1 (copy, index: 5)
                            UpVector_upv_1 (copy, index: 6)
                            u30 (copy, index: 7)
                            a3 (copy, index: 8)
                            tbl_upv_6 (copy, index: 9)
                            a4 (copy, index: 10)
                        ]]
                        local v59 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                        if not v59 then
                            return
                        end
                        local v60 = (((n_upv_1 % 2 ~= 0) and -1) or 1) * u29:NextNumber(150, 260)
                        v59 = u29:NextNumber(10, 80)
                        if n_upv_1 % 3 == 0 then
                            v60, v59 = u29:NextNumber(-140, 140), u29:NextNumber(70, 110)
                        end
                        local v61 = a3 or (tbl_upv_6[u29:NextInteger(1, #tbl_upv_6)])
                        rocket(((Vector3.new(0, 66, -135) + (RightVector_upv_1 * v60)) + (UpVector_upv_1 * v59)) + (u30 * 30), v61, a4)
                    end
                )
            end
        end
        local function reveal(a1)
            --[[
              name: reveal
              line: 685
              upvalues:
                UPDATE_COUNTDOWN_upv_1 (copy, index: 1)
                Gold_upv_1 (copy, index: 2)
                u37 (ref,  index: 3)
                u38 (ref,  index: 4)
                tbl_upv_3 (copy, index: 5)
                u3 (copy, index: 6)
                u18 (copy, index: 7)
                UIAssets_upv_1 (copy, index: 8)
                u20 (copy, index: 9)
                tbl_upv_11 (copy, index: 10)
                Colors_upv_1 (copy, index: 11)
                u19 (copy, index: 12)
                u14 (copy, index: 13)
                u15 (copy, index: 14)
                fadeText (copy, index: 15)
                TweenService_upv_1 (copy, index: 16)
                u16 (copy, index: 17)
                u17 (copy, index: 18)
                Sfx_upv_1 (ref,  index: 19)
                volley (copy, index: 20)
                showBanner (copy, index: 21)
                u21 (copy, index: 22)
            ]]
            local u39 = UPDATE_COUNTDOWN_upv_1.ranks[a1]
            local v62 = u39.color or Gold_upv_1
            local v63 = a1 == #UPDATE_COUNTDOWN_upv_1.ranks
            u37 = true
            u38 = a1
            local v64 = tbl_upv_3[a1]
            v64.out = false
            v64.img.ImageColor3 = u3
            v64.img.ImageTransparency = 0.15
            local Ranks_4 = UIAssets_upv_1.Ranks
            u18.Image = Ranks_4 and Ranks_4[string.lower(u39.name)] or u39.img or ""
            u18.ImageTransparency = 0
            local name_1 = u39.name
            if tbl_upv_11[u20] ~= name_1 then
                tbl_upv_11[u20] = name_1
                u20.label.Text = name_1
                u20.shadow.Text = name_1
            end
            u20.label.TextColor3 = v62:Lerp(Colors_upv_1.White, 0.35)
            for _, value_4 in {u20, u19} do
                value_4.label.TextTransparency = 0
                value_4.shadow.TextTransparency = 0.45
            end
            u14.Position = UDim2.fromOffset(640, 120)
            u14.Visible = true
            u15.Scale = 0.3
            fadeText(1, 0.2)
            local tbl_14 = {Scale = 1}
            TweenService_upv_1:Create(u15, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_14):Play()
            u16.ImageColor3 = v62
            u16.ImageTransparency = 0
            u17.Scale = 0.4
            local tbl_15 = {ImageTransparency = 0.55}
            TweenService_upv_1:Create(u16, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_15):Play()
            local tbl_16 = {Scale = 1.3}
            TweenService_upv_1:Create(u17, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_16):Play()
            if Sfx_upv_1 then
                pcall(Sfx_upv_1.PlayUI, "UI/Unlock")
            end
            if v63 then
                task.delay(
                    0.15,
                    function()
                        --[[
                          line: 712
                          upvalues:
                            Sfx_upv_1 (ref, index: 1)
                        ]]
                        if not Sfx_upv_1 then
                            return
                        end
                        pcall(Sfx_upv_1.PlayUI, "UI/NewItem_Fanfare")
                    end
                )
            end
            volley((v63 and 14) or 8, 2.4, v62, (v63 and 1.35) or 1.1)
            showBanner(u39)
            task.delay(
                3.4,
                function()
                    --[[
                      line: 718
                      upvalues:
                        tbl_upv_3 (copy, index: 1)
                        a1 (copy, index: 2)
                        u21 (copy, index: 3)
                        u39 (copy, index: 4)
                        UIAssets_upv_1 (copy, index: 5)
                        u14 (copy, index: 6)
                        u16 (copy, index: 7)
                        TweenService_upv_1 (copy, index: 8)
                        Colors_upv_1 (copy, index: 10)
                        Sfx_upv_1 (ref,  index: 11)
                        fadeText (copy, index: 12)
                        u37 (ref,  index: 13)
                        u38 (ref,  index: 14)
                    ]]
                    local v66 = tbl_upv_3[a1]
                    local v67 = Vector2.new(430, 120)
                    local Ranks_5 = UIAssets_upv_1.Ranks
                    u21.Image = Ranks_5 and Ranks_5[string.lower(u39.name)] or u39.img or ""
                    u21.Position = UDim2.fromOffset(v67.X, v67.Y)
                    u21.Size = UDim2.fromOffset(180, 180)
                    u21.Visible = true
                    u14.Visible = false
                    u16.ImageTransparency = 1
                    local v69 = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                    local tbl_17 = {}
                    tbl_17.Position = v66.cell.Position
                    tbl_17.Size = UDim2.fromOffset(62, 62)
                    TweenService_upv_1:Create(u21, v69, tbl_17):Play()
                    task.wait(0.55)
                    u21.Visible = false
                    local v70 = tbl_upv_3[a1]
                    v70.out = true
                    v70.img.ImageColor3 = Colors_upv_1.White
                    v70.img.ImageTransparency = 0
                    v66.scale.Scale = 1.6
                    local tbl_18 = {Scale = 1}
                    TweenService_upv_1:Create(v66.scale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_18):Play()
                    if Sfx_upv_1 then
                        pcall(Sfx_upv_1.PlayUI, "UI/Card_Reveal")
                    end
                    fadeText(0, 0.35)
                    u37 = false
                    u38 = 0
                end
            )
        end
        local u40 = -1
        local u41 = ""
        local u42 = false
        local u43 = os.clock()
        local u44 = nil
        local u45 = 0
        local tbl_upv_19 = {}
        Workspace_upv_1:GetAttributeChangedSignal("CountdownPreviewAt"):Connect(
            function()
                --[[
                  line: 754
                  upvalues:
                    u42 (ref,  index: 1)
                    u41 (ref,  index: 2)
                    u44 (ref,  index: 3)
                    tbl_upv_19 (copy, index: 4)
                ]]
                u42 = false
                u41 = ""
                u44 = nil
                table.clear(tbl_upv_19)
            end
        )
        local function clock_4(a1)
            --[[
              name: clock
              line: 633
            ]]
            local v71 = a1 // 86400
            local v72 = a1 // 3600 % 24
            local v73 = a1 // 60 % 60
            local v74 = a1 % 60
            if v71 > 0 then
                return string.format("%dD %02d:%02d:%02d", v71, v72, v73, v74)
            elseif v72 > 0 then
                return string.format("%d:%02d:%02d", v72, v73, v74)
            else
                return string.format("%d:%02d", v73, v74)
            end
        end
        local function step(a1)
            --[[
              name: step
              line: 761
              upvalues:
                Workspace_upv_1 (copy, index: 1)
                UPDATE_COUNTDOWN_upv_1 (copy, index: 2)
                LocalPlayer_upv_1 (copy, index: 3)
                u5 (copy, index: 4)
                u12 (copy, index: 5)
                u22 (copy, index: 6)
                tbl_upv_3 (copy, index: 7)
                u42 (ref,  index: 8)
                Colors_upv_1 (copy, index: 9)
                u3 (copy, index: 10)
                tbl_upv_19 (copy, index: 11)
                u38 (ref,  index: 12)
                u43 (copy, index: 13)
                u37 (ref,  index: 14)
                reveal (copy, index: 15)
                u1 (copy, index: 16)
                u2 (copy, index: 17)
                ReplicatedStorage_upv_1 (copy, index: 18)
                tbl_upv_10 (copy, index: 19)
                paintSky (copy, index: 20)
                u8 (copy, index: 21)
                Gold_upv_1 (copy, index: 22)
                u9 (copy, index: 23)
                u10 (copy, index: 24)
                tbl_upv_11 (copy, index: 25)
                u13 (copy, index: 26)
                u40 (ref,  index: 27)
                TweenService_upv_1 (copy, index: 28)
                Sfx_upv_1 (ref,  index: 29)
                u36 (copy, index: 30)
                clock_4 (copy, index: 31)
                u41 (ref,  index: 32)
                u44 (ref,  index: 33)
                volley (copy, index: 34)
                u45 (ref,  index: 35)
                u29 (copy, index: 36)
            ]]
            local v75 = Workspace_upv_1:GetServerTimeNow()
            local v76 = Workspace_upv_1:GetAttribute("CountdownPreview")
            local v77 = Workspace_upv_1:GetAttribute("CountdownPreviewAt")
            local v78
            if type(v76) == "number" and type(v77) == "number" then
                v78 = UPDATE_COUNTDOWN_upv_1.at - v76 + (v75 - v77)
            else
                v78 = v75
            end
            local v79 = UPDATE_COUNTDOWN_upv_1.at - v78
            local v80 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
            u5.Enabled = v80
            u12.Enabled = v80
            u22.Enabled = v80
            for key_2, value_5 in UPDATE_COUNTDOWN_upv_1.ranks do
                local v81 = UPDATE_COUNTDOWN_upv_1.at - value_5.hours * 3600
                local v82 = v81 <= v78
                local v83 = tbl_upv_3[key_2]
                if v83.out == nil or not (u42) then
                    local v84 = tbl_upv_3[key_2]
                    v84.out = v82
                    if v82 then
                        v84.img.ImageColor3 = Colors_upv_1.White
                        v84.img.ImageTransparency = 0
                    else
                        v84.img.ImageColor3 = u3
                        v84.img.ImageTransparency = 0.15
                    end
                    continue
                end
                if v82 then
                    if v83.out or table.find(tbl_upv_19, key_2) or u38 == key_2 then
                        if v82 then
                            continue
                        end
                        if v83.out then
                            local v85 = tbl_upv_3[key_2]
                            v85.out = false
                            v85.img.ImageColor3 = u3
                            v85.img.ImageTransparency = 0.15
                        end
                    else
                        if not (v78 - v81 < 4) then
                            local v86 = tbl_upv_3[key_2]
                            v86.out = true
                            v86.img.ImageColor3 = Colors_upv_1.White
                            v86.img.ImageTransparency = 0
                            continue
                        end
                        if os.clock() - u43 > 6 then
                            table.insert(tbl_upv_19, key_2)
                        else
                            local v86 = tbl_upv_3[key_2]
                            v86.out = true
                            v86.img.ImageColor3 = Colors_upv_1.White
                            v86.img.ImageTransparency = 0
                        end
                    end
                else
                    if v82 then
                        continue
                    end
                    if v83.out then
                        local v85 = tbl_upv_3[key_2]
                        v85.out = false
                        v85.img.ImageColor3 = u3
                        v85.img.ImageTransparency = 0.15
                    end
                end
            end
            u42 = true
            if not (u37) and #tbl_upv_19 > 0 then
                local v87 = table.remove(tbl_upv_19, 1)
                if v80 then
                    reveal(v87)
                else
                    local v88 = tbl_upv_3[v87]
                    v88.out = true
                    v88.img.ImageColor3 = Colors_upv_1.White
                    v88.img.ImageTransparency = 0
                end
            end
            local v89 = 0
            local v90 = 0
            if (v79 > 0) and (v79 <= u1) then
                if u2 < v79 then
                    local _ = (u1 - v79) / (u1 - u2)
                    v89 = 0.6 * ((u1 - v79) / (u1 - u2)) * ((u1 - v79) / (u1 - u2)) * (3 - 2 * ((u1 - v79) / (u1 - u2)))
                else
                    v89 = 0.6 + 0.4 * (1 - (math.max(0, v79 - 60) / (u2 - 60)))
                end
                v90 = ((v79 <= 60) and (1 - v79 / 60)) or 0
            elseif v79 <= 0 then
                local v91 = ((Workspace_upv_1:GetAttribute("CountdownPreviewShipped") == true) and true) or ((UPDATE_COUNTDOWN_upv_1.shipped ~= nil) and (ReplicatedStorage_upv_1.Shared:FindFirstChild(UPDATE_COUNTDOWN_upv_1.shipped) ~= nil))
                if not v91 then
                    v89, v90 = 1, 1
                end
            end
            local v92 = ((os.clock() - u43 < 0.4) and 1) or (math.min(1, a1 * 0.6))
            tbl_upv_10.w = tbl_upv_10.w + ((v89 - tbl_upv_10.w) * v92)
            tbl_upv_10.d = tbl_upv_10.d + ((v90 - tbl_upv_10.d) * v92)
            paintSky(tbl_upv_10.w, tbl_upv_10.d)
            local v93 = nil
            if v79 > 0 then
                local v94 = math.ceil(v79)
                v90 = ((v79 <= 60) and "final") or (((v79 <= u2) and "close") or "far")
                for _, value_6 in tbl_upv_3 do
                    value_6.cell.Visible = true
                end
                v89 = v90 ~= "far"
                local label_1 = u8.label
                local v95
                if v89 then
                    v95 = Gold_upv_1
                else
                    v95 = Colors_upv_1.White
                end
                label_1.TextColor3 = v95
                local label_2 = u9.label
                local v96
                if v89 then
                    v96 = Gold_upv_1
                else
                    v96 = Colors_upv_1.White
                end
                label_2.TextColor3 = v96
                local v97, v98, v99 = nil, nil, nil
                if v90 ~= "final" then
                    v97 = u36
                    if tbl_upv_11[u10] ~= v97 then
                        tbl_upv_11[u10] = v97
                        u10.label.Text = v97
                        u10.shadow.Text = v97
                    end
                    u10.label.TextColor3 = Colors_upv_1.White
                    u8.holder.Visible = true
                    u9.holder.Visible = true
                    u13.holder.Visible = false
                    v98 = clock_4(v94)
                    if tbl_upv_11[u9] ~= v98 then
                        tbl_upv_11[u9] = v98
                        u9.label.Text = v98
                        u9.shadow.Text = v98
                    end
                else
                    v99 = string.upper(UPDATE_COUNTDOWN_upv_1.title) .. " IN"
                    if tbl_upv_11[u10] ~= v99 then
                        tbl_upv_11[u10] = v99
                        u10.label.Text = v99
                        u10.shadow.Text = v99
                    end
                    u10.label.TextColor3 = Gold_upv_1
                    u8.holder.Visible = false
                    u9.holder.Visible = false
                    u13.holder.Visible = not u37
                    local label_3 = u13.label
                    local v100
                    if v94 <= 10 then
                        v100 = Colors_upv_1.White
                    else
                        v100 = Gold_upv_1
                    end
                    label_3.TextColor3 = v100
                    local v101 = nil
                    if v94 ~= u40 then
                        v101 = tostring(v94)
                        if tbl_upv_11[u13] ~= v101 then
                            tbl_upv_11[u13] = v101
                            u13.label.Text = v101
                            u13.shadow.Text = v101
                        end
                        u13.scale.Scale = ((v94 <= 10) and 1.2) or 1.12
                        local tbl_20 = {Scale = 1}
                        TweenService_upv_1:Create(u13.scale, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_20):Play()
                        if v80 then
                            local v102 = ((v94 <= 3) and "Match/Countdown_1") or "Match/Countdown_Tick"
                            if Sfx_upv_1 then
                                pcall(Sfx_upv_1.PlayUI, v102)
                            end
                        end
                    end
                end
                u40 = v94
                u41 = v90
            else
                if u41 == "final" or u41 == "close" then
                    u44 = os.clock()
                    if v80 then
                        if Sfx_upv_1 then
                            pcall(Sfx_upv_1.PlayUI, "Match/Victory")
                        end
                        volley(16, 7, nil, 1.5)
                        task.delay(
                            7.5,
                            function()
                                --[[
                                  line: 863
                                  upvalues:
                                    volley (copy, index: 1)
                                ]]
                                volley(10, 3, nil, 1.8)
                            end
                        )
                    end
                end
                if u41 ~= "done" then
                    u13.scale.Scale = 0.4
                    local tbl_21 = {Scale = 1}
                    TweenService_upv_1:Create(u13.scale, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_21):Play()
                end
                u41 = "done"
                for _, value_7 in tbl_upv_3 do
                    value_7.cell.Visible = false
                end
                u8.holder.Visible = false
                u9.holder.Visible = false
                u10.holder.Visible = true
                u13.holder.Visible = true
                u10.label.TextColor3 = Gold_upv_1
                v93 = string.upper(UPDATE_COUNTDOWN_upv_1.title)
                if tbl_upv_11[u10] ~= v93 then
                    tbl_upv_11[u10] = v93
                    u10.label.Text = v93
                    u10.shadow.Text = v93
                end
                local v103 = ((Workspace_upv_1:GetAttribute("CountdownPreviewShipped") == true) and true) or ((UPDATE_COUNTDOWN_upv_1.shipped ~= nil) and (ReplicatedStorage_upv_1.Shared:FindFirstChild(UPDATE_COUNTDOWN_upv_1.shipped) ~= nil))
                if v103 then
                    if UPDATE_COUNTDOWN_upv_1.OUT_FOR < -v79 then
                        return false
                    end
                    if tbl_upv_11[u13] ~= "OUT NOW!" then
                        tbl_upv_11[u13] = "OUT NOW!"
                        u13.label.Text = "OUT NOW!"
                        u13.shadow.Text = "OUT NOW!"
                    end
                    u13.label.TextColor3 = Gold_upv_1
                    if v80 then
                        local v104 = os.clock()
                        if u45 <= v104 and -v79 < 7200 then
                            u45 = os.clock() + u29:NextNumber(25, 40)
                            if u44 == nil or os.clock() - u44 > 15 then
                                volley(5, 2.5, nil, 1.1)
                            end
                        end
                    end
                else
                    if tbl_upv_11[u13] ~= "SERVERS RESTARTING..." then
                        tbl_upv_11[u13] = "SERVERS RESTARTING..."
                        u13.label.Text = "SERVERS RESTARTING..."
                        u13.shadow.Text = "SERVERS RESTARTING..."
                    end
                    u13.label.TextColor3 = Colors_upv_1.White
                end
            end
            return true
        end
        local u46 = nil
        local u47 = 0
        local v105 = RunService_1.Heartbeat:Connect(
            function(a1)
                --[[
                  line: 904
                  upvalues:
                    u47 (ref,  index: 1)
                    step (copy, index: 2)
                    u46 (ref,  index: 3)
                    LocalPlayer_upv_1 (copy, index: 4)
                    LightingController_upv_1 (ref,  index: 5)
                    u34 (copy, index: 6)
                    u35 (ref,  index: 7)
                    Lighting_upv_1 (copy, index: 8)
                    tbl_upv_7 (copy, index: 9)
                    u5 (copy, index: 10)
                    u12 (copy, index: 11)
                    u22 (copy, index: 12)
                    u4 (copy, index: 13)
                    u11 (copy, index: 14)
                    u28 (copy, index: 15)
                ]]
                u47 = u47 + a1
                if u47 < 0.05 then
                    return
                end
                local success_5, v106 = pcall(step, u47)
                u47 = 0
                if success_5 and v106 == false then
                    if u46 then
                        u46:Disconnect()
                    end
                    local v107 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                    if v107 then
                        if LightingController_upv_1 then
                            local success_6, v108 = pcall(LightingController_upv_1.Current)
                            v107 = success_6 and (v108 == "Lobby")
                        else
                            v107 = true
                        end
                        if v107 then
                            if u35 then
                                Lighting_upv_1.ClockTime = tbl_upv_7.clock
                                Lighting_upv_1.ColorShift_Top = tbl_upv_7.shiftTop
                                Lighting_upv_1.Brightness = tbl_upv_7.brightness
                                Lighting_upv_1.OutdoorAmbient = tbl_upv_7.outdoor
                                v107 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                                if v107 then
                                    v107.Color = tbl_upv_7.atmColor
                                    v107.Decay = tbl_upv_7.atmDecay
                                    v107.Haze = tbl_upv_7.atmHaze
                                    v107.Density = tbl_upv_7.atmDensity
                                    v107.Glare = tbl_upv_7.atmGlare
                                end
                                v107 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                                if v107 then
                                    v107.Intensity = tbl_upv_7.rays
                                end
                                u35 = false
                            end
                            u34.Enabled = false
                        else
                            u34.Enabled = false
                            u35 = false
                        end
                    else
                        u34.Enabled = false
                        u35 = false
                    end
                    u5:Destroy()
                    u12:Destroy()
                    u22:Destroy()
                    u4:Destroy()
                    u11:Destroy()
                    u28:Destroy()
                    u34:Destroy()
                    return
                end
                if (success_5) then
                    return
                end
                warn("[UpdateCountdown] " .. tostring(v106))
            end
        )
        u46 = v105
    end
else
    local function inLobby()
        --[[
          name: inLobby
          line: 100
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
        ]]
        local v6 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
        return v6
    end
    local function now()
        --[[
          name: now
          line: 105
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            UPDATE_COUNTDOWN_upv_1 (copy, index: 2)
        ]]
        local v7 = Workspace_upv_1:GetServerTimeNow()
        local v8 = Workspace_upv_1:GetAttribute("CountdownPreview")
        local v9 = Workspace_upv_1:GetAttribute("CountdownPreviewAt")
        if type(v8) == "number" and type(v9) == "number" then
            return (UPDATE_COUNTDOWN_upv_1.at - v8) + (v7 - v9)
        end
        return v7
    end
    local function play(a1)
        --[[
          name: play
          line: 114
          upvalues:
            Sfx_upv_1 (ref, index: 1)
        ]]
        if not Sfx_upv_1 then
            return
        end
        pcall(Sfx_upv_1.PlayUI, a1)
    end
    local u4 = Instance.new("Part")
    u4.Name = "UpdateCountdownSky"
    u4.Anchored = true
    u4.CanCollide = false
    u4.CanQuery = false
    u4.CanTouch = false
    u4.CastShadow = false
    u4.Transparency = 1
    u4.Size = Vector3.new(357, 64, 0.20000000298023224)
    u4.CFrame = CFrame.lookAt(Vector3.new(0, 66, -135), Vector3.new(0, 9, 120))
    u4.Parent = Workspace_upv_1
    local u5 = Instance.new("SurfaceGui")
    u5.Name = "UpdateCountdown"
    u5.Adornee = u4
    u5.Face = Enum.NormalId.Front
    u5.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
    u5.PixelsPerStud = 3.361344537815126
    u5.LightInfluence = 0
    u5.Brightness = 1.25
    u5.MaxDistance = 2000
    u5.ResetOnSpawn = false
    u5.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local u6 = Instance.new("Frame")
    u6.Name = "Root"
    u6.BackgroundTransparency = 1
    u6.Size = UDim2.fromScale(1, 1)
    u6.Parent = u5
    local v10 = Instance.new("ImageLabel")
    v10.Name = "Plate"
    v10.BackgroundTransparency = 1
    v10.Image = "rbxassetid://90962482350826"
    v10.ImageColor3 = u3
    v10.ImageTransparency = 0.3
    v10.ScaleType = Enum.ScaleType.Stretch
    v10.AnchorPoint = Vector2.new(0.5, 0.5)
    v10.Position = UDim2.fromOffset(600, 112)
    v10.Size = UDim2.fromOffset(1240, 300)
    v10.Parent = u6
    local function text(a1, a2, a3, a4, a5, a6, a7, a8)
        --[[
          name: text
          line: 155
          upvalues:
            u6 (copy, index: 1)
            u3 (copy, index: 2)
            Colors_upv_1 (copy, index: 3)
        ]]
        local u7 = Instance.new("Frame")
        u7.Name = a1
        u7.BackgroundTransparency = 1
        u7.AnchorPoint = Vector2.new(0.5, 0.5)
        u7.Position = UDim2.fromOffset(a2, a3)
        u7.Size = UDim2.fromOffset(a4, a5)
        u7.Parent = a8 or u6
        local v12 = Instance.new("UIScale")
        v12.Parent = u7
        local function mk_1(a9, a10, a11, a12, a13)
            --[[
              name: mk
              line: 165
              upvalues:
                a6 (copy, index: 1)
                u7 (copy, index: 2)
            ]]
            local v13 = Instance.new("TextLabel")
            v13.Name = a9
            v13.BackgroundTransparency = 1
            v13.TextScaled = true
            v13.FontFace = a6
            v13.TextColor3 = a11
            v13.TextTransparency = a12
            v13.Position = UDim2.fromOffset(0, a10)
            v13.Size = UDim2.fromScale(1, 1)
            v13.Text = ""
            v13.ZIndex = a13
            v13.Parent = u7
            return v13
        end
        local v14 = mk_1("Shadow", a7, u3, 0.45, 1)
        local tbl_1 = {}
        tbl_1.label = mk_1("Text", 0, Colors_upv_1.White, 0, 2)
        tbl_1.shadow = v14
        tbl_1.holder = u7
        tbl_1.scale = v12
        return tbl_1
    end
    local u8 = text("Title", 600, 82, 1000, 84, v2, 4)
    u8.label.Text = UPDATE_COUNTDOWN_upv_1.title
    u8.shadow.Text = UPDATE_COUNTDOWN_upv_1.title
    local u9 = text("Timer", 600, 168, 480, 74, v2, 4)
    local u10 = text("When", 600, 22, 600, 24, v3, 2)
    local u11 = u4:Clone()
    u11.Name = "UpdateCountdownSkyBig"
    u11.CFrame = u4.CFrame * CFrame.new(0, 0, -0.3)
    u11.Parent = Workspace_upv_1
    local u12 = u5:Clone()
    u12.Name = "UpdateCountdownBig"
    u12.Adornee = u11
    u12.PixelsPerStud = 1.680672268907563
    u12:ClearAllChildren()
    local v15 = Instance.new("Frame")
    v15.Name = "Root"
    v15.BackgroundTransparency = 1
    v15.Size = UDim2.fromScale(1, 1)
    v15.Parent = u12
    local u13 = text("Big", 300, 62, 560, 84, v2, 4, v15)
    u13.holder.Visible = false
    local tbl_upv_2 = {u8, u9, u10}
    local tbl_upv_3 = {}
    local v16 = math.ceil(#UPDATE_COUNTDOWN_upv_1.ranks / 2)
    for key_1, value_1 in UPDATE_COUNTDOWN_upv_1.ranks do
        local v17 = ((key_1 <= v16) and (310 - (v16 - key_1) * 74)) or (890 + ((key_1 - v16) - 1) * 74)
        local v18 = Instance.new("Frame")
        v18.Name = value_1.name
        v18.BackgroundTransparency = 1
        v18.AnchorPoint = Vector2.new(0.5, 0.5)
        v18.Position = UDim2.fromOffset(v17, 168)
        v18.Size = UDim2.fromOffset(62, 62)
        v18.Parent = u6
        local v19 = Instance.new("ImageLabel")
        v19.Name = "Emblem"
        v19.BackgroundTransparency = 1
        local Ranks_2 = UIAssets_upv_1.Ranks
        local v20 = (Ranks_2 and (Ranks_2[string.lower(value_1.name)])) or (value_1.img or "")
        v19.Image = v20
        v19.ScaleType = Enum.ScaleType.Fit
        v19.Size = UDim2.fromScale(1, 1)
        v19.Parent = v18
        local v21 = Instance.new("UIScale")
        v21.Parent = v18
        table.insert(tbl_upv_3, {cell = v18, img = v19, scale = v21})
    end
    local u14 = Instance.new("Frame")
    u14.Name = "Hero"
    u14.BackgroundTransparency = 1
    u14.AnchorPoint = Vector2.new(0.5, 0.5)
    u14.Position = UDim2.fromOffset(640, 120)
    u14.Size = UDim2.fromOffset(620, 210)
    u14.Visible = false
    u14.ZIndex = 3
    u14.Parent = u6
    local u15 = Instance.new("UIScale")
    u15.Parent = u14
    local u16 = Instance.new("ImageLabel")
    u16.Name = "Glow"
    u16.BackgroundTransparency = 1
    u16.Image = "rbxassetid://90962482350826"
    u16.ImageTransparency = 1
    u16.ScaleType = Enum.ScaleType.Stretch
    u16.AnchorPoint = Vector2.new(0.5, 0.5)
    u16.Position = UDim2.fromOffset(100, 105)
    u16.Size = UDim2.fromOffset(300, 300)
    u16.Parent = u14
    local u17 = Instance.new("UIScale")
    u17.Parent = u16
    local u18 = Instance.new("ImageLabel")
    u18.Name = "Emblem"
    u18.BackgroundTransparency = 1
    u18.ScaleType = Enum.ScaleType.Fit
    u18.AnchorPoint = Vector2.new(0.5, 0.5)
    u18.Position = UDim2.fromOffset(100, 105)
    u18.Size = UDim2.fromOffset(180, 180)
    u18.ZIndex = 4
    u18.Parent = u14
    local u19 = text("Kicker", 370, 66, 320, 30, v3, 2, u14)
    local u20 = text("HeroName", 370, 124, 320, 80, v2, 4, u14)
    for _, value_2 in {u19, u20} do
        value_2.label.TextXAlignment = Enum.TextXAlignment.Left
        value_2.shadow.TextXAlignment = Enum.TextXAlignment.Left
        value_2.label.ZIndex = 5
        value_2.shadow.ZIndex = 4
    end
    u19.label.Text = "NEW RANK REVEALED"
    u19.shadow.Text = "NEW RANK REVEALED"
    u19.label.TextColor3 = Gold_upv_1
    local u21 = Instance.new("ImageLabel")
    u21.Name = "Flyer"
    u21.BackgroundTransparency = 1
    u21.ScaleType = Enum.ScaleType.Fit
    u21.AnchorPoint = Vector2.new(0.5, 0.5)
    u21.Visible = false
    u21.ZIndex = 6
    u21.Parent = u6
    u5.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
    u12.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
    local u22 = Instance.new("ScreenGui")
    u22.Name = "UpdateCountdownBanner"
    u22.ResetOnSpawn = false
    u22.DisplayOrder = 30
    u22.IgnoreGuiInset = false
    u22.Parent = LocalPlayer_upv_1:WaitForChild("PlayerGui")
    local u23 = Instance.new("Frame")
    u23.Name = "Banner"
    u23.AnchorPoint = Vector2.new(0.5, 1)
    u23.Position = UDim2.new(0.5, 0, 0, -10)
    u23.Size = UDim2.fromOffset(420, 92)
    u23.BackgroundColor3 = fromRGB_upv_1(14, 17, 24)
    u23.BackgroundTransparency = 0.08
    u23.Visible = false
    u23.Parent = u22
    local u24 = Instance.new("UICorner")
    u24.CornerRadius = UDim.new(0, 14)
    u24.Parent = u23
    u24 = Instance.new("UIStroke")
    u24.Thickness = 2
    u24.Color = Gold_upv_1
    u24.Transparency = 0.25
    u24.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    u24.Parent = u23
    u24 = Instance.new("ImageLabel")
    u24.BackgroundTransparency = 1
    u24.ScaleType = Enum.ScaleType.Fit
    u24.Position = UDim2.fromOffset(12, 10)
    u24.Size = UDim2.fromOffset(72, 72)
    u24.Parent = u23
    local v22 = Instance.new("TextLabel")
    v22.BackgroundTransparency = 1
    v22.Position = UDim2.fromOffset(98, 14)
    v22.Size = UDim2.new(1, -110, 0, 22)
    v22.FontFace = v3
    v22.TextSize = 17
    v22.TextColor3 = Gold_upv_1
    v22.TextXAlignment = Enum.TextXAlignment.Left
    v22.Text = "NEW RANK REVEALED"
    v22.Parent = u23
    local u25 = Instance.new("TextLabel")
    u25.BackgroundTransparency = 1
    u25.Position = UDim2.fromOffset(98, 38)
    u25.Size = UDim2.new(1, -110, 0, 40)
    u25.FontFace = v2
    u25.TextScaled = true
    u25.TextColor3 = Colors_upv_1.White
    u25.TextXAlignment = Enum.TextXAlignment.Left
    u25.Parent = u23
    local u26 = 0
    local function showBanner(a1)
        --[[
          name: showBanner
          line: 368
          upvalues:
            u26 (ref,  index: 1)
            u24 (copy, index: 2)
            UIAssets_upv_1 (copy, index: 3)
            u25 (copy, index: 4)
            u23 (copy, index: 5)
            TweenService_upv_1 (copy, index: 6)
        ]]
        u26 = u26 + 1
        local u27 = u26
        local Ranks_3 = UIAssets_upv_1.Ranks
        u24.Image = Ranks_3 and Ranks_3[string.lower(a1.name)] or a1.img or ""
        u25.Text = a1.name
        u23.Position = UDim2.new(0.5, 0, 0, -10)
        u23.Visible = true
        local v24 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local tbl_4 = {}
        tbl_4.Position = UDim2.new(0.5, 0, 0, 110)
        TweenService_upv_1:Create(u23, v24, tbl_4):Play()
        task.delay(
            4.2,
            function()
                --[[
                  line: 376
                  upvalues:
                    u26 (ref,  index: 1)
                    u27 (copy, index: 2)
                    TweenService_upv_1 (copy, index: 3)
                    u23 (copy, index: 4)
                ]]
                if u26 == u27 then
                    local v25 = TweenService_upv_1:Create(u23, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0, -10)})
                    v25.Completed:Once(
                        function()
                            --[[
                              line: 379
                              upvalues:
                                u26 (ref,  index: 1)
                                u27 (copy, index: 2)
                                u23 (copy, index: 3)
                            ]]
                            if u26 ~= u27 then
                                return
                            end
                            u23.Visible = false
                        end
                    )
                    v25:Play()
                end
            end
        )
    end
    local u28 = Instance.new("Folder")
    u28.Name = "UpdateCountdownFx"
    u28.Parent = Workspace_upv_1
    local u29 = Random.new()
    local RightVector_upv_1 = u4.CFrame.RightVector
    local UpVector_upv_1 = u4.CFrame.UpVector
    local u30 = -u4.CFrame.LookVector
    local function around(a1, a2, a3)
        --[[
          name: around
          line: 401
          upvalues:
            RightVector_upv_1 (copy, index: 1)
            UpVector_upv_1 (copy, index: 2)
            u30 (copy, index: 3)
        ]]
        return ((Vector3.new(0, 66, -135) + (RightVector_upv_1 * a1)) + (UpVector_upv_1 * a2)) + (u30 * (a3 or 30))
    end
    local tbl_upv_5 = {}
    local function fwSound(a1, a2, a3, a4)
        --[[
          name: fwSound
          line: 410
          upvalues:
            Sfx_upv_1 (ref,  index: 1)
            tbl_upv_5 (copy, index: 2)
            u29 (copy, index: 3)
        ]]
        if not Sfx_upv_1 or (os.clock() - (tbl_upv_5[a1] or 0) < a2) then
            return
        end
        tbl_upv_5[a1] = os.clock()
        task.delay(
            a3,
            function()
                --[[
                  line: 415
                  upvalues:
                    Sfx_upv_1 (ref,  index: 1)
                    a1 (copy, index: 2)
                    a4 (copy, index: 3)
                    u29 (copy, index: 4)
                ]]
                pcall(Sfx_upv_1.Play, a1, nil, {volume = a4, pitch = u29:NextNumber(0.94, 1.06)})
            end
        )
    end
    local function boom(a1)
        --[[
          name: boom
          line: 419
          upvalues:
            fwSound (copy, index: 1)
        ]]
        fwSound("Firework/Explode", 0.25, 0.15, 1)
        fwSound("Firework/Crackle", 0.6, 0.45, 1)
    end
    local function burst(a1, a2, a3)
        --[[
          name: burst
          line: 424
          upvalues:
            u28 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
        ]]
        local u31 = Instance.new("Part")
        u31.Anchored = true
        u31.CanCollide = false
        u31.CanQuery = false
        u31.CanTouch = false
        u31.Transparency = 1
        u31.Size = Vector3.new(1, 1, 1)
        u31.CFrame = CFrame.new(a1)
        u31.Parent = u28
        local function emitter_1(a4, a5, a6, a7, a8, a9)
            --[[
              name: emitter
              line: 434
              upvalues:
                a2 (copy, index: 1)
                u31 (copy, index: 2)
            ]]
            local v26 = Instance.new("ParticleEmitter")
            v26.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            v26.LightEmission = 1
            v26.LightInfluence = 0
            v26.Brightness = a9
            v26.Color = ColorSequence.new(a8, a2)
            v26.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, a5), NumberSequenceKeypoint.new(0.7, a5 * 0.6), NumberSequenceKeypoint.new(1, 0)})
            v26.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.75, 0.15), NumberSequenceKeypoint.new(1, 1)})
            v26.Lifetime = NumberRange.new(a7 * 0.75, a7)
            v26.Speed = NumberRange.new(a6 * 0.8, a6)
            v26.SpreadAngle = Vector2.new(180, 180)
            v26.Acceleration = Vector3.new(0, -22, 0)
            v26.Drag = 1.6
            v26.Rate = 0
            v26.RotSpeed = NumberRange.new(-180, 180)
            v26.Parent = u31
            v26:Emit(a4)
        end
        emitter_1(math.floor(a3 * 120), a3 * 8, a3 * 72, 2, a2:Lerp(Colors_upv_1.White, 0.1), 3)
        emitter_1(math.floor(a3 * 26), a3 * 4, a3 * 36, 2.6, a2:Lerp(Colors_upv_1.White, 0.6), 2)
        task.delay(
            4,
            function()
                --[[
                  line: 456
                  upvalues:
                    u31 (copy, index: 1)
                ]]
                u31:Destroy()
            end
        )
    end
    local tbl_upv_6 = {fromRGB_upv_1(255, 204, 64), fromRGB_upv_1(255, 92, 92), fromRGB_upv_1(86, 202, 255), fromRGB_upv_1(186, 116, 255), fromRGB_upv_1(120, 236, 150), fromRGB_upv_1(255, 150, 80)}
    local function rocket(a1, a2, a3)
        --[[
          name: rocket
          line: 462
          upvalues:
            u29 (copy, index: 1)
            Colors_upv_1 (copy, index: 2)
            u28 (copy, index: 3)
            TweenService_upv_1 (copy, index: 4)
            burst (copy, index: 5)
            fwSound (copy, index: 6)
        ]]
        local v27 = Vector3.new(a1.X + u29:NextNumber(-20, 20), 30, a1.Z + u29:NextNumber(-10, 10))
        local u32 = Instance.new("Part")
        u32.Anchored = true
        u32.CanCollide = false
        u32.CanQuery = false
        u32.CanTouch = false
        u32.CastShadow = false
        u32.Material = Enum.Material.Neon
        u32.Color = a2:Lerp(Colors_upv_1.White, 0.5)
        u32.Size = Vector3.new(1.600000023841858, 1.600000023841858, 1.600000023841858)
        u32.Shape = Enum.PartType.Ball
        u32.CFrame = CFrame.new(v27)
        v27 = Instance.new("Attachment")
        v27.Position = Vector3.new(0, 0.800000011920929, 0)
        v27.Parent = u32
        local v28 = Instance.new("Attachment")
        v28.Position = Vector3.new(0, -0.800000011920929, 0)
        v28.Parent = u32
        local v29 = Instance.new("Trail")
        v29.Attachment0 = v27
        v29.Attachment1 = v28
        v29.Lifetime = 0.45
        v29.LightEmission = 1
        v29.FaceCamera = true
        v29.Color = ColorSequence.new(a2:Lerp(Colors_upv_1.White, 0.6), a2)
        v29.Transparency = NumberSequence.new(0, 1)
        v29.WidthScale = NumberSequence.new(1, 0)
        v29.Parent = u32
        u32.Parent = u28
        local v30 = TweenService_upv_1:Create(u32, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(a1)})
        v30.Completed:Once(
            function()
                --[[
                  line: 493
                  upvalues:
                    u32 (copy, index: 1)
                    burst (copy, index: 2)
                    a1 (copy, index: 3)
                    a2 (copy, index: 4)
                    a3 (copy, index: 5)
                    fwSound (copy, index: 6)
                ]]
                u32.Transparency = 1
                burst(a1, a2, a3)
                fwSound("Firework/Explode", 0.25, 0.15, 1)
                fwSound("Firework/Crackle", 0.6, 0.45, 1)
                task.delay(
                    0.6,
                    function()
                        --[[
                          line: 497
                          upvalues:
                            u32 (copy, index: 1)
                        ]]
                        u32:Destroy()
                    end
                )
            end
        )
        v30:Play()
    end
    local Lighting_2 = ReplicatedStorage_upv_1:FindFirstChild("Lighting")
    local u33 = Lighting_2 and (Lighting_2:FindFirstChild("Lobby"))
    local function base(a1, a2)
        --[[
          name: base
          line: 529
          upvalues:
            u33 (copy, index: 1)
        ]]
        local v31
        if u33 then
            v31 = u33:GetAttribute(a1)
        else
            v31 = u33
        end
        if v31 == nil then
            return a2
        end
        return v31
    end
    local v32 = u33 and (u33:FindFirstChildOfClass("Atmosphere"))
    local tbl_upv_7 = {atmColor = 0, atmGlare = 0, atmHaze = 0, rays = 0, atmDensity = 0, outdoor = 0, clock = 0, brightness = 0, atmDecay = 0, shiftTop = 0}
    local v33 = u33 and (u33:GetAttribute("ClockTime"))
    local u34
    if v33 == nil then
        u34 = 16.3
    else
        u34 = v33
    end
    tbl_upv_7.clock = u34
    local v34 = fromRGB_upv_1(214, 184, 140)
    local v35 = u33 and (u33:GetAttribute("ColorShift_Top"))
    if v35 == nil then
        u34 = v34
    else
        u34 = v35
    end
    tbl_upv_7.shiftTop = u34
    local v36 = u33 and (u33:GetAttribute("Brightness"))
    if v36 == nil then
        u34 = 2.5
    else
        u34 = v36
    end
    tbl_upv_7.brightness = u34
    local v37 = fromRGB_upv_1(136, 128, 126)
    local v38 = u33 and (u33:GetAttribute("OutdoorAmbient"))
    if v38 == nil then
        u34 = v37
    else
        u34 = v38
    end
    tbl_upv_7.outdoor = u34
    if v32 then
        u34 = v32.Color
    else
        u34 = fromRGB_upv_1(224, 210, 190)
    end
    tbl_upv_7.atmColor = u34
    if v32 then
        u34 = v32.Decay
    else
        u34 = fromRGB_upv_1(170, 160, 178)
    end
    tbl_upv_7.atmDecay = u34
    tbl_upv_7.atmHaze = ((not v32) and 1.2) or (v32.Haze)
    tbl_upv_7.atmDensity = ((not v32) and 0.24) or (v32.Density)
    tbl_upv_7.atmGlare = ((not v32) and 0.08) or (v32.Glare)
    local v39 = u33 and (u33:FindFirstChildOfClass("SunRaysEffect"))
    if v39 then
        u34 = v39.Intensity
    else
        u34 = 0.035
    end
    tbl_upv_7.rays = u34
    local tbl_upv_8 = {bright = 2.9, density = 0.27, rays = 0.14, clock = 17.35, glare = 2.2, haze = 1.6}
    tbl_upv_8.shiftTop = fromRGB_upv_1(255, 176, 110)
    tbl_upv_8.atmColor = fromRGB_upv_1(255, 178, 130)
    tbl_upv_8.atmDecay = fromRGB_upv_1(232, 128, 140)
    tbl_upv_8.outdoor = fromRGB_upv_1(170, 132, 118)
    local tbl_upv_9 = {bright = 2.6, density = 0.29, rays = 0.2, clock = 17.62, glare = 3, haze = 1.9}
    tbl_upv_9.shiftTop = fromRGB_upv_1(255, 140, 100)
    tbl_upv_9.atmColor = fromRGB_upv_1(255, 150, 120)
    tbl_upv_9.atmDecay = fromRGB_upv_1(196, 98, 150)
    tbl_upv_9.outdoor = fromRGB_upv_1(156, 112, 128)
    u34 = Instance.new("ColorCorrectionEffect")
    u34.Name = "UpdateCountdownGrade"
    u34.Enabled = false
    u34.Parent = CurrentCamera_1
    local LightingController_upv_1 = nil
    pcall(
        function()
            --[[
              line: 560
              upvalues:
                LightingController_upv_1 (ref, index: 1)
            ]]
            LightingController_upv_1 = require(script.Parent.Parent.Core.LightingController)
        end
    )
    local function lobbyLit()
        --[[
          name: lobbyLit
          line: 563
          upvalues:
            LightingController_upv_1 (ref, index: 1)
        ]]
        if not LightingController_upv_1 then
            return true
        end
        local success_1, v40 = pcall(LightingController_upv_1.Current)
        return success_1 and (v40 == "Lobby")
    end
    local tbl_upv_10 = {w = 0, d = 0}
    local u35 = false
    local function paintSky(a1, a2)
        --[[
          name: paintSky
          line: 573
          upvalues:
            LocalPlayer_upv_1 (copy, index: 1)
            LightingController_upv_1 (ref,  index: 2)
            u34 (copy, index: 3)
            u35 (ref,  index: 4)
            Lighting_upv_1 (copy, index: 5)
            tbl_upv_7 (copy, index: 6)
            tbl_upv_8 (copy, index: 7)
            tbl_upv_9 (copy, index: 8)
            Colors_upv_1 (copy, index: 9)
            fromRGB_upv_1 (copy, index: 10)
        ]]
        local v41 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
        if v41 then
            if LightingController_upv_1 then
                local success_2, v42 = pcall(LightingController_upv_1.Current)
                v41 = success_2 and (v42 == "Lobby")
            else
                v41 = true
            end
            if v41 then
                if a1 <= 0.001 and a2 <= 0.001 then
                    if u35 then
                        Lighting_upv_1.ClockTime = tbl_upv_7.clock
                        Lighting_upv_1.ColorShift_Top = tbl_upv_7.shiftTop
                        Lighting_upv_1.Brightness = tbl_upv_7.brightness
                        Lighting_upv_1.OutdoorAmbient = tbl_upv_7.outdoor
                        v41 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                        if v41 then
                            v41.Color = tbl_upv_7.atmColor
                            v41.Decay = tbl_upv_7.atmDecay
                            v41.Haze = tbl_upv_7.atmHaze
                            v41.Density = tbl_upv_7.atmDensity
                            v41.Glare = tbl_upv_7.atmGlare
                        end
                        v41 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                        if v41 then
                            v41.Intensity = tbl_upv_7.rays
                        end
                        u35 = false
                    end
                    u34.Enabled = false
                    return
                end
                u35 = true
                local function mix_1(a3, a4, a5)
                    --[[
                      name: mix
                      line: 600
                      upvalues:
                        a1 (copy, index: 1)
                        a2 (copy, index: 2)
                    ]]
                    if typeof(a3) == "Color3" then
                        return a3:Lerp(a4, a1):Lerp(a5, a2)
                    end
                    local v43 = a3 + (a4 - a3) * a1
                    return v43 + ((a5 - v43) * a2)
                end
                local clock_1 = tbl_upv_7.clock
                local clock_2 = tbl_upv_8.clock
                local clock_3 = tbl_upv_9.clock
                local v42
                if typeof(clock_1) ~= "Color3" then
                    local _ = clock_1 + (clock_2 - clock_1) * a1
                    v42 = clock_1 + (clock_2 - clock_1) * a1 + (clock_3 - (clock_1 + (clock_2 - clock_1) * a1)) * a2
                else
                    v42 = clock_1:Lerp(clock_2, a1):Lerp(clock_3, a2)
                end
                Lighting_upv_1.ClockTime = v42
                local shiftTop_1 = tbl_upv_7.shiftTop
                local shiftTop_2 = tbl_upv_8.shiftTop
                local shiftTop_3 = tbl_upv_9.shiftTop
                if typeof(shiftTop_1) ~= "Color3" then
                    local _ = shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1
                    v42 = shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1 + (shiftTop_3 - (shiftTop_1 + (shiftTop_2 - shiftTop_1) * a1)) * a2
                else
                    v42 = shiftTop_1:Lerp(shiftTop_2, a1):Lerp(shiftTop_3, a2)
                end
                Lighting_upv_1.ColorShift_Top = v42
                local brightness_1 = tbl_upv_7.brightness
                local bright_1 = tbl_upv_8.bright
                local bright_2 = tbl_upv_9.bright
                if typeof(brightness_1) ~= "Color3" then
                    local _ = brightness_1 + (bright_1 - brightness_1) * a1
                    v42 = brightness_1 + (bright_1 - brightness_1) * a1 + (bright_2 - (brightness_1 + (bright_1 - brightness_1) * a1)) * a2
                else
                    v42 = brightness_1:Lerp(bright_1, a1):Lerp(bright_2, a2)
                end
                Lighting_upv_1.Brightness = v42
                local v44 = tbl_upv_7.outdoor
                local outdoor_1 = tbl_upv_8.outdoor
                local outdoor_2 = tbl_upv_9.outdoor
                if typeof(v44) ~= "Color3" then
                    local _ = v44 + (outdoor_1 - v44) * a1
                    v42 = v44 + (outdoor_1 - v44) * a1 + (outdoor_2 - (v44 + (outdoor_1 - v44) * a1)) * a2
                else
                    v42 = v44:Lerp(outdoor_1, a1):Lerp(outdoor_2, a2)
                end
                Lighting_upv_1.OutdoorAmbient = v42
                local v45 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                local v46 = nil
                if v45 then
                    v46 = tbl_upv_7.rays
                    local rays_1 = tbl_upv_8.rays
                    local rays_2 = tbl_upv_9.rays
                    if typeof(v46) ~= "Color3" then
                        local _ = v46 + (rays_1 - v46) * a1
                        v42 = v46 + (rays_1 - v46) * a1 + (rays_2 - (v46 + (rays_1 - v46) * a1)) * a2
                    else
                        v42 = v46:Lerp(rays_1, a1):Lerp(rays_2, a2)
                    end
                    v45.Intensity = v42
                end
                local v47 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                local v48, v49, v50, v51, v52 = nil, nil, nil, nil, nil
                if v47 then
                    v48 = tbl_upv_7.atmColor
                    local atmColor_1 = tbl_upv_8.atmColor
                    local atmColor_2 = tbl_upv_9.atmColor
                    if typeof(v48) ~= "Color3" then
                        local _ = v48 + (atmColor_1 - v48) * a1
                        v42 = v48 + (atmColor_1 - v48) * a1 + (atmColor_2 - (v48 + (atmColor_1 - v48) * a1)) * a2
                    else
                        v42 = v48:Lerp(atmColor_1, a1):Lerp(atmColor_2, a2)
                    end
                    v47.Color = v42
                    v49 = tbl_upv_7.atmDecay
                    local atmDecay_1 = tbl_upv_8.atmDecay
                    local atmDecay_2 = tbl_upv_9.atmDecay
                    if typeof(v49) ~= "Color3" then
                        local _ = v49 + (atmDecay_1 - v49) * a1
                        v42 = v49 + (atmDecay_1 - v49) * a1 + (atmDecay_2 - (v49 + (atmDecay_1 - v49) * a1)) * a2
                    else
                        v42 = v49:Lerp(atmDecay_1, a1):Lerp(atmDecay_2, a2)
                    end
                    v47.Decay = v42
                    v50 = tbl_upv_7.atmHaze
                    local haze_1 = tbl_upv_8.haze
                    local haze_2 = tbl_upv_9.haze
                    if typeof(v50) ~= "Color3" then
                        local _ = v50 + (haze_1 - v50) * a1
                        v42 = v50 + (haze_1 - v50) * a1 + (haze_2 - (v50 + (haze_1 - v50) * a1)) * a2
                    else
                        v42 = v50:Lerp(haze_1, a1):Lerp(haze_2, a2)
                    end
                    v47.Haze = v42
                    v51 = tbl_upv_7.atmDensity
                    local density_1 = tbl_upv_8.density
                    local density_2 = tbl_upv_9.density
                    if typeof(v51) ~= "Color3" then
                        local _ = v51 + (density_1 - v51) * a1
                        v42 = v51 + (density_1 - v51) * a1 + (density_2 - (v51 + (density_1 - v51) * a1)) * a2
                    else
                        v42 = v51:Lerp(density_1, a1):Lerp(density_2, a2)
                    end
                    v47.Density = v42
                    v52 = tbl_upv_7.atmGlare
                    local glare_1 = tbl_upv_8.glare
                    local glare_2 = tbl_upv_9.glare
                    if typeof(v52) ~= "Color3" then
                        local _ = v52 + (glare_1 - v52) * a1
                        v42 = v52 + (glare_1 - v52) * a1 + (glare_2 - (v52 + (glare_1 - v52) * a1)) * a2
                    else
                        v42 = v52:Lerp(glare_1, a1):Lerp(glare_2, a2)
                    end
                    v47.Glare = v42
                end
                u34.Enabled = true
                local White_1 = Colors_upv_1.White
                local v53 = fromRGB_upv_1(255, 238, 222)
                local v54 = fromRGB_upv_1(255, 228, 226)
                if typeof(White_1) ~= "Color3" then
                    local _ = White_1 + (v53 - White_1) * a1
                    v44 = White_1 + (v53 - White_1) * a1 + (v54 - (White_1 + (v53 - White_1) * a1)) * a2
                else
                    v44 = White_1:Lerp(v53, a1):Lerp(v54, a2)
                end
                u34.TintColor = v44
                u34.Saturation = a1 * 0.12
                u34.Contrast = a1 * 0.05
                u34.Brightness = a1 * 0.03
                return
            end
        end
        u34.Enabled = false
        u35 = false
    end
    local function localTime(a1)
        --[[
          name: localTime
          line: 644
        ]]
        local success_3, v55 = pcall(function() end)
        if success_3 then
            return string.upper(v55) .. " YOUR TIME"
        end
        return ""
    end
    local at_upv_1 = UPDATE_COUNTDOWN_upv_1.at
    local success_4, v56 = pcall(
        function()
            --[[
              line: 645
              upvalues:
                at_upv_1 (copy, index: 1)
            ]]
            return DateTime.fromUnixTimestamp(at_upv_1):FormatLocalTime("dddd h:mm A", "en-us")
        end
    )
    local u36 = (success_4 and (string.upper(v56) .. " YOUR TIME")) or ""
    local tbl_upv_11 = {}
    local function set(a1, a2)
        --[[
          name: set
          line: 653
          upvalues:
            tbl_upv_11 (copy, index: 1)
        ]]
        if tbl_upv_11[a1] == a2 then
            return
        end
        tbl_upv_11[a1] = a2
        a1.label.Text = a2
        a1.shadow.Text = a2
    end
    local function paintSlot(a1, a2)
        --[[
          name: paintSlot
          line: 668
          upvalues:
            tbl_upv_3 (copy, index: 1)
            Colors_upv_1 (copy, index: 3)
            u3 (copy, index: 4)
        ]]
        local v57 = tbl_upv_3[a1]
        v57.out = a2
        if a2 then
            v57.img.ImageColor3 = Colors_upv_1.White
            v57.img.ImageTransparency = 0
        else
            v57.img.ImageColor3 = u3
            v57.img.ImageTransparency = 0.15
        end
    end
    local u37 = false
    local u38 = 0
    local function fadeText(a1, a2)
        --[[
          name: fadeText
          line: 661
          upvalues:
            tbl_upv_2 (copy, index: 1)
            TweenService_upv_1 (copy, index: 2)
        ]]
        for _, value_3 in tbl_upv_2 do
            local tbl_12 = {}
            tbl_12.TextTransparency = a1
            TweenService_upv_1:Create(value_3.label, TweenInfo.new(a2), tbl_12):Play()
            local v58 = TweenInfo.new(a2)
            local tbl_13 = {}
            tbl_13.TextTransparency = math.max(a1, 0.45)
            TweenService_upv_1:Create(value_3.shadow, v58, tbl_13):Play()
        end
    end
    local function volley(a1, a2, a3, a4)
        --[[
          name: volley
          line: 507
          upvalues:
            u29 (copy, index: 1)
            LocalPlayer_upv_1 (copy, index: 2)
            rocket (copy, index: 3)
            RightVector_upv_1 (copy, index: 4)
            UpVector_upv_1 (copy, index: 5)
            u30 (copy, index: 6)
            tbl_upv_6 (copy, index: 7)
        ]]
        for n_upv_1 = 1, a1 do
            task.delay(
                (((n_upv_1 - 1) / math.max(1, a1 - 1)) * a2) + u29:NextNumber(0, 0.15),
                function()
                    --[[
                      line: 509
                      upvalues:
                        LocalPlayer_upv_1 (copy, index: 1)
                        n_upv_1 (copy, index: 2)
                        u29 (copy, index: 3)
                        rocket (copy, index: 4)
                        RightVector_upv_1 (copy, index: 5)
                        UpVector_upv_1 (copy, index: 6)
                        u30 (copy, index: 7)
                        a3 (copy, index: 8)
                        tbl_upv_6 (copy, index: 9)
                        a4 (copy, index: 10)
                    ]]
                    local v59 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                    if not v59 then
                        return
                    end
                    local v60 = (((n_upv_1 % 2 ~= 0) and -1) or 1) * u29:NextNumber(150, 260)
                    v59 = u29:NextNumber(10, 80)
                    if n_upv_1 % 3 == 0 then
                        v60, v59 = u29:NextNumber(-140, 140), u29:NextNumber(70, 110)
                    end
                    local v61 = a3 or (tbl_upv_6[u29:NextInteger(1, #tbl_upv_6)])
                    rocket(((Vector3.new(0, 66, -135) + (RightVector_upv_1 * v60)) + (UpVector_upv_1 * v59)) + (u30 * 30), v61, a4)
                end
            )
        end
    end
    local function reveal(a1)
        --[[
          name: reveal
          line: 685
          upvalues:
            UPDATE_COUNTDOWN_upv_1 (copy, index: 1)
            Gold_upv_1 (copy, index: 2)
            u37 (ref,  index: 3)
            u38 (ref,  index: 4)
            tbl_upv_3 (copy, index: 5)
            u3 (copy, index: 6)
            u18 (copy, index: 7)
            UIAssets_upv_1 (copy, index: 8)
            u20 (copy, index: 9)
            tbl_upv_11 (copy, index: 10)
            Colors_upv_1 (copy, index: 11)
            u19 (copy, index: 12)
            u14 (copy, index: 13)
            u15 (copy, index: 14)
            fadeText (copy, index: 15)
            TweenService_upv_1 (copy, index: 16)
            u16 (copy, index: 17)
            u17 (copy, index: 18)
            Sfx_upv_1 (ref,  index: 19)
            volley (copy, index: 20)
            showBanner (copy, index: 21)
            u21 (copy, index: 22)
        ]]
        local u39 = UPDATE_COUNTDOWN_upv_1.ranks[a1]
        local v62 = u39.color or Gold_upv_1
        local v63 = a1 == #UPDATE_COUNTDOWN_upv_1.ranks
        u37 = true
        u38 = a1
        local v64 = tbl_upv_3[a1]
        v64.out = false
        v64.img.ImageColor3 = u3
        v64.img.ImageTransparency = 0.15
        local Ranks_4 = UIAssets_upv_1.Ranks
        u18.Image = Ranks_4 and Ranks_4[string.lower(u39.name)] or u39.img or ""
        u18.ImageTransparency = 0
        local name_1 = u39.name
        if tbl_upv_11[u20] ~= name_1 then
            tbl_upv_11[u20] = name_1
            u20.label.Text = name_1
            u20.shadow.Text = name_1
        end
        u20.label.TextColor3 = v62:Lerp(Colors_upv_1.White, 0.35)
        for _, value_4 in {u20, u19} do
            value_4.label.TextTransparency = 0
            value_4.shadow.TextTransparency = 0.45
        end
        u14.Position = UDim2.fromOffset(640, 120)
        u14.Visible = true
        u15.Scale = 0.3
        fadeText(1, 0.2)
        local tbl_14 = {Scale = 1}
        TweenService_upv_1:Create(u15, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_14):Play()
        u16.ImageColor3 = v62
        u16.ImageTransparency = 0
        u17.Scale = 0.4
        local tbl_15 = {ImageTransparency = 0.55}
        TweenService_upv_1:Create(u16, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_15):Play()
        local tbl_16 = {Scale = 1.3}
        TweenService_upv_1:Create(u17, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_16):Play()
        if Sfx_upv_1 then
            pcall(Sfx_upv_1.PlayUI, "UI/Unlock")
        end
        if v63 then
            task.delay(
                0.15,
                function()
                    --[[
                      line: 712
                      upvalues:
                        Sfx_upv_1 (ref, index: 1)
                    ]]
                    if not Sfx_upv_1 then
                        return
                    end
                    pcall(Sfx_upv_1.PlayUI, "UI/NewItem_Fanfare")
                end
            )
        end
        volley((v63 and 14) or 8, 2.4, v62, (v63 and 1.35) or 1.1)
        showBanner(u39)
        task.delay(
            3.4,
            function()
                --[[
                  line: 718
                  upvalues:
                    tbl_upv_3 (copy, index: 1)
                    a1 (copy, index: 2)
                    u21 (copy, index: 3)
                    u39 (copy, index: 4)
                    UIAssets_upv_1 (copy, index: 5)
                    u14 (copy, index: 6)
                    u16 (copy, index: 7)
                    TweenService_upv_1 (copy, index: 8)
                    Colors_upv_1 (copy, index: 10)
                    Sfx_upv_1 (ref,  index: 11)
                    fadeText (copy, index: 12)
                    u37 (ref,  index: 13)
                    u38 (ref,  index: 14)
                ]]
                local v66 = tbl_upv_3[a1]
                local v67 = Vector2.new(430, 120)
                local Ranks_5 = UIAssets_upv_1.Ranks
                u21.Image = Ranks_5 and Ranks_5[string.lower(u39.name)] or u39.img or ""
                u21.Position = UDim2.fromOffset(v67.X, v67.Y)
                u21.Size = UDim2.fromOffset(180, 180)
                u21.Visible = true
                u14.Visible = false
                u16.ImageTransparency = 1
                local v69 = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                local tbl_17 = {}
                tbl_17.Position = v66.cell.Position
                tbl_17.Size = UDim2.fromOffset(62, 62)
                TweenService_upv_1:Create(u21, v69, tbl_17):Play()
                task.wait(0.55)
                u21.Visible = false
                local v70 = tbl_upv_3[a1]
                v70.out = true
                v70.img.ImageColor3 = Colors_upv_1.White
                v70.img.ImageTransparency = 0
                v66.scale.Scale = 1.6
                local tbl_18 = {Scale = 1}
                TweenService_upv_1:Create(v66.scale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_18):Play()
                if Sfx_upv_1 then
                    pcall(Sfx_upv_1.PlayUI, "UI/Card_Reveal")
                end
                fadeText(0, 0.35)
                u37 = false
                u38 = 0
            end
        )
    end
    local u40 = -1
    local u41 = ""
    local u42 = false
    local u43 = os.clock()
    local u44 = nil
    local u45 = 0
    local tbl_upv_19 = {}
    Workspace_upv_1:GetAttributeChangedSignal("CountdownPreviewAt"):Connect(
        function()
            --[[
              line: 754
              upvalues:
                u42 (ref,  index: 1)
                u41 (ref,  index: 2)
                u44 (ref,  index: 3)
                tbl_upv_19 (copy, index: 4)
            ]]
            u42 = false
            u41 = ""
            u44 = nil
            table.clear(tbl_upv_19)
        end
    )
    local function clock_4(a1)
        --[[
          name: clock
          line: 633
        ]]
        local v71 = a1 // 86400
        local v72 = a1 // 3600 % 24
        local v73 = a1 // 60 % 60
        local v74 = a1 % 60
        if v71 > 0 then
            return string.format("%dD %02d:%02d:%02d", v71, v72, v73, v74)
        elseif v72 > 0 then
            return string.format("%d:%02d:%02d", v72, v73, v74)
        else
            return string.format("%d:%02d", v73, v74)
        end
    end
    local function step(a1)
        --[[
          name: step
          line: 761
          upvalues:
            Workspace_upv_1 (copy, index: 1)
            UPDATE_COUNTDOWN_upv_1 (copy, index: 2)
            LocalPlayer_upv_1 (copy, index: 3)
            u5 (copy, index: 4)
            u12 (copy, index: 5)
            u22 (copy, index: 6)
            tbl_upv_3 (copy, index: 7)
            u42 (ref,  index: 8)
            Colors_upv_1 (copy, index: 9)
            u3 (copy, index: 10)
            tbl_upv_19 (copy, index: 11)
            u38 (ref,  index: 12)
            u43 (copy, index: 13)
            u37 (ref,  index: 14)
            reveal (copy, index: 15)
            u1 (copy, index: 16)
            u2 (copy, index: 17)
            ReplicatedStorage_upv_1 (copy, index: 18)
            tbl_upv_10 (copy, index: 19)
            paintSky (copy, index: 20)
            u8 (copy, index: 21)
            Gold_upv_1 (copy, index: 22)
            u9 (copy, index: 23)
            u10 (copy, index: 24)
            tbl_upv_11 (copy, index: 25)
            u13 (copy, index: 26)
            u40 (ref,  index: 27)
            TweenService_upv_1 (copy, index: 28)
            Sfx_upv_1 (ref,  index: 29)
            u36 (copy, index: 30)
            clock_4 (copy, index: 31)
            u41 (ref,  index: 32)
            u44 (ref,  index: 33)
            volley (copy, index: 34)
            u45 (ref,  index: 35)
            u29 (copy, index: 36)
        ]]
        local v75 = Workspace_upv_1:GetServerTimeNow()
        local v76 = Workspace_upv_1:GetAttribute("CountdownPreview")
        local v77 = Workspace_upv_1:GetAttribute("CountdownPreviewAt")
        local v78
        if type(v76) == "number" and type(v77) == "number" then
            v78 = UPDATE_COUNTDOWN_upv_1.at - v76 + (v75 - v77)
        else
            v78 = v75
        end
        local v79 = UPDATE_COUNTDOWN_upv_1.at - v78
        local v80 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
        u5.Enabled = v80
        u12.Enabled = v80
        u22.Enabled = v80
        for key_2, value_5 in UPDATE_COUNTDOWN_upv_1.ranks do
            local v81 = UPDATE_COUNTDOWN_upv_1.at - value_5.hours * 3600
            local v82 = v81 <= v78
            local v83 = tbl_upv_3[key_2]
            if v83.out == nil or not (u42) then
                local v84 = tbl_upv_3[key_2]
                v84.out = v82
                if v82 then
                    v84.img.ImageColor3 = Colors_upv_1.White
                    v84.img.ImageTransparency = 0
                else
                    v84.img.ImageColor3 = u3
                    v84.img.ImageTransparency = 0.15
                end
                continue
            end
            if v82 then
                if v83.out or table.find(tbl_upv_19, key_2) or u38 == key_2 then
                    if v82 then
                        continue
                    end
                    if v83.out then
                        local v85 = tbl_upv_3[key_2]
                        v85.out = false
                        v85.img.ImageColor3 = u3
                        v85.img.ImageTransparency = 0.15
                    end
                else
                    if not (v78 - v81 < 4) then
                        local v86 = tbl_upv_3[key_2]
                        v86.out = true
                        v86.img.ImageColor3 = Colors_upv_1.White
                        v86.img.ImageTransparency = 0
                        continue
                    end
                    if os.clock() - u43 > 6 then
                        table.insert(tbl_upv_19, key_2)
                    else
                        local v86 = tbl_upv_3[key_2]
                        v86.out = true
                        v86.img.ImageColor3 = Colors_upv_1.White
                        v86.img.ImageTransparency = 0
                    end
                end
            else
                if v82 then
                    continue
                end
                if v83.out then
                    local v85 = tbl_upv_3[key_2]
                    v85.out = false
                    v85.img.ImageColor3 = u3
                    v85.img.ImageTransparency = 0.15
                end
            end
        end
        u42 = true
        if not (u37) and #tbl_upv_19 > 0 then
            local v87 = table.remove(tbl_upv_19, 1)
            if v80 then
                reveal(v87)
            else
                local v88 = tbl_upv_3[v87]
                v88.out = true
                v88.img.ImageColor3 = Colors_upv_1.White
                v88.img.ImageTransparency = 0
            end
        end
        local v89 = 0
        local v90 = 0
        if (v79 > 0) and (v79 <= u1) then
            if u2 < v79 then
                local _ = (u1 - v79) / (u1 - u2)
                v89 = 0.6 * ((u1 - v79) / (u1 - u2)) * ((u1 - v79) / (u1 - u2)) * (3 - 2 * ((u1 - v79) / (u1 - u2)))
            else
                v89 = 0.6 + 0.4 * (1 - (math.max(0, v79 - 60) / (u2 - 60)))
            end
            v90 = ((v79 <= 60) and (1 - v79 / 60)) or 0
        elseif v79 <= 0 then
            local v91 = ((Workspace_upv_1:GetAttribute("CountdownPreviewShipped") == true) and true) or ((UPDATE_COUNTDOWN_upv_1.shipped ~= nil) and (ReplicatedStorage_upv_1.Shared:FindFirstChild(UPDATE_COUNTDOWN_upv_1.shipped) ~= nil))
            if not v91 then
                v89, v90 = 1, 1
            end
        end
        local v92 = ((os.clock() - u43 < 0.4) and 1) or (math.min(1, a1 * 0.6))
        tbl_upv_10.w = tbl_upv_10.w + ((v89 - tbl_upv_10.w) * v92)
        tbl_upv_10.d = tbl_upv_10.d + ((v90 - tbl_upv_10.d) * v92)
        paintSky(tbl_upv_10.w, tbl_upv_10.d)
        local v93 = nil
        if v79 > 0 then
            local v94 = math.ceil(v79)
            v90 = ((v79 <= 60) and "final") or (((v79 <= u2) and "close") or "far")
            for _, value_6 in tbl_upv_3 do
                value_6.cell.Visible = true
            end
            v89 = v90 ~= "far"
            local label_1 = u8.label
            local v95
            if v89 then
                v95 = Gold_upv_1
            else
                v95 = Colors_upv_1.White
            end
            label_1.TextColor3 = v95
            local label_2 = u9.label
            local v96
            if v89 then
                v96 = Gold_upv_1
            else
                v96 = Colors_upv_1.White
            end
            label_2.TextColor3 = v96
            local v97, v98, v99 = nil, nil, nil
            if v90 ~= "final" then
                v97 = u36
                if tbl_upv_11[u10] ~= v97 then
                    tbl_upv_11[u10] = v97
                    u10.label.Text = v97
                    u10.shadow.Text = v97
                end
                u10.label.TextColor3 = Colors_upv_1.White
                u8.holder.Visible = true
                u9.holder.Visible = true
                u13.holder.Visible = false
                v98 = clock_4(v94)
                if tbl_upv_11[u9] ~= v98 then
                    tbl_upv_11[u9] = v98
                    u9.label.Text = v98
                    u9.shadow.Text = v98
                end
            else
                v99 = string.upper(UPDATE_COUNTDOWN_upv_1.title) .. " IN"
                if tbl_upv_11[u10] ~= v99 then
                    tbl_upv_11[u10] = v99
                    u10.label.Text = v99
                    u10.shadow.Text = v99
                end
                u10.label.TextColor3 = Gold_upv_1
                u8.holder.Visible = false
                u9.holder.Visible = false
                u13.holder.Visible = not u37
                local label_3 = u13.label
                local v100
                if v94 <= 10 then
                    v100 = Colors_upv_1.White
                else
                    v100 = Gold_upv_1
                end
                label_3.TextColor3 = v100
                local v101 = nil
                if v94 ~= u40 then
                    v101 = tostring(v94)
                    if tbl_upv_11[u13] ~= v101 then
                        tbl_upv_11[u13] = v101
                        u13.label.Text = v101
                        u13.shadow.Text = v101
                    end
                    u13.scale.Scale = ((v94 <= 10) and 1.2) or 1.12
                    local tbl_20 = {Scale = 1}
                    TweenService_upv_1:Create(u13.scale, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), tbl_20):Play()
                    if v80 then
                        local v102 = ((v94 <= 3) and "Match/Countdown_1") or "Match/Countdown_Tick"
                        if Sfx_upv_1 then
                            pcall(Sfx_upv_1.PlayUI, v102)
                        end
                    end
                end
            end
            u40 = v94
            u41 = v90
        else
            if u41 == "final" or u41 == "close" then
                u44 = os.clock()
                if v80 then
                    if Sfx_upv_1 then
                        pcall(Sfx_upv_1.PlayUI, "Match/Victory")
                    end
                    volley(16, 7, nil, 1.5)
                    task.delay(
                        7.5,
                        function()
                            --[[
                              line: 863
                              upvalues:
                                volley (copy, index: 1)
                            ]]
                            volley(10, 3, nil, 1.8)
                        end
                    )
                end
            end
            if u41 ~= "done" then
                u13.scale.Scale = 0.4
                local tbl_21 = {Scale = 1}
                TweenService_upv_1:Create(u13.scale, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), tbl_21):Play()
            end
            u41 = "done"
            for _, value_7 in tbl_upv_3 do
                value_7.cell.Visible = false
            end
            u8.holder.Visible = false
            u9.holder.Visible = false
            u10.holder.Visible = true
            u13.holder.Visible = true
            u10.label.TextColor3 = Gold_upv_1
            v93 = string.upper(UPDATE_COUNTDOWN_upv_1.title)
            if tbl_upv_11[u10] ~= v93 then
                tbl_upv_11[u10] = v93
                u10.label.Text = v93
                u10.shadow.Text = v93
            end
            local v103 = ((Workspace_upv_1:GetAttribute("CountdownPreviewShipped") == true) and true) or ((UPDATE_COUNTDOWN_upv_1.shipped ~= nil) and (ReplicatedStorage_upv_1.Shared:FindFirstChild(UPDATE_COUNTDOWN_upv_1.shipped) ~= nil))
            if v103 then
                if UPDATE_COUNTDOWN_upv_1.OUT_FOR < -v79 then
                    return false
                end
                if tbl_upv_11[u13] ~= "OUT NOW!" then
                    tbl_upv_11[u13] = "OUT NOW!"
                    u13.label.Text = "OUT NOW!"
                    u13.shadow.Text = "OUT NOW!"
                end
                u13.label.TextColor3 = Gold_upv_1
                if v80 then
                    local v104 = os.clock()
                    if u45 <= v104 and -v79 < 7200 then
                        u45 = os.clock() + u29:NextNumber(25, 40)
                        if u44 == nil or os.clock() - u44 > 15 then
                            volley(5, 2.5, nil, 1.1)
                        end
                    end
                end
            else
                if tbl_upv_11[u13] ~= "SERVERS RESTARTING..." then
                    tbl_upv_11[u13] = "SERVERS RESTARTING..."
                    u13.label.Text = "SERVERS RESTARTING..."
                    u13.shadow.Text = "SERVERS RESTARTING..."
                end
                u13.label.TextColor3 = Colors_upv_1.White
            end
        end
        return true
    end
    local u46 = nil
    local u47 = 0
    local v105 = RunService_1.Heartbeat:Connect(
        function(a1)
            --[[
              line: 904
              upvalues:
                u47 (ref,  index: 1)
                step (copy, index: 2)
                u46 (ref,  index: 3)
                LocalPlayer_upv_1 (copy, index: 4)
                LightingController_upv_1 (ref,  index: 5)
                u34 (copy, index: 6)
                u35 (ref,  index: 7)
                Lighting_upv_1 (copy, index: 8)
                tbl_upv_7 (copy, index: 9)
                u5 (copy, index: 10)
                u12 (copy, index: 11)
                u22 (copy, index: 12)
                u4 (copy, index: 13)
                u11 (copy, index: 14)
                u28 (copy, index: 15)
            ]]
            u47 = u47 + a1
            if u47 < 0.05 then
                return
            end
            local success_5, v106 = pcall(step, u47)
            u47 = 0
            if success_5 and v106 == false then
                if u46 then
                    u46:Disconnect()
                end
                local v107 = LocalPlayer_upv_1:GetAttribute("State") ~= "Match"
                if v107 then
                    if LightingController_upv_1 then
                        local success_6, v108 = pcall(LightingController_upv_1.Current)
                        v107 = success_6 and (v108 == "Lobby")
                    else
                        v107 = true
                    end
                    if v107 then
                        if u35 then
                            Lighting_upv_1.ClockTime = tbl_upv_7.clock
                            Lighting_upv_1.ColorShift_Top = tbl_upv_7.shiftTop
                            Lighting_upv_1.Brightness = tbl_upv_7.brightness
                            Lighting_upv_1.OutdoorAmbient = tbl_upv_7.outdoor
                            v107 = Lighting_upv_1:FindFirstChildOfClass("Atmosphere")
                            if v107 then
                                v107.Color = tbl_upv_7.atmColor
                                v107.Decay = tbl_upv_7.atmDecay
                                v107.Haze = tbl_upv_7.atmHaze
                                v107.Density = tbl_upv_7.atmDensity
                                v107.Glare = tbl_upv_7.atmGlare
                            end
                            v107 = Lighting_upv_1:FindFirstChildOfClass("SunRaysEffect")
                            if v107 then
                                v107.Intensity = tbl_upv_7.rays
                            end
                            u35 = false
                        end
                        u34.Enabled = false
                    else
                        u34.Enabled = false
                        u35 = false
                    end
                else
                    u34.Enabled = false
                    u35 = false
                end
                u5:Destroy()
                u12:Destroy()
                u22:Destroy()
                u4:Destroy()
                u11:Destroy()
                u28:Destroy()
                u34:Destroy()
                return
            end
            if (success_5) then
                return
            end
            warn("[UpdateCountdown] " .. tostring(v106))
        end
    )
    u46 = v105
end