local localPlayer, cFrameChangedConnection

local function DestroyBubble(a4, a5, a6)
    --[[
      name: DestroyBubble
      line: 513
    ]]
    if not a5 then
        return
    end

    if a5:Empty() then
        return
    end

    local renderBubble = a5:Front().RenderBubble
    if not renderBubble then
        a5:PopFront()
        return
    end

    spawn(
        function()
            --[[
              line: 523
              upvalues:
                a5 (copy, index: 1)
                a6 (copy, index: 2)
                renderBubble (ref,  index: 3)
            ]]
            while true do
                if a5:Front().RenderBubble == a6 then
                    break
                end

                wait()
            end

            renderBubble = a5:Front().RenderBubble
            local bubbleText = renderBubble:FindFirstChild("BubbleText")
            local chatBubbleTail = renderBubble:FindFirstChild("ChatBubbleTail")

            while renderBubble and renderBubble.ImageTransparency < 1 do
                local elapsedTime = wait()

                if renderBubble then
                    local v11 = elapsedTime * 1.5
                    renderBubble.ImageTransparency += v11

                    if bubbleText then
                        bubbleText.TextTransparency += v11
                    end

                    if not chatBubbleTail then
                        continue
                    end

                    chatBubbleTail.ImageTransparency += v11
                end
            end

            if renderBubble then
                renderBubble:Destroy()
                a5:PopFront()
            end
        end
    )
end

local function SetBillboardLODVeryFar(a13, a14)
    --[[
      name: SetBillboardLODVeryFar
      line: 409
    ]]
    a14.Enabled = false
end

local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local chat = game:GetService("Chat")
local textService = game:GetService("TextService")
localPlayer = players.LocalPlayer

while localPlayer == nil do
    players.ChildAdded:wait()
    localPlayer = players.LocalPlayer
end

local playerGui = localPlayer:WaitForChild("PlayerGui")
local success, isUserFeatureEnabled = pcall(
    function()
        --[[
          line: 24
        ]]
        return UserSettings():IsUserFeatureEnabled("UserShouldLocalizeGameChatBubble")
    end
)
local isUserFeatureEnabled2 = success and isUserFeatureEnabled
local success2, isUserFeatureEnabled3 = pcall(
    function()
        --[[
          line: 30
        ]]
        return UserSettings():IsUserFeatureEnabled("UserFixBubbleChatText")
    end
)
local isUserFeatureEnabled4 = success2 and isUserFeatureEnabled3
local success3, isUserFeatureEnabled5 = pcall(
    function()
        --[[
          line: 37
        ]]
        return UserSettings():IsUserFeatureEnabled("UserRoactBubbleChatBeta")
    end
)
local isUserFeatureEnabled6 = success3 and isUserFeatureEnabled5
local success4, isUserFeatureEnabled7 = pcall(
    function()
        --[[
          line: 44
        ]]
        return UserSettings():IsUserFeatureEnabled("UserPreventOldBubbleChatOverlap")
    end
)
local isUserFeatureEnabled8 = success4 and isUserFeatureEnabled7

local function getMessageLength(a33)
    --[[
      name: getMessageLength
      line: 50
    ]]
    return utf8.len(utf8.nfcnormalize(a33))
end

local sourceSans = Enum.Font.SourceSans
local size24 = Enum.FontSize.Size24
local v36 = 128 - utf8.len(utf8.nfcnormalize("...")) - 1
local v37 = {WHITE = "dub", BLUE = "blu", GREEN = "gre", RED = "red"}
local bubbleChat = Instance.new("ScreenGui")
bubbleChat.Name = "BubbleChat"
bubbleChat.ResetOnSpawn = false
bubbleChat.Parent = playerGui

local function lerpLength(a40, a41, a42)
    --[[
      name: lerpLength
      line: 93
    ]]
    return a41 + ((a42 - a41) * math.min(utf8.len(utf8.nfcnormalize(a40)) / 75, 1))
end

local function createFifo()
    --[[
      name: createFifo
      line: 97
    ]]
    local v44 = {data = {}}
    local bindableEvent = Instance.new("BindableEvent")
    v44.Emptied = bindableEvent.Event

    function v44.Size(a46)
        --[[
          name: Size
          line: 104
          upvalues:
            v44 (copy, index: 1)
        ]]
        return #v44.data
    end

    function v44.Empty(a47)
        --[[
          name: Empty
          line: 108
          upvalues:
            v44 (copy, index: 1)
        ]]
        return v44:Size() <= 0
    end

    function v44.PopFront(a48)
        --[[
          name: PopFront
          line: 112
          upvalues:
            v44 (copy, index: 1)
            bindableEvent (copy, index: 2)
        ]]
        table.remove(v44.data, 1)

        if v44:Empty() then
            bindableEvent:Fire()
        end
    end

    function v44.Front(a49)
        --[[
          name: Front
          line: 117
          upvalues:
            v44 (copy, index: 1)
        ]]
        return v44.data[1]
    end

    function v44.Get(a50, key)
        --[[
          name: Get
          line: 121
          upvalues:
            v44 (copy, index: 1)
        ]]
        return v44.data[key]
    end

    function v44.PushBack(a52, a53)
        --[[
          name: PushBack
          line: 125
          upvalues:
            v44 (copy, index: 1)
        ]]
        table.insert(v44.data, a53)
    end

    function v44.GetData(a54)
        --[[
          name: GetData
          line: 129
          upvalues:
            v44 (copy, index: 1)
        ]]
        return v44.data
    end

    return v44
end

local function createCharacterChats()
    --[[
      name: createCharacterChats
      line: 136
      upvalues:
        createFifo (copy, index: 1)
    ]]
    return {Fifo = createFifo(), BillboardGui = nil}
end

local function createChatLine(message, bubbleColor, isLocalPlayer)
    --[[
      name: createChatLine
      line: 184
    ]]
    local v60 = {
        ComputeBubbleLifetime = (function(a61, a62, a63)
            --[[
              name: ComputeBubbleLifetime
              line: 187
            ]]
            if a63 then
                return 8 + (7 * math.min(utf8.len(utf8.nfcnormalize(a62)) / 75, 1))
            end

            return 12 + (8 * math.min(utf8.len(utf8.nfcnormalize(a62)) / 75, 1))
        end),
        Origin = nil,
        RenderBubble = nil,
        Message = message
    }
    v60.BubbleDieDelay = v60:ComputeBubbleLifetime(message, isLocalPlayer)
    v60.BubbleColor = bubbleColor
    v60.IsLocalPlayer = isLocalPlayer
    return v60
end

local function createPlayerChatLine(a65, message, isLocalPlayer)
    --[[
      name: createPlayerChatLine
      line: 205
      upvalues:
        createChatLine (copy, index: 1)
    ]]
    local chatLine = createChatLine(message, "dub", isLocalPlayer)

    if a65 then
        chatLine.User = a65.Name
        chatLine.Origin = a65.Character
    end

    return chatLine
end

local function createGameChatLine(origin, message, isLocalPlayer, bubbleColor)
    --[[
      name: createGameChatLine
      line: 216
      upvalues:
        createChatLine (copy, index: 1)
    ]]
    local chatLine = createChatLine(message, bubbleColor, isLocalPlayer)
    chatLine.Origin = origin
    return chatLine
end

function createChatBubbleMain(a75, sliceCenter)
    --[[
      name: createChatBubbleMain
      line: 223
    ]]
    local chatBubble = Instance.new("ImageLabel")
    chatBubble.Name = "ChatBubble"
    chatBubble.ScaleType = Enum.ScaleType.Slice
    chatBubble.SliceCenter = sliceCenter
    chatBubble.Image = "rbxasset://textures/" .. tostring(a75) .. ".png"
    chatBubble.BackgroundTransparency = 1
    chatBubble.BorderSizePixel = 0
    chatBubble.Size = UDim2.new(1, 0, 1, 0)
    chatBubble.Position = UDim2.new(0, 0, 0, 0)
    return chatBubble
end

function createChatBubbleTail(position, size: UDim2)
    --[[
      name: createChatBubbleTail
      line: 237
    ]]
    local chatBubbleTail = Instance.new("ImageLabel")
    chatBubbleTail.Name = "ChatBubbleTail"
    chatBubbleTail.Image = "rbxasset://textures/ui/dialog_tail.png"
    chatBubbleTail.BackgroundTransparency = 1
    chatBubbleTail.BorderSizePixel = 0
    chatBubbleTail.Position = position
    chatBubbleTail.Size = size
    return chatBubbleTail
end

function createChatBubbleWithTail(a81, a82, udim2: UDim2, a84)
    --[[
      name: createChatBubbleWithTail
      line: 249
    ]]
    local parent = createChatBubbleMain(a81, a84)
    createChatBubbleTail(a82, udim2).Parent = parent

    return parent
end

function createScaledChatBubbleWithTail(a86, a87, udim2: UDim2, a89)
    --[[
      name: createScaledChatBubbleWithTail
      line: 258
    ]]
    local parent = createChatBubbleMain(a86, a89)
    local chatBubbleTailFrame = Instance.new("Frame")
    chatBubbleTailFrame.Name = "ChatBubbleTailFrame"
    chatBubbleTailFrame.BackgroundTransparency = 1
    chatBubbleTailFrame.SizeConstraint = Enum.SizeConstraint.RelativeXX
    chatBubbleTailFrame.Position = UDim2.new(0.5, 0, 1, 0)
    chatBubbleTailFrame.Size = UDim2.new(a87, 0, a87, 0)
    chatBubbleTailFrame.Parent = parent
    createChatBubbleTail(udim2, UDim2.new(1, 0, 0.5, 0)).Parent = chatBubbleTailFrame

    return parent
end

function createChatImposter(a92, a93, a94: number)
    --[[
      name: createChatImposter
      line: 275
    ]]
    local dialogPlaceholder = Instance.new("ImageLabel")
    dialogPlaceholder.Name = "DialogPlaceholder"
    dialogPlaceholder.Image = "rbxasset://textures/" .. tostring(a92) .. ".png"
    dialogPlaceholder.BackgroundTransparency = 1
    dialogPlaceholder.BorderSizePixel = 0
    dialogPlaceholder.Position = UDim2.new(0, 0, -1.25, 0)
    dialogPlaceholder.Size = UDim2.new(1, 0, 1, 0)

    local dotDotDot = Instance.new("ImageLabel")
    dotDotDot.Name = "DotDotDot"
    dotDotDot.Image = "rbxasset://textures/" .. tostring(a93) .. ".png"
    dotDotDot.BackgroundTransparency = 1
    dotDotDot.BorderSizePixel = 0
    dotDotDot.Position = UDim2.new(0.001, 0, a94, 0)
    dotDotDot.Size = UDim2.new(1, 0, 0.7, 0)
    dotDotDot.Parent = dialogPlaceholder

    return dialogPlaceholder
end

local v97 = {
    ChatBubble = {},
    ChatBubbleWithTail = {},
    ScalingChatBubbleWithTail = {},
    CharacterSortedMsg = (function()
        --[[
          name: createMap
          line: 145
          upvalues:
            createFifo (copy, index: 1)
        ]]
        local v98 = {data = {}}
        local v99 = 0

        function v98.Size(a100)
            --[[
              name: Size
              line: 150
              upvalues:
                v99 (ref, index: 1)
            ]]
            return v99
        end

        function v98.Erase(a101, key)
            --[[
              name: Erase
              line: 154
              upvalues:
                v98 (copy, index: 1)
                v99 (ref,  index: 2)
            ]]
            if v98.data[key] then
                v99 -= 1
            end

            v98.data[key] = nil
        end

        function v98.Set(a103, key, value)
            --[[
              name: Set
              line: 159
              upvalues:
                v98 (copy, index: 1)
                v99 (ref,  index: 2)
            ]]
            v98.data[key] = value

            if value then
                v99 += 1
            end
        end

        function v98.Get(a106, key)
            --[[
              name: Get
              line: 164
              upvalues:
                v98 (copy, index: 1)
                createFifo (copy, index: 2)
            ]]
            if not key then
                return
            end

            if not v98.data[key] then
                v98.data[key] = {Fifo = createFifo(), BillboardGui = nil}
                local v108 = nil

                v108 = v98.data[key].Fifo.Emptied:connect(
                    function()
                        --[[
                          line: 169
                          upvalues:
                            v108 (ref,  index: 1)
                            v98 (copy, index: 2)
                            key (copy, index: 3)
                        ]]
                        v108:disconnect()
                        v98:Erase(key)
                    end
                )
            end

            return v98.data[key]
        end

        function v98.GetData(a109)
            --[[
              name: GetData
              line: 177
              upvalues:
                v98 (copy, index: 1)
            ]]
            return v98.data
        end

        return v98
    end)()
}

local function initChatBubbleType(key: string, a112: string, a113: string, a114: boolean, rect)
    --[[
      name: initChatBubbleType
      line: 304
      upvalues:
        v97 (copy, index: 1)
    ]]
    v97.ChatBubble[key] = createChatBubbleMain(a112, rect)
    local chatBubbleWithTail = v97.ChatBubbleWithTail
    local v117 = createChatBubbleWithTail
    local newUDim2 = UDim2.new
    local v119 = a114 and -1 or 0
    chatBubbleWithTail[key] = v117(a112, newUDim2(0.5, -14, 1, v119), UDim2.new(0, 30, 0, 14), rect)
    local scalingChatBubbleWithTail = v97.ScalingChatBubbleWithTail
    v117 = createScaledChatBubbleWithTail
    local newUDim22 = UDim2.new
    local v122 = a114 and -1 or 0
    scalingChatBubbleWithTail[key] = v117(a112, 0.5, newUDim22(-0.5, 0, 0, v122), rect)
end

initChatBubbleType("dub", "ui/dialog_white", "ui/chatBubble_white_notify_bkg", false, Rect.new(5, 5, 15, 15))
initChatBubbleType("blu", "ui/dialog_blue", "ui/chatBubble_blue_notify_bkg", true, Rect.new(7, 7, 33, 33))
initChatBubbleType("red", "ui/dialog_red", "ui/chatBubble_red_notify_bkg", true, Rect.new(7, 7, 33, 33))
initChatBubbleType("gre", "ui/dialog_green", "ui/chatBubble_green_notify_bkg", true, Rect.new(7, 7, 33, 33))

function v97.SanitizeChatLine(a123, text)
    --[[
      name: SanitizeChatLine
      line: 315
      upvalues:
        v36 (copy, index: 1)
    ]]
    if v36 < utf8.len(utf8.nfcnormalize(text)) then
        return (string.sub(text, 1, utf8.offset(text, (v36 + utf8.len(utf8.nfcnormalize("..."))) + 1) - 1))
    end

    return text
end

local function createBillboardInstance(adornee: Instance?)
    --[[
      name: createBillboardInstance
      line: 324
      upvalues:
        bubbleChat (copy, index: 1)
        v97 (copy, index: 2)
    ]]
    local parent = Instance.new("BillboardGui")
    parent.Adornee = adornee
    parent.Size = UDim2.new(0, 400, 0, 250)
    parent.StudsOffset = Vector3.new(0, 1.5, 2)
    parent.Parent = bubbleChat

    local billboardFrame = Instance.new("Frame")
    billboardFrame.Name = "BillboardFrame"
    billboardFrame.Size = UDim2.new(1, 0, 1, 0)
    billboardFrame.Position = UDim2.new(0, 0, -0.5, 0)
    billboardFrame.BackgroundTransparency = 1
    billboardFrame.Parent = parent
    local childRemovedConnection = nil

    childRemovedConnection = billboardFrame.ChildRemoved:connect(
        function()
            --[[
              line: 339
              upvalues:
                billboardFrame (copy, index: 1)
                childRemovedConnection (ref,  index: 2)
                parent (copy, index: 3)
            ]]
            if #billboardFrame:GetChildren() <= 1 then
                childRemovedConnection:disconnect()
                parent:Destroy()
            end
        end
    )

    v97:CreateSmallTalkBubble("dub").Parent = billboardFrame

    return parent
end

function v97.CreateBillboardGuiHelper(a130, adornee: Instance?, a132: boolean)
    --[[
      name: CreateBillboardGuiHelper
      line: 351
      upvalues:
        v97 (copy, index: 1)
        createBillboardInstance (copy, index: 2)
    ]]
    if adornee and not v97.CharacterSortedMsg:Get(adornee).BillboardGui then
        if not a132 and adornee:IsA("BasePart") then
            local billboardGui = createBillboardInstance(adornee)
            v97.CharacterSortedMsg:Get(adornee).BillboardGui = billboardGui

            return
        end

        if adornee:IsA("Model") then
            local head = adornee:FindFirstChild("Head")

            if head and head:IsA("BasePart") then
                local billboardGui = createBillboardInstance(head)
                v97.CharacterSortedMsg:Get(adornee).BillboardGui = billboardGui
            end
        end
    end
end

local function distanceToBubbleOrigin(a137)
    --[[
      name: distanceToBubbleOrigin
      line: 373
    ]]
    if not a137 then
        return 1e+05
    end

    return (a137.Position - game.Workspace.CurrentCamera.CoordinateFrame.Position).magnitude
end

local function isPartOfLocalPlayer(a139)
    --[[
      name: isPartOfLocalPlayer
      line: 379
      upvalues:
        players (copy, index: 1)
    ]]
    if a139 and players.LocalPlayer.Character then
        return a139:IsDescendantOf(players.LocalPlayer.Character)
    end
end

function v97.SetBillboardLODNear(a140, a141)
    --[[
      name: SetBillboardLODNear
      line: 385
      upvalues:
        players (copy, index: 1)
    ]]
    local adornee = a141.Adornee
    local v143 = if adornee and players.LocalPlayer.Character then adornee:IsDescendantOf(players.LocalPlayer.Character) else nil
    a141.Size = UDim2.new(0, 400, 0, 250)
    local y = v143 and 1.5 or 2.5
    local z = v143 and 2 or 0.1
    a141.StudsOffset = Vector3.new(0, y, z)
    a141.Enabled = true
    local children = a141.BillboardFrame:GetChildren()

    for childKey = 1, #children do
        children[childKey].Visible = true
    end

    a141.BillboardFrame.SmallTalkBubble.Visible = false
end

function v97.SetBillboardLODDistant(a148, a149)
    --[[
      name: SetBillboardLODDistant
      line: 397
      upvalues:
        players (copy, index: 1)
    ]]
    local adornee = a149.Adornee
    local v151 = if adornee and players.LocalPlayer.Character then adornee:IsDescendantOf(players.LocalPlayer.Character) else nil
    a149.Size = UDim2.new(4, 0, 3, 0)
    local z = v151 and 2 or 0.1
    a149.StudsOffset = Vector3.new(0, 3, z)
    a149.Enabled = true
    local children = a149.BillboardFrame:GetChildren()

    for childKey = 1, #children do
        children[childKey].Visible = false
    end

    a149.BillboardFrame.SmallTalkBubble.Visible = true
end

v97.SetBillboardLODVeryFar = SetBillboardLODVeryFar

function v97.SetBillboardGuiLOD(a155, a156, a157)
    --[[
      name: SetBillboardGuiLOD
      line: 413
      upvalues:
        v97 (copy, index: 1)
    ]]
    if not a157 then
        return
    end

    if a157:IsA("Model") then
        a157 = a157:FindFirstChild("Head") or a157.PrimaryPart
    end

    local v158 = not a157 and 1e+05
        or (a157.Position - game.Workspace.CurrentCamera.CoordinateFrame.Position).magnitude

    if v158 < 65 then
        v97:SetBillboardLODNear(a156)
        return
    end

    if 65 <= v158 then
        if v158 < 100 then
            v97:SetBillboardLODDistant(a156)
            return
        end
    end

    v97:SetBillboardLODVeryFar(a156)
end

function v97.CameraCFrameChanged(a159)
    --[[
      name: CameraCFrameChanged
      line: 433
      upvalues:
        v97 (copy, index: 1)
    ]]
    for key, v161 in pairs(v97.CharacterSortedMsg:GetData()) do
        if const billboardGui = v161.BillboardGui then
            v97:SetBillboardGuiLOD(billboardGui, key)
        end
    end
end

function v97.CreateBubbleText(a163, text, autoLocalize)
    --[[
      name: CreateBubbleText
      line: 440
      upvalues:
        isUserFeatureEnabled4 (ref,  index: 1)
        sourceSans (copy, index: 2)
        size24 (copy, index: 3)
    ]]
    local bubbleText = Instance.new("TextLabel")
    bubbleText.Name = "BubbleText"
    bubbleText.BackgroundTransparency = 1

    if isUserFeatureEnabled4 then
        bubbleText.Size = UDim2.fromScale(1, 1)
    else
        bubbleText.Position = UDim2.new(0, 15, 0, 0)
        bubbleText.Size = UDim2.new(1, -30, 1, 0)
    end

    bubbleText.Font = sourceSans
    bubbleText.ClipsDescendants = true
    bubbleText.TextWrapped = true
    bubbleText.FontSize = size24
    bubbleText.Text = text
    bubbleText.Visible = false
    bubbleText.AutoLocalize = autoLocalize

    if isUserFeatureEnabled4 then
        local uiPadding = Instance.new("UIPadding")
        uiPadding.PaddingTop = UDim.new(0, 12)
        uiPadding.PaddingRight = UDim.new(0, 12)
        uiPadding.PaddingBottom = UDim.new(0, 12)
        uiPadding.PaddingLeft = UDim.new(0, 12)
        uiPadding.Parent = bubbleText
    end

    return bubbleText
end

function v97.CreateSmallTalkBubble(a168, key: string)
    --[[
      name: CreateSmallTalkBubble
      line: 472
      upvalues:
        v97 (copy, index: 1)
    ]]
    local parent = v97.ScalingChatBubbleWithTail[key]:Clone()
    parent.Name = "SmallTalkBubble"
    parent.AnchorPoint = Vector2.new(0, 0.5)
    parent.Position = UDim2.new(0, 0, 0.5, 0)
    parent.Visible = false

    local bubbleText = v97:CreateBubbleText("...")
    bubbleText.TextScaled = true
    bubbleText.TextWrapped = false
    bubbleText.Visible = true
    bubbleText.Parent = parent

    return parent
end

function v97.UpdateChatLinesForOrigin(a172, a173, a174)
    --[[
      name: UpdateChatLinesForOrigin
      line: 487
      upvalues:
        v97 (copy, index: 1)
    ]]
    local fifo = v97.CharacterSortedMsg:Get(a173).Fifo
    local v176 = fifo:Size()
    local data = fifo:GetData()

    if #data <= 1 then
        return
    end

    for index = #data - 1, 1, -1 do
        local v179 = data[index]
        local renderBubble = v179.RenderBubble
        if not renderBubble then
            return
        end

        if 1 < (v176 - index) + 1 then
            if const chatBubbleTail = renderBubble:FindFirstChild("ChatBubbleTail") then
                chatBubbleTail:Destroy()
            end

            if const bubbleText = renderBubble:FindFirstChild("BubbleText") then
                bubbleText.TextTransparency = 0.5
            end
        end

        renderBubble:TweenPosition(UDim2.new(renderBubble.Position.X.Scale, renderBubble.Position.X.Offset, 1, (a174 - renderBubble.Size.Y.Offset) - 14), Enum.EasingDirection.Out, Enum.EasingStyle.Bounce, 0.1, true)
        a174 = a174 - renderBubble.Size.Y.Offset - 14
    end
end

v97.DestroyBubble = DestroyBubble

function v97.CreateChatLineRender(a183, instance: Instance?, a185, a186: boolean, a187, a188: boolean)
    --[[
      name: CreateChatLineRender
      line: 551
      upvalues:
        v97 (copy, index: 1)
        textService (copy, index: 2)
        sourceSans (copy, index: 3)
        isUserFeatureEnabled4 (ref,  index: 4)
    ]]
    if not instance then
        return
    end

    if not v97.CharacterSortedMsg:Get(instance).BillboardGui then
        v97:CreateBillboardGuiHelper(instance, a186)
    end

    if const billboardGui = v97.CharacterSortedMsg:Get(instance).BillboardGui then
        local v190 = v97.ChatBubbleWithTail[a185.BubbleColor]:Clone()
        v190.Visible = false

        local bubbleText = v97:CreateBubbleText(a185.Message, a188)
        bubbleText.Parent = v190
        v190.Parent = billboardGui.BillboardFrame
        a185.RenderBubble = v190
        local textSize = textService:GetTextSize(bubbleText.Text, 24, sourceSans, Vector2.new(400, 250))
        local v193 = textSize.Y / 24

        if isUserFeatureEnabled4 then
            local ceilingValue = math.ceil(textSize.X + 24)
            local v195 = v193 * 34
            v190.Size = UDim2.fromOffset(0, 0)
            v190.Position = UDim2.fromScale(0.5, 1)
            v190:TweenSizeAndPosition(
                UDim2.fromOffset(ceilingValue, v195),
                UDim2.new(0.5, -ceilingValue / 2, 1, -v195),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Elastic,
                0.1,
                true,
                function()
                    --[[
                      line: 590
                      upvalues:
                        bubbleText (copy, index: 1)
                    ]]
                    bubbleText.Visible = true
                end
            )
            v97:SetBillboardGuiLOD(billboardGui, a185.Origin)
            v97:UpdateChatLinesForOrigin(a185.Origin, -v195)
        else
            local v196 = math.max((textSize.X + 30) / 400, 0.1)
            v190.Size = UDim2.new(0, 0, 0, 0)
            v190.Position = UDim2.new(0.5, 0, 1, 0)
            local v197 = v193 * 34
            v190:TweenSizeAndPosition(
                UDim2.new(v196, 0, 0, v197),
                UDim2.new((1 - v196) / 2, 0, 1, -v197),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Elastic,
                0.1,
                true,
                function()
                    --[[
                      line: 610
                      upvalues:
                        bubbleText (copy, index: 1)
                    ]]
                    bubbleText.Visible = true
                end
            )
            v97:SetBillboardGuiLOD(billboardGui, a185.Origin)
            v97:UpdateChatLinesForOrigin(a185.Origin, -v197)
        end

        delay(
            a185.BubbleDieDelay,
            function()
                --[[
                  line: 617
                  upvalues:
                    v97 (copy, index: 1)
                    a187 (copy, index: 2)
                    v190 (copy, index: 3)
                ]]
                v97:DestroyBubble(a187, v190)
            end
        )
    end
end

function v97.OnPlayerChatMessage(a198, player: Player?, a200, a201: nil)
    --[[
      name: OnPlayerChatMessage
      line: 623
      upvalues:
        v97 (copy, index: 1)
        players (copy, index: 2)
        createChatLine (copy, index: 3)
        v37 (copy, index: 4)
    ]]
    if not v97:BubbleChatEnabled() then
        return
    end

    local localPlayer = players.LocalPlayer
    local v203 = localPlayer ~= nil and player ~= localPlayer
    local message = v97:SanitizeChatLine(a200)
    local chatLine = createChatLine(message, v37.WHITE, not v203)

    if player then
        chatLine.User = player.Name
        chatLine.Origin = player.Character
    end

    if player and chatLine.Origin then
        local fifo = v97.CharacterSortedMsg:Get(chatLine.Origin).Fifo
        fifo:PushBack(chatLine)
        v97:CreateChatLineRender(player.Character, chatLine, true, fifo, false)
    end
end

function v97.OnGameChatMessage(a207, origin: Instance, a209: string, chatColor: Enum.ChatColor)
    --[[
      name: OnGameChatMessage
      line: 642
      upvalues:
        isUserFeatureEnabled6 (ref,  index: 1)
        isUserFeatureEnabled8 (ref,  index: 2)
        chat (copy, index: 3)
        players (copy, index: 4)
        v97 (copy, index: 5)
        createChatLine (copy, index: 6)
        isUserFeatureEnabled2 (copy, index: 7)
    ]]
    if not isUserFeatureEnabled6 then
        if not isUserFeatureEnabled8 or not chat.BubbleChatEnabled then
            local localPlayer = players.LocalPlayer
            local v212 = localPlayer ~= nil and localPlayer.Character ~= origin
            local v213 = "dub"

            if chatColor ~= Enum.ChatColor.Blue then
                if chatColor ~= Enum.ChatColor.Green then
                    if chatColor == Enum.ChatColor.Red then
                        v213 = "red"
                    end
                else
                    v213 = "gre"
                end
            else
                v213 = "blu"
            end

            local message = v97:SanitizeChatLine(a209)
            local chatLine = createChatLine(message, v213, not v212)
            chatLine.Origin = origin
            v97.CharacterSortedMsg:Get(chatLine.Origin).Fifo:PushBack(chatLine)

            if isUserFeatureEnabled2 then
                v97:CreateChatLineRender(origin, chatLine, false, v97.CharacterSortedMsg:Get(chatLine.Origin).Fifo, true)
                return
            end

            v97:CreateChatLineRender(origin, chatLine, false, v97.CharacterSortedMsg:Get(chatLine.Origin).Fifo, false)
        end
    end
end

function v97.BubbleChatEnabled(a216)
    --[[
      name: BubbleChatEnabled
      line: 668
      upvalues:
        isUserFeatureEnabled6 (ref,  index: 1)
        isUserFeatureEnabled8 (ref,  index: 2)
        chat (copy, index: 3)
        players (copy, index: 4)
    ]]
    if isUserFeatureEnabled6 or isUserFeatureEnabled8 and chat.BubbleChatEnabled then
        return false
    elseif const clientChatModules = chat:FindFirstChild("ClientChatModules") then
        if local v218 = clientChatModules:FindFirstChild("ChatSettings") then
            local v219 = v218
            v218 = require(v219)

            if v218.BubbleChatEnabled ~= nil then
                return v218.BubbleChatEnabled
            end
        end
    end

    return players.BubbleChat
end

function v97.ShowOwnFilteredMessage(a220)
    --[[
      name: ShowOwnFilteredMessage
      line: 685
      upvalues:
        chat (copy, index: 1)
    ]]
    if const clientChatModules = chat:FindFirstChild("ClientChatModules") then
        if const chatSettings = clientChatModules:FindFirstChild("ChatSettings") then
            return require(chatSettings).ShowUserOwnFilteredMessage
        end
    end

    return false
end

function findPlayer(a223)
    --[[
      name: findPlayer
      line: 697
      upvalues:
        players (copy, index: 1)
    ]]
    for _, player in pairs(players:GetPlayers()) do
        if player.Name == a223 then
            return player
        end
    end
end

chat.Chatted:connect(
    function(part: Instance, message: string, color: Enum.ChatColor)
        --[[
          line: 705
          upvalues:
            v97 (copy, index: 1)
        ]]
        v97:OnGameChatMessage(part, message, color)
    end
)

if game.Workspace.CurrentCamera then
    cFrameChangedConnection = game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(
        function(a229)
            --[[
              line: 709
              upvalues:
                v97 (copy, index: 1)
            ]]
            v97:CameraCFrameChanged()
        end
    )
else
    cFrameChangedConnection = nil
end

game.Workspace.Changed:Connect(
    function(property: string)
        --[[
          line: 712
          upvalues:
            cFrameChangedConnection (ref,  index: 1)
            v97 (copy, index: 2)
        ]]
        if property == "CurrentCamera" then
            if cFrameChangedConnection then
                cFrameChangedConnection:disconnect()
            end

            if game.Workspace.CurrentCamera then
                cFrameChangedConnection = game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(
                    function(a231)
                        --[[
                          line: 716
                          upvalues:
                            v97 (copy, index: 1)
                        ]]
                        v97:CameraCFrameChanged()
                    end
                )
            end
        end
    end
)

local v232 = nil

function getAllowedMessageTypes()
    --[[
      name: getAllowedMessageTypes
      line: 724
      upvalues:
        v232 (ref,  index: 1)
        chat (copy, index: 2)
    ]]
    if v232 then
        return v232
    end

    local clientChatModules = chat:FindFirstChild("ClientChatModules")
    if not clientChatModules then
        return {"Message", "Whisper"}
    elseif local v234 = clientChatModules:FindFirstChild("ChatSettings") then
        local v235 = v234
        v234 = require(v235)

        if v234.BubbleChatMessageTypes then
            v232 = v234.BubbleChatMessageTypes
            return v232
        end
    end

    if local v236 = clientChatModules:FindFirstChild("ChatConstants") then
        local v237 = v236
        v236 = require(v237)
        v232 = {v236.MessageTypeDefault, v236.MessageTypeWhisper}
    end

    return v232
end

function checkAllowedMessageType(a238)
    --[[
      name: checkAllowedMessageType
      line: 748
    ]]
    local v239 = getAllowedMessageTypes()

    for index = 1, #v239 do
        if v239[index] == a238.MessageType then
            return true
        end
    end

    return false
end

local defaultChatSystemChatEvents = replicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local onMessageDoneFiltering = defaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering")
local onNewMessage = defaultChatSystemChatEvents:WaitForChild("OnNewMessage")

onNewMessage.OnClientEvent:connect(
    function(a244, a245)
        --[[
          line: 762
          upvalues:
            localPlayer (ref,  index: 1)
            v97 (copy, index: 2)
        ]]
        if not checkAllowedMessageType(a244) then
            return
        end

        local player = findPlayer(a244.FromSpeaker)
        if not player then
            return
        end

        if (not a244.IsFiltered or a244.FromSpeaker == localPlayer.Name)
            and (a244.FromSpeaker ~= localPlayer.Name or v97:ShowOwnFilteredMessage())
        then
            return
        end

        v97:OnPlayerChatMessage(player, a244.Message, nil)
    end
)

onMessageDoneFiltering.OnClientEvent:connect(
    function(a247, a248)
        --[[
          line: 781
          upvalues:
            localPlayer (ref,  index: 1)
            v97 (copy, index: 2)
        ]]
        if not checkAllowedMessageType(a247) then
            return
        end

        local player = findPlayer(a247.FromSpeaker)
        if not player then
            return
        end

        if a247.FromSpeaker == localPlayer.Name and not v97:ShowOwnFilteredMessage() then
            return
        end

        v97:OnPlayerChatMessage(player, a247.Message, nil)
    end
)