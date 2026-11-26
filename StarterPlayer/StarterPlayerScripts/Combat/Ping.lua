local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local shared = replicatedStorage:WaitForChild("Shared")
local Net = require(shared:WaitForChild("Net"))
local Keybinds = require(shared:WaitForChild("Keybinds"))
local Combat = require(shared:WaitForChild("Combat"))
local Sfx = require(shared:WaitForChild("Sfx"))
local Util = require(script.Parent:WaitForChild("Util"))
local v13 = {}
local localPlayer = players.LocalPlayer
local color3 = Color3.fromRGB(40, 150, 255)
local color32 = Color3.fromRGB(235, 70, 60)
local color33 = Color3.fromRGB(18, 20, 26)
local color34 = Color3.fromRGB(255, 255, 255)
local fontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local v20 = {Spectate = true, FreeCursor = true, UI = true}
local v21 = nil
local v22 = {}
local timestamp = -math.huge
local screenGui = nil
local parent = nil
local textButton = nil
local frame = nil

local function matchId()
    --[[
      name: matchId
      line: 69
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local matchId = localPlayer:GetAttribute("MatchId")

    if type(matchId) ~= "string" then
        return ""
    end

    return matchId
end

local function sideOf(a31)
    --[[
      name: sideOf
      line: 76
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    local matchId
    local matchId2 = localPlayer:GetAttribute("MatchId")

    if type(matchId2) ~= "string" then
        matchId = ""
    else
        matchId = matchId2
    end

    local team = localPlayer:GetAttribute("Team")

    if matchId == "" or a31:GetAttribute("MatchId") ~= matchId or team == nil then
        return nil
    end
    if a31:GetAttribute("Team") == team then
        return "ally"
    end

    return "enemy"
end

local function hasHumanTeammate()
    --[[
      name: hasHumanTeammate
      line: 84
      upvalues:
        localPlayer (copy, index: 1)
        runService (copy, index: 2)
        screenGui (ref,  index: 3)
        players (copy, index: 4)
    ]]
    local matchId
    local matchId2 = localPlayer:GetAttribute("MatchId")

    if type(matchId2) ~= "string" then
        matchId = ""
    else
        matchId = matchId2
    end

    local team = localPlayer:GetAttribute("Team")

    if matchId == "" then
        return false
    end

    if runService:IsStudio() and screenGui then
        if screenGui:GetAttribute("ForceVisible") == true then
            return true
        end
    end

    for _, player in players:GetPlayers() do
        if player ~= localPlayer and player:GetAttribute("MatchId") == matchId and player:GetAttribute("Team") == team then
            return true
        end
    end

    return false
end

local function isDead()
    --[[
      name: isDead
      line: 102
      upvalues:
        localPlayer (copy, index: 1)
    ]]
    if localPlayer:GetAttribute("Alive") == false then
        return true
    end

    local instance = localPlayer.Character
    instance = instance and instance:FindFirstChildOfClass("Humanoid")

    return not instance or (instance.Health <= 0)
end

local function blocked(a44: boolean?)
    --[[
      name: blocked
      line: 113
      upvalues:
        localPlayer (copy, index: 1)
        Util (copy, index: 2)
        guiService (copy, index: 3)
        v20 (copy, index: 4)
    ]]
    if localPlayer:GetAttribute("MenuOpen") == true then
        return true
    end
    if not a44 then
        return Util.IsMouseUnlocked()
    end
    if guiService.MenuIsOpen then
        return true
    end

    local v45 = Util.Camera()

    if v45 and type(v45.GetUnlockReasons) == "function" then
        local success, result = pcall(v45.GetUnlockReasons)

        if success and type(result) == "table" then
            for _, v49 in result do
                if not v20[v49] then
                    return true
                end
            end
        end
    end

    return false
end

local function headshot(a51: number)
    --[[
      name: headshot
      line: 137
    ]]
    if 0 < a51 then
        return (string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48", a51))
    end

    return ""
end

local function screenScale()
    --[[
      name: screenScale
      line: 142
    ]]
    local vector2 = if const camera = workspace.CurrentCamera then camera.ViewportSize else Vector2.new(1600, 900)
    return (math.clamp(math.min(vector2.X / 1600, vector2.Y / 900), 0.8, 1.2))
end

local function remove(key)
    --[[
      name: remove
      line: 148
      upvalues:
        v22 (copy, index: 1)
    ]]
    if const v57 = v22[key] then
        v22[key] = nil
        v57.frame:Destroy()
    end
end

local function stroke(parent: Instance?, thickness: number)
    --[[
      name: stroke
      line: 156
      upvalues:
        color33 (copy, index: 1)
    ]]
    local uiStroke = Instance.new("UIStroke")
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Thickness = thickness
    uiStroke.Color = color33
    uiStroke.Transparency = 0.35
    uiStroke.Parent = parent
    return uiStroke
end

local function show(a63: number, position, a65)
    --[[
      name: show
      line: 168
      upvalues:
        v22 (copy, index: 1)
        color32 (copy, index: 2)
        color3 (copy, index: 3)
        fontFace (copy, index: 4)
        color34 (copy, index: 5)
        color33 (copy, index: 6)
        parent (ref,  index: 7)
        tweenService (copy, index: 8)
        Sfx (copy, index: 9)
    ]]
    local v66

    if const v67 = v22[a63] then
        v22[a63] = nil
        v67.frame:Destroy()
    end

    local startValue = if a65 == "enemy" then color32 else color3
    local mark = Instance.new("Frame")
    mark.Name = "Mark"
    mark.AnchorPoint = Vector2.new(0.5, 0.9642857142857143)
    mark.Size = UDim2.fromOffset(60, 56)
    mark.BackgroundTransparency = 1
    mark.Visible = false

    local instance = Instance.new("UIScale")
    instance.Parent = mark

    local pointer = Instance.new("Frame")
    pointer.Name = "Pointer"
    pointer.AnchorPoint = Vector2.new(0.5, 0.5)
    pointer.Position = UDim2.new(0.5, 0, 0, 47)
    pointer.Size = UDim2.fromOffset(10, 10)
    pointer.Rotation = 45
    pointer.BackgroundColor3 = startValue
    pointer.BorderSizePixel = 0
    pointer.ZIndex = 1
    pointer.Parent = mark

    local ring = Instance.new("Frame")
    ring.Name = "Ring"
    ring.AnchorPoint = Vector2.new(0.5, 0)
    ring.Position = UDim2.new(0.5, 0, 0, 16)
    ring.Size = UDim2.fromOffset(32, 32)
    ring.BackgroundColor3 = startValue
    ring.BorderSizePixel = 0
    ring.ZIndex = 2
    ring.Parent = mark

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = ring

    local head = Instance.new("ImageLabel")
    head.Name = "Head"
    head.AnchorPoint = Vector2.new(0.5, 0.5)
    head.Position = UDim2.fromScale(0.5, 0.5)
    head.Size = UDim2.fromOffset(26, 26)
    head.BackgroundColor3 = startValue:Lerp(Color3.new(0, 0, 0), 0.55)
    head.BorderSizePixel = 0
    head.ScaleType = Enum.ScaleType.Crop

    if not (0 < a63) then
        v66 = ""
        v66 = fontFace
    else
        v66 = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48", a63)
        v66 = fontFace
    end

    head.Image = v66
    head.ZIndex = 3
    head.Parent = ring
    local uiCorner2 = Instance.new("UICorner")
    uiCorner2.CornerRadius = UDim.new(1, 0)
    uiCorner2.Parent = head

    local distance = Instance.new("TextLabel")
    distance.Name = "Distance"
    distance.BackgroundTransparency = 1
    distance.AnchorPoint = Vector2.new(0.5, 1)
    distance.Position = UDim2.new(0.5, 0, 0, 15)
    distance.Size = UDim2.new(1, 0, 0, 16)
    distance.TextYAlignment = Enum.TextYAlignment.Bottom
    distance.FontFace = v66
    distance.TextSize = 14
    distance.TextColor3 = color34
    distance.TextStrokeColor3 = color33
    distance.TextStrokeTransparency = 0.3
    distance.Text = ""
    distance.AutoLocalize = false
    distance.Parent = mark
    mark.Parent = parent
    local vector2 = if const camera = workspace.CurrentCamera then camera.ViewportSize else Vector2.new(1600, 900)
    local scale = math.clamp(math.min(vector2.X / 1600, vector2.Y / 900), 0.8, 1.2)
    instance.Scale = scale * 0.5
    local propertyTable = {Scale = scale}
    tweenService:Create(instance, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), propertyTable):Play()
    local v81 = {position = position, frame = mark, scale = instance, ring = ring, pointer = pointer, head = head}
    local uiStroke = Instance.new("UIStroke")
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Thickness = 1.5
    uiStroke.Color = color33
    uiStroke.Transparency = 0.35
    uiStroke.Parent = ring

    local uiStroke2 = Instance.new("UIStroke")
    uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke2.Thickness = 1.5
    uiStroke2.Color = color33
    uiStroke2.Transparency = 0.35
    uiStroke2.Parent = pointer
    v81.strokes = {uiStroke, uiStroke2}
    v81.label = distance
    v81.born = os.clock()
    v22[a63] = v81
    Sfx.PlayUI("Click")
end

local function toMarks(a85, a86)
    --[[
      name: toMarks
      line: 245
      upvalues:
        parent (ref, index: 1)
    ]]
    local v87 = a85:WorldToScreenPoint(a86)
    local vector2 = if parent then parent.AbsolutePosition else Vector2.zero

    return v87.X - vector2.X, v87.Y - vector2.Y, v87.Z
end

local function place(a90, camera: Camera?)
    --[[
      name: place
      line: 252
      upvalues:
        parent (ref, index: 1)
    ]]
    local vector2 = if parent then parent.AbsoluteSize else camera.ViewportSize
    local v93 = camera:WorldToScreenPoint(a90.position)
    local vector22 = if parent then parent.AbsolutePosition else Vector2.zero
    local v95 = v93.X - vector22.X
    local v96 = v93.Y - vector22.Y

    if v93.Z <= 0 then
        v95 = vector2.X - v95
        v96 = vector2.Y
    end

    local maxValue = math.max(44, vector2.X - 44)
    local maxValue2 = math.max(98, vector2.Y - 44)
    a90.frame.Position = UDim2.fromOffset(math.floor(math.clamp(v95, 44, maxValue) + 0.5), (math.floor(math.clamp(v96, 98, maxValue2) + 0.5)))
    a90.frame.Visible = true
    a90.label.Text = tostring((math.floor((camera.CFrame.Position - a90.position).Magnitude + 0.5)))
end

local function spectateAim()
    --[[
      name: spectateAim
      line: 274
      upvalues:
        userInputService (copy, index: 1)
        Util (copy, index: 2)
        localPlayer (copy, index: 3)
    ]]
    local v100
    local camera = workspace.CurrentCamera
    if not camera then
        return nil, nil
    end

    if userInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter
        and userInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse
    then
        local mouseLocation = userInputService:GetMouseLocation()
        v100 = camera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y)
    else
        v100 = Util.GetAimRay()
    end

    local v103 = {}

    for _, v105 in Util.Targets() do
        local matchId = localPlayer:GetAttribute("MatchId")

        if type(matchId) ~= "string" then
            matchId = ""
        end

        local team = localPlayer:GetAttribute("Team")
        local v108 = if matchId == "" then nil else if v105:GetAttribute("MatchId") ~= matchId then nil else team ~= nil
            and (v105:GetAttribute("Team") ~= team and "enemy" or "ally")
            or nil

        if v108 == "ally" then
            table.insert(v103, v105)
        end
    end

    local raycastResult = workspace:Raycast(v100.Origin, v100.Direction.Unit * 600, Util.WorldParams(v103))
    if not raycastResult then
        return nil, nil
    end

    return raycastResult.Position, raycastResult
end

local function ping()
    --[[
      name: ping
      line: 301
      upvalues:
        localPlayer (copy, index: 1)
        timestamp (ref,  index: 2)
        blocked (copy, index: 3)
        spectateAim (copy, index: 4)
        Util (copy, index: 5)
        Combat (copy, index: 6)
        show (copy, index: 7)
        v21 (ref,  index: 8)
    ]]
    local v111
    local matchId
    local timestamp2 = os.clock()

    if localPlayer:GetAttribute("Alive") ~= false then
        local instance = localPlayer.Character
        instance = instance and instance:FindFirstChildOfClass("Humanoid")
        v111 = not instance or instance.Health <= 0
    else
        v111 = true
    end

    local matchId2 = localPlayer:GetAttribute("MatchId")

    if type(matchId2) ~= "string" then
        matchId = ""
    else
        matchId = matchId2
    end

    if matchId == "" or timestamp2 - timestamp < 0.6 or blocked(v111) then
        return
    end

    local v116, v117

    if v111 then
        v116, v117 = spectateAim()
    else
        v116, v117 = Util.AimPoint(600)
    end

    if not v116 then
        return
    end

    local character = nil

    if v117 then
        local character2 = Combat.FindCharacter(v117.Instance)

        if character2 and character2 ~= localPlayer.Character then
            local matchId3
            local matchId4 = localPlayer:GetAttribute("MatchId")

            if type(matchId4) ~= "string" then
                matchId3 = ""
            else
                matchId3 = matchId4
            end

            local team = localPlayer:GetAttribute("Team")
            local v123 = if matchId3 == "" then nil else if character2:GetAttribute("MatchId") ~= matchId3 then nil else team ~= nil
                and (character2:GetAttribute("Team") ~= team and "enemy" or "ally")
                or nil

            if v123 == "enemy" then
                character = character2
            end
        end
    end

    timestamp = timestamp2
    local userId = localPlayer.UserId
    local v125 = character and "enemy" or "spot"
    show(userId, v116, v125)
    local camera = workspace.CurrentCamera

    if v21 and camera then
        v21:FireServer(v116, character, camera.CFrame.Position)
    end
end

local function refreshButton()
    --[[
      name: refreshButton
      line: 332
      upvalues:
        localPlayer (copy, index: 1)
        hasHumanTeammate (copy, index: 2)
        blocked (copy, index: 3)
        textButton (ref,  index: 4)
        userInputService (copy, index: 5)
        frame (ref,  index: 6)
        parent (ref,  index: 7)
    ]]
    local v128

    if localPlayer:GetAttribute("Alive") ~= false then
        local instance = localPlayer.Character
        instance = instance and instance:FindFirstChildOfClass("Humanoid")
        v128 = not instance or instance.Health <= 0
    else
        v128 = true
    end

    local v130 = hasHumanTeammate() and not blocked(v128)

    if const textButton2 = textButton then
        textButton2.Visible = v130 and (userInputService.PreferredInput == Enum.PreferredInput.Touch)
    end

    local frame2 = frame
    local camera = workspace.CurrentCamera

    if frame2 and camera then
        frame2.Visible = v130
            and v128
            and localPlayer:GetAttribute("SpectateMode") == "follow"
            and userInputService.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse
        local v134 = camera:WorldToScreenPoint(camera.CFrame.Position + (camera.CFrame.LookVector * 10))
        local vector2 = if parent then parent.AbsolutePosition else Vector2.zero
        local v136 = v134.X - vector2.X
        local v137 = v134.Y - vector2.Y
        local _ = v134.Z
        frame2.Position = UDim2.fromOffset(math.floor(v136 + 0.5), (math.floor(v137 + 0.5)))
    end
end

local function buildButton()
    --[[
      name: buildButton
      line: 350
      upvalues:
        color33 (copy, index: 1)
        color34 (copy, index: 2)
        fontFace (copy, index: 3)
        ping (copy, index: 4)
        localPlayer (copy, index: 5)
        screenGui (ref,  index: 6)
        textButton (ref,  index: 7)
        parent (ref,  index: 8)
        frame (ref,  index: 9)
    ]]
    local tribesPing = Instance.new("ScreenGui")
    tribesPing.Name = "TribesPing"
    tribesPing.ResetOnSpawn = false
    tribesPing.IgnoreGuiInset = true
    tribesPing.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    tribesPing.DisplayOrder = 5

    local ping2 = Instance.new("TextButton")
    ping2.Name = "Ping"
    ping2.AnchorPoint = Vector2.new(1, 0.5)
    ping2.Position = UDim2.new(1, -22, 0.3, 0)
    ping2.Size = UDim2.fromOffset(48, 48)
    ping2.BackgroundColor3 = color33
    ping2.BackgroundTransparency = 0.3
    ping2.AutoButtonColor = false
    ping2.Text = "PING"
    ping2.TextColor3 = color34
    ping2.TextSize = 12
    ping2.FontFace = fontFace
    ping2.Visible = false

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = ping2

    local uiStroke = Instance.new("UIStroke")
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Thickness = 2
    uiStroke.Color = color34
    uiStroke.Transparency = 0.8
    uiStroke.Parent = ping2

    ping2.InputBegan:Connect(
        function(input: InputObject)
            --[[
              line: 379
              upvalues:
                ping (copy, index: 1)
            ]]
            if input.UserInputType == Enum.UserInputType.Touch
                or input.UserInputType == Enum.UserInputType.MouseButton1
            then
                ping()
            end
        end
    )

    ping2.Parent = tribesPing
    tribesPing.Parent = localPlayer:WaitForChild("PlayerGui")
    screenGui = tribesPing
    textButton = ping2
    local tribesPingMarks = Instance.new("ScreenGui")
    tribesPingMarks.Name = "TribesPingMarks"
    tribesPingMarks.ResetOnSpawn = false
    tribesPingMarks.IgnoreGuiInset = true
    tribesPingMarks.ScreenInsets = Enum.ScreenInsets.None
    tribesPingMarks.DisplayOrder = 4
    tribesPingMarks.Parent = localPlayer:WaitForChild("PlayerGui")
    parent = tribesPingMarks
    local spectateAim = Instance.new("Frame")
    spectateAim.Name = "SpectateAim"
    spectateAim.AnchorPoint = Vector2.new(0.5, 0.5)
    spectateAim.Position = UDim2.fromScale(0.5, 0.5)
    spectateAim.Size = UDim2.fromOffset(6, 6)
    spectateAim.BackgroundColor3 = color34
    spectateAim.BackgroundTransparency = 0.25
    spectateAim.BorderSizePixel = 0
    spectateAim.Visible = false

    local uiCorner2 = Instance.new("UICorner")
    uiCorner2.CornerRadius = UDim.new(1, 0)
    uiCorner2.Parent = spectateAim

    local uiStroke2 = Instance.new("UIStroke")
    uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke2.Thickness = 1
    uiStroke2.Color = color33
    uiStroke2.Transparency = 0.35
    uiStroke2.Parent = spectateAim
    spectateAim.Parent = tribesPingMarks
    frame = spectateAim
end

function v13.Start()
    --[[
      name: Start
      line: 413
      upvalues:
        v21 (ref,  index: 1)
        Net (copy, index: 2)
        buildButton (copy, index: 3)
        localPlayer (copy, index: 4)
        show (copy, index: 5)
        Keybinds (copy, index: 6)
        ping (copy, index: 7)
        runService (copy, index: 8)
        refreshButton (copy, index: 9)
        v22 (copy, index: 10)
        place (copy, index: 11)
    ]]
    v21 = Net.Event("Ping")
    buildButton()

    v21.OnClientEvent:Connect(
        function(a149: number, position, a151)
            --[[
              line: 416
              upvalues:
                localPlayer (copy, index: 1)
                show (copy, index: 2)
            ]]
            if type(a149) == "number" and typeof(position) == "Vector3" then
                local matchId
                local matchId2 = localPlayer:GetAttribute("MatchId")

                if type(matchId2) ~= "string" then
                    matchId = ""
                else
                    matchId = matchId2
                end

                if matchId ~= "" then
                    local v154 = a151 ~= "enemy" and "spot" or "enemy"
                    show(a149, position, v154)
                end
            end
        end
    )

    Keybinds.OnInput(
        "Began",
        function(a155, a156)
            --[[
              line: 421
              upvalues:
                Keybinds (copy, index: 1)
                ping (copy, index: 2)
            ]]
            if a156 then
                return
            end

            if Keybinds.ActionOf(a155) == "Ping" or Keybinds.IsPad(a155, "Ping") and not Keybinds.PadBlocked() then
                ping()
            end
        end
    )

    local v157 = 0

    runService.RenderStepped:Connect(
        function()
            --[[
              line: 431
              upvalues:
                v157 (ref,  index: 1)
                refreshButton (copy, index: 2)
                localPlayer (copy, index: 3)
                v22 (copy, index: 4)
                place (copy, index: 5)
            ]]
            local timestamp = os.clock()

            if v157 <= timestamp then
                local matchId
                v157 = timestamp + 0.25
                refreshButton()
                local matchId2 = localPlayer:GetAttribute("MatchId")

                if type(matchId2) ~= "string" then
                    matchId = ""
                else
                    matchId = matchId2
                end

                if matchId == "" then
                    for v161 in v22 do
                        if const v162 = v22[v161] then
                            v22[v161] = nil
                            v162.frame:Destroy()
                        end
                    end
                end
            end

            local camera = workspace.CurrentCamera

            for v164, v165 in v22 do
                local v166 = timestamp - v165.born

                if not (6 <= v166) then
                    local clampedValue = math.clamp((v166 - 5) / 1, 0, 1)
                    v165.ring.BackgroundTransparency = clampedValue
                    v165.pointer.BackgroundTransparency = clampedValue
                    v165.head.BackgroundTransparency = clampedValue
                    v165.head.ImageTransparency = clampedValue

                    for _, stroke in v165.strokes do
                        stroke.Transparency = (clampedValue * 0.65) + 0.35
                    end

                    v165.label.TextTransparency = clampedValue
                    v165.label.TextStrokeTransparency = (clampedValue * 0.7) + 0.3

                    if camera then
                        place(v165, camera)
                    end
                elseif const v170 = v22[v164] then
                    v22[v164] = nil
                    v170.frame:Destroy()
                end
            end
        end
    )
end

return v13