local players = game:GetService("Players")
local Combat = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Combat"))
local tweenService = game:GetService("TweenService")
local collectionService = game:GetService("CollectionService")
local workspace = game:GetService("Workspace")
local runService = game:GetService("RunService")
local Tribes = require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Tribes"))
local RankArt = require(script.Parent.Parent.RankArt)

return {
    Init = (function(a9)
        --[[
          name: Init
          line: 60
          upvalues:
            players (copy, index: 1)
            Tribes (copy, index: 2)
            collectionService (copy, index: 3)
            RankArt (copy, index: 4)
            tweenService (copy, index: 5)
            workspace (copy, index: 6)
            runService (copy, index: 7)
            Combat (copy, index: 8)
        ]]
        local ui = a9.UI
        local theme = a9.Theme
        local state = a9.State
        local colors = theme.Colors
        local fonts = theme.Fonts
        local localPlayer = players.LocalPlayer
        local textColor3 = Color3.fromRGB(226, 222, 212)
        local backgroundColor3 = theme.Lighten(colors.Ally, 0.1)
        local v18 = theme.Lighten(colors.Enemy, 0.05)
        local parent = ui.new("ScreenGui", {Name = "TR_Nameplates", ResetOnSpawn = false, DisplayOrder = 0, Parent = a9.PlayerGui})
        local parent2 = ui.new("ScreenGui", {Name = "TR_Plates", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 1, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = a9.PlayerGui})
        parent2.ScreenInsets = Enum.ScreenInsets.None
        local v21 = {}
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.IgnoreWater = true

        local function modelName(character: Model)
            --[[
              name: modelName
              line: 124
              upvalues:
                players (copy, index: 1)
            ]]
            local displayName = character:GetAttribute("DisplayName")

            return if type(displayName) == "string" and displayName ~= "" then displayName elseif const player = players:GetPlayerFromCharacter(character) then player.DisplayName else character.Name
        end

        local function escape(text: string)
            --[[
              name: escape
              line: 133
            ]]
            return (string.gsub(string.gsub(string.gsub(text, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
        end

        local function levelOf(character)
            --[[
              name: levelOf
              line: 139
              upvalues:
                players (copy, index: 1)
            ]]
            local level = character:GetAttribute("Level")

            if type(level) ~= "number" then
                local player = players:GetPlayerFromCharacter(character)
                level = player and player:GetAttribute("Level")
            end

            if type(level) == "number" and 1 <= level then
                return (math.floor(level))
            end

            return nil
        end

        local function levelPrefix(character: Model)
            --[[
              name: levelPrefix
              line: 148
              upvalues:
                levelOf (copy, index: 1)
            ]]
            return if const v35 = levelOf(character) then (string.format("<font color=\"%s\">[%d]</font> ", "#AEB5C2", v35)) else ""
        end

        local function tribeOf(character)
            --[[
              name: tribeOf
              line: 155
              upvalues:
                players (copy, index: 1)
            ]]
            local tribeTag = character:GetAttribute("TribeTag")
            local tribeColor1 = character:GetAttribute("TribeColor1")

            if type(tribeTag) ~= "string" or tribeTag == "" then
                local player = players:GetPlayerFromCharacter(character)
                local tribeTag2 = player and player:GetAttribute("TribeTag")
                local tribeColor12 = player and player:GetAttribute("TribeColor1")
                tribeTag, tribeColor1 = tribeTag2, tribeColor12
            end

            if type(tribeTag) ~= "string" or tribeTag == "" then
                return nil, nil
            end
            if type(tribeColor1) ~= "number" then
                return tribeTag, 1
            end

            return tribeTag, tribeColor1
        end

        local function tribePrefix(character: Model, a45)
            --[[
              name: tribePrefix
              line: 168
              upvalues:
                tribeOf (copy, index: 1)
                Tribes (copy, index: 2)
            ]]
            local text, v47 = tribeOf(character)
            if not text then
                return ""
            end
            if not a45 then
                return "[" .. text .. "] "
            end

            return string.format("<font color=\"#%s\">[%s]</font> ", Tribes.TextColor(v47):ToHex(), (string.gsub(string.gsub(string.gsub(text, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")))
        end

        local function isFighterTagged(instance: Instance)
            --[[
              name: isFighterTagged
              line: 179
              upvalues:
                collectionService (copy, index: 1)
            ]]
            return collectionService:HasTag(instance, "Combatant") or collectionService:HasTag(instance, "Bot")
        end

        local function roleOf(character)
            --[[
              name: roleOf
              line: 183
              upvalues:
                state (copy, index: 1)
                players (copy, index: 2)
            ]]
            if not state.SeesMatch() then
                local matchId = character:GetAttribute("MatchId")
                local v53 = type(matchId) == "string" and matchId ~= ""

                if players:GetPlayerFromCharacter(character) and not v53 then
                    return "lobby"
                end

                return "none"
            end

            local v54 = state.SeenMatchId()
            local matchId = character:GetAttribute("MatchId")

            if type(v54) == "string" and v54 ~= "" and type(matchId) == "string" and matchId ~= "" and matchId ~= v54 then
                return "none"
            end

            local team = character:GetAttribute("Team")

            if type(team) ~= "number" then
                local player = players:GetPlayerFromCharacter(character)
                team = player and player:GetAttribute("Team")
            end

            if type(team) ~= "number" or team == 0 then
                return "none"
            end
            if team == state.MyTeam() then
                return "ally"
            end

            return "enemy"
        end

        local function ensureBillboard(a59)
            --[[
              name: ensureBillboard
              line: 207
              upvalues:
                ui (copy, index: 1)
                parent (copy, index: 2)
                players (copy, index: 3)
                fonts (copy, index: 4)
                textColor3 (copy, index: 5)
                colors (copy, index: 6)
            ]]
            local v60

            if a59.bb then
                return
            end

            local ui2 = ui.new("BillboardGui", {Name = "Plate", StudsOffsetWorldSpace = Vector3.new(0, 1.899999976158142, 0), LightInfluence = 0, AlwaysOnTop = false, MaxDistance = 90, ResetOnSpawn = false, Active = false, Enabled = false, Size = UDim2.new(5.5, 104, 0.6, 12), Parent = parent})
            local newUi = ui.new
            local v63 = {Name = "PlayerName", AutoLocalize = false, RichText = true, TextScaled = true, Size = UDim2.fromScale(1, 1)}
            local v64 = a59.model
            local displayName = v64:GetAttribute("DisplayName")

            if type(displayName) == "string" and displayName ~= "" then
                v60 = displayName
            else
                v60 = if const player = players:GetPlayerFromCharacter(v64) then player.DisplayName else v64.Name
            end

            v63.Text = v60
            v63.FontFace = fonts.Heavy
            v63.TextColor3 = textColor3
            v63.TextTruncate = Enum.TextTruncate.AtEnd
            v63.Parent = ui2
            local ui3 = newUi("TextLabel", v63)
            ui.new("UITextSizeConstraint", {MaxTextSize = 20, MinTextSize = 9, Parent = ui3})
            ui.TextStroke(colors.Void, 1.6, 0.15).Parent = ui3
            local bbRank = ui.new("Frame", {Name = "RankEmblem", BackgroundTransparency = 1, Visible = false, AnchorPoint = Vector2.new(1, 0.5), Parent = ui2})

            local function place()
                --[[
                  name: place
                  line: 245
                  upvalues:
                    ui3 (copy, index: 1)
                    bbRank (copy, index: 2)
                ]]
                local textBounds = ui3.TextBounds
                local v71 = math.max(10, (math.floor(textBounds.Y * 1.3)))
                bbRank.Size = UDim2.fromOffset(v71, v71)
                bbRank.Position = UDim2.new(0.5, -math.floor(textBounds.X / 2) - 2, 0.5, 0)
            end

            ui3:GetPropertyChangedSignal("TextBounds"):Connect(place)
            place()
            a59.bb = ui2
            a59.bbName = ui3
            a59.bbRank = bbRank
        end

        local function paintRank(a73)
            --[[
              name: paintRank
              line: 258
              upvalues:
                players (copy, index: 1)
                RankArt (copy, index: 2)
            ]]
            local bbRank = a73.bbRank
            if not bbRank then
                return
            end

            local v75 = players:GetPlayerFromCharacter(a73.model)
            if v75 then
                local v76 = false
                v75 = if v75 ~= players.LocalPlayer then v75:GetAttribute("Trophies") else v76
            end

            if type(v75) ~= "number" then
                bbRank.Visible = false
                return
            end

            RankArt.SetEmblem(bbRank, RankArt.Ranks.RankOf(v75))

            for _, child in bbRank:GetChildren() do
                if child:IsA("GuiObject") then
                    child.ZIndex = 2
                end
            end

            bbRank.Visible = true
        end

        local function playerOf(a80)
            --[[
              name: playerOf
              line: 279
              upvalues:
                players (copy, index: 1)
            ]]
            return players:GetPlayerFromCharacter(a80.model)
        end

        local function lobbyName(a82)
            --[[
              name: lobbyName
              line: 283
              upvalues:
                levelOf (copy, index: 1)
                tribeOf (copy, index: 2)
                Tribes (copy, index: 3)
                players (copy, index: 4)
            ]]
            local v83
            local v85 = if const v84 = levelOf(a82.model) then string.format("<font color=\"%s\">[%d]</font> ", "#AEB5C2", v84) else ""
            local text, v87 = tribeOf(a82.model)
            local v88 = not text and ""
                or string.format("<font color=\"#%s\">[%s]</font> ", Tribes.TextColor(v87):ToHex(), (string.gsub(string.gsub(string.gsub(text, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")))
            local v89 = a82.model
            local displayName = v89:GetAttribute("DisplayName")

            if type(displayName) == "string" and displayName ~= "" then
                v83 = displayName
            else
                v83 = if const player = players:GetPlayerFromCharacter(v89) then player.DisplayName else v89.Name
            end

            local v92 = v85 .. v88 .. string.gsub(string.gsub(string.gsub(v83, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")
            local player = players:GetPlayerFromCharacter(a82.model)
            local streak = player and player:GetAttribute("Streak")

            if type(streak) == "number" then
                if 2 <= streak then
                    return string.format("%s  <font color=\"#FFA24A\">🔥 %d</font>", v92, (math.floor(streak)))
                end
            end

            return v92
        end

        local function paintQueue(a96)
            --[[
              name: paintQueue
              line: 292
              upvalues:
                players (copy, index: 1)
                a9 (copy, index: 2)
                ui (copy, index: 3)
                parent (copy, index: 4)
                colors (copy, index: 5)
                theme (copy, index: 6)
                tweenService (copy, index: 7)
                fonts (copy, index: 8)
            ]]
            local player = players:GetPlayerFromCharacter(a96.model)

            if player == nil
                or player:GetAttribute("Queued") ~= true
                or a96.role ~= "lobby"
                or a96.head == nil
                or a9.HudHidden
            then
                if a96.queueBB then
                    a96.queueBB.Enabled = false
                end

                return
            end

            local text
            local queueFound = player:GetAttribute("QueueFound") == true
            local v100 = a96.queueBB
            if not v100 then
                v100 = ui.new("BillboardGui", {Name = "QueueTag", StudsOffsetWorldSpace = Vector3.new(0, 3.049999952316284, 0), LightInfluence = 0, AlwaysOnTop = false, MaxDistance = 90, ResetOnSpawn = false, Active = false, Size = UDim2.new(2.9, 36, 0.5, 9), Parent = parent})
                local parent2 = ui.new("Frame", {Name = "Pill", Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, (ui.Corner(theme.Radius.Pill)), Parent = v100})
                ui.new("UIStroke", {Name = "Rim", Thickness = 1.5, Transparency = 0.2, Color = colors.Accent, Parent = parent2})
                ui.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, Parent = parent2})
                local newUi = ui.new
                local v103 = {Name = "Dot", Size = UDim2.fromScale(0.34, 0.34), SizeConstraint = Enum.SizeConstraint.RelativeYY, BackgroundColor3 = colors.Accent, LayoutOrder = 1, (ui.Corner(theme.Radius.Pill))}
                v103.Parent = parent2
                local propertyTable = {BackgroundTransparency = 0.75}
                tweenService:Create(newUi("Frame", v103), TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), propertyTable):Play()
                local parent3 = ui.new("TextLabel", {Name = "Label", Text = "IN QUEUE", TextScaled = true, LayoutOrder = 2, Size = UDim2.fromScale(0.72, 0.62), FontFace = fonts.Heavy, TextColor3 = colors.Text, Parent = parent2})
                ui.new("UITextSizeConstraint", {MaxTextSize = 15, MinTextSize = 7, Parent = parent3})
                a96.queueBB = v100
            end

            local pill = v100:FindFirstChild("Pill")
            local v107 = if queueFound then colors.Success else colors.Accent
            pill:FindFirstChild("Dot").BackgroundColor3 = v107
            pill:FindFirstChild("Rim").Color = v107
            local label = pill:FindFirstChild("Label")

            if queueFound then
                text = "MATCH FOUND"
            else
                text = "IN QUEUE"
            end

            label.Text = text
            label.TextColor3 = if queueFound then colors.Success else colors.Text
            v100.Adornee = a96.head
            v100.Enabled = true
        end

        local function ensureFlat(a110)
            --[[
              name: ensureFlat
              line: 370
              upvalues:
                ui (copy, index: 1)
                parent2 (copy, index: 2)
                fonts (copy, index: 3)
                colors (copy, index: 4)
                backgroundColor3 (copy, index: 5)
            ]]
            if a110.flat then
                return a110.flat
            end

            local ui2 = ui.new("Frame", {Name = "Plate", Visible = false, AnchorPoint = Vector2.new(0.5, 1), Size = UDim2.fromOffset(220, 38), Parent = parent2})
            local scale = ui.new("UIScale", {Parent = ui2})
            local ui3 = ui.new("Frame", {Name = "NameRow", Size = UDim2.new(1, 0, 0, 22), (ui.List(Enum.FillDirection.Horizontal, 5, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)), Parent = ui2})
            local ui4 = ui.new("TextLabel", {Name = "Level", Text = "", TextSize = 19, LayoutOrder = 1, Visible = false, Size = UDim2.fromOffset(0, 22), AutomaticSize = Enum.AutomaticSize.X, FontFace = fonts.Heavy, TextColor3 = Color3.fromHex("#AEB5C2"), Parent = ui3})
            local levelStroke = ui.TextStroke(colors.Void, 1.8, 0.1)
            levelStroke.Parent = ui4
            local newUi = ui.new
            local v117 = ui.new
            local v118 = {MaxSize = Vector2.new(168, 22)}
            local ui5 = newUi("TextLabel", {Name = "PlayerName", AutoLocalize = false, Size = UDim2.fromOffset(0, 22), AutomaticSize = Enum.AutomaticSize.X, Text = "", FontFace = fonts.Heavy, TextSize = 19, TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = 2, (v117("UISizeConstraint", v118)), Parent = ui3})
            local nameStroke = ui.TextStroke(colors.Void, 1.8, 0.1)
            nameStroke.Parent = ui5
            local ui6 = ui.new("Frame", {Name = "Bar", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -4), Size = UDim2.fromOffset(96, 8), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.3, (ui.Corner(4)), Parent = ui2})
            v117 = ui.new("Frame", {Name = "Fill", Size = UDim2.fromScale(1, 1), BackgroundColor3 = backgroundColor3, (ui.Corner(4)), Parent = ui6})
            local ui7 = ui.new("Frame", {Name = "Armor", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -13), Size = UDim2.fromOffset(96, 4), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.4, Visible = false, (ui.Corner(2)), Parent = ui2})
            local armorFill = ui.new("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Armor, (ui.Corner(2)), Parent = ui7})
            local ui8 = ui.new("Frame", {Name = "Chevron", ClipsDescendants = true, Visible = false, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -15), Size = UDim2.fromOffset(18, 12), Parent = ui2})
            ui.new("Frame", {Name = "Tri", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(15, 15), Rotation = 45, BackgroundColor3 = backgroundColor3, (ui.Stroke(colors.Void, 1.5, 0.2)), Parent = ui8})
            local flat = {bucket = 0, mode = "full", faded = false, frame = ui2, scale = scale, row = ui3, level = ui4, levelStroke = levelStroke, name = ui5, nameStroke = nameStroke, barBg = ui6, fill = v117, chevron = ui8, armorBg = ui7, armorFill = armorFill}
            a110.flat = flat

            return flat
        end

        local function paintArmor(a127)
            --[[
              name: paintArmor
              line: 479
            ]]
            local flat = a127.flat
            if not flat then
                return
            end

            local maxArmor = a127.model:GetAttribute("MaxArmor")
            local armor = a127.model:GetAttribute("Armor")

            if type(maxArmor) ~= "number" then
                maxArmor = 0
            end

            if type(armor) ~= "number" then
                armor = 0
            end

            flat.armorBg.Visible = 0 < maxArmor and 0 < armor and (flat.mode ~= "bar")

            if 0 < maxArmor then
                flat.armorFill.Size = UDim2.fromScale(math.clamp(armor / maxArmor, 0, 1), 1)
            end
        end

        local function healthFrac(a132)
            --[[
              name: healthFrac
              line: 494
            ]]
            local hum = a132.hum
            if not hum then
                return 1
            end
            if 0 < hum.MaxHealth then
                return (math.clamp(hum.Health / hum.MaxHealth, 0, 1))
            end

            return 0
        end

        local function alive(a135)
            --[[
              name: alive
              line: 502
            ]]
            return (a135.hum == nil) or (0 < a135.hum.Health)
        end

        local function setFaded(faded2, faded: boolean)
            --[[
              name: setFaded
              line: 507
            ]]
            if faded2.faded == faded then
                return
            end

            faded2.faded = faded
            local v139 = faded and 0.4 or 0
            faded2.name.TextTransparency = v139
            faded2.nameStroke.Transparency = faded and 0.5 or 0.1
            faded2.level.TextTransparency = v139
            faded2.levelStroke.Transparency = faded and 0.5 or 0.1
            faded2.fill.BackgroundTransparency = v139
            faded2.barBg.BackgroundTransparency = faded and 0.6 or 0.3
            faded2.chevron:FindFirstChild("Tri").BackgroundTransparency = v139
        end

        local function setMode(mode2, mode)
            --[[
              name: setMode
              line: 523
            ]]
            if mode2.mode == mode then
                return
            end

            mode2.mode = mode
            mode2.row.Visible = mode == "full"
            mode2.chevron.Visible = mode == "far"
        end

        local function setOutline(outline, a145: boolean)
            --[[
              name: setOutline
              line: 533
              upvalues:
                colors (copy, index: 1)
            ]]
            if a145 and not outline.outline then
                local trEnemyOutline = Instance.new("Highlight")
                trEnemyOutline.Name = "TR_EnemyOutline"
                trEnemyOutline.Adornee = outline.model
                trEnemyOutline.DepthMode = Enum.HighlightDepthMode.Occluded
                trEnemyOutline.FillTransparency = 1
                trEnemyOutline.OutlineTransparency = 0.35
                trEnemyOutline.OutlineColor = colors.Enemy
                trEnemyOutline.Parent = outline.model
                outline.outline = trEnemyOutline

                return
            end

            if not a145 and outline.outline then
                outline.outline:Destroy()
                outline.outline = nil
            end
        end

        local v147 = {}
        local values = table.create(12, 0)
        local values2 = table.create(12, 0)
        local values3 = table.create(12, 0)
        local values4 = table.create(12, 0)

        local function byDistance(left, right)
            --[[
              name: byDistance
              line: 556
            ]]
            return left.dist < right.dist
        end

        local function overlaps(endIndex: number, a157, a158, a159, a160)
            --[[
              name: overlaps
              line: 559
              upvalues:
                values (copy, index: 1)
                values3 (copy, index: 2)
                values2 (copy, index: 3)
                values4 (copy, index: 4)
            ]]
            for valueKey = 1, endIndex do
                if a157 < values[valueKey] + values3[valueKey] then
                    local v162 = a157 + a159

                    if values[valueKey] < v162 and a158 < values2[valueKey] + values4[valueKey] then
                        local v163 = a158 + a160

                        if values2[valueKey] < v163 then
                            return true
                        end
                    end
                end
            end

            return false
        end

        local renderSteppedConnection = nil

        local function step()
            --[[
              name: step
              line: 569
              upvalues:
                workspace (copy, index: 1)
                a9 (copy, index: 2)
                v147 (copy, index: 3)
                byDistance (copy, index: 4)
                ui (copy, index: 5)
                overlaps (copy, index: 6)
                values (copy, index: 7)
                values2 (copy, index: 8)
                values3 (copy, index: 9)
                values4 (copy, index: 10)
            ]]
            local camera = workspace.CurrentCamera
            if not camera then
                return
            end

            local position = camera.CFrame.Position
            local hudHidden = a9.HudHidden

            for _, v170 in v147 do
                local head = v170.head
                v170.onScreen = false

                if head and v170.flat then
                    local worldPoint = head.Position + Vector3.new(0, 1.899999976158142, 0)
                    v170.dist = (worldPoint - position).Magnitude
                    local v173, v174 = camera:WorldToViewportPoint(worldPoint)
                    local v175 = v170.role ~= "ally" and 200 or 450
                    v170.onScreen = v174 and 0 < v173.Z and v170.dist <= v175 and not hudHidden
                    v170.sx, v170.sy = v173.X, v173.Y
                    continue
                end

                v170.dist = math.huge
            end

            table.sort(v147, byDistance)
            local v176 = 0
            local v177 = 0
            local v178 = -1
            local scoreboard = a9.Scoreboard

            if scoreboard and scoreboard.Parent and 0 < scoreboard.AbsoluteSize.X then
                local parent = scoreboard.Parent

                if parent.Visible then
                    v176 = scoreboard.AbsolutePosition.X - 8
                    v177 = scoreboard.AbsolutePosition.X + scoreboard.AbsoluteSize.X + 8
                    v178 = scoreboard.AbsolutePosition.Y + scoreboard.AbsoluteSize.Y + 6
                end
            end

            local writeIndex = 0
            local scale = ui.Scale
            local v183 = ui.Compact and 1.3 or 1
            local v184 = scale * v183

            for _, v186 in v147 do
                if const flat = v186.flat then
                    if v186.onScreen then
                        local v188, v189
                        local bucket = v186.dist < 35 and 1 or v186.dist < 90 and 2 or 3

                        if bucket ~= flat.bucket then
                            flat.bucket = bucket
                            flat.scale.Scale = v184 * ((bucket ~= 1 and (bucket ~= 2 and 0.72 or 0.85)) or 1)
                        end

                        local scale2 = flat.scale.Scale
                        local mode = v186.role == "ally" and 60 < v186.dist and "far" or "full"
                        local v193 = ((mode ~= "full" and (mode ~= "far" and 14 or 26)) or 38) * scale2

                        if mode == "full" then
                            v188 = 150
                            v189 = v186
                        else
                            v188 = 100
                            v189 = v186
                        end

                        local v194 = v188 * scale2
                        local v195 = v189.sx - v194 / 2
                        local v196 = v189.sy
                        local count = 0

                        while count < 2 and overlaps(writeIndex, v195, v196 - v193, v194, v193) do
                            v196 -= v193 + 2
                            count += 1
                        end

                        if overlaps(writeIndex, v195, v196 - v193, v194, v193) then
                            mode = "bar"
                            v193 = 14 * scale2
                        end

                        if 0 < v178 and v176 < v189.sx and v189.sx < v177 and v196 - v193 < v178 then
                            v196 = v178 + v193
                        end

                        if writeIndex < 12 then
                            writeIndex += 1
                            values[writeIndex], values2[writeIndex] = v195, v196 - v193
                            values3[writeIndex] = v194
                            values4[writeIndex] = v193
                        end

                        if flat.mode ~= mode then
                            flat.mode = mode
                            flat.row.Visible = mode == "full"
                            flat.chevron.Visible = mode == "far"
                        end

                        flat.frame.Position = UDim2.fromOffset(math.floor(v189.sx + 0.5), (math.floor(v196 + 0.5)))
                        flat.frame.Visible = true
                    else
                        flat.frame.Visible = false
                    end
                end
            end
        end

        local function wantsPlate(a199)
            --[[
              name: wantsPlate
              line: 646
            ]]
            local v200 = false

            if a199.head ~= nil then
                v200 = a199.hum == nil or 0 < a199.hum.Health
                return v200 and (a199.role == "ally" or a199.role == "enemy" and a199.visibleLOS)
            end

            return v200
        end

        local function wantsOutline(a202)
            --[[
              name: wantsOutline
              line: 649
            ]]
            local v203 = false

            if a202.role == "enemy" then
                v203 = a202.hum == nil or 0 < a202.hum.Health
                return v203 and a202.head ~= nil and not a202.smoked
            end

            return v203
        end

        local function refreshActive()
            --[[
              name: refreshActive
              line: 652
              upvalues:
                v147 (copy, index: 1)
                v21 (copy, index: 2)
                setOutline (copy, index: 3)
                renderSteppedConnection (ref,  index: 4)
                runService (copy, index: 5)
                step (copy, index: 6)
                alive (copy, index: 7)
            ]]
            table.clear(v147)

            for _, outline in v21 do
                local v207 = outline.head ~= nil
                    and alive(outline)
                    and (outline.role == "ally" or outline.role == "enemy" and outline.visibleLOS)
                v207 = v207 and #v147 < 12
                outline.listed = v207

                if v207 then
                    table.insert(v147, outline)
                elseif outline.flat then
                    outline.flat.frame.Visible = false
                end

                local v208 = outline.role == "enemy"
                    and alive(outline)
                    and outline.head ~= nil
                    and not outline.smoked
                setOutline(outline, v208)
            end

            if 0 < #v147 and not renderSteppedConnection then
                renderSteppedConnection = runService.RenderStepped:Connect(step)
                return
            end

            if #v147 == 0 and renderSteppedConnection then
                renderSteppedConnection:Disconnect()
                renderSteppedConnection = nil
            end
        end

        ui.ScaleChanged:Connect(
            function()
                --[[
                  line: 671
                  upvalues:
                    v21 (copy, index: 1)
                ]]
                for _, v210 in v21 do
                    if v210.flat then
                        v210.flat.bucket = 0
                    end
                end
            end
        )

        local function paint(a212)
            --[[
              name: paint
              line: 679
              upvalues:
                ensureFlat (copy, index: 1)
                backgroundColor3 (copy, index: 2)
                v18 (copy, index: 3)
                levelOf (copy, index: 4)
                tribeOf (copy, index: 5)
                players (copy, index: 6)
                paintArmor (copy, index: 7)
                a9 (copy, index: 8)
                ensureBillboard (copy, index: 9)
                lobbyName (copy, index: 10)
                paintRank (copy, index: 11)
                paintQueue (copy, index: 12)
                refreshActive (copy, index: 13)
            ]]
            local role = a212.role

            if role == "ally" or role == "enemy" then
                local v214 = ensureFlat(a212)
                local v215 = if role == "ally" then backgroundColor3 else v18
                local v216 = levelOf(a212.model)
                v214.level.Text = not v216 and "" or string.format("[%d]", v216)
                local v217
                local v218
                v214.level.Visible = v216 ~= nil
                local name = v214.name
                local v221 = if const v220 = tribeOf(a212.model) then "[" .. v220 .. "] " else ""
                local v222 = a212.model
                local displayName = v222:GetAttribute("DisplayName")

                if type(displayName) == "string" and displayName ~= "" then
                    v217 = displayName
                else
                    v217 = if const player = players:GetPlayerFromCharacter(v222) then player.DisplayName else v222.Name
                end

                name.Text = v221 .. v217
                v214.name.TextColor3 = v215
                v214.fill.BackgroundColor3 = v215
                local fill = v214.fill
                local udim2FromScale = UDim2.fromScale
                v218 = if const hum = a212.hum then not (0 < hum.MaxHealth) and 0
                    or math.clamp(hum.Health / hum.MaxHealth, 0, 1) else 1
                fill.Size = udim2FromScale(v218, 1)
                v214.chevron:FindFirstChild("Tri").BackgroundColor3 = v215
                paintArmor(a212)

                if role == "enemy" and v214.faded ~= false then
                    v214.faded = false
                    v214.name.TextTransparency = 0
                    v214.nameStroke.Transparency = 0.1
                    v214.level.TextTransparency = 0
                    v214.levelStroke.Transparency = 0.1
                    v214.fill.BackgroundTransparency = 0
                    v214.barBg.BackgroundTransparency = 0.3
                    v214.chevron:FindFirstChild("Tri").BackgroundTransparency = 0
                end
            end

            if a212.bb then
                a212.bb.Enabled = role == "lobby" and a212.head ~= nil and not a9.HudHidden
            elseif role == "lobby" then
                ensureBillboard(a212)
                a212.bb.Enabled = a212.head ~= nil and not a9.HudHidden
            end

            if a212.bb and a212.head then
                a212.bb.Adornee = a212.head
                a212.bbName.Text = lobbyName(a212)
                paintRank(a212)
            end

            paintQueue(a212)
            refreshActive()
        end

        local function setHealth(health)
            --[[
              name: setHealth
              line: 712
              upvalues:
                refreshActive (copy, index: 1)
                alive (copy, index: 2)
            ]]
            if health.flat then
                local v230
                local fill = health.flat.fill
                local udim2FromScale = UDim2.fromScale
                v230 = if const hum = health.hum then not (0 < hum.MaxHealth) and 0
                    or math.clamp(hum.Health / hum.MaxHealth, 0, 1) else 1
                fill.Size = udim2FromScale(v230, 1)
            end

            local wasAlive = alive(health)

            if wasAlive ~= health.wasAlive then
                health.wasAlive = wasAlive
                refreshActive()
            end
        end

        local function detach(a236)
            --[[
              name: detach
              line: 725
              upvalues:
                v21 (copy, index: 1)
                refreshActive (copy, index: 2)
            ]]
            local v237 = v21[a236]
            if not v237 then
                return
            end

            v21[a236] = nil

            for _, conn in v237.conns do
                conn:Disconnect()
            end

            if v237.outline then
                v237.outline:Destroy()
                v237.outline = nil
            end

            if v237.bb then
                v237.bb:Destroy()
            end

            if v237.queueBB then
                v237.queueBB:Destroy()
            end

            if v237.flat then
                v237.flat.frame:Destroy()
            end

            refreshActive()
        end

        local function hookHead(a241)
            --[[
              name: hookHead
              line: 747
              upvalues:
                paint (copy, index: 1)
            ]]
            local head = a241.model:FindFirstChild("Head")
            a241.head = if head and head:IsA("BasePart") then head else nil
            paint(a241)
        end

        local function hookHumanoid(a244, hum)
            --[[
              name: hookHumanoid
              line: 753
              upvalues:
                refreshActive (copy, index: 1)
                alive (copy, index: 2)
            ]]
            a244.hum = hum
            pcall(
                function()
                    --[[
                      line: 755
                      upvalues:
                        hum (copy, index: 1)
                    ]]
                    hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                end
            )

            table.insert(
                a244.conns,
                hum.HealthChanged:Connect(
                    function()
                        --[[
                          line: 758
                          upvalues:
                            a244 (copy, index: 1)
                            refreshActive (copy, index: 2)
                        ]]
                        if a244.flat then
                            local v246
                            local fill = a244.flat.fill
                            local udim2FromScale = UDim2.fromScale
                            v246 = if const hum = a244.hum then not (0 < hum.MaxHealth) and 0
                                or math.clamp(hum.Health / hum.MaxHealth, 0, 1) else 1
                            fill.Size = udim2FromScale(v246, 1)
                        end

                        local wasAlive = a244.hum == nil or 0 < a244.hum.Health

                        if wasAlive ~= a244.wasAlive then
                            a244.wasAlive = wasAlive
                            refreshActive()
                        end
                    end
                )
            )

            if a244.flat then
                local v251
                local fill = a244.flat.fill
                local udim2FromScale = UDim2.fromScale
                v251 = if const hum2 = a244.hum then not (0 < hum2.MaxHealth) and 0
                    or math.clamp(hum2.Health / hum2.MaxHealth, 0, 1) else 1
                fill.Size = udim2FromScale(v251, 1)
            end

            local wasAlive = alive(a244)

            if wasAlive ~= a244.wasAlive then
                a244.wasAlive = wasAlive
                refreshActive()
            end
        end

        local v256 = false

        local function attach(model)
            --[[
              name: attach
              line: 765
              upvalues:
                v21 (copy, index: 1)
                localPlayer (copy, index: 2)
                v256 (ref,  index: 3)
                roleOf (copy, index: 4)
                hookHumanoid (copy, index: 5)
                paint (copy, index: 6)
                paintArmor (copy, index: 7)
                detach (copy, index: 8)
            ]]
            if not v21[model] then
                if model ~= localPlayer.Character or v256 then
                    local head
                    local v260 = {head = nil, bb = nil, bbName = nil, bbRank = nil, queueBB = nil, flat = nil, hum = nil, visibleLOS = false, wasAlive = true, listed = false, smoked = false, outline = nil, sx = 0, sy = 0, dist = 0, onScreen = false, model = model, conns = {}, role = roleOf(model)}
                    v21[model] = v260

                    if const humanoid = model:FindFirstChildOfClass("Humanoid") then
                        hookHumanoid(v260, humanoid)
                    end

                    table.insert(
                        v260.conns,
                        model.ChildAdded:Connect(
                            function(hum)
                                --[[
                                  line: 795
                                  upvalues:
                                    v260 (copy, index: 1)
                                    paint (copy, index: 2)
                                    hookHumanoid (copy, index: 3)
                                ]]
                                if hum.Name ~= "Head" then
                                    if hum:IsA("Humanoid") and not v260.hum then
                                        hookHumanoid(v260, hum)
                                    end

                                    return
                                end

                                local v263 = v260
                                local head = v263.model:FindFirstChild("Head")
                                v263.head = if head and head:IsA("BasePart") then head else nil
                                paint(v263)
                            end
                        )
                    )

                    table.insert(
                        v260.conns,
                        model.ChildRemoved:Connect(
                            function(a265)
                                --[[
                                  line: 802
                                  upvalues:
                                    v260 (copy, index: 1)
                                    paint (copy, index: 2)
                                ]]
                                if a265.Name == "Head" then
                                    local v266 = v260
                                    local head = v266.model:FindFirstChild("Head")
                                    v266.head = if head and head:IsA("BasePart") then head else nil
                                    paint(v266)
                                end
                            end
                        )
                    )

                    table.insert(
                        v260.conns,
                        model.AttributeChanged:Connect(
                            function(a268)
                                --[[
                                  line: 807
                                  upvalues:
                                    v260 (copy, index: 1)
                                    roleOf (copy, index: 2)
                                    model (copy, index: 3)
                                    paint (copy, index: 4)
                                ]]
                                if a268 == "Team" or a268 == "MatchId" or a268 == "DisplayName" or a268 == "Level" then
                                    v260.role = roleOf(model)
                                    paint(v260)
                                end
                            end
                        )
                    )

                    table.insert(
                        v260.conns,
                        model:GetAttributeChangedSignal("Armor"):Connect(
                            function()
                                --[[
                                  line: 813
                                  upvalues:
                                    paintArmor (copy, index: 1)
                                    v260 (copy, index: 2)
                                ]]
                                paintArmor(v260)
                            end
                        )
                    )
                    table.insert(
                        v260.conns,
                        model:GetAttributeChangedSignal("MaxArmor"):Connect(
                            function()
                                --[[
                                  line: 816
                                  upvalues:
                                    paintArmor (copy, index: 1)
                                    v260 (copy, index: 2)
                                ]]
                                paintArmor(v260)
                            end
                        )
                    )

                    table.insert(
                        v260.conns,
                        model.AncestryChanged:Connect(
                            function(a269, a270)
                                --[[
                                  line: 819
                                  upvalues:
                                    detach (copy, index: 1)
                                    model (copy, index: 2)
                                ]]
                                if not a270 then
                                    detach(model)
                                end
                            end
                        )
                    )

                    local head2 = v260.model:FindFirstChild("Head")

                    if not head2 or not head2:IsA("BasePart") then
                        head = nil
                        v260.head = head
                        paint(v260)

                        return
                    end

                    head = head2
                    v260.head = head
                    paint(v260)
                end
            end
        end

        local function watchPlayer(player: Player?)
            --[[
              name: watchPlayer
              line: 828
              upvalues:
                localPlayer (copy, index: 1)
                v256 (ref,  index: 2)
                detach (copy, index: 3)
                workspace (copy, index: 4)
                attach (copy, index: 5)
                v21 (copy, index: 6)
                roleOf (copy, index: 7)
                paint (copy, index: 8)
                paintQueue (copy, index: 9)
                lobbyName (copy, index: 10)
                paintRank (copy, index: 11)
            ]]
            if player == localPlayer and not v256 then
                return
            end

            local character = nil
            local v275 = nil

            local function setChar(character2)
                --[[
                  name: setChar
                  line: 834
                  upvalues:
                    character (ref,  index: 1)
                    detach (copy, index: 2)
                    v275 (ref,  index: 3)
                    workspace (copy, index: 4)
                    attach (copy, index: 5)
                ]]
                if character ~= character2 then
                    if character then
                        detach(character)
                    end

                    if v275 then
                        v275:Disconnect()
                        v275 = nil
                    end

                    character = character2

                    if character2 then
                        v275 = character2.AncestryChanged:Connect(
                            function()
                                --[[
                                  line: 849
                                  upvalues:
                                    character (ref,  index: 1)
                                    character2 (copy, index: 2)
                                    workspace (copy, index: 3)
                                    attach (copy, index: 4)
                                ]]
                                if character == character2 and character2:IsDescendantOf(workspace) then
                                    attach(character2)
                                end
                            end
                        )
                    end
                end

                if character2 and character2:IsDescendantOf(workspace) then
                    attach(character2)
                end
            end

            player.CharacterAdded:Connect(setChar)

            player.CharacterRemoving:Connect(
                function(character2: Model)
                    --[[
                      line: 861
                      upvalues:
                        character (ref,  index: 1)
                        detach (copy, index: 2)
                        v275 (ref,  index: 3)
                    ]]
                    if character2 ~= character then
                        detach(character2)
                    elseif character ~= nil then
                        if character then
                            detach(character)
                        end

                        if v275 then
                            v275:Disconnect()
                            v275 = nil
                        end

                        character = nil
                    end
                end
            )

            player:GetPropertyChangedSignal("Character"):Connect(
                function()
                    --[[
                      line: 868
                      upvalues:
                        setChar (copy, index: 1)
                        player (copy, index: 2)
                    ]]
                    setChar(player.Character)
                end
            )

            player:GetAttributeChangedSignal("Team"):Connect(
                function()
                    --[[
                      line: 871
                      upvalues:
                        player (copy, index: 1)
                        v21 (copy, index: 2)
                        roleOf (copy, index: 3)
                        paint (copy, index: 4)
                    ]]
                    local character = player.Character

                    if const v280 = character and v21[character] then
                        v280.role = roleOf(character)
                        paint(v280)
                    end
                end
            )

            for _, attribute in {"Queued", "QueueFound"} do
                player:GetAttributeChangedSignal(attribute):Connect(
                    function()
                        --[[
                          line: 880
                          upvalues:
                            player (copy, index: 1)
                            v21 (copy, index: 2)
                            paintQueue (copy, index: 3)
                        ]]
                        local v283 = player.Character
                        v283 = v283 and v21[v283]

                        if v283 then
                            paintQueue(v283)
                        end
                    end
                )
            end

            player:GetAttributeChangedSignal("Streak"):Connect(
                function()
                    --[[
                      line: 888
                      upvalues:
                        player (copy, index: 1)
                        v21 (copy, index: 2)
                        lobbyName (copy, index: 3)
                    ]]
                    local v284 = player.Character
                    v284 = v284 and v21[v284]

                    if v284 and v284.bbName then
                        v284.bbName.Text = lobbyName(v284)
                    end
                end
            )

            player:GetAttributeChangedSignal("Trophies"):Connect(
                function()
                    --[[
                      line: 895
                      upvalues:
                        player (copy, index: 1)
                        v21 (copy, index: 2)
                        paintRank (copy, index: 3)
                    ]]
                    local v285 = player.Character
                    v285 = v285 and v21[v285]

                    if v285 then
                        paintRank(v285)
                    end
                end
            )

            player:GetAttributeChangedSignal("TribeTag"):Connect(
                function()
                    --[[
                      line: 904
                      upvalues:
                        player (copy, index: 1)
                        v21 (copy, index: 2)
                        paint (copy, index: 3)
                    ]]
                    local v286 = player.Character
                    v286 = v286 and v21[v286]

                    if v286 then
                        paint(v286)
                    end
                end
            )

            player:GetAttributeChangedSignal("Level"):Connect(
                function()
                    --[[
                      line: 911
                      upvalues:
                        player (copy, index: 1)
                        v21 (copy, index: 2)
                        paint (copy, index: 3)
                    ]]
                    local v287 = player.Character
                    v287 = v287 and v21[v287]

                    if v287 then
                        paint(v287)
                    end
                end
            )

            setChar(player.Character)
        end

        for _, player in players:GetPlayers() do
            watchPlayer(player)
        end

        players.PlayerAdded:Connect(watchPlayer)
        local ui2 = nil
        local ui3 = nil
        local v292 = nil

        local function cameraModule()
            --[[
              name: cameraModule
              line: 932
              upvalues:
                v292 (ref, index: 1)
            ]]
            if v292 == nil then
                local success, Camera = pcall(
                    function()
                        --[[
                          line: 934
                        ]]
                        return (require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Camera")))
                    end
                )

                if not success or type(Camera) ~= "table" then
                    v292 = false
                else
                    v292 = Camera
                end
            end

            return v292 or nil
        end

        local function drawnPart(a297)
            --[[
              name: drawnPart
              line: 941
              upvalues:
                v292 (ref, index: 1)
            ]]
            if v292 == nil then
                local success, Camera = pcall(
                    function()
                        --[[
                          line: 934
                        ]]
                        return (require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Camera")))
                    end
                )

                if not success or type(Camera) ~= "table" then
                    v292 = false
                else
                    v292 = Camera
                end
            end

            local v300 = v292 or nil

            if v300 and type(v300.Drawn) == "function" then
                local success, result = pcall(v300.Drawn, a297)

                if success and typeof(result) == "Instance" then
                    return result
                end
            end

            return a297
        end

        local function paintSelf()
            --[[
              name: paintSelf
              line: 951
              upvalues:
                localPlayer (copy, index: 1)
                state (copy, index: 2)
                a9 (copy, index: 3)
                v256 (ref,  index: 4)
                ui2 (ref,  index: 5)
                ui (copy, index: 6)
                parent (copy, index: 7)
                fonts (copy, index: 8)
                colors (copy, index: 9)
                ui3 (ref,  index: 10)
                v292 (ref,  index: 11)
            ]]
            local streak = localPlayer:GetAttribute("Streak")
            local character = localPlayer.Character
            local head = character and character:FindFirstChild("Head")

            if type(streak) ~= "number"
                or not (2 <= streak)
                or head == nil
                or state.SeesMatch()
                or a9.HudHidden
                or v256
            then
                if ui2 then
                    ui2.Enabled = false
                end

                return
            end

            local v307

            if not ui2 then
                local parent2 = ui.new("BillboardGui", {Name = "MyStreak", StudsOffsetWorldSpace = Vector3.new(0, 1.899999976158142, 0), LightInfluence = 0, AlwaysOnTop = false, MaxDistance = 90, ResetOnSpawn = false, Active = false, Size = UDim2.new(2.2, 40, 0.6, 12), Parent = parent})
                local parent3 = ui.new("TextLabel", {Name = "Streak", Text = "", TextScaled = true, Size = UDim2.fromScale(1, 1), FontFace = fonts.Heavy, TextColor3 = Color3.fromRGB(255, 162, 74), Parent = parent2})
                ui.new("UITextSizeConstraint", {MaxTextSize = 22, MinTextSize = 10, Parent = parent3})
                ui.TextStroke(colors.Void, 1.6, 0.15).Parent = parent3
                ui2 = parent2
                ui3 = parent3
            end

            local ui4 = ui2

            if v292 == nil then
                local success, Camera = pcall(
                    function()
                        --[[
                          line: 934
                        ]]
                        return (require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Camera")))
                    end
                )

                if not success or type(Camera) ~= "table" then
                    v292 = false
                else
                    v292 = Camera
                end
            end

            local v313 = v292 or nil

            if not v313 or type(v313.Drawn) ~= "function" then
                v307 = head
            else
                local success, result = pcall(v313.Drawn, head)

                if not success or typeof(result) ~= "Instance" then
                    v307 = head
                else
                    v307 = result
                end
            end

            ui4.Adornee = v307
            ui3.Text = string.format("🔥 %d", (math.floor(streak)))
            ui4.Enabled = true
        end

        localPlayer:GetAttributeChangedSignal("Streak"):Connect(paintSelf)

        task.spawn(
            function()
                --[[
                  line: 996
                  upvalues:
                    v292 (ref,  index: 1)
                    paintSelf (copy, index: 2)
                ]]
                if v292 == nil then
                    local success, Camera = pcall(
                        function()
                            --[[
                              line: 934
                            ]]
                            return (require(game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Camera")))
                        end
                    )

                    if not success or type(Camera) ~= "table" then
                        v292 = false
                    else
                        v292 = Camera
                    end
                end

                local v318 = v292 or nil
                v318 = v318 and v318.DrawnChanged

                if v318 then
                    v318:Connect(
                        function()
                            --[[
                              line: 1000
                              upvalues:
                                paintSelf (copy, index: 1)
                            ]]
                            task.defer(paintSelf)
                        end
                    )
                end
            end
        )

        localPlayer.CharacterAdded:Connect(
            function(character: Model)
                --[[
                  line: 1005
                  upvalues:
                    paintSelf (copy, index: 1)
                ]]
                character:WaitForChild("Head", 10)
                paintSelf()
            end
        )

        state.PlayerStateChanged:Connect(paintSelf)
        a9.HudHiddenChanged:Connect(paintSelf)
        task.defer(paintSelf)

        for _, tag in {"Combatant", "Bot"} do
            for _, character in collectionService:GetTagged(tag) do
                if character:IsA("Model") and not players:GetPlayerFromCharacter(character) then
                    attach(character)
                end
            end

            collectionService:GetInstanceAddedSignal(tag):Connect(
                function(character)
                    --[[
                      name: addFighter
                      line: 1014
                      upvalues:
                        players (copy, index: 1)
                        attach (copy, index: 2)
                    ]]
                    if character:IsA("Model") and not players:GetPlayerFromCharacter(character) then
                        attach(character)
                    end
                end
            )

            collectionService:GetInstanceRemovedSignal(tag):Connect(
                function(character)
                    --[[
                      line: 1024
                      upvalues:
                        collectionService (copy, index: 1)
                        players (copy, index: 2)
                        detach (copy, index: 3)
                    ]]
                    if character:IsA("Model") then
                        local hasTag = collectionService:HasTag(character, "Combatant")
                            or collectionService:HasTag(character, "Bot")

                        if not hasTag and not players:GetPlayerFromCharacter(character) then
                            detach(character)
                        end
                    end
                end
            )
        end

        local function repaintAll()
            --[[
              name: repaintAll
              line: 1032
              upvalues:
                v21 (copy, index: 1)
                roleOf (copy, index: 2)
                paint (copy, index: 3)
            ]]
            for character, v329 in v21 do
                v329.role = roleOf(character)
                paint(v329)
            end
        end

        state.PlayerStateChanged:Connect(repaintAll)
        state.WatchChanged:Connect(repaintAll)

        state.AttrChanged:Connect(
            function(a330)
                --[[
                  line: 1040
                  upvalues:
                    repaintAll (copy, index: 1)
                ]]
                if a330 == "Team" or a330 == "MatchId" then
                    repaintAll()
                end
            end
        )

        state.MatchChanged:Connect(
            function()
                --[[
                  line: 1045
                  upvalues:
                    v21 (copy, index: 1)
                    roleOf (copy, index: 2)
                    paint (copy, index: 3)
                ]]
                for character, v332 in v21 do
                    local role = roleOf(character)

                    if role ~= v332.role then
                        v332.role = role
                        paint(v332)
                    end
                end
            end
        )

        a9.HudHiddenChanged:Connect(
            function()
                --[[
                  line: 1054
                  upvalues:
                    v21 (copy, index: 1)
                    a9 (copy, index: 2)
                    paintQueue (copy, index: 3)
                ]]
                for _, v335 in v21 do
                    if v335.flat and a9.HudHidden then
                        v335.flat.frame.Visible = false
                    end

                    if v335.bb then
                        v335.bb.Enabled = v335.role == "lobby" and v335.head ~= nil and not a9.HudHidden
                    end

                    paintQueue(v335)
                end
            end
        )

        local filterDescendantsInstances = {}
        local v337 = 0

        ui.Every(
            parent,
            0.2,
            function()
                --[[
                  line: 1069
                  upvalues:
                    v337 (ref,  index: 1)
                    players (copy, index: 2)
                    localPlayer (copy, index: 3)
                    v256 (ref,  index: 4)
                    v21 (copy, index: 5)
                    workspace (copy, index: 6)
                    attach (copy, index: 7)
                    state (copy, index: 8)
                    filterDescendantsInstances (copy, index: 9)
                    raycastParams (copy, index: 10)
                    Combat (copy, index: 11)
                    setFaded (copy, index: 12)
                    v147 (copy, index: 13)
                    refreshActive (copy, index: 14)
                    alive (copy, index: 15)
                ]]
                local timestamp = os.clock()

                if v337 <= timestamp then
                    v337 = timestamp + 1

                    for _, player in players:GetPlayers() do
                        if const character = player.Character then
                            if player == localPlayer and not v256 then
                                continue
                            end

                            if not v21[character] and character:IsDescendantOf(workspace) then
                                attach(character)
                            end
                        end
                    end
                end

                if not state.SeesMatch() then
                    return
                end

                local camera = workspace.CurrentCamera
                if not camera then
                    return
                end

                local position = camera.CFrame.Position
                local head = localPlayer.Character and localPlayer.Character:FindFirstChild("Head")
                local v345 = if head and head:IsA("BasePart") and not state.Watching() then head.Position else nil
                local v346 = false

                for v347, v348 in v21 do
                    if v348.role == "enemy" or v348.role == "ally" then
                        local v349
                        local visibleLos = false
                        local smoked = false
                        local head2 = v348.head
                        local v353 = v348.role ~= "enemy" and 450 or 200

                        if head2 and alive(v348) then
                            local direction = head2.Position - position

                            if direction.Magnitude <= v353 then
                                table.clear(filterDescendantsInstances)
                                table.insert(filterDescendantsInstances, v347)

                                if localPlayer.Character then
                                    table.insert(filterDescendantsInstances, localPlayer.Character)
                                end

                                if const fx = workspace:FindFirstChild("FX") then
                                    table.insert(filterDescendantsInstances, fx)
                                end

                                if const projectiles = workspace:FindFirstChild("Projectiles") then
                                    table.insert(filterDescendantsInstances, projectiles)
                                end

                                raycastParams.FilterDescendantsInstances = filterDescendantsInstances
                                visibleLos = workspace:Raycast(position, direction, raycastParams) == nil
                            end

                            if v348.role == "enemy" then
                                smoked = Combat.SmokeBlocks(position, head2.Position)
                                    or v345 ~= nil and Combat.SmokeBlocks(v345, head2.Position)
                                visibleLos = visibleLos and not smoked
                            end
                        end

                        if smoked ~= v348.smoked then
                            v348.smoked = smoked
                            v346 = true
                        end

                        if v348.role == "ally" and v348.flat then
                            setFaded(v348.flat, not visibleLos)
                            v349 = v346
                        else
                            v349 = visibleLos ~= v348.visibleLOS or v346
                        end

                        v348.visibleLOS = visibleLos
                        v346 = v349
                    end

                    local v357 = v348.head ~= nil
                        and alive(v348)
                        and (v348.role == "ally" or v348.role == "enemy" and v348.visibleLOS)

                    if v357 == v348.listed or v357 and not (#v147 < 12) then
                        local v358 = v348.outline ~= nil
                        local v359 = false

                        if v348.role == "enemy" then
                            local v360 = alive(v348)
                            v359 = v360 and v348.head ~= nil and not v348.smoked
                        end

                        if v358 ~= v359 then
                            v346 = true
                        end
                    else
                        v346 = true
                    end
                end

                if v346 then
                    refreshActive()
                end
            end
        )

        a9.Debug.plateSelf = function(a361)
            --[[
              line: 1148
              upvalues:
                v256 (ref,  index: 1)
                localPlayer (copy, index: 2)
                watchPlayer (copy, index: 3)
                v21 (copy, index: 4)
                detach (copy, index: 5)
                paintSelf (copy, index: 6)
            ]]
            v256 = a361 == true
            local character = localPlayer.Character

            if v256 then
                watchPlayer(localPlayer)
            elseif character and v21[character] then
                detach(character)
            end

            paintSelf()

            return true
        end

        a9.Debug.plates = function()
            --[[
              line: 1160
              upvalues:
                v147 (copy, index: 1)
                v21 (copy, index: 2)
                players (copy, index: 3)
                renderSteppedConnection (ref,  index: 4)
                a9 (copy, index: 5)
                alive (copy, index: 6)
            ]]
            local v363 = {}

            for _, v365 in v147 do
                v363[v365] = true
            end

            local plates = {}

            for character, v368 in v21 do
                local v369 = {}
                local v370 = character:GetAttribute("DisplayName")

                if type(v370) ~= "string" or v370 == "" then
                    v370 = if const player = players:GetPlayerFromCharacter(character) then player.DisplayName else character.Name
                end

                v369.name = v370
                v369.role = v368.role
                v369.head = v368.head ~= nil
                local alive2 = alive(v368)
                v369.alive = alive2
                v369.hp = not v368.hum and -1 or math.floor(v368.hum.Health)
                v369.los = v368.visibleLOS
                v369.smoked = v368.smoked
                v369.active = v363[v368] == true
                v369.visible = v368.flat ~= nil and v368.flat.frame.Visible
                v369.onScreen = v368.onScreen
                v369.parent = not character.Parent and "nil" or character.Parent.Name
                table.insert(plates, v369)
            end

            local v373 = {plates = plates}
            local render = renderSteppedConnection ~= nil
            v373.render = render
            v373.hudHidden = a9.HudHidden == true

            return v373
        end
    end)
}