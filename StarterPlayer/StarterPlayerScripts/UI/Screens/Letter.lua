local guiService = game:GetService("GuiService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local starterGui = game:GetService("StarterGui")
local textChatService = game:GetService("TextChatService")
local Letters = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Letters"))
local v8 = {}
local startValue = Color3.fromRGB(240, 228, 200)
local targetValue = Color3.fromRGB(222, 202, 162)
local targetValue2 = Color3.fromRGB(46, 34, 26)
local fontFace = Font.fromEnum(Enum.Font.PatrickHand)
local v13 = Letters.Current()
local v14 = {heading = v13.heading, body = v13.body, signature = v13.signature}
local author = v13.author
local startValue2 = Color3.fromRGB(226, 208, 170)
local color3 = Color3.fromRGB(216, 196, 154)
local interpolatedValue = startValue2:Lerp(targetValue2, 0.3)
local color32 = Color3.fromRGB(66, 50, 38)
local color33 = Color3.fromRGB(80, 62, 47)
local color34 = Color3.fromRGB(212, 158, 70)
local color35 = Color3.fromRGB(246, 234, 208)
local v23 = nil

local function hideChat()
    --[[
      name: hideChat
      line: 58
      upvalues:
        v23 (ref,  index: 1)
        textChatService (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    if v23 then
        return
    end

    local v25 = {}

    pcall(
        function()
            --[[
              line: 63
              upvalues:
                textChatService (copy, index: 1)
                v25 (copy, index: 2)
                starterGui (copy, index: 3)
            ]]
            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatWindowConfiguration then
                v25.window = chatWindowConfiguration.Enabled
                chatWindowConfiguration.Enabled = false
            end

            if chatInputBarConfiguration then
                v25.bar = chatInputBarConfiguration.Enabled
                chatInputBarConfiguration.Enabled = false
            end

            v25.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
            starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        end
    )

    v23 = v25
end

local function restoreChat()
    --[[
      name: restoreChat
      line: 79
      upvalues:
        v23 (ref,  index: 1)
        textChatService (copy, index: 2)
        starterGui (copy, index: 3)
    ]]
    local v29 = v23
    if not v29 then
        return
    end

    v23 = nil

    pcall(
        function()
            --[[
              line: 85
              upvalues:
                textChatService (copy, index: 1)
                v29 (copy, index: 2)
                starterGui (copy, index: 3)
            ]]
            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if chatWindowConfiguration and v29.window ~= nil then
                chatWindowConfiguration.Enabled = v29.window
            end

            if chatInputBarConfiguration and v29.bar ~= nil then
                chatInputBarConfiguration.Enabled = v29.bar
            end

            if v29.core ~= nil then
                starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v29.core)
            end
        end
    )
end

function v8.Init(a32)
    --[[
      name: Init
      line: 100
      upvalues:
        targetValue (copy, index: 1)
        startValue (copy, index: 2)
        fontFace (copy, index: 3)
        targetValue2 (copy, index: 4)
        v14 (copy, index: 5)
        players (copy, index: 6)
        author (copy, index: 7)
        v13 (copy, index: 8)
        startValue2 (copy, index: 9)
        interpolatedValue (copy, index: 10)
        replicatedStorage (copy, index: 11)
        color33 (ref,  index: 12)
        color32 (ref,  index: 13)
        color3 (copy, index: 14)
        color34 (ref,  index: 15)
        color35 (ref,  index: 16)
        runService (copy, index: 17)
        guiService (copy, index: 18)
        v23 (ref,  index: 19)
        textChatService (copy, index: 20)
        starterGui (copy, index: 21)
    ]]
    local ui = a32.UI
    local colors = a32.Theme.Colors
    local parent = ui.new("Frame", {Name = "Letter", Visible = false, Size = UDim2.fromScale(1, 1), Parent = a32.Canvas.Menus})
    local newUi = ui.new
    local v37 = {Name = "Outside", BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Selectable = false, Size = UDim2.fromScale(1, 1), Parent = parent}
    newUi("TextButton", v37).Activated:Connect(
        function()
            --[[
              line: 115
              upvalues:
                a32 (copy, index: 1)
            ]]
            a32.MenuManager.Close("Letter")
        end
    )
    local parent2 = ui.new("Frame", {Name = "Sheet", Rotation = -0.8, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromOffset(640, 420), Parent = parent})
    ui.new("Frame", {Name = "Shadow", Position = UDim2.fromOffset(10, 14), Size = UDim2.fromScale(1, 1), BackgroundColor3 = colors.Void, BackgroundTransparency = 0.55, (ui.Corner(UDim.new(0, 10))), Parent = parent2})
    local parent3 = ui.new("TextButton", {Name = "Paper", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), Text = "", AutoButtonColor = false, Selectable = false, ui.Corner(UDim.new(0, 10)), (ui.Stroke(targetValue, 2, 0.1)), Parent = parent2})
    ui.new("UIGradient", {Rotation = 70, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, startValue), ColorSequenceKeypoint.new(0.7, startValue:Lerp(targetValue, 0.25)), ColorSequenceKeypoint.new(1, targetValue)}), Parent = parent3})
    parent3.Activated:Connect(function()
        --[[
          line: 158
        ]]
    end)
    local parent4 = ui.new("Frame", {Name = "Body", Size = UDim2.fromScale(1, 1), (ui.Padding(40, 46, 30, 46)), Parent = parent3})
    ui.new("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 18), Parent = parent4})

    local function line(name, text, textSize: number, layoutOrder)
        --[[
          name: line
          line: 167
          upvalues:
            ui (copy, index: 1)
            fontFace (copy, index: 2)
            targetValue2 (copy, index: 3)
            parent4 (copy, index: 4)
        ]]
        return ui.new("TextLabel", {TextWrapped = true, Name = name, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Text = text, FontFace = fontFace, TextSize = textSize, TextColor3 = targetValue2, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = layoutOrder, Parent = parent4})
    end

    line("Heading", v14.heading, 52, 1)

    for v46, text in v14.body do
        line("Para" .. v46, text, 34, 1 + v46)
    end

    local parent5 = ui.new("Frame", {Name = "Signature", LayoutOrder = 10, Size = UDim2.new(1, 0, 0, 72), Parent = parent4})
    local parent6 = ui.new("Frame", {Name = "Sign", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromOffset(0, 72), AutomaticSize = Enum.AutomaticSize.X, Parent = parent5})
    ui.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder, Parent = parent6})
    ui.new("TextLabel", {Name = "Name", TextSize = 46, LayoutOrder = 1, Size = UDim2.fromOffset(0, 60), AutomaticSize = Enum.AutomaticSize.X, Text = v14.signature, FontFace = fontFace, TextColor3 = targetValue2, Parent = parent6})
    local ui2 = ui.new("ImageLabel", {Name = "Headshot", Size = UDim2.fromOffset(68, 68), BackgroundColor3 = targetValue, Image = "", LayoutOrder = 2, ui.Corner(UDim.new(1, 0)), (ui.Stroke(targetValue2, 2, 0.35)), Parent = parent6})

    task.spawn(
        function()
            --[[
              line: 230
              upvalues:
                players (copy, index: 1)
                author (copy, index: 2)
                ui2 (copy, index: 3)
            ]]
            local success, image = pcall(
                function()
                    --[[
                      line: 231
                      upvalues:
                        players (copy, index: 1)
                        author (copy, index: 2)
                    ]]
                    return players:GetUserThumbnailAsync(author, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
                end
            )

            if success and type(image) == "string" then
                ui2.Image = image
            end
        end
    )

    local remotes = a32.Remotes
    local state = a32.State
    local v55 = v13.id
    local reactions = v13.reactions ~= false
    local parent7 = ui.new("TextButton", {Name = "Reaction", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -8, 0.5, 0), Size = UDim2.fromOffset(0, 72), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Visible = reactions, (ui.Padding(0, 8, 0, 8)), Parent = parent5})
    ui.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Parent = parent7})
    local parent8 = ui.new("Frame", {Name = "Pill", Size = UDim2.fromOffset(0, 54), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = startValue2, (ui.Corner(UDim.new(1, 0))), Parent = parent7})
    local v59 = ui.Stroke(interpolatedValue, 1.5, 0)
    v59.Parent = parent8

    local v60 = ui.Padding(0, 18, 0, 14)
    v60.Parent = parent8
    ui.new("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = parent8})
    local scaleObj = ui.GetScaleObj(parent8, "HoverScale")
    local ui3 = ui.new("TextLabel", {Name = "Icon", Text = "👍", TextSize = 34, LayoutOrder = 1, Size = UDim2.fromOffset(38, 38), TextColor3 = targetValue2, Parent = parent8})
    local scaleObj2 = ui.GetScaleObj(ui3, "PopScale")
    local ui4 = ui.new("TextLabel", {Name = "Count", Text = "", TextSize = 27, LayoutOrder = 2, Visible = false, Size = UDim2.fromOffset(0, 34), AutomaticSize = Enum.AutomaticSize.X, FontFace = a32.Theme.Fonts.Bold, TextColor3 = targetValue2, Parent = parent8})
    local v65 = nil
    local reacted = false
    local inflight = false
    local timestamp = -math.huge
    local v69 = false
    local v70 = false
    local instance = nil
    local v72 = {}
    local v73 = nil

    local function valueObj()
        --[[
          name: valueObj
          line: 322
          upvalues:
            instance (ref,  index: 1)
            replicatedStorage (copy, index: 2)
            v55 (copy, index: 3)
            v72 (ref,  index: 4)
            v73 (ref,  index: 5)
        ]]
        if instance and instance.Parent then
            return instance
        end

        local instance2 = replicatedStorage:FindFirstChild("LetterReactions")
        instance2 = instance2 and instance2:FindFirstChild(v55)

        if instance2 and instance2:IsA("IntValue") and instance2 ~= instance then
            instance = instance2

            for _, v77 in v72 do
                v77:Disconnect()
            end

            v72 = {
                instance2.Changed:Connect(
                    function()
                        --[[
                          line: 334
                          upvalues:
                            v73 (ref, index: 1)
                        ]]
                        v73()
                    end
                ),
                instance2:GetAttributeChangedSignal("Ready"):Connect(
                    function()
                        --[[
                          line: 337
                          upvalues:
                            v73 (ref, index: 1)
                        ]]
                        v73()
                    end
                )
            }
        end

        if instance and instance.Parent then
            return instance
        end

        return nil
    end

    local function profileReacted()
        --[[
          name: profileReacted
          line: 345
          upvalues:
            state (copy, index: 1)
            v55 (copy, index: 2)
        ]]
        local reactions = state.Profile and state.Profile.reactions
        return type(reactions) == "table" and reactions[v55] == true
    end

    local function shownCount()
        --[[
          name: shownCount
          line: 351
          upvalues:
            valueObj (copy, index: 1)
            v65 (ref,  index: 2)
            reacted (ref,  index: 3)
        ]]
        local instance = valueObj()
        local v82 = not instance and 0 or instance.Value
        local ready = instance ~= nil and instance:GetAttribute("Ready") == true

        if v65 ~= nil and reacted ~= v65 then
            local v84 = reacted and 1 or -1
            v82 += v84
        end

        return math.max(0, v82), ready
    end

    local function formatCount(a86)
        --[[
          name: formatCount
          line: 361
          upvalues:
            ui (copy, index: 1)
        ]]
        if 1e+05 <= a86 then
            return (ui.FormatCompact(a86))
        end

        return (ui.FormatNumber(a86))
    end

    v73 = function()
        --[[
          line: 365
          upvalues:
            valueObj (copy, index: 1)
            v65 (ref,  index: 2)
            reacted (ref,  index: 3)
            ui4 (copy, index: 4)
            ui (copy, index: 5)
            v60 (copy, index: 6)
            parent8 (copy, index: 7)
            v70 (ref,  index: 8)
            color33 (ref,  index: 9)
            color32 (ref,  index: 10)
            color3 (copy, index: 11)
            startValue2 (copy, index: 12)
            v59 (copy, index: 13)
            color34 (ref,  index: 14)
            interpolatedValue (copy, index: 15)
            color35 (ref,  index: 16)
            targetValue2 (copy, index: 17)
        ]]
        local backgroundColor3
        local instance = valueObj()
        local v89 = not instance and 0 or instance.Value
        local ready = instance ~= nil and instance:GetAttribute("Ready") == true

        if v65 ~= nil and reacted ~= v65 then
            local v91 = reacted and 1 or -1
            v89 += v91
        end

        local v92 = math.max(0, v89)
        local visible = ready and 0 < v92
        ui4.Text = if 1e+05 <= v92 then ui.FormatCompact(v92) else ui.FormatNumber(v92)
        ui4.Visible = visible
        local newUDim = UDim.new
        local v95 = visible and 18 or 14
        v60.PaddingRight = newUDim(0, v95)
        local v96 = reacted

        if v96 then
            backgroundColor3 = if v70 then color33 else color32
        else
            backgroundColor3 = if v70 then color3 else startValue2
        end

        parent8.BackgroundColor3 = backgroundColor3
        v59.Color = if v96 then color34 else interpolatedValue
        v59.Thickness = v96 and 2 or 1.5
        ui4.TextColor3 = if v96 then color35 else targetValue2
    end

    local v97 = nil

    v97 = function()
        --[[
          line: 379
          upvalues:
            inflight (ref,  index: 1)
            reactions (copy, index: 2)
            v65 (ref,  index: 3)
            reacted (ref,  index: 4)
            timestamp (ref,  index: 5)
            v69 (ref,  index: 6)
            v97 (ref,  index: 7)
            remotes (copy, index: 8)
            v55 (copy, index: 9)
            v73 (ref,  index: 10)
        ]]
        if not inflight and reactions and v65 ~= nil and reacted ~= v65 then
            local v98 = timestamp + 0.25 - os.clock()

            if not (0 < v98) then
                inflight = true
                timestamp = os.clock()
                local v99 = reacted

                task.spawn(
                    function()
                        --[[
                          line: 397
                          upvalues:
                            remotes (copy, index: 1)
                            v55 (copy, index: 2)
                            v99 (copy, index: 3)
                            inflight (ref,  index: 4)
                            v65 (ref,  index: 5)
                            reacted (ref,  index: 6)
                            v73 (ref,  index: 7)
                            v97 (ref,  index: 8)
                        ]]
                        local v100, v101, v102 = remotes.Invoke("LetterAction", "React", v55, v99)
                        inflight = false

                        if not v100 or type(v102) ~= "boolean" then
                            if reacted == v99 then
                                reacted = v65
                            end
                        else
                            v65 = v102

                            if v101 ~= true and reacted == v99 then
                                reacted = v102
                            end
                        end

                        v73()
                        v97()
                    end
                )

                return
            end

            if not v69 then
                v69 = true

                task.delay(
                    v98,
                    function()
                        --[[
                          line: 387
                          upvalues:
                            v69 (ref, index: 1)
                            v97 (ref, index: 2)
                        ]]
                        v69 = false
                        v97()
                    end
                )
            end
        end
    end

    local function pop(a104)
        --[[
          name: pop
          line: 413
          upvalues:
            scaleObj2 (copy, index: 1)
            ui (copy, index: 2)
            a32 (copy, index: 3)
            ui4 (copy, index: 4)
        ]]
        if a104 then
            scaleObj2.Scale = 1
            local v105 = {Scale = 1.45}
            ui.Tween(scaleObj2, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v105)

            task.delay(
                0.08,
                function()
                    --[[
                      line: 417
                      upvalues:
                        ui (copy, index: 1)
                        scaleObj2 (copy, index: 2)
                    ]]
                    local v106 = {Scale = 1}
                    ui.Tween(scaleObj2, TweenInfo.new(0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out), v106)
                end
            )
        else
            scaleObj2.Scale = 0.8
            ui.Tween(scaleObj2, a32.Theme.Tween.PopSmall, {Scale = 1})
        end

        if ui4.Visible then
            ui.Bump(ui4, 0.16)
        end
    end

    local function tap()
        --[[
          name: tap
          line: 429
          upvalues:
            reactions (copy, index: 1)
            v65 (ref,  index: 2)
            state (copy, index: 3)
            v55 (copy, index: 4)
            reacted (ref,  index: 5)
            a32 (copy, index: 6)
            v73 (ref,  index: 7)
            pop (copy, index: 8)
            v97 (ref,  index: 9)
        ]]
        if not reactions then
            return
        end

        if v65 == nil then
            local reactions2 = state.Profile and state.Profile.reactions
            v65 = type(reactions2) == "table" and reactions2[v55] == true
            reacted = v65
        end

        reacted = not reacted
        a32.Sounds.Play("Click")
        v73()
        pop(reacted)
        v97()
    end

    parent7.Activated:Connect(tap)

    parent7.MouseEnter:Connect(
        function()
            --[[
              line: 444
              upvalues:
                ui (copy, index: 1)
                v70 (ref,  index: 2)
                scaleObj (copy, index: 3)
                a32 (copy, index: 4)
                v73 (ref,  index: 5)
            ]]
            if ui.Touch then
                return
            end

            v70 = true
            ui.Tween(scaleObj, a32.Theme.Tween.PopSmall, {Scale = 1.05})
            v73()
        end
    )

    parent7.MouseLeave:Connect(
        function()
            --[[
              line: 452
              upvalues:
                v70 (ref,  index: 1)
                ui (copy, index: 2)
                scaleObj (copy, index: 3)
                a32 (copy, index: 4)
                v73 (ref,  index: 5)
            ]]
            v70 = false
            ui.Tween(scaleObj, a32.Theme.Tween.PopSmall, {Scale = 1})
            v73()
        end
    )

    parent7.MouseButton1Down:Connect(
        function()
            --[[
              line: 457
              upvalues:
                ui (copy, index: 1)
                scaleObj (copy, index: 2)
                a32 (copy, index: 3)
            ]]
            ui.Tween(scaleObj, a32.Theme.Tween.Instant, {Scale = 0.93})
        end
    )

    parent7.MouseButton1Up:Connect(
        function()
            --[[
              line: 460
              upvalues:
                ui (copy, index: 1)
                scaleObj (copy, index: 2)
                a32 (copy, index: 3)
                v70 (ref,  index: 4)
            ]]
            local scale
            local tween = ui.Tween
            local popSmall = a32.Theme.Tween.PopSmall
            local v112 = {}

            if v70 then
                scale = 1.05
            else
                scale = 1
            end

            v112.Scale = scale
            tween(scaleObj, popSmall, v112)
        end
    )

    task.spawn(
        function()
            --[[
              line: 464
              upvalues:
                replicatedStorage (copy, index: 1)
                v55 (copy, index: 2)
                v73 (ref,  index: 3)
            ]]
            if const letterReactions = replicatedStorage:WaitForChild("LetterReactions", 30) then
                letterReactions:WaitForChild(v55, 30)
            end

            v73()
        end
    )

    state.ProfileChanged:Connect(
        function()
            --[[
              line: 471
              upvalues:
                inflight (ref,  index: 1)
                reacted (ref,  index: 2)
                v65 (ref,  index: 3)
                state (copy, index: 4)
                v55 (copy, index: 5)
                v73 (ref,  index: 6)
            ]]
            if not inflight and reacted == v65 then
                local reactions = state.Profile and state.Profile.reactions
                v65 = type(reactions) == "table" and reactions[v55] == true
                reacted = v65
                v73()
            end
        end
    )

    if state.HasProfile then
        local reactions2 = state.Profile and state.Profile.reactions
        v65 = type(reactions2) == "table" and reactions2[v55] == true
    else
        v65 = nil
    end

    if v65 == true then
        reacted = true
    else
        reacted = false
    end

    v73()

    local function watch(a117)
        --[[
          name: watch
          line: 484
          upvalues:
            reactions (copy, index: 1)
            remotes (copy, index: 2)
            v55 (copy, index: 3)
            inflight (ref,  index: 4)
            v65 (ref,  index: 5)
            reacted (ref,  index: 6)
            v73 (ref,  index: 7)
        ]]
        if not reactions then
            return
        end

        task.spawn(
            function()
                --[[
                  line: 488
                  upvalues:
                    remotes (copy, index: 1)
                    v55 (copy, index: 2)
                    a117 (copy, index: 3)
                    inflight (ref,  index: 4)
                    v65 (ref,  index: 5)
                    reacted (ref,  index: 6)
                    v73 (ref,  index: 7)
                ]]
                local v118, v119, _, v121 = remotes.Invoke("LetterAction", "Watch", v55, a117)

                if a117
                    and v118
                    and v119 == true
                    and type(v121) == "boolean"
                    and not inflight
                    and (v65 == nil or reacted == v65)
                then
                    v65 = v121
                    reacted = v121
                end

                v73()
            end
        )
    end

    a32.Debug.letter = function(a122, a123)
        --[[
          line: 498
          upvalues:
            reactions (copy, index: 1)
            v65 (ref,  index: 2)
            state (copy, index: 3)
            v55 (copy, index: 4)
            reacted (ref,  index: 5)
            a32 (copy, index: 6)
            v73 (ref,  index: 7)
            pop (copy, index: 8)
            v97 (ref,  index: 9)
            runService (copy, index: 10)
            color32 (ref,  index: 11)
            color33 (ref,  index: 12)
            color34 (ref,  index: 13)
            color35 (ref,  index: 14)
            valueObj (copy, index: 15)
            parent7 (copy, index: 16)
            parent (copy, index: 17)
            inflight (ref,  index: 18)
            ui4 (copy, index: 19)
            ui3 (ref,  index: 20)
            parent8 (copy, index: 21)
            ui (copy, index: 22)
        ]]
        if a122 == "tap" then
            if reactions then
                if v65 == nil then
                    local reactions2 = state.Profile and state.Profile.reactions
                    v65 = type(reactions2) == "table" and reactions2[v55] == true
                    reacted = v65
                end

                reacted = not reacted
                a32.Sounds.Play("Click")
                v73()
                pop(reacted)
                v97()
            end
        elseif a122 == "palette" and runService:IsStudio() and type(a123) == "table" then
            local color3
            local color36
            local color37
            local color38

            local function c(a130, a131)
                --[[
                  name: c
                  line: 503
                ]]
                if type(a130) ~= "table" then
                    return a131
                end

                return (Color3.fromRGB(a130[1], a130[2], a130[3]))
            end

            local on = a123.on
            local color39 = color32

            if type(on) ~= "table" then
                color3 = color39
            else
                color3 = Color3.fromRGB(on[1], on[2], on[3])
            end

            local hover = a123.hover
            local color310 = color33

            if type(hover) ~= "table" then
                color36 = color310
            else
                color36 = Color3.fromRGB(hover[1], hover[2], hover[3])
            end

            color32 = color3
            color33 = color36
            local edge = a123.edge
            local color311 = color34

            if type(edge) ~= "table" then
                color37 = color311
            else
                color37 = Color3.fromRGB(edge[1], edge[2], edge[3])
            end

            local text = a123.text
            local color312 = color35

            if type(text) ~= "table" then
                color38 = color312
            else
                color38 = Color3.fromRGB(text[1], text[2], text[3])
            end

            color34 = color37
            color35 = color38
            v73()
        end

        local instance = valueObj()
        local v141 = {id = v55}
        v141.chip = parent7.Parent ~= nil and parent7.Visible
        v141.visible = parent.Visible
        v141.reacted = reacted
        v141.confirmed = v65 == nil and "unknown" or v65
        v141.inflight = inflight
        v141.text = ui4.Text
        v141.countVisible = ui4.Visible
        v141.value = if instance then instance.Value else false
        local ready = instance ~= nil and instance:GetAttribute("Ready") == true
        v141.ready = ready
        v141.icon = if ui3:IsA("TextLabel") then ui3.Text else ui3.Image
        v141.hit = {parent7.AbsoluteSize.X, parent7.AbsoluteSize.Y}
        v141.pill = {parent8.AbsoluteSize.X, parent8.AbsoluteSize.Y}
        v141.scale = ui.Scale
        v141.centre = {parent7.AbsolutePosition.X + (parent7.AbsoluteSize.X / 2), parent7.AbsolutePosition.Y + (parent7.AbsoluteSize.Y / 2)}

        return v141
    end

    local iconButton = ui.IconButton
    local v144 = {Name = "Close", IconName = "cross", IconScale = 0.4, Transparency = 0.15, Sound = "Close", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 14), Size = UDim2.fromOffset(52, 52), Color = Color3.fromRGB(58, 44, 34), Parent = parent3}
    iconButton(v144).Activated:Connect(
        function()
            --[[
              line: 542
              upvalues:
                a32 (copy, index: 1)
            ]]
            a32.MenuManager.Close("Letter")
        end
    )
    local ceilingValue = 420
    local ui5 = ui.new("UIScale", {Parent = parent2})
    local uiListLayout = parent4:FindFirstChildOfClass("UIListLayout")

    local function barButtonsRight()
        --[[
          name: barButtonsRight
          line: 554
          upvalues:
            ui (copy, index: 1)
            guiService (copy, index: 2)
            a32 (copy, index: 3)
            parent (copy, index: 4)
        ]]
        local v149 = math.max(ui.Scale, 0.01)

        if ui.DebugDevice then
            return (ui.TopInset() - 4) * 4.5
        end

        local success, topbarInset = pcall(
            function()
                --[[
                  line: 561
                  upvalues:
                    guiService (copy, index: 1)
                ]]
                return guiService.TopbarInset
            end
        )
        local button = a32.TopbarSettings and a32.TopbarSettings.Button
        local v154 = if const firstAncestorOfClass = button and button:FindFirstAncestorOfClass("ScreenGui") then firstAncestorOfClass.AbsolutePosition.X - parent.AbsolutePosition.X else 0

        if success and topbarInset and not (topbarInset.Width <= 0) then
            return ((v154 + topbarInset.Min.X) / v149) + 8
        end

        return 0
    end

    local function layout()
        --[[
          name: layout
          line: 572
          upvalues:
            ui (copy, index: 1)
            ui5 (copy, index: 2)
            uiListLayout (copy, index: 3)
            ceilingValue (ref,  index: 4)
            parent2 (copy, index: 5)
            barButtonsRight (copy, index: 6)
            parent7 (copy, index: 7)
        ]]
        local v156
        local v157
        local v158
        local v159 = ui.CanvasSize()
        local v160 = math.max(ui.Scale * ui5.Scale, 0.01)

        if uiListLayout then
            v156 = uiListLayout.AbsoluteContentSize.Y / v160
        else
            v156 = 0
        end

        if 50 < v156 then
            ceilingValue = math.ceil(v156 + 78)
        end

        parent2.Size = UDim2.fromOffset(640, ceilingValue)
        local v161 = math.min(1, (v159.Y - 24) / ceilingValue, (v159.X - 32) / 640)
        local v162 = (v159.X - (v161 * 640)) / 2

        if barButtonsRight() < v162 then
            v157 = 12
        else
            v157 = ui.TopInset()
        end

        local scale = math.min(v161, ((v159.Y - v157) - 12) / ceilingValue)
        ui5.Scale = scale
        local v164 = ceilingValue * scale
        local v165 = math.max(v159.Y / 2, v157 + (v164 / 2))
        parent2.Position = UDim2.fromOffset(v159.X / 2, v165)
        v165 = math.max(ui.Scale * scale, 0.01)
        local udim2FromOffset = UDim2.fromOffset

        if ui.Touch then
            v158 = math.max(72, (math.ceil(46 / v165)))
        else
            v158 = 72
        end

        parent7.Size = udim2FromOffset(0, v158)
    end

    layout()
    ui.LayoutChanged:Connect(layout)
    ui.ScaleChanged:Connect(layout)
    ui.TouchChanged:Connect(layout)

    if uiListLayout then
        local v167 = false
        local absoluteContentSize = uiListLayout.AbsoluteContentSize
        local v169 = 0
        local timestamp2 = 0

        uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
            function()
                --[[
                  line: 606
                  upvalues:
                    v167 (ref,  index: 1)
                    uiListLayout (copy, index: 2)
                    absoluteContentSize (ref,  index: 3)
                    timestamp2 (ref,  index: 4)
                    v169 (ref,  index: 5)
                    layout (copy, index: 6)
                ]]
                if v167 or (uiListLayout.AbsoluteContentSize - absoluteContentSize).Magnitude < 0.5 then
                    return
                end

                local timestamp = os.clock()

                if 0.5 < timestamp - timestamp2 then
                    v169 = 0
                end

                if 6 <= v169 then
                    return
                end

                v169 += 1
                timestamp2 = timestamp
                v167 = true

                task.delay(
                    0,
                    function()
                        --[[
                          line: 620
                          upvalues:
                            v167 (ref,  index: 1)
                            absoluteContentSize (ref,  index: 2)
                            uiListLayout (copy, index: 3)
                            layout (copy, index: 4)
                        ]]
                        v167 = false
                        absoluteContentSize = uiListLayout.AbsoluteContentSize
                        layout()
                    end
                )
            end
        )
    end

    local function hideOthers(a173)
        --[[
          name: hideOthers
          line: 628
          upvalues:
            a32 (copy, index: 1)
            v23 (ref,  index: 2)
            textChatService (copy, index: 3)
            starterGui (copy, index: 4)
        ]]
        a32.SetHudHidden("Letter", a173)

        if a32.TopbarSettings and a32.TopbarSettings.SetHidden then
            a32.TopbarSettings.SetHidden("Letter", a173)
        end

        if a173 then
            if v23 then
                return
            end

            local v174 = {}

            pcall(
                function()
                    --[[
                      line: 63
                      upvalues:
                        textChatService (copy, index: 1)
                        v174 (copy, index: 2)
                        starterGui (copy, index: 3)
                    ]]
                    local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                    local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                    if chatWindowConfiguration then
                        v174.window = chatWindowConfiguration.Enabled
                        chatWindowConfiguration.Enabled = false
                    end

                    if chatInputBarConfiguration then
                        v174.bar = chatInputBarConfiguration.Enabled
                        chatInputBarConfiguration.Enabled = false
                    end

                    v174.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                end
            )

            v23 = v174

            return
        end

        local v177 = v23
        if not v177 then
            return
        end

        v23 = nil

        pcall(
            function()
                --[[
                  line: 85
                  upvalues:
                    textChatService (copy, index: 1)
                    v177 (copy, index: 2)
                    starterGui (copy, index: 3)
                ]]
                local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                if chatWindowConfiguration and v177.window ~= nil then
                    chatWindowConfiguration.Enabled = v177.window
                end

                if chatInputBarConfiguration and v177.bar ~= nil then
                    chatInputBarConfiguration.Enabled = v177.bar
                end

                if v177.core ~= nil then
                    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v177.core)
                end
            end
        )
    end

    local count = 0

    a32.MenuManager.Register(
        "Letter",
        {
            open = (function()
                --[[
                  name: open
                  line: 642
                  upvalues:
                    count (ref,  index: 1)
                    a32 (copy, index: 2)
                    v23 (ref,  index: 3)
                    textChatService (copy, index: 4)
                    starterGui (copy, index: 5)
                    layout (copy, index: 6)
                    parent (copy, index: 7)
                    parent2 (copy, index: 8)
                    ui (copy, index: 9)
                    reactions (copy, index: 10)
                    remotes (copy, index: 11)
                    v55 (copy, index: 12)
                    inflight (ref,  index: 13)
                    v65 (ref,  index: 14)
                    reacted (ref,  index: 15)
                    v73 (ref,  index: 16)
                ]]
                count += 1
                a32.SetHudHidden("Letter", true)

                if a32.TopbarSettings and a32.TopbarSettings.SetHidden then
                    a32.TopbarSettings.SetHidden("Letter", true)
                end

                if not v23 then
                    local v181 = {}

                    pcall(
                        function()
                            --[[
                              line: 63
                              upvalues:
                                textChatService (copy, index: 1)
                                v181 (copy, index: 2)
                                starterGui (copy, index: 3)
                            ]]
                            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                            if chatWindowConfiguration then
                                v181.window = chatWindowConfiguration.Enabled
                                chatWindowConfiguration.Enabled = false
                            end

                            if chatInputBarConfiguration then
                                v181.bar = chatInputBarConfiguration.Enabled
                                chatInputBarConfiguration.Enabled = false
                            end

                            v181.core = starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
                            starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                        end
                    )

                    v23 = v181
                end

                layout()
                parent.Visible = true
                parent2.Rotation = -4
                local position = parent2.Position
                parent2.Position = position + UDim2.fromOffset(0, 40)
                ui.Tween(parent2, TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -0.8, Position = position})
                ui.FadeIn(parent2, TweenInfo.new(0.2))
                a32.Sounds.Play("Open")

                if not reactions then
                    return
                end

                local v185 = true

                task.spawn(
                    function()
                        --[[
                          line: 488
                          upvalues:
                            remotes (copy, index: 1)
                            v55 (copy, index: 2)
                            v185 (copy, index: 3)
                            inflight (ref,  index: 4)
                            v65 (ref,  index: 5)
                            reacted (ref,  index: 6)
                            v73 (ref,  index: 7)
                        ]]
                        local v186, v187, _, v189 = remotes.Invoke("LetterAction", "Watch", v55, v185)

                        if v185
                            and v186
                            and v187 == true
                            and type(v189) == "boolean"
                            and not inflight
                            and (v65 == nil or reacted == v65)
                        then
                            v65 = v189
                            reacted = v189
                        end

                        v73()
                    end
                )
            end),
            close = (function(a190)
                --[[
                  name: close
                  line: 655
                  upvalues:
                    count (ref,  index: 1)
                    a32 (copy, index: 2)
                    v23 (ref,  index: 3)
                    textChatService (copy, index: 4)
                    starterGui (copy, index: 5)
                    reactions (copy, index: 6)
                    remotes (copy, index: 7)
                    v55 (copy, index: 8)
                    inflight (ref,  index: 9)
                    v65 (ref,  index: 10)
                    reacted (ref,  index: 11)
                    v73 (ref,  index: 12)
                    parent (copy, index: 13)
                    ui (copy, index: 14)
                    parent2 (copy, index: 15)
                ]]
                count += 1
                local v191 = count
                a32.SetHudHidden("Letter", false)

                if a32.TopbarSettings and a32.TopbarSettings.SetHidden then
                    a32.TopbarSettings.SetHidden("Letter", false)
                end

                if const v192 = v23 then
                    v23 = nil

                    pcall(
                        function()
                            --[[
                              line: 85
                              upvalues:
                                textChatService (copy, index: 1)
                                v192 (copy, index: 2)
                                starterGui (copy, index: 3)
                            ]]
                            local chatWindowConfiguration = textChatService:FindFirstChildOfClass("ChatWindowConfiguration")
                            local chatInputBarConfiguration = textChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

                            if chatWindowConfiguration and v192.window ~= nil then
                                chatWindowConfiguration.Enabled = v192.window
                            end

                            if chatInputBarConfiguration and v192.bar ~= nil then
                                chatInputBarConfiguration.Enabled = v192.bar
                            end

                            if v192.core ~= nil then
                                starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, v192.core)
                            end
                        end
                    )
                end

                if reactions then
                    local v195 = false

                    task.spawn(
                        function()
                            --[[
                              line: 488
                              upvalues:
                                remotes (copy, index: 1)
                                v55 (copy, index: 2)
                                v195 (copy, index: 3)
                                inflight (ref,  index: 4)
                                v65 (ref,  index: 5)
                                reacted (ref,  index: 6)
                                v73 (ref,  index: 7)
                            ]]
                            local v196, v197, _, v199 = remotes.Invoke("LetterAction", "Watch", v55, v195)

                            if v195
                                and v196
                                and v197 == true
                                and type(v199) == "boolean"
                                and not inflight
                                and (v65 == nil or reacted == v65)
                            then
                                v65 = v199
                                reacted = v199
                            end

                            v73()
                        end
                    )
                end

                if a190 then
                    parent.Visible = false
                    return
                end

                ui.FadeOut(parent2, TweenInfo.new(0.16))

                task.delay(
                    0.17,
                    function()
                        --[[
                          line: 665
                          upvalues:
                            v191 (copy, index: 1)
                            count (ref,  index: 2)
                            parent (copy, index: 3)
                        ]]
                        if v191 == count then
                            parent.Visible = false
                        end
                    end
                )
            end)
        }
    )
end

return v8