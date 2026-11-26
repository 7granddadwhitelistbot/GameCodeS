local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local guiService = game:GetService("GuiService")
local userInputService = game:GetService("UserInputService")
local Keybinds = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Keybinds"))
local v7 = {}
local color3FromRGB = Color3.fromRGB
local v9 = {{id = "3v3", name = "3V3", kicker = "TEAM BATTLE", desc = "Team up with two allies. Last team standing takes the round.", play = "PLAY 3V3", key = "1", keyCode = Enum.KeyCode.One}, {id = "1v1", name = "1V1", kicker = "DUEL", desc = "Just you and one rival. No teammates, no excuses.", play = "PLAY 1V1", key = "2", keyCode = Enum.KeyCode.Two}}

function v7.Init(a10)
    --[[
      name: Init
      line: 52
      upvalues:
        players (copy, index: 1)
        replicatedStorage (copy, index: 2)
        color3FromRGB (copy, index: 3)
        guiService (copy, index: 4)
        v9 (copy, index: 5)
        Keybinds (copy, index: 6)
        userInputService (copy, index: 7)
        runService (copy, index: 8)
    ]]
    local ui = a10.UI
    local theme = a10.Theme
    local state = a10.State
    local colors = theme.Colors
    local fonts = theme.Fonts
    local menuManager = a10.MenuManager
    local udim2FromOffset = UDim2.fromOffset
    local localPlayer = players.LocalPlayer
    local SettingsStore = require(script.Parent.Parent:WaitForChild("SettingsStore"))
    local RankArt = require(script.Parent.Parent:WaitForChild("RankArt"))
    local Config = nil
    pcall(
        function()
            --[[
              line: 63
              upvalues:
                Config (ref,  index: 1)
                replicatedStorage (copy, index: 2)
            ]]
            Config = require(replicatedStorage.Shared:WaitForChild("Config"))
        end
    )

    local function modeConfig(modeKey)
        --[[
          name: modeConfig
          line: 66
          upvalues:
            Config (ref, index: 1)
        ]]
        local modes
        local mode

        if type(Config) ~= "table" then
            modes = nil
        else
            modes = Config.MODES
        end

        if type(modes) ~= "table" then
            mode = nil
        else
            mode = modes[modeKey]
        end

        if type(mode) ~= "table" then
            return nil
        end

        return mode
    end

    local function roundsToWin(modeKey)
        --[[
          name: roundsToWin
          line: 71
          upvalues:
            Config (ref,  index: 1)
            state (copy, index: 2)
        ]]
        local modes
        local mode
        local mode2

        if type(Config) ~= "table" then
            modes = nil
        else
            modes = Config.MODES
        end

        if type(modes) ~= "table" then
            mode = nil
        else
            mode = modes[modeKey]
        end

        if type(mode) ~= "table" then
            mode2 = nil
        else
            mode2 = mode
        end

        local v31 = tonumber((mode2 and mode2.roundsToWin)) or state.DEFAULT_ROUNDS_TO_WIN

        return (math.clamp(math.floor(v31), 1, 9))
    end

    local function ranked()
        --[[
          name: ranked
          line: 75
          upvalues:
            SettingsStore (copy, index: 1)
        ]]
        return 0.5 < SettingsStore.Get("mmRanked")
    end

    local function memBits()
        --[[
          name: memBits
          line: 81
          upvalues:
            SettingsStore (copy, index: 1)
        ]]
        return (math.floor((SettingsStore.Get("modeSel"))))
    end

    local function setBits(bits)
        --[[
          name: setBits
          line: 84
          upvalues:
            SettingsStore (copy, index: 1)
        ]]
        if bits ~= math.floor((SettingsStore.Get("modeSel"))) then
            SettingsStore.Set("modeSel", bits, true)
        end
    end

    local function lastMode()
        --[[
          name: lastMode
          line: 89
          upvalues:
            SettingsStore (copy, index: 1)
        ]]
        if bit32.btest(math.floor((SettingsStore.Get("modeSel"))), 1) then
            return "1v1"
        end

        return "3v3"
    end

    local function lockReason(a38)
        --[[
          name: lockReason
          line: 94
          upvalues:
            state (copy, index: 1)
            a10 (copy, index: 2)
        ]]
        if a38 ~= "1v1" then
            return nil
        end
        if state.Get("Duel") ~= true then
            return "PLAY 3 MATCHES FIRST"
        end

        local v39 = if a10.Party and a10.Party.Size then a10.Party.Size() else 1

        if 2 <= v39 then
            return "LEAVE YOUR PARTY TO PLAY 1V1"
        end

        return nil
    end

    local function geo()
        --[[
          name: geo
          line: 110
          upvalues:
            ui (copy, index: 1)
        ]]
        if ui.Compact then
            return {W = 470, H = 438, gap = 26, art = 232, pad = 10, cta = 62, headGap = 18, nameSize = 76, kickerSize = 16, descSize = 18, chipH = 32, chipText = 15, titleSize = 34, ctaText = 26, headH = ui.WindowCloseSize()}
        end

        return {W = 450, H = 520, gap = 32, art = 300, pad = 10, cta = 64, headGap = 18, nameSize = 92, kickerSize = 17, descSize = 18, chipH = 32, chipText = 15, titleSize = 40, ctaText = 26, headH = ui.WindowCloseSize()}
    end

    local ui2 = nil
    local ui3 = nil
    local ui4 = nil
    local scaleObj = nil
    local ui5 = nil
    local parent = nil
    local close2 = nil
    local ui6 = nil
    local ui7 = nil
    local v50 = nil
    local v51 = nil
    local selectionImageObject = nil
    local v53 = {}
    local focus = 1
    local v55 = false
    local open2 = false
    local timestamp = 0
    local v58 = false
    local buttonStyles = ui.ButtonStyles

    local function chip(parent, layoutOrder: number, a63, text: string, a65)
        --[[
          name: chip
          line: 187
          upvalues:
            ui (copy, index: 1)
            colors (copy, index: 2)
            theme (copy, index: 3)
            fonts (copy, index: 4)
        ]]
        local parent2 = ui.new("Frame", {Name = "Chip" .. layoutOrder, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, a65.chipH), BackgroundColor3 = colors.Inset, BackgroundTransparency = 0.25, LayoutOrder = layoutOrder, ui.Corner(theme.Radius.Pill), ui.Stroke(colors.Stroke, 1, 0.88), ui.Padding(0, 13, 0, 9), (ui.List(Enum.FillDirection.Horizontal, 7, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = parent})
        a63.LayoutOrder, a63.Parent = 1, parent2

        return parent2, (ui.new("TextLabel", {Name = "Text", LayoutOrder = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Text = text, FontFace = fonts.Heavy, TextSize = a65.chipText, TextColor3 = colors.TextDim, Parent = parent2}))
    end

    local function makeCard(def, index: number, parent)
        --[[
          name: makeCard
          line: 217
          upvalues:
            geo (copy, index: 1)
            ui (copy, index: 2)
            udim2FromOffset (copy, index: 3)
            selectionImageObject (ref,  index: 4)
            color3FromRGB (copy, index: 5)
            colors (copy, index: 6)
            fonts (copy, index: 7)
            theme (copy, index: 8)
            chip (copy, index: 9)
            buttonStyles (copy, index: 10)
        ]]
        local v71
        local v72 = geo()
        local v73 = def.id == "1v1"
        local ui2 = ui.new("TextButton", {Selectable = true, Name = "Mode_" .. def.id, Size = udim2FromOffset(v72.W, v72.H), SelectionImageObject = selectionImageObject, Parent = parent})
        local ui3 = ui.new("Frame", {Name = "Lift", Size = UDim2.fromScale(1, 1), Parent = ui2})
        local image = ui.Image
        local glow = ui.Assets.Icons.Glow
        local v78 = {Name = "Glow", ImageTransparency = 1, ZIndex = 0, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.56), Size = UDim2.fromScale(1.45, 1.3), ImageColor3 = if v73 then color3FromRGB(255, 120, 110) else colors.Accent}
        v78.ScaleType = Enum.ScaleType.Stretch
        v78.Parent = ui3
        local glow3 = image(glow, v78)
        ui.DropShadow(ui3, 20, 10, 0.55)
        local v80 = ui.Panel({Name = "Body", BackgroundTransparency = 0.03, StrokeTransparency = 0.86, ZIndex = 2, Size = UDim2.fromScale(1, 1), TopColor = colors.PanelHi, BottomColor = colors.Panel, Radius = UDim.new(0, 20), Parent = ui3})
        local ui4 = ui.new("Frame", {Name = "Art", Position = udim2FromOffset(v72.pad, v72.pad), Size = UDim2.new(1, v72.pad * -2, 0, v72.art), BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, (ui.Corner(14)), Parent = v80})
        local bg = ui.Gradient(ColorSequence.new(colors.Panel), nil, 90)
        bg.Parent = ui4
        local deco = {}

        if v73 then
            bg.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color3FromRGB(14, 52, 112)), ColorSequenceKeypoint.new(0.47, color3FromRGB(28, 92, 178)), ColorSequenceKeypoint.new(0.5, color3FromRGB(18, 22, 34)), ColorSequenceKeypoint.new(0.53, color3FromRGB(170, 36, 48)), ColorSequenceKeypoint.new(1, color3FromRGB(92, 16, 26))})
            bg.Rotation = 14
            table.insert(deco, ui.Image(ui.Assets.Icons.Glow, {Name = "GlowL", ImageTransparency = 0.6, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.25, 0.42), Size = UDim2.fromScale(0.75, 1.1), ScaleType = Enum.ScaleType.Stretch, ImageColor3 = color3FromRGB(90, 170, 255), Parent = ui4}))
            local image2 = ui.Image
            local glow2 = ui.Assets.Icons.Glow
            local v86 = {Name = "GlowR", ImageTransparency = 0.62, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.75, 0.42), Size = UDim2.fromScale(0.75, 1.1), ScaleType = Enum.ScaleType.Stretch, ImageColor3 = color3FromRGB(255, 96, 90), Parent = ui4}
            table.insert(deco, image2(glow2, v86))
            local image3 = ui.Image
            local flare = ui.Assets.Fx.Flare
            local v89 = {Name = "Streak", Rotation = 104, ImageTransparency = 0.45, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.new(0, 560, 0, 52), ImageColor3 = color3FromRGB(255, 214, 170), Parent = ui4}
            table.insert(deco, image3(flare, v89))
        else
            bg.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color3FromRGB(30, 104, 196)), ColorSequenceKeypoint.new(0.55, color3FromRGB(16, 58, 124)), ColorSequenceKeypoint.new(1, color3FromRGB(10, 30, 70))})
            bg.Rotation = 90
            table.insert(deco, ui.Image(ui.Assets.Icons.Glow, {Name = "GlowC", ImageTransparency = 0.55, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.38), Size = UDim2.fromScale(1.05, 1.15), ScaleType = Enum.ScaleType.Stretch, ImageColor3 = color3FromRGB(110, 190, 255), Parent = ui4}))

            for v90, v91 in {0.22, 0.5, 0.78} do
                local image4 = ui.Image
                local beam = ui.Assets.Fx.Beam
                local v94 = {Rotation = 180, Name = "Beam" .. v90, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(v91, 0)}
                local newUDim2 = UDim2.new
                local v96 = v90 ~= 2 and 120 or 150
                v94.Size = newUDim2(0, v96, 1, 0)
                v94.ScaleType = Enum.ScaleType.Stretch
                v94.ImageColor3 = color3FromRGB(160, 210, 255)
                v94.ImageTransparency = v90 ~= 2 and 0.8 or 0.72
                v94.Parent = ui4
                table.insert(deco, image4(beam, v94))
            end
        end

        for _, v98 in deco do
            if v98:IsA("ImageLabel") then
                v98:SetAttribute("Tint", v98.ImageColor3)
                v98:SetAttribute("BaseT", v98.ImageTransparency)
            end
        end

        local vpf = ui.new("ViewportFrame", {Name = "Scene", Size = UDim2.fromScale(1, 1), Ambient = color3FromRGB(140, 146, 160), LightColor = color3FromRGB(255, 246, 232), LightDirection = Vector3.new(-0.550000011920929, -0.699999988079071, 0.44999998807907104), ZIndex = 2, (ui.Corner(14)), Parent = ui4})
        local veil = ui.new("Frame", {Name = "Veil", Size = UDim2.fromScale(1, 1), BackgroundColor3 = color3FromRGB(16, 18, 24), BackgroundTransparency = 0.3, Visible = false, ZIndex = 3, (ui.Corner(14)), Parent = ui4})
        local scrim = ui.new("Frame", {Name = "Scrim", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.62), BackgroundColor3 = colors.Void, ZIndex = 3, (ui.Gradient(colors.Void, colors.Void, 90, NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.55, 0.55), NumberSequenceKeypoint.new(1, 0.12)}))), Parent = ui4})
        local ui5 = ui.new("TextLabel", {Name = "ModeName", ZIndex = 4, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 22, 1, 6), Size = UDim2.new(1, -44, 0, v72.nameSize), Text = def.name, FontFace = fonts.Display, TextSize = v72.nameSize, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, Parent = ui4})
        ui.TextStroke(colors.Void, 2, 0.55).Parent = ui5
        local newUi = ui.new
        local v104 = {Name = "Kicker", ZIndex = 4, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 25, 1, -v72.nameSize + 8), Size = UDim2.new(1, -50, 0, v72.kickerSize + 4), Text = def.kicker, FontFace = fonts.Heavy, TextSize = v72.kickerSize}

        if v73 then
            v71 = color3FromRGB(255, 178, 170)
            v71 = ui
        else
            v71 = color3FromRGB(150, 206, 255)
            v71 = ui
        end

        v104.TextColor3 = v71
        v104.TextXAlignment = Enum.TextXAlignment.Left
        v104.Parent = ui4
        local ui6 = newUi("TextLabel", v104)
        v71.TextStroke(colors.Void, 1.5, 0.5).Parent = ui6
        local newPill = v71.Pill("NEW", colors.Gold, {Name = "New", Height = 26, TextSize = 15, ZIndex = 5, TextColor = colors.TextDark, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12), Parent = ui4})
        newPill.Visible = false

        if not v73 then
            local parent2 = v71.new(
                "Frame",
                {Name = "Recommended", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12), Size = udim2FromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = colors.SuccessDark, BackgroundTransparency = 0.05, ZIndex = 5, v71.Corner(theme.Radius.Pill), v71.Stroke(colors.Success, 1, 0.35), v71.Padding(0, 11, 0, 8), (v71.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = ui4}
            )
            ui.Icon("check", 15, colors.Text, {LayoutOrder = 1, ZIndex = 5, Parent = parent2})
            ui.new("TextLabel", {Name = "Text", Text = "RECOMMENDED", TextSize = 14, LayoutOrder = 2, ZIndex = 5, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = parent2})
        end

        local v108 = v72.pad + v72.art + 16
        local desc = v71.new("TextLabel", {Name = "Desc", TextWrapped = true, Position = udim2FromOffset(24, v108), Size = UDim2.new(1, -48, 0, (v72.descSize * 2) + 6), Text = def.desc, FontFace = fonts.SemiBold, TextSize = v72.descSize, TextColor3 = colors.TextDim, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = v80})
        local chips = v71.new("Frame", {Name = "Chips", Position = udim2FromOffset(22, (v108 + (v72.descSize * 2)) + 16), Size = UDim2.new(1, -44, 0, v72.chipH), (v71.List(Enum.FillDirection.Horizontal, 8, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)), Parent = v80})
        local _, roundsText = chip(chips, 1, v71.Image(v71.Assets.Icons.CrossedArrows, {Size = udim2FromOffset(18, 17), ImageColor3 = colors.TextDim}), "", v72)
        local v113 = v71.new("Frame", {Name = "Play", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -v72.pad), Size = UDim2.new(1, v72.pad * -2, 0, v72.cta), Parent = v80})
        local ctaLip = v71.new("Frame", {Name = "Lip", Position = udim2FromOffset(0, 3), Size = UDim2.new(1, 0, 1, -3), BackgroundColor3 = buttonStyles.Dark.lip, (v71.Corner(14)), Parent = v113})
        local parent3 = v71.new("Frame", {Name = "Face", Size = UDim2.new(1, 0, 1, -3), BackgroundColor3 = Color3.new(1, 1, 1), (v71.Corner(14)), Parent = v113})
        local ctaGrad = v71.Gradient(buttonStyles.Dark.top, buttonStyles.Dark.bottom, 90)
        ctaGrad.Parent = parent3

        local ctaStroke = v71.Stroke(buttonStyles.Dark.stroke, 1, 0.6)
        ctaStroke.Parent = parent3
        local ctaGlow = v71.new("Frame", {Name = "Glow", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, ZIndex = 3, (v71.Corner(14)), Parent = parent3})
        local ctaLabel = v71.new("TextLabel", {Name = "Label", ZIndex = 2, Size = UDim2.fromScale(1, 1), Text = def.play, FontFace = fonts.Display, TextSize = v72.ctaText, TextColor3 = colors.Text, Parent = parent3})
        local ctaKey = v71.KeyCap(def.key, {Height = 28, TextSize = 17, Managed = true, ZIndex = 2, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Parent = parent3})
        local v121 = v71.new("Frame", {Name = "Pad", ZIndex = 2, Visible = false, Size = UDim2.fromScale(1, 1), Parent = parent3})
        ui.PadCap(Enum.KeyCode.ButtonA, {Height = 30, ZIndex = 2, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0), Parent = v121})
        local v122 = v71.new("Frame", {Name = "Locked", Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2, (v71.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = parent3})
        ui.Image(ui.Assets.Icons.Lock, {Name = "Lock", LayoutOrder = 1, ZIndex = 2, Size = udim2FromOffset(22, 22), ImageColor3 = colors.TextDim, Parent = v122})
        local lockText = v71.new("TextLabel", {Name = "Reason", Text = "", TextSize = 17, LayoutOrder = 2, ZIndex = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = fonts.Heavy, TextColor3 = colors.TextDim, Parent = v122})
        local parent4 = v71.new("Frame", {Name = "Ring", Size = UDim2.fromScale(1, 1), ZIndex = 3, (v71.Corner(20)), Parent = ui3})
        local ring = v71.Stroke(colors.Accent, 3, 1)
        ring.Parent = parent4

        local topPill = v71.Pill("LAST PLAYED", colors.Accent, {Name = "Last", Height = 26, TextSize = 14, ZIndex = 6, PadX = 12, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0), Parent = ui3})
        topPill.Visible = false

        return {
            def = def,
            index = index,
            btn = ui2,
            lift = ui3,
            body = v80,
            glow = glow3,
            ring = ring,
            art = ui4,
            bg = bg,
            deco = deco,
            vpf = vpf,
            veil = veil,
            scrim = scrim,
            kicker = ui6,
            name = ui5,
            desc = desc,
            chips = chips,
            roundsText = roundsText,
            cta = v113,
            ctaGrad = ctaGrad,
            ctaLip = ctaLip,
            ctaStroke = ctaStroke,
            ctaGlow = ctaGlow,
            ctaLabel = ctaLabel,
            ctaKey = ctaKey,
            ctaPad = v121,
            lockRow = v122,
            lockText = lockText,
            topPill = topPill,
            topPillText = topPill:FindFirstChild("Text"),
            newPill = newPill,
            scene = nil,
            foc = 0,
            up = 0,
            hover = false
        }
    end

    local v127 = {ForceField = true, Sound = true, BillboardGui = true, SurfaceGui = true, ProximityPrompt = true, Highlight = true, SelectionBox = true, ClickDetector = true, Fire = true, Smoke = true, Sparkles = true, BodyGyro = true, BodyPosition = true, BodyVelocity = true, AlignPosition = true, AlignOrientation = true, LinearVelocity = true, AngularVelocity = true, VectorForce = true}

    local function snapshotCharacter()
        --[[
          name: snapshotCharacter
          line: 526
          upvalues:
            localPlayer (copy, index: 1)
            v127 (copy, index: 2)
        ]]
        local character = localPlayer.Character

        if not character
            or not character.Parent
            or not character:FindFirstChildOfClass("Humanoid")
            or not character:FindFirstChild("HumanoidRootPart")
            or not character:FindFirstChild("Head")
        then
            return nil
        end

        local archivable = character.Archivable
        character.Archivable = true
        local success, fighter = pcall(
            function()
                --[[
                  line: 533
                  upvalues:
                    character (copy, index: 1)
                ]]
                return character:Clone()
            end
        )
        character.Archivable = archivable

        if not success or not fighter then
            return nil
        end

        for _, tag in fighter:GetTags() do
            fighter:RemoveTag(tag)
        end

        for v135 in fighter:GetAttributes() do
            fighter:SetAttribute(v135, nil)
        end

        for _, descendant in fighter:GetDescendants() do
            local v138

            if descendant:IsA("ParticleEmitter") then
                v138 = descendant:FindFirstAncestorOfClass("Accessory") == nil
            elseif descendant:IsA("Trail") then
                v138 = descendant:FindFirstAncestorOfClass("Accessory") == nil
            elseif descendant:IsA("Beam") then
                v138 = descendant:FindFirstAncestorOfClass("Accessory") == nil
            else
                v138 = descendant:IsA("Light")
                v138 = v138 and descendant:FindFirstAncestorOfClass("Accessory") == nil
            end

            if descendant:IsA("LuaSourceContainer") or descendant:IsA("Tool") or v127[descendant.ClassName] or v138 then
                descendant:Destroy()
            else
                for _, tag in descendant:GetTags() do
                    descendant:RemoveTag(tag)
                end

                if descendant:IsA("BasePart") then
                    descendant.CanCollide = false
                    descendant.CanQuery = false
                    descendant.CanTouch = false
                    descendant.CastShadow = false
                    descendant.LocalTransparencyModifier = 0
                elseif descendant:IsA("Decal") then
                    descendant.LocalTransparencyModifier = 0
                end
            end
        end

        for _, descendant in fighter:GetDescendants() do
            if descendant:IsA("AnimationConstraint") or descendant:IsA("RigidConstraint") then
                local descendant2
                local attachment0 = descendant.Attachment0
                local attachment1 = descendant.Attachment1
                local attachment02 = attachment0
                local _

                if attachment02 then
                    _ = attachment0.Parent
                end

                local attachment12 = attachment1
                local _

                if attachment12 then
                    _ = attachment1.Parent
                end

                if attachment0 then
                    if attachment1 then
                        if attachment02 then
                            if attachment12 then
                                if attachment02:IsA("BasePart") then
                                    if attachment12:IsA("BasePart") then
                                        local jointInstance = if descendant:IsA("AnimationConstraint") then Instance.new("Motor6D") else Instance.new("Weld")
                                        jointInstance.Name = descendant.Name
                                        jointInstance.Part0 = attachment02
                                        jointInstance.Part1 = attachment12
                                        jointInstance.C0, jointInstance.C1 = attachment0.CFrame, attachment1.CFrame
                                        jointInstance.Parent = attachment12
                                        descendant2 = descendant
                                    else
                                        descendant2 = descendant
                                    end
                                else
                                    descendant2 = descendant
                                end
                            else
                                descendant2 = descendant
                            end
                        else
                            descendant2 = descendant
                        end
                    else
                        descendant2 = descendant
                    end
                else
                    descendant2 = descendant
                end

                descendant2:Destroy()
            elseif descendant:IsA("BallSocketConstraint")
                or descendant:IsA("HingeConstraint")
                or descendant:IsA("NoCollisionConstraint")
            then
                descendant:Destroy()
            elseif descendant:IsA("Motor6D") then
                descendant.Transform = CFrame.identity
            end
        end

        local humanoid = fighter:FindFirstChildOfClass("Humanoid")
        pcall(
            function()
                --[[
                  line: 583
                  upvalues:
                    humanoid (copy, index: 1)
                ]]
                humanoid.EvaluateStateMachine = false
            end
        )
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        humanoid.BreakJointsOnDeath = false
        local v152 = fighter:FindFirstChild("HumanoidRootPart")
        v152.Anchored = true
        v152.Transparency = 1
        v152 = fighter:FindFirstChild("TribesHull")

        if v152 then
            v152:Destroy()
        end

        fighter.Name = "Fighter"

        return fighter
    end

    local function silhouette(parent, color)
        --[[
          name: silhouette
          line: 600
        ]]
        for _, descendant in parent:GetDescendants() do
            if descendant:IsA("Accessory")
                or descendant:IsA("Clothing")
                or descendant:IsA("ShirtGraphic")
                or descendant:IsA("Decal")
                or descendant:IsA("SurfaceAppearance")
                or descendant:IsA("BodyColors")
                or descendant:IsA("WrapLayer")
            then
                descendant:Destroy()
            end
        end

        for _, descendant in parent:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Color = color
                descendant.Material = Enum.Material.SmoothPlastic

                if descendant:IsA("MeshPart") then
                    pcall(
                        function()
                            --[[
                              line: 611
                              upvalues:
                                descendant (copy, index: 1)
                            ]]
                            descendant.TextureID = ""
                        end
                    )
                end
            elseif descendant:IsA("SpecialMesh") then
                descendant.TextureId = ""
            end
        end
    end

    local function weapon(parent, childName: string, color)
        --[[
          name: weapon
          line: 621
          upvalues:
            replicatedStorage (copy, index: 1)
        ]]
        local instance = replicatedStorage:FindFirstChild("Assets")
        instance = instance and instance:FindFirstChild("Weapons")
        local child = instance and instance:FindFirstChild(childName)
        local v166 = parent:FindFirstChild("RightHand") or parent:FindFirstChild("Right Arm")

        if not child or not v166 or not v166:IsA("BasePart") then
            return
        end

        local weapon = child:Clone()
        local handle = weapon:FindFirstChild("Handle")

        if not handle or not handle:IsA("BasePart") then
            weapon:Destroy()
            return
        end

        for _, descendant in weapon:GetDescendants() do
            if descendant:IsA("LuaSourceContainer")
                or descendant:IsA("Sound")
                or descendant:IsA("ParticleEmitter")
                or descendant:IsA("Light")
            then
                descendant:Destroy()
            elseif descendant:IsA("BasePart") then
                descendant.Anchored = false
                descendant.CanCollide = false
                descendant.CanQuery = false
                descendant.CanTouch = false
                descendant.Massless = true
                descendant.CastShadow = false

                if color then
                    descendant.Color = color
                    descendant.Material = Enum.Material.SmoothPlastic

                    if not descendant:IsA("MeshPart") then
                        continue
                    end

                    pcall(
                        function()
                            --[[
                              line: 644
                              upvalues:
                                descendant (copy, index: 1)
                            ]]
                            descendant.TextureID = ""
                        end
                    )
                end
            elseif color and descendant:IsA("SpecialMesh") then
                descendant.TextureId = ""
                descendant.VertexColor = Vector3.new(color.R, color.G, color.B)
            elseif color then
                if descendant:IsA("Decal") or descendant:IsA("Texture") or descendant:IsA("SurfaceAppearance") then
                    descendant:Destroy()
                end
            end
        end

        for _, descendant in weapon:GetDescendants() do
            if descendant:IsA("WeldConstraint") then
                local part0 = descendant.Part0
                local part1 = descendant.Part1

                if part0 and part1 then
                    local weld = Instance.new("Weld")
                    weld.Part0 = part0
                    weld.Part1 = part1
                    weld.C0 = part0.CFrame:ToObjectSpace(part1.CFrame)
                    weld.C1 = CFrame.identity
                    weld.Parent = part1
                end

                descendant:Destroy()
            end
        end

        local grip = Instance.new("Weld")
        grip.Name = "Grip"
        grip.Part0 = v166
        grip.Part1 = handle
        local rightGripAttachment = v166:FindFirstChild("RightGripAttachment")
        local rightGripAttachment2 = handle:FindFirstChild("RightGripAttachment")
        grip.C0 = if rightGripAttachment and rightGripAttachment:IsA("Attachment") then rightGripAttachment.CFrame else CFrame.new(0, -v166.Size.Y / 2, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
        grip.C1 = if rightGripAttachment2 and rightGripAttachment2:IsA("Attachment") then rightGripAttachment2.CFrame else CFrame.identity
        grip.Parent = handle
        weapon.Name = "Weapon"
        weapon.Parent = parent
    end

    local function hold(parent, childName: string, tracks)
        --[[
          name: hold
          line: 684
          upvalues:
            replicatedStorage (copy, index: 1)
        ]]
        local animations = replicatedStorage:FindFirstChild("Assets")
            and replicatedStorage.Assets:FindFirstChild("Animations")
        local child = animations and animations:FindFirstChild(childName)
        local humanoid = parent:FindFirstChildOfClass("Humanoid")

        if not child or not child:IsA("Animation") or not humanoid then
            return
        end

        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator")
        animator.Parent = humanoid

        pcall(
            function()
                --[[
                  line: 693
                  upvalues:
                    animator (copy, index: 1)
                    child (copy, index: 2)
                    tracks (copy, index: 3)
                ]]
                local v187 = animator:LoadAnimation(child)
                v187.Looped = true
                v187:Play(0)
                table.insert(tracks, v187)
            end
        )
    end

    local v188 = {
        ["3v3"] = {
            eye = Vector3.new(0.800000011920929, 3.0999999046325684, -15.5),
            target = Vector3.new(0, 3.75, 1.399999976158142),
            fov = 30,
            fighters = {{at = Vector3.new(3.9000000953674316, 3, 3.4000000953674316), yaw = -24, item = "spear", anim = "Hold_Spear", look = color3FromRGB(38, 86, 160)}, {at = Vector3.new(-3.9000000953674316, 3, 3.200000047683716), yaw = 28, item = "battle_axe", anim = "Hold_Heavy", look = color3FromRGB(38, 86, 160)}, {look = "you", at = Vector3.new(0, 3, 0), yaw = 12, item = "bronze_sword", anim = "Hold_Sword"}}
        },
        ["1v1"] = {eye = Vector3.new(0, 3.299999952316284, -15.600000381469727), target = Vector3.new(0, 3.799999952316284, 0.5), fov = 30, fighters = {{at = Vector3.new(-2.549999952316284, 3, 1), yaw = -32, item = "battle_axe", anim = "Hold_Heavy", look = color3FromRGB(84, 18, 28)}, {look = "you", at = Vector3.new(2.700000047683716, 3, 0), yaw = 40, item = "bronze_sword", anim = "Hold_Sword"}}}
    }
    local character = nil
    local hasAppearanceLoaded = false

    local function clearScene(a192)
        --[[
          name: clearScene
          line: 728
        ]]
        if const scene = a192.scene then
            for _, track in scene.tracks do
                pcall(
                    function()
                        --[[
                          line: 732
                          upvalues:
                            track (copy, index: 1)
                        ]]
                        track:Stop(0)
                    end
                )
            end

            scene.wm:Destroy()
            scene.cam:Destroy()
            a192.scene = nil
        end
    end

    local function buildScene(a197)
        --[[
          name: buildScene
          line: 741
          upvalues:
            clearScene (copy, index: 1)
            v188 (copy, index: 2)
            snapshotCharacter (copy, index: 3)
            silhouette (copy, index: 4)
            weapon (copy, index: 5)
            theme (copy, index: 6)
            hold (copy, index: 7)
        ]]
        clearScene(a197)
        local v198 = v188[a197.def.id]
        if not v198 then
            return false
        end

        local worldModel = Instance.new("WorldModel")
        worldModel.Parent = a197.vpf
        local tracks = {}
        local v201 = false

        for _, fighter in v198.fighters do
            if const parent = snapshotCharacter() then
                v201 = true

                if fighter.look ~= "you" then
                    silhouette(parent, fighter.look)
                end

                local item = fighter.item
                local color = if fighter.look ~= "you" then theme.Lighten(fighter.look, 0.12) else nil
                weapon(parent, item, color)
                parent:PivotTo(CFrame.new(fighter.at) * CFrame.Angles(0, math.rad(fighter.yaw), 0))
                parent.Parent = worldModel
                hold(parent, fighter.anim, tracks)
            end
        end

        local camera = Instance.new("Camera")
        camera.FieldOfView = v198.fov
        camera.CFrame = CFrame.lookAt(v198.eye, v198.target)
        camera.Parent = a197.vpf
        a197.vpf.CurrentCamera = camera
        a197.scene = {built = true, vpf = a197.vpf, wm = worldModel, cam = camera, target = v198.target, eye = v198.eye, phase = a197.index * 1.7, tracks = tracks}

        return v201
    end

    local function ensureScenes()
        --[[
          name: ensureScenes
          line: 773
          upvalues:
            localPlayer (copy, index: 1)
            character (ref,  index: 2)
            hasAppearanceLoaded (ref,  index: 3)
            v53 (copy, index: 4)
            buildScene (copy, index: 5)
        ]]
        local character2 = localPlayer.Character
        local hasAppearanceLoaded2 = localPlayer:HasAppearanceLoaded()

        if character2 == character and (hasAppearanceLoaded or not hasAppearanceLoaded2) and v53[1] and v53[1].scene then
            for _, v212 in v53 do
                if v212.scene then
                    for _, track in v212.scene.tracks do
                        if not track.IsPlaying then
                            track:Play(0)
                        end
                    end
                end
            end

            return
        end

        if not character2 then
            return
        end

        character = character2
        hasAppearanceLoaded = hasAppearanceLoaded2

        for _, v216 in v53 do
            buildScene(v216)
        end
    end

    localPlayer.CharacterAdded:Connect(
        function()
            --[[
              line: 797
              upvalues:
                character (ref, index: 1)
            ]]
            character = nil
        end
    )

    local function paintCta(a218, a219: boolean, visible: boolean)
        --[[
          name: paintCta
          line: 802
          upvalues:
            buttonStyles (copy, index: 1)
            ui (copy, index: 2)
        ]]
        local v221

        if visible then
            v221 = buttonStyles.Disabled
        else
            v221 = if a219 then buttonStyles.Primary else buttonStyles.Dark
        end

        a218.ctaGrad.Color = ColorSequence.new(v221.top, v221.bottom)
        a218.ctaLip.BackgroundColor3 = v221.lip
        a218.ctaStroke.Color = v221.stroke
        a218.ctaLabel.TextColor3 = v221.text
        a218.ctaLabel.Visible = not visible
        a218.ctaKey.Visible = not visible and not ui.Touch and not ui.Gamepad
        a218.ctaPad.Visible = a219 and not visible
        a218.lockRow.Visible = visible
    end

    local function paint()
        --[[
          name: paint
          line: 814
          upvalues:
            ui2 (ref,  index: 1)
            SettingsStore (copy, index: 2)
            v53 (copy, index: 3)
            state (copy, index: 4)
            a10 (copy, index: 5)
            focus (ref,  index: 6)
            Config (ref,  index: 7)
            paintCta (copy, index: 8)
            color3FromRGB (copy, index: 9)
            colors (copy, index: 10)
            ui6 (ref,  index: 11)
            ui7 (ref,  index: 12)
            v50 (ref,  index: 13)
            v51 (ref,  index: 14)
        ]]
        local v223

        if not ui2 then
            return
        end

        if bit32.btest(math.floor((SettingsStore.Get("modeSel"))), 1) then
            v223 = "1v1"
        else
            v223 = "3v3"
        end

        local v224 = bit32.btest(math.floor((SettingsStore.Get("modeSel"))), 4)

        for _, v226 in v53 do
            local v227
            local modes
            local mode
            local mode2
            local imageColor3
            local id = v226.def.id

            if id == "1v1" then
                if state.Get("Duel") == true then
                    local v233 = if a10.Party and a10.Party.Size then a10.Party.Size() else 1
                    v227 = 2 <= v233 and "LEAVE YOUR PARTY TO PLAY 1V1" or nil
                else
                    v227 = "PLAY 3 MATCHES FIRST"
                end
            else
                v227 = nil
            end

            local visible = v227 ~= nil
            local v235 = v226.index == focus
            local roundsText = v226.roundsText
            local stringFormat = string.format

            if type(Config) == "table" then
                modes = Config.MODES
            else
                modes = nil
            end

            if type(modes) == "table" then
                mode = modes[id]
            else
                mode = nil
            end

            if type(mode) == "table" then
                mode2 = mode
            else
                mode2 = nil
            end

            local v238 = tonumber((mode2 and mode2.roundsToWin)) or state.DEFAULT_ROUNDS_TO_WIN
            roundsText.Text = stringFormat("FIRST TO %d", (math.clamp(math.floor(v238), 1, 9)))
            v226.lockText.Text = v227 or ""
            paintCta(v226, v235, visible)
            local vpf = v226.vpf

            if visible then
                imageColor3 = color3FromRGB(150, 154, 164)
            else
                imageColor3 = Color3.new(1, 1, 1)
            end

            vpf.ImageColor3 = imageColor3
            v226.veil.Visible = visible

            for _, v241 in v226.deco do
                if v241:IsA("ImageLabel") then
                    local v242

                    if visible then
                        v242 = color3FromRGB(120, 124, 136)
                    else
                        v242 = v241:GetAttribute("Tint") or v241.ImageColor3
                    end

                    v241.ImageColor3 = v242
                end
            end

            v226.name.TextColor3 = if visible then colors.TextDim else colors.Text
            v226.topPill.Visible = id == v223 and not visible
            v226.newPill.Visible = id == "1v1" and not v224 and not visible
            v226.ring.Color = if visible then colors.TextMuted else colors.Accent
        end

        if ui6 and ui7 and v50 then
            local v243 = 0.5 < SettingsStore.Get("mmRanked")
            ui7.Text = v243 and "RANKED" or "UNRANKED"
            ui7.TextColor3 = if v243 then colors.Text else colors.TextDim
            v50:Set(v243)

            if v51 and v51:IsA("ImageLabel") then
                v51.ImageTransparency = v243 and 0 or 0.6
            end

            if const uiStroke = ui6:FindFirstChildOfClass("UIStroke") then
                uiStroke.Color = if v243 then colors.Accent else colors.Stroke
                uiStroke.Transparency = v243 and 0.55 or 0.86
            end
        end
    end

    local function setFocus(a246, a247: boolean?)
        --[[
          name: setFocus
          line: 857
          upvalues:
            v53 (copy, index: 1)
            focus (ref,  index: 2)
            ui (copy, index: 3)
            a10 (copy, index: 4)
            paint (copy, index: 5)
            open2 (ref,  index: 6)
            guiService (copy, index: 7)
        ]]
        local clampedValue = math.clamp(a246, 1, #v53)

        if clampedValue ~= focus then
            focus = clampedValue

            if not ui.Touch then
                a10.Sounds.Play("Hover")
            end

            paint()

            if ui.Gamepad
                and not a247
                and open2
                and v53[clampedValue]
                and guiService.SelectedObject ~= v53[clampedValue].btn
            then
                guiService.SelectedObject = v53[clampedValue].btn
            end
        end
    end

    local function layout()
        --[[
          name: layout
          line: 874
          upvalues:
            ui2 (ref,  index: 1)
            ui4 (ref,  index: 2)
            ui5 (ref,  index: 3)
            scaleObj (ref,  index: 4)
            geo (copy, index: 5)
            udim2FromOffset (copy, index: 6)
            ui (copy, index: 7)
            parent (ref,  index: 8)
            v53 (copy, index: 9)
        ]]
        if not ui2 or not ui4 or not ui5 or not scaleObj then
            return
        end

        local v250 = geo()
        local v251 = v250.W * 2 + v250.gap
        local v252 = v250.headH + v250.headGap + v250.H
        ui4.Size = udim2FromOffset(v251, v252)
        local v253 = ui.CanvasSize()
        local v254 = ui.TopInset()
        local scale = math.min(1, (v253.X - 32) / v251, ((v253.Y - v254) - 16) / (v252 + 14))
        scaleObj.Scale = scale
        local v256 = math.max(v253.Y / 2, (v254 + 8) + ((v252 * scale) / 2))
        ui4.Position = UDim2.new(0.5, 0, 0, (math.floor(v256)))
        ui5.Size = UDim2.new(1, 0, 0, v250.headH)

        if parent then
            parent.TextSize = v250.titleSize
        end

        for v257, v258 in v53 do
            v258.btn.Size = udim2FromOffset(v250.W, v250.H)
            v258.btn.Position = udim2FromOffset((v257 - 1) * (v250.W + v250.gap), v250.headH + v250.headGap)
        end
    end

    local function close()
        --[[
          name: close
          line: 899
          upvalues:
            menuManager (copy, index: 1)
        ]]
        menuManager.Close("Mode")
    end

    local function pick(a261)
        --[[
          name: pick
          line: 903
          upvalues:
            v53 (copy, index: 1)
            v58 (ref,  index: 2)
            open2 (ref,  index: 3)
            state (copy, index: 4)
            a10 (copy, index: 5)
            ui (copy, index: 6)
            setFocus (copy, index: 7)
            SettingsStore (copy, index: 8)
            udim2FromOffset (copy, index: 9)
            menuManager (copy, index: 10)
        ]]
        local v262 = v53[a261]

        if not v262 or v58 or not open2 then
            return
        end

        local v263
        local id = v262.def.id

        if id == "1v1" then
            if state.Get("Duel") == true then
                local v265 = if a10.Party and a10.Party.Size then a10.Party.Size() else 1
                v263 = 2 <= v265 and "LEAVE YOUR PARTY TO PLAY 1V1" or nil
            else
                v263 = "PLAY 3 MATCHES FIRST"
            end
        else
            v263 = nil
        end

        if v263 then
            a10.Sounds.Play("Error")
            ui.Shake(v262.lift, 7)
            ui.Bump(v262.lockRow, 0.08)

            return
        end

        if not a10.LobbyHud or not a10.LobbyHud.Queue then
            return
        end

        local v266
        v58 = true
        setFocus(a261)
        local flooredValue = math.floor((SettingsStore.Get("modeSel")))

        if id ~= "1v1" then
            v266 = bit32.band(flooredValue, 4294967294)
        else
            v266 = bit32.bor(flooredValue, 1, 4)
        end

        if v266 ~= math.floor((SettingsStore.Get("modeSel"))) then
            SettingsStore.Set("modeSel", v266, true)
        end

        local udim2 = UDim2.new()
        ui.Tween(v262.lift, TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = udim2 + udim2FromOffset(0, 5)})
        v262.ctaGlow.BackgroundTransparency = 0.55
        local v269 = {BackgroundTransparency = 1}
        ui.Tween(v262.ctaGlow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), v269)

        task.delay(
            0.11,
            function()
                --[[
                  line: 929
                  upvalues:
                    v58 (ref,  index: 1)
                    open2 (ref,  index: 2)
                    menuManager (copy, index: 3)
                    a10 (copy, index: 4)
                    id (copy, index: 5)
                ]]
                v58 = false

                if open2 then
                    menuManager.Close("Mode")
                end

                if a10.LobbyHud.CanPlay == nil or a10.LobbyHud.CanPlay() then
                    a10.LobbyHud.Queue(id)
                end
            end
        )
    end

    local function build()
        --[[
          name: build
          line: 941
          upvalues:
            geo (copy, index: 1)
            ui2 (ref,  index: 2)
            ui (copy, index: 3)
            a10 (copy, index: 4)
            ui3 (ref,  index: 5)
            colors (copy, index: 6)
            selectionImageObject (ref,  index: 7)
            ui4 (ref,  index: 8)
            udim2FromOffset (copy, index: 9)
            scaleObj (ref,  index: 10)
            ui5 (ref,  index: 11)
            parent (ref,  index: 12)
            fonts (copy, index: 13)
            close (copy, index: 14)
            close2 (ref,  index: 15)
            ui6 (ref,  index: 16)
            theme (copy, index: 17)
            v51 (ref,  index: 18)
            RankArt (copy, index: 19)
            ui7 (ref,  index: 20)
            v50 (ref,  index: 21)
            SettingsStore (copy, index: 22)
            paint (copy, index: 23)
            v9 (copy, index: 24)
            makeCard (copy, index: 25)
            v53 (copy, index: 26)
            setFocus (copy, index: 27)
            v58 (ref,  index: 28)
            state (copy, index: 29)
            pick (copy, index: 30)
            timestamp (ref,  index: 31)
            menuManager (copy, index: 32)
            guiService (copy, index: 33)
            v55 (ref,  index: 34)
            layout (copy, index: 35)
        ]]
        local v271 = geo()
        ui2 = ui.new("Frame", {Name = "ModeSelect", Visible = false, Size = UDim2.fromScale(1, 1), Parent = a10.Canvas.Menus})
        local parent2 = ui2
        ui3 = ui.new("TextButton", {Name = "ModeSelectBackdrop", BackgroundTransparency = 1, Modal = true, Selectable = false, Visible = false, Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, Parent = ui.BackdropCanvas
            or parent2})
        selectionImageObject = ui.new("Frame", {Name = "NoRing", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1)})
        ui4 = ui.new("Frame", {Name = "Holder", Active = true, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = udim2FromOffset((v271.W * 2) + v271.gap, v271.headH + v271.headGap + v271.H), Parent = parent2})
        local parent3 = ui4
        scaleObj = ui.GetScaleObj(parent3, "FitScale")

        pcall(
            function()
                --[[
                  line: 966
                  upvalues:
                    parent3 (copy, index: 1)
                ]]
                parent3.SelectionGroup = true
                parent3.SelectionBehaviorUp, parent3.SelectionBehaviorDown = Enum.SelectionBehavior.Stop, Enum.SelectionBehavior.Stop
                parent3.SelectionBehaviorLeft, parent3.SelectionBehaviorRight = Enum.SelectionBehavior.Stop, Enum.SelectionBehavior.Stop
            end
        )

        ui5 = ui.new("Frame", {Name = "Header", Size = UDim2.new(1, 0, 0, v271.headH), Parent = parent3})
        local parent4 = ui5
        parent = ui.new("TextLabel", {Name = "Title", Text = "SELECT MODE", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.new(0.5, 0, 1, 0), FontFace = fonts.Display, TextSize = v271.titleSize, TextColor3 = colors.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent4})
        ui.TextStroke(colors.Void, 1.5, 0.5).Parent = parent
        local v275 = ui.WindowCloseSize()

        local function makeClose()
            --[[
              name: makeClose
              line: 989
              upvalues:
                ui (copy, index: 1)
                udim2FromOffset (copy, index: 2)
                v275 (ref,  index: 3)
                colors (copy, index: 4)
                parent4 (copy, index: 5)
                close (copy, index: 6)
            ]]
            return ui.IconButton({Name = "Close", IconName = "cross", Sound = "Close", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = udim2FromOffset(v275, v275), Color = colors.Raised, HoverColor = colors.Danger, Parent = parent4, OnClick = close})
        end

        close2 = makeClose()

        ui.TouchChanged:Connect(
            function()
                --[[
                  line: 1004
                  upvalues:
                    close2 (ref,  index: 1)
                    v275 (ref,  index: 2)
                    ui (copy, index: 3)
                    makeClose (copy, index: 4)
                ]]
                if close2 then
                    close2:Destroy()
                end

                v275 = ui.WindowCloseSize()
                close2 = makeClose()
            end
        )

        ui6 = ui.new(
            "TextButton",
            {
                Name = "Ranked",
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -(v275 + 14), 0.5, 0),
                Size = udim2FromOffset(0, (math.min(v275, 52))),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = colors.Panel,
                BackgroundTransparency = 0.15,
                Selectable = true,
                ui.Corner(theme.Radius.Pill),
                ui.Stroke(colors.Stroke, 1, 0.86),
                ui.Padding(0, 10, 0, 14),
                (ui.List(Enum.FillDirection.Horizontal, 10, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)),
                Parent = parent4
            }
        )
        local parent5 = ui6
        v51 = RankArt.Trophy(24, {LayoutOrder = 1, Parent = parent5})
        ui7 = ui.new("TextLabel", {Name = "Title", Text = "RANKED", TextSize = 18, LayoutOrder = 2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = parent5})
        v50 = ui.Switch({Width = 50, LayoutOrder = 3, Parent = parent5})

        parent5.Activated:Connect(
            function()
                --[[
                  line: 1041
                  upvalues:
                    a10 (copy, index: 1)
                    SettingsStore (copy, index: 2)
                    paint (copy, index: 3)
                ]]
                a10.Sounds.Play("Click")
                local set = SettingsStore.Set
                local v279 = 0.5 < SettingsStore.Get("mmRanked") and 0 or 1
                set("mmRanked", v279, "now")
                paint()
            end
        )

        for index, def in v9 do
            local card = makeCard(def, index, parent3)
            v53[index] = card

            card.btn.MouseEnter:Connect(
                function()
                    --[[
                      line: 1050
                      upvalues:
                        card (copy, index: 1)
                        ui (copy, index: 2)
                        setFocus (copy, index: 3)
                        index (copy, index: 4)
                    ]]
                    card.hover = true

                    if not ui.Touch then
                        setFocus(index)
                    end
                end
            )

            card.btn.MouseLeave:Connect(
                function()
                    --[[
                      line: 1056
                      upvalues:
                        card (copy, index: 1)
                    ]]
                    card.hover = false
                end
            )

            card.btn.MouseButton1Down:Connect(
                function()
                    --[[
                      line: 1059
                      upvalues:
                        v58 (ref,  index: 1)
                        def (copy, index: 2)
                        state (copy, index: 3)
                        a10 (copy, index: 4)
                        ui (copy, index: 5)
                        card (copy, index: 6)
                        udim2FromOffset (copy, index: 7)
                    ]]
                    if not v58 then
                        local v283

                        if def.id == "1v1" then
                            if state.Get("Duel") == true then
                                local v284 = if a10.Party and a10.Party.Size then a10.Party.Size() else 1
                                v283 = 2 <= v284 and "LEAVE YOUR PARTY TO PLAY 1V1" or nil
                            else
                                v283 = "PLAY 3 MATCHES FIRST"
                            end
                        else
                            v283 = nil
                        end

                        if not v283 then
                            ui.Tween(card.lift, TweenInfo.new(0.06, Enum.EasingStyle.Quad), {Position = udim2FromOffset(0, 3)})
                        end
                    end
                end
            )

            card.btn.MouseButton1Up:Connect(
                function()
                    --[[
                      line: 1064
                      upvalues:
                        v58 (ref,  index: 1)
                        ui (copy, index: 2)
                        card (copy, index: 3)
                        theme (copy, index: 4)
                    ]]
                    if not v58 then
                        ui.Tween(card.lift, theme.Tween.PopSmall, {Position = UDim2.new()})
                    end
                end
            )

            card.btn.Activated:Connect(
                function()
                    --[[
                      line: 1069
                      upvalues:
                        pick (copy, index: 1)
                        index (copy, index: 2)
                    ]]
                    pick(index)
                end
            )
        end

        local v285 = false
        local ui8 = ui3

        ui8.InputBegan:Connect(
            function(a287)
                --[[
                  line: 1076
                  upvalues:
                    v285 (ref, index: 1)
                ]]
                local userInputType = a287.UserInputType

                if userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch then
                    v285 = true
                end
            end
        )

        ui8.Activated:Connect(
            function()
                --[[
                  line: 1082
                  upvalues:
                    timestamp (ref,  index: 1)
                    v285 (ref,  index: 2)
                    a10 (copy, index: 3)
                    menuManager (copy, index: 4)
                ]]
                if os.clock() - timestamp < 0.4 or not v285 then
                    return
                end

                a10.Sounds.Play("Close")
                menuManager.Close("Mode")
            end
        )

        guiService:GetPropertyChangedSignal("SelectedObject"):Connect(
            function()
                --[[
                  line: 1090
                  upvalues:
                    guiService (copy, index: 1)
                    v53 (copy, index: 2)
                    v55 (ref,  index: 3)
                    setFocus (copy, index: 4)
                ]]
                local selectedObject = guiService.SelectedObject

                for v290, v291 in v53 do
                    if selectedObject == v291.btn then
                        v55 = true
                        setFocus(v290, true)
                    end
                end
            end
        )

        layout()
    end

    local v292 = {TR_Menus = true, TR_Backdrop = true, TR_TopbarSettings = true, TR_Loading = true, TR_Teleport = true, TR_Reveal = true, TR_RevealSafe = true, TR_RankUp = true, TR_Replay = true, TR_ReplayFrame = true, TR_ReplayHud = true, CombatHUD = true, CombatTouch = true, CharacterTouch = true, TouchGui = true, Chat = true, BubbleChat = true}
    local v293 = {}
    local v294 = {}
    local v295 = false

    local function hideOne(descendant)
        --[[
          name: hideOne
          line: 1119
          upvalues:
            v292 (copy, index: 1)
            a10 (copy, index: 2)
            v293 (copy, index: 3)
            v294 (copy, index: 4)
        ]]
        if v292[descendant.Name] then
            return
        end

        local firstAncestorWhichIsA = descendant:FindFirstAncestorWhichIsA("ScreenGui")

        if firstAncestorWhichIsA and v292[firstAncestorWhichIsA.Name] then
            return
        end

        if descendant:IsA("ScreenGui") then
            if descendant.Parent == a10.PlayerGui and descendant.Enabled then
                descendant.Enabled = false
                v293[descendant] = true
            end
        elseif (descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui")) and v294[descendant] == nil then
            pcall(
                function()
                    --[[
                      line: 1133
                      upvalues:
                        descendant (copy, index: 1)
                        v294 (copy, index: 2)
                    ]]
                    descendant.MaxDistance, v294[descendant] = 0.001, descendant.MaxDistance
                end
            )
        end
    end

    local function sweepOthers()
        --[[
          name: sweepOthers
          line: 1140
          upvalues:
            a10 (copy, index: 1)
            hideOne (copy, index: 2)
        ]]
        for _, descendant in a10.PlayerGui:GetDescendants() do
            if descendant:IsA("LayerCollector") then
                hideOne(descendant)
            end
        end

        if const trContractDisplay = workspace:FindFirstChild("TR_ContractDisplay") then
            for _, descendant in trContractDisplay:GetDescendants() do
                if descendant:IsA("LayerCollector") then
                    hideOne(descendant)
                end
            end
        end
    end

    local function hideOthers(a306: boolean)
        --[[
          name: hideOthers
          line: 1155
          upvalues:
            v295 (ref,  index: 1)
            a10 (copy, index: 2)
            sweepOthers (copy, index: 3)
            v293 (copy, index: 4)
            v294 (copy, index: 5)
        ]]
        if v295 == a306 then
            return
        end

        v295 = a306
        a10.SetHudHidden("ModeSelect", a306)

        if a10.TopbarSettings and type(a10.TopbarSettings.SetHidden) == "function" then
            pcall(a10.TopbarSettings.SetHidden, "ModeSelect", a306)
        end

        if a306 then
            sweepOthers()
            return
        end

        for v307 in v293 do
            if v307.Parent then
                v307.Enabled = true
            end
        end

        table.clear(v293)

        for v308, maxDistance in v294 do
            if v308.Parent then
                pcall(
                    function()
                        --[[
                          line: 1176
                          upvalues:
                            v308 (copy, index: 1)
                            maxDistance (copy, index: 2)
                        ]]
                        v308.MaxDistance = maxDistance
                    end
                )
            end
        end

        table.clear(v294)
    end

    local timestamp2 = 0
    local renderSteppedConnection = nil
    local v312 = false
    local timestamp3 = 0

    local function quintOut(a315)
        --[[
          name: quintOut
          line: 1192
        ]]
        return 1 - ((1 - a315) ^ 5)
    end

    local function cardDelay(a317)
        --[[
          name: cardDelay
          line: 1195
        ]]
        return ((a317 - 1) * 0.07) + 0.05
    end

    local function step(deltaTime: number)
        --[[
          name: step
          line: 1198
          upvalues:
            v295 (ref,  index: 1)
            timestamp2 (ref,  index: 2)
            sweepOthers (copy, index: 3)
            timestamp (ref,  index: 4)
            v312 (ref,  index: 5)
            timestamp3 (ref,  index: 6)
            v53 (copy, index: 7)
            focus (ref,  index: 8)
            v55 (ref,  index: 9)
            ui (copy, index: 10)
            v58 (ref,  index: 11)
        ]]
        local clampedValue
        local timestamp4 = os.clock()

        if v295 and 0.5 < timestamp4 - timestamp2 then
            timestamp2 = timestamp4
            sweepOthers()
        end

        local v322 = timestamp4 - timestamp
        local v323 = 1 - (1 - ((1 - math.clamp(v322 / 0.9, 0, 1)) ^ 5))

        if v312 then
            clampedValue = math.clamp((timestamp4 - timestamp3) / 0.12, 0, 1)
        else
            clampedValue = 0
        end

        for _, v325 in v53 do
            local v326
            local v327 = math.clamp((v322 - (((v325.index - 1) * 0.07) + 0.05)) / 0.24, 0, 1) * (1 - clampedValue)
            local v328 = v325.index == focus and not v312 and 1 or 0
            v325.foc += ((v328 - v325.foc) * math.min(1, deltaTime * 14))
            local foc = v325.foc

            if v325.index ~= focus or v312 then
                v326 = 0
            elseif v325.hover or v55 or ui.Gamepad then
                v326 = 1
            else
                v326 = 0
            end

            v325.up += ((v326 - v325.up) * math.min(1, deltaTime * 16))

            if not v58 and not v312 then
                v325.lift.Position = UDim2.fromOffset(0, v325.up * -7)
            end

            v325.glow.ImageTransparency = 1 - ((foc * 0.42) * v327)
            v325.ring.Transparency = 1 - (foc * v327)

            if const scene = v325.scene then
                local rotationY = math.sin((timestamp4 * 0.45) + scene.phase) * 0.045
                local y = math.sin((timestamp4 * 0.7) + scene.phase) * 0.06
                local v333 = (v323 * 0.16) + 1 - foc * 0.045
                local v334 = (scene.eye - scene.target) * v333
                local v335 = scene.target + CFrame.Angles(0, rotationY, 0):VectorToWorldSpace(v334) + Vector3.new(0, y, 0)
                scene.cam.CFrame = CFrame.lookAt(v335, scene.target)
            end

            for v336, v337 in v325.deco do
                if v337:IsA("ImageLabel") then
                    local v338
                    local baseT = v337:GetAttribute("BaseT")

                    if type(baseT) ~= "number" then
                        baseT = 0.5
                    end

                    if string.sub(v337.Name, 1, 4) == "Beam" then
                        v337.Rotation = (math.sin((timestamp4 * 0.55) + (v336 * 1.9)) * 5) + 180
                        v338 = baseT + math.sin((timestamp4 * 0.9) + v336) * 0.05
                    else
                        v338 = if v337.Name == "Streak" then baseT + math.sin(timestamp4 * 1.6) * 0.08 else baseT
                    end

                    v337.ImageTransparency = 1 - ((1 - v338) * v327)
                end
            end
        end
    end

    Keybinds.OnInput(
        "Began",
        function(a340, a341)
            --[[
              line: 1248
              upvalues:
                open2 (ref,  index: 1)
                userInputService (copy, index: 2)
                v9 (copy, index: 3)
                pick (copy, index: 4)
                v55 (ref,  index: 5)
                setFocus (copy, index: 6)
                focus (ref,  index: 7)
            ]]
            if not open2 or a341 or userInputService:GetFocusedTextBox() then
                return
            end

            local keyCode = a340.KeyCode

            for v343, v344 in v9 do
                if keyCode == v344.keyCode then
                    break
                end
                if v343 == 1 and keyCode == Enum.KeyCode.KeypadOne then
                    break
                end
                if v343 == 2 and keyCode == Enum.KeyCode.KeypadTwo then
                    break
                end
            end

            if keyCode == Enum.KeyCode.Left then
                v55 = true
                setFocus(focus - 1)

                return
            end

            if keyCode == Enum.KeyCode.Right then
                v55 = true
                setFocus(focus + 1)

                return
            end

            if keyCode == Enum.KeyCode.Return or keyCode == Enum.KeyCode.KeypadEnter then
                pick(focus)
            end
        end
    )

    local count = 0

    local function open()
        --[[
          name: open
          line: 1272
          upvalues:
            ui2 (ref,  index: 1)
            build (copy, index: 2)
            count (ref,  index: 3)
            open2 (ref,  index: 4)
            v312 (ref,  index: 5)
            v58 (ref,  index: 6)
            timestamp (ref,  index: 7)
            SettingsStore (copy, index: 8)
            focus (ref,  index: 9)
            state (copy, index: 10)
            a10 (copy, index: 11)
            v55 (ref,  index: 12)
            v53 (copy, index: 13)
            ui (copy, index: 14)
            ui5 (ref,  index: 15)
            v295 (ref,  index: 16)
            sweepOthers (copy, index: 17)
            layout (copy, index: 18)
            paint (copy, index: 19)
            ensureScenes (copy, index: 20)
            ui3 (ref,  index: 21)
            theme (copy, index: 22)
            udim2FromOffset (copy, index: 23)
            renderSteppedConnection (ref,  index: 24)
            runService (copy, index: 25)
            step (copy, index: 26)
        ]]
        local v347
        local v348

        if not ui2 then
            build()
        end

        local ui4 = ui2
        count += 1
        open2 = true
        v312 = false
        v58 = false
        timestamp = os.clock()

        if bit32.btest(math.floor((SettingsStore.Get("modeSel"))), 1) then
            v347 = "1v1"
        else
            v347 = "3v3"
        end

        local v350
        local v351
        local v352, v353, v354, v355 = false, false, false, false

        if v347 ~= "1v1" then
            v355 = true
        elseif state.Get("Duel") == true then
            if a10.Party then
                if a10.Party.Size then
                    v350 = a10.Party.Size()
                    v353 = true
                else
                    v352 = true
                end
            else
                v352 = true
            end
        else
            v351 = "PLAY 3 MATCHES FIRST"
            v354 = true
        end

        if v352 then
            v350 = 1
            v353 = true
        end

        if v353 then
            if not (2 <= v350) then
                v351 = nil
            else
                v351 = "LEAVE YOUR PARTY TO PLAY 1V1"
            end

            v354 = true
        end

        if v354 then
            if v351 then
                v355 = true
            else
                v348 = 2
            end
        end

        if v355 then
            v348 = 1
        end

        focus = v348
        v55 = false

        for _, v357 in v53 do
            ui.Unfade(v357.body)
            v357.foc = v357.index ~= focus and 0 or 1
            v357.up = 0
            v357.hover = false
        end

        ui.Unfade(ui5)

        if v295 ~= true then
            v295 = true
            a10.SetHudHidden("ModeSelect", true)

            if a10.TopbarSettings and type(a10.TopbarSettings.SetHidden) == "function" then
                pcall(a10.TopbarSettings.SetHidden, "ModeSelect", true)
            end

            sweepOthers()
        end

        layout()
        paint()
        ensureScenes()
        ui4.Visible = true
        local ui6 = ui3
        ui6.Visible = true
        ui6.BackgroundTransparency = 1
        ui.Tween(ui6, theme.Tween.Smooth, {BackgroundTransparency = 0.42})
        ui.ResetFade(ui5)
        ui.Enter(ui5, Vector2.new(0, -18), 0, UDim2.new())

        for v359, v360 in v53 do
            local v361
            local v362 = (v359 - 1) * 0.07 + 0.05
            v360.glow.ImageTransparency = 1
            v360.ring.Transparency = 1

            for _, v364 in v360.deco do
                if v364:IsA("ImageLabel") then
                    v364.ImageTransparency = 1
                end
            end

            v360.lift.Position = UDim2.new()
            ui.ResetFade(v360.body)
            ui.FadeIn(v360.body, TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, v362))
            local position = v360.btn.Position
            v360.btn.Position = position + udim2FromOffset(0, 56)
            ui.Tween(v360.btn, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, v362), {Position = position})

            for _, child in v360.lift:GetChildren() do
                if child:IsA("Frame") then
                    if string.sub(child.Name, 1, 6) ~= "Shadow" then
                        continue
                    end

                    local v368 = child:GetAttribute("BaseT")
                    if v368 == nil then
                        child:SetAttribute("BaseT", child.BackgroundTransparency)
                        v368 = child.BackgroundTransparency
                    end

                    child.BackgroundTransparency = 1
                    ui.Tween(child, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, v362), {BackgroundTransparency = v368})
                end
            end

            v360.topPill.Visible = false
            local id = v360.def.id

            if bit32.btest(math.floor((SettingsStore.Get("modeSel"))), 1) then
                v361 = "1v1"
            else
                v361 = "3v3"
            end

            if id == v361 then
                local v370

                if v360.def.id == "1v1" then
                    if state.Get("Duel") == true then
                        local v371 = if a10.Party and a10.Party.Size then a10.Party.Size() else 1
                        v370 = 2 <= v371 and "LEAVE YOUR PARTY TO PLAY 1V1" or nil
                    else
                        v370 = "PLAY 3 MATCHES FIRST"
                    end
                else
                    v370 = nil
                end

                if v370 then
                    continue
                end

                local v372 = count

                task.delay(
                    v362 + 0.32,
                    function()
                        --[[
                          line: 1335
                          upvalues:
                            open2 (ref,  index: 1)
                            v372 (copy, index: 2)
                            count (ref,  index: 3)
                            SettingsStore (copy, index: 4)
                            v360 (copy, index: 5)
                            state (copy, index: 6)
                            a10 (copy, index: 7)
                            ui (copy, index: 8)
                        ]]
                        if open2 and v372 == count then
                            local v373 = bit32.btest(math.floor((SettingsStore.Get("modeSel"))), 1) and "1v1"
                                or "3v3"

                            if v373 == v360.def.id then
                                local v374

                                if v360.def.id == "1v1" then
                                    if state.Get("Duel") == true then
                                        local v375 = if a10.Party and a10.Party.Size then a10.Party.Size() else 1
                                        v374 = 2 <= v375 and "LEAVE YOUR PARTY TO PLAY 1V1" or nil
                                    else
                                        v374 = "PLAY 3 MATCHES FIRST"
                                    end
                                else
                                    v374 = nil
                                end

                                if not v374 then
                                    v360.topPill.Visible = true
                                    ui.Pop(v360.topPill, 0.6)
                                end
                            end
                        end
                    end
                )
            end
        end

        renderSteppedConnection = renderSteppedConnection or runService.RenderStepped:Connect(step)
        a10.Sounds.Play("Open")
    end

    local function closeMenu(a377)
        --[[
          name: closeMenu
          line: 1349
          upvalues:
            open2 (ref,  index: 1)
            v312 (ref,  index: 2)
            timestamp3 (ref,  index: 3)
            hideOthers (copy, index: 4)
            count (ref,  index: 5)
            ui2 (ref,  index: 6)
            ui3 (ref,  index: 7)
            renderSteppedConnection (ref,  index: 8)
            v53 (copy, index: 9)
            ui (copy, index: 10)
            ui5 (ref,  index: 11)
            layout (copy, index: 12)
            theme (copy, index: 13)
            udim2FromOffset (copy, index: 14)
        ]]
        if not open2 then
            return
        end

        open2 = false
        local timestamp = os.clock()
        v312 = true
        timestamp3 = timestamp
        hideOthers(false)
        count += 1
        local v379 = count
        local ui4 = ui2
        local ui6 = ui3

        local function done()
            --[[
              name: done
              line: 1360
              upvalues:
                v379 (copy, index: 1)
                count (ref,  index: 2)
                v312 (ref,  index: 3)
                ui4 (copy, index: 4)
                ui6 (copy, index: 5)
                renderSteppedConnection (ref,  index: 6)
                v53 (copy, index: 7)
                ui (copy, index: 8)
                ui5 (ref,  index: 9)
                layout (copy, index: 10)
            ]]
            if v379 ~= count then
                return
            end

            v312 = false
            ui4.Visible = false
            ui6.Visible = false

            if renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil
            end

            for _, v384 in v53 do
                ui.Unfade(v384.body)

                if v384.scene then
                    for _, track in v384.scene.tracks do
                        pcall(
                            function()
                                --[[
                                  line: 1375
                                  upvalues:
                                    track (copy, index: 1)
                                ]]
                                track:Stop(0)
                            end
                        )
                    end
                end
            end

            ui.Unfade(ui5)
            layout()
        end

        if a377 then
            done()
            return
        end

        ui.Tween(ui6, theme.Tween.Close, {BackgroundTransparency = 1})
        ui.FadeOut(ui5, theme.Tween.Close)

        for _, v388 in v53 do
            ui.FadeOut(v388.body, theme.Tween.Close)
            ui.Tween(v388.btn, theme.Tween.Close, {Position = v388.btn.Position + udim2FromOffset(0, 26)})

            for _, child in v388.lift:GetChildren() do
                if child:IsA("Frame") and string.sub(child.Name, 1, 6) == "Shadow" then
                    ui.Tween(child, theme.Tween.Close, {BackgroundTransparency = 1})
                end
            end

            v388.topPill.Visible = false
        end

        task.delay(0.16, done)
    end

    menuManager.Register(
        "Mode",
        {
            open = open,
            close = closeMenu,
            select = (function()
                --[[
                  name: select
                  line: 1406
                  upvalues:
                    v53 (copy, index: 1)
                    focus (ref,  index: 2)
                ]]
                return if const v391 = v53[focus] then v391.btn else nil
            end)
        }
    )

    local function repaint()
        --[[
          name: repaint
          line: 1413
          upvalues:
            open2 (ref,  index: 1)
            paint (copy, index: 2)
        ]]
        if open2 then
            paint()
        end
    end

    state.AttrChanged:Connect(
        function(a393)
            --[[
              line: 1418
              upvalues:
                open2 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            if a393 == "Duel" and open2 then
                paint()
            end
        end
    )

    SettingsStore.Changed:Connect(
        function(a394)
            --[[
              line: 1423
              upvalues:
                open2 (ref,  index: 1)
                paint (copy, index: 2)
            ]]
            if (a394 == "mmRanked" or a394 == "modeSel") and open2 then
                paint()
            end
        end
    )

    if a10.Party and a10.Party.Changed then
        a10.Party.Changed:Connect(repaint)
    end

    ui.GamepadChanged:Connect(repaint)

    local function relayout()
        --[[
          name: relayout
          line: 1432
          upvalues:
            ui2 (ref,  index: 1)
            layout (copy, index: 2)
        ]]
        if ui2 then
            layout()
        end
    end

    ui.LayoutChanged:Connect(
        function()
            --[[
              line: 1437
              upvalues:
                ui2 (ref,  index: 1)
                open2 (ref,  index: 2)
                menuManager (copy, index: 3)
                v53 (copy, index: 4)
                clearScene (copy, index: 5)
                ui3 (ref,  index: 6)
                ui4 (ref,  index: 7)
                ui5 (ref,  index: 8)
                character (ref,  index: 9)
            ]]
            if ui2 then
                if open2 then
                    menuManager.Close("Mode", true)
                end

                for _, v397 in v53 do
                    clearScene(v397)
                    v397.btn:Destroy()
                end

                table.clear(v53)
                ui2:Destroy()

                if ui3 then
                    ui3:Destroy()
                end

                ui2 = nil
                ui3 = nil
                ui4 = nil
                ui5 = nil
                character = nil
            end
        end
    )

    ui.OnResize(relayout)

    a10.Debug.modeSelect = function(a398, key: number, a400)
        --[[
          line: 1460
          upvalues:
            setFocus (copy, index: 1)
            v9 (copy, index: 2)
            pick (copy, index: 3)
            v188 (copy, index: 4)
            character (ref,  index: 5)
            open2 (ref,  index: 6)
            ensureScenes (copy, index: 7)
            v53 (copy, index: 8)
            focus (ref,  index: 9)
            SettingsStore (copy, index: 10)
            state (copy, index: 11)
            a10 (copy, index: 12)
        ]]
        local last

        if a398 == "focus" and type(key) == "number" then
            setFocus(key)
        elseif a398 == "pick" then
            for v402, v403 in v9 do
                if v403.id == key then
                    pick(v402)
                end
            end
        elseif a398 == "hover" and type(key) == "number" then
            setFocus(key)
        elseif a398 == "scene" and type(key) == "string" and v188[key] and type(a400) == "table" then
            for v404, v405 in a400 do
                v188[key][v404] = v405
            end

            character = nil

            if open2 then
                ensureScenes()
            end
        elseif a398 == "light" and type(key) == "table" then
            for _, v407 in v53 do
                v407.vpf.Ambient = key.ambient or v407.vpf.Ambient
                v407.vpf.LightColor = key.color or v407.vpf.LightColor
                v407.vpf.LightDirection = key.dir or v407.vpf.LightDirection
            end
        end

        local v408 = {open = open2, focus = focus}

        if bit32.btest(math.floor((SettingsStore.Get("modeSel"))), 1) then
            last = "1v1"
        else
            last = "3v3"
        end

        v408.last = last
        v408.bits = math.floor((SettingsStore.Get("modeSel")))
        local ranked = 0.5 < SettingsStore.Get("mmRanked")
        v408.ranked = ranked

        for _, v411 in v53 do
            local v412
            local id = v411.def.id
            local v414 = {}

            if v411.def.id == "1v1" then
                if state.Get("Duel") == true then
                    local v415 = if a10.Party and a10.Party.Size then a10.Party.Size() else 1
                    v412 = 2 <= v415 and "LEAVE YOUR PARTY TO PLAY 1V1" or nil
                else
                    v412 = "PLAY 3 MATCHES FIRST"
                end
            else
                v412 = nil
            end

            v414.locked = v412 or false
            v414.scene = v411.scene ~= nil
            v414.fighters = not v411.scene and 0 or #v411.scene.wm:GetChildren()
            v414.tracks = not v411.scene and 0 or #v411.scene.tracks
            v408[id] = v414
        end

        return v408
    end
end

return v7