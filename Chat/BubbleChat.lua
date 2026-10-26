local Players_upv_1 = game:GetService("Players")
local ReplicatedStorage_1 = game:GetService("ReplicatedStorage")
local Chat_upv_1 = game:GetService("Chat")
local TextService_upv_1 = game:GetService("TextService")
local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
while LocalPlayer_upv_1 == nil do
    Players_upv_1.ChildAdded:wait()
    LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
end
local PlayerGui_1 = LocalPlayer_upv_1:WaitForChild("PlayerGui")
local success_1, v1 = pcall(
    function()
        --[[
          line: 24
        ]]
        return UserSettings():IsUserFeatureEnabled("UserShouldLocalizeGameChatBubble")
    end
)
local u1 = success_1 and v1
local success_2, v2 = pcall(
    function()
        --[[
          line: 30
        ]]
        return UserSettings():IsUserFeatureEnabled("UserFixBubbleChatText")
    end
)
local u2 = success_2 and v2
local success_3, v3 = pcall(
    function()
        --[[
          line: 37
        ]]
        return UserSettings():IsUserFeatureEnabled("UserRoactBubbleChatBeta")
    end
)
local u3 = success_3 and v3
local success_4, v4 = pcall(
    function()
        --[[
          line: 44
        ]]
        return UserSettings():IsUserFeatureEnabled("UserPreventOldBubbleChatOverlap")
    end
)
local u4 = success_4 and v4
local function getMessageLength(a1)
    --[[
      name: getMessageLength
      line: 50
    ]]
    return utf8.len(utf8.nfcnormalize(a1))
end
local SourceSans_upv_1 = Enum.Font.SourceSans
local Size24_upv_1 = Enum.FontSize.Size24
local u5 = 128 - utf8.len(utf8.nfcnormalize("...")) - 1
local tbl_upv_1 = {WHITE = "dub", GREEN = "gre", BLUE = "blu", RED = "red"}
local u6 = Instance.new("ScreenGui")
u6.Name = "BubbleChat"
u6.ResetOnSpawn = false
u6.Parent = PlayerGui_1
local function lerpLength(a1, a2, a3)
    --[[
      name: lerpLength
      line: 93
    ]]
    return a2 + ((a3 - a2) * math.min(utf8.len(utf8.nfcnormalize(a1)) / 75, 1))
end
local function createFifo()
    --[[
      name: createFifo
      line: 97
    ]]
    local tbl_upv_2 = {}
    tbl_upv_2.data = {}
    local u7 = Instance.new("BindableEvent")
    tbl_upv_2.Emptied = u7.Event
    function tbl_upv_2.Size(a1)
        --[[
          name: Size
          line: 104
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        return #tbl_upv_2.data
    end
    function tbl_upv_2.Empty(a2)
        --[[
          name: Empty
          line: 108
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        local v5 = tbl_upv_2:Size() <= 0
        return v5
    end
    function tbl_upv_2.PopFront(a3)
        --[[
          name: PopFront
          line: 112
          upvalues:
            tbl_upv_2 (copy, index: 1)
            u7 (copy, index: 2)
        ]]
        table.remove(tbl_upv_2.data, 1)
        if not tbl_upv_2:Empty() then
            return
        end
        u7:Fire()
    end
    function tbl_upv_2.Front(a4)
        --[[
          name: Front
          line: 117
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        return tbl_upv_2.data[1]
    end
    function tbl_upv_2.Get(a5, a6)
        --[[
          name: Get
          line: 121
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        return tbl_upv_2.data[a6]
    end
    function tbl_upv_2.PushBack(a7, a8)
        --[[
          name: PushBack
          line: 125
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        table.insert(tbl_upv_2.data, a8)
    end
    function tbl_upv_2.GetData(a9)
        --[[
          name: GetData
          line: 129
          upvalues:
            tbl_upv_2 (copy, index: 1)
        ]]
        return tbl_upv_2.data
    end
    return tbl_upv_2
end
local function createCharacterChats()
    --[[
      name: createCharacterChats
      line: 136
      upvalues:
        createFifo (copy, index: 1)
    ]]
    local tbl_3 = {}
    tbl_3.Fifo = createFifo()
    tbl_3.BillboardGui = nil
    return tbl_3
end
local function createChatLine(a1, a2, a3)
    --[[
      name: createChatLine
      line: 184
    ]]
    local tbl_4 = {}
    function tbl_4.ComputeBubbleLifetime(a4, a5, a6)
        --[[
          name: ComputeBubbleLifetime
          line: 187
        ]]
        if a6 then
            return 8 + (7 * math.min(utf8.len(utf8.nfcnormalize(a5)) / 75, 1))
        end
        return 12 + (8 * math.min(utf8.len(utf8.nfcnormalize(a5)) / 75, 1))
    end
    tbl_4.Origin = nil
    tbl_4.RenderBubble = nil
    tbl_4.Message = a1
    tbl_4.BubbleDieDelay = tbl_4:ComputeBubbleLifetime(a1, a3)
    tbl_4.BubbleColor = a2
    tbl_4.IsLocalPlayer = a3
    return tbl_4
end
local function createPlayerChatLine(a1, a2, a3)
    --[[
      name: createPlayerChatLine
      line: 205
      upvalues:
        createChatLine (copy, index: 1)
    ]]
    local v6 = createChatLine(a2, "dub", a3)
    if a1 then
        v6.User = a1.Name
        v6.Origin = a1.Character
    end
    return v6
end
local function createGameChatLine(a1, a2, a3, a4)
    --[[
      name: createGameChatLine
      line: 216
      upvalues:
        createChatLine (copy, index: 1)
    ]]
    local v7 = createChatLine(a2, a4, a3)
    v7.Origin = a1
    return v7
end
function createChatBubbleMain(a1, a2)
    --[[
      name: createChatBubbleMain
      line: 223
    ]]
    local v8 = Instance.new("ImageLabel")
    v8.Name = "ChatBubble"
    v8.ScaleType = Enum.ScaleType.Slice
    v8.SliceCenter = a2
    v8.Image = "rbxasset://textures/" .. tostring(a1) .. ".png"
    v8.BackgroundTransparency = 1
    v8.BorderSizePixel = 0
    v8.Size = UDim2.new(1, 0, 1, 0)
    v8.Position = UDim2.new(0, 0, 0, 0)
    return v8
end
function createChatBubbleTail(a1, a2)
    --[[
      name: createChatBubbleTail
      line: 237
    ]]
    local v9 = Instance.new("ImageLabel")
    v9.Name = "ChatBubbleTail"
    v9.Image = "rbxasset://textures/ui/dialog_tail.png"
    v9.BackgroundTransparency = 1
    v9.BorderSizePixel = 0
    v9.Position = a1
    v9.Size = a2
    return v9
end
function createChatBubbleWithTail(a1, a2, a3, a4)
    --[[
      name: createChatBubbleWithTail
      line: 249
    ]]
    local v10 = createChatBubbleMain(a1, a4)
    createChatBubbleTail(a2, a3).Parent = v10
    return v10
end
function createScaledChatBubbleWithTail(a1, a2, a3, a4)
    --[[
      name: createScaledChatBubbleWithTail
      line: 258
    ]]
    local v11 = createChatBubbleMain(a1, a4)
    local v12 = Instance.new("Frame")
    v12.Name = "ChatBubbleTailFrame"
    v12.BackgroundTransparency = 1
    v12.SizeConstraint = Enum.SizeConstraint.RelativeXX
    v12.Position = UDim2.new(0.5, 0, 1, 0)
    v12.Size = UDim2.new(a2, 0, a2, 0)
    v12.Parent = v11
    createChatBubbleTail(a3, UDim2.new(1, 0, 0.5, 0)).Parent = v12
    return v11
end
function createChatImposter(a1, a2, a3)
    --[[
      name: createChatImposter
      line: 275
    ]]
    local v13 = Instance.new("ImageLabel")
    v13.Name = "DialogPlaceholder"
    v13.Image = "rbxasset://textures/" .. tostring(a1) .. ".png"
    v13.BackgroundTransparency = 1
    v13.BorderSizePixel = 0
    v13.Position = UDim2.new(0, 0, -1.25, 0)
    v13.Size = UDim2.new(1, 0, 1, 0)
    local v14 = Instance.new("ImageLabel")
    v14.Name = "DotDotDot"
    v14.Image = "rbxasset://textures/" .. tostring(a2) .. ".png"
    v14.BackgroundTransparency = 1
    v14.BorderSizePixel = 0
    v14.Position = UDim2.new(0.001, 0, a3, 0)
    v14.Size = UDim2.new(1, 0, 0.7, 0)
    v14.Parent = v13
    return v13
end
local tbl_upv_5 = {}
tbl_upv_5.ChatBubble = {}
tbl_upv_5.ChatBubbleWithTail = {}
tbl_upv_5.ScalingChatBubbleWithTail = {}
tbl_upv_5.CharacterSortedMsg = (function()
    --[[
      name: createMap
      line: 145
      upvalues:
        createFifo (copy, index: 1)
    ]]
    local tbl_upv_6 = {}
    tbl_upv_6.data = {}
    local u8 = 0
    function tbl_upv_6.Size(a1)
        --[[
          name: Size
          line: 150
          upvalues:
            u8 (ref, index: 1)
        ]]
        return u8
    end
    function tbl_upv_6.Erase(a2, a3)
        --[[
          name: Erase
          line: 154
          upvalues:
            tbl_upv_6 (copy, index: 1)
            u8 (ref,  index: 2)
        ]]
        if tbl_upv_6.data[a3] then
            u8 = u8 - 1
        end
        tbl_upv_6.data[a3] = nil
    end
    function tbl_upv_6.Set(a4, a5, a6)
        --[[
          name: Set
          line: 159
          upvalues:
            tbl_upv_6 (copy, index: 1)
            u8 (ref,  index: 2)
        ]]
        tbl_upv_6.data[a5] = a6
        if not a6 then
            return
        end
        u8 = u8 + 1
    end
    function tbl_upv_6.Get(a7, a8)
        --[[
          name: Get
          line: 164
          upvalues:
            tbl_upv_6 (copy, index: 1)
            createFifo (copy, index: 2)
        ]]
        if a8 then
            if not (tbl_upv_6.data[a8]) then
                tbl_upv_6.data[a8] = {Fifo = createFifo(), BillboardGui = nil}
                local u9 = nil
                local v15 = tbl_upv_6.data[a8].Fifo.Emptied:connect(
                    function()
                        --[[
                          line: 169
                          upvalues:
                            u9 (ref,  index: 1)
                            tbl_upv_6 (copy, index: 2)
                            a8 (copy, index: 3)
                        ]]
                        u9:disconnect()
                        tbl_upv_6:Erase(a8)
                    end
                )
                u9 = v15
            end
            return tbl_upv_6.data[a8]
        end
    end
    function tbl_upv_6.GetData(a9)
        --[[
          name: GetData
          line: 177
          upvalues:
            tbl_upv_6 (copy, index: 1)
        ]]
        return tbl_upv_6.data
    end
    return tbl_upv_6
end)()
local function initChatBubbleType(a1, a2, a3, a4, a5)
    --[[
      name: initChatBubbleType
      line: 304
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    tbl_upv_5.ChatBubble[a1] = createChatBubbleMain(a2, a5)
    local ChatBubbleWithTail_1 = tbl_upv_5.ChatBubbleWithTail
    ChatBubbleWithTail_1[a1] = createChatBubbleWithTail(a2, UDim2.new(0.5, -14, 1, (a4 and -1) or 0), UDim2.new(0, 30, 0, 14), a5)
    local ScalingChatBubbleWithTail_1 = tbl_upv_5.ScalingChatBubbleWithTail
    ScalingChatBubbleWithTail_1[a1] = createScaledChatBubbleWithTail(a2, 0.5, UDim2.new(-0.5, 0, 0, (a4 and -1) or 0), a5)
end
initChatBubbleType("dub", "ui/dialog_white", "ui/chatBubble_white_notify_bkg", false, Rect.new(5, 5, 15, 15))
initChatBubbleType("blu", "ui/dialog_blue", "ui/chatBubble_blue_notify_bkg", true, Rect.new(7, 7, 33, 33))
initChatBubbleType("red", "ui/dialog_red", "ui/chatBubble_red_notify_bkg", true, Rect.new(7, 7, 33, 33))
initChatBubbleType("gre", "ui/dialog_green", "ui/chatBubble_green_notify_bkg", true, Rect.new(7, 7, 33, 33))
function tbl_upv_5.SanitizeChatLine(a1, a2)
    --[[
      name: SanitizeChatLine
      line: 315
      upvalues:
        u5 (copy, index: 1)
    ]]
    if u5 < utf8.len(utf8.nfcnormalize(a2)) then
        return (string.sub(a2, 1, utf8.offset(a2, (u5 + utf8.len(utf8.nfcnormalize("..."))) + 1) - 1))
    end
    return a2
end
local function createBillboardInstance(a1)
    --[[
      name: createBillboardInstance
      line: 324
      upvalues:
        u6 (copy, index: 1)
        tbl_upv_5 (copy, index: 2)
    ]]
    local u10 = Instance.new("BillboardGui")
    u10.Adornee = a1
    u10.Size = UDim2.new(0, 400, 0, 250)
    u10.StudsOffset = Vector3.new(0, 1.5, 2)
    u10.Parent = u6
    local u11 = Instance.new("Frame")
    u11.Name = "BillboardFrame"
    u11.Size = UDim2.new(1, 0, 1, 0)
    u11.Position = UDim2.new(0, 0, -0.5, 0)
    u11.BackgroundTransparency = 1
    u11.Parent = u10
    local u12 = nil
    local v16 = u11.ChildRemoved:connect(
        function()
            --[[
              line: 339
              upvalues:
                u11 (copy, index: 1)
                u12 (ref,  index: 2)
                u10 (copy, index: 3)
            ]]
            if not (#u11:GetChildren() <= 1) then
                return
            end
            u12:disconnect()
            u10:Destroy()
        end
    )
    u12 = v16
    tbl_upv_5:CreateSmallTalkBubble("dub").Parent = u11
    return u10
end
function tbl_upv_5.CreateBillboardGuiHelper(a1, a2, a3)
    --[[
      name: CreateBillboardGuiHelper
      line: 351
      upvalues:
        tbl_upv_5 (copy, index: 1)
        createBillboardInstance (copy, index: 2)
    ]]
    if not a2 or (tbl_upv_5.CharacterSortedMsg:Get(a2).BillboardGui) then
        return
    end
    if not (a3) and a2:IsA("BasePart") then
        local v17 = createBillboardInstance(a2)
        tbl_upv_5.CharacterSortedMsg:Get(a2).BillboardGui = v17
        return
    end
    if a2:IsA("Model") then
        local Head_1 = a2:FindFirstChild("Head")
        if not Head_1 then
            return
        end
        if Head_1:IsA("BasePart") then
            local v18 = createBillboardInstance(Head_1)
            tbl_upv_5.CharacterSortedMsg:Get(a2).BillboardGui = v18
        end
    end
end
local function distanceToBubbleOrigin(a1)
    --[[
      name: distanceToBubbleOrigin
      line: 373
    ]]
    if a1 then
        return (a1.Position - game.Workspace.CurrentCamera.CoordinateFrame.Position).magnitude
    end
    return 1e+05
end
local function isPartOfLocalPlayer(a1)
    --[[
      name: isPartOfLocalPlayer
      line: 379
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    if a1 and Players_upv_1.LocalPlayer.Character then
        return a1:IsDescendantOf(Players_upv_1.LocalPlayer.Character)
    end
end
function tbl_upv_5.SetBillboardLODNear(a1, a2)
    --[[
      name: SetBillboardLODNear
      line: 385
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local Adornee_1 = a2.Adornee
    local v19 = not (Adornee_1) or not (Players_upv_1.LocalPlayer.Character) or Adornee_1:IsDescendantOf(Players_upv_1.LocalPlayer.Character)
    a2.Size = UDim2.new(0, 400, 0, 250)
    local v20
    if v19 then
        v20 = 1.5
    else
        v20 = 2.5
    end
    a2.StudsOffset = Vector3.new(0, v20, (v19 and 2) or 0.1)
    a2.Enabled = true
    local v21 = a2.BillboardFrame:GetChildren()
    for n_1 = 1, #v21 do
        v21[n_1].Visible = true
    end
    a2.BillboardFrame.SmallTalkBubble.Visible = false
end
function tbl_upv_5.SetBillboardLODDistant(a1, a2)
    --[[
      name: SetBillboardLODDistant
      line: 397
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    local Adornee_2 = a2.Adornee
    local v22 = not (Adornee_2) or not (Players_upv_1.LocalPlayer.Character) or Adornee_2:IsDescendantOf(Players_upv_1.LocalPlayer.Character)
    a2.Size = UDim2.new(4, 0, 3, 0)
    local v23
    if v22 then
        v23 = 2
    else
        v23 = 0.1
    end
    a2.StudsOffset = Vector3.new(0, 3, v23)
    a2.Enabled = true
    local v24 = a2.BillboardFrame:GetChildren()
    for n_2 = 1, #v24 do
        v24[n_2].Visible = false
    end
    a2.BillboardFrame.SmallTalkBubble.Visible = true
end
function tbl_upv_5.SetBillboardLODVeryFar(a1, a2)
    --[[
      name: SetBillboardLODVeryFar
      line: 409
    ]]
    a2.Enabled = false
end
function tbl_upv_5.SetBillboardGuiLOD(a1, a2, a3)
    --[[
      name: SetBillboardGuiLOD
      line: 413
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    if not a3 then
        return
    end
    local v25 = a3:IsA("Model")
    local v26 = nil
    if v25 then
        v26 = a3:FindFirstChild("Head")
        if v26 then
            a3 = v26
        else
            a3 = a3.PrimaryPart
        end
    end
    local v27
    if a3 then
        v27 = (a3.Position - game.Workspace.CurrentCamera.CoordinateFrame.Position).magnitude
    else
        v27 = 1e+05
    end
    if v27 < 65 then
        tbl_upv_5:SetBillboardLODNear(a2)
    elseif v27 >= 65 and v27 < 100 then
        tbl_upv_5:SetBillboardLODDistant(a2)
    else
        tbl_upv_5:SetBillboardLODVeryFar(a2)
    end
end
function tbl_upv_5.CameraCFrameChanged(a1)
    --[[
      name: CameraCFrameChanged
      line: 433
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    for key_1, value_1 in pairs(tbl_upv_5.CharacterSortedMsg:GetData()) do
        local BillboardGui_1 = value_1.BillboardGui
        if BillboardGui_1 then
            tbl_upv_5:SetBillboardGuiLOD(BillboardGui_1, key_1)
        end
    end
end
function tbl_upv_5.CreateBubbleText(a1, a2, a3)
    --[[
      name: CreateBubbleText
      line: 440
      upvalues:
        u2 (ref,  index: 1)
        SourceSans_upv_1 (copy, index: 2)
        Size24_upv_1 (copy, index: 3)
    ]]
    local v28 = Instance.new("TextLabel")
    v28.Name = "BubbleText"
    v28.BackgroundTransparency = 1
    if u2 then
        v28.Size = UDim2.fromScale(1, 1)
    else
        v28.Position = UDim2.new(0, 15, 0, 0)
        v28.Size = UDim2.new(1, -30, 1, 0)
    end
    v28.Font = SourceSans_upv_1
    v28.ClipsDescendants = true
    v28.TextWrapped = true
    v28.FontSize = Size24_upv_1
    v28.Text = a2
    v28.Visible = false
    v28.AutoLocalize = a3
    if u2 then
        local v29 = Instance.new("UIPadding")
        v29.PaddingTop = UDim.new(0, 12)
        v29.PaddingRight = UDim.new(0, 12)
        v29.PaddingBottom = UDim.new(0, 12)
        v29.PaddingLeft = UDim.new(0, 12)
        v29.Parent = v28
    end
    return v28
end
function tbl_upv_5.CreateSmallTalkBubble(a1, a2)
    --[[
      name: CreateSmallTalkBubble
      line: 472
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    local v30 = tbl_upv_5.ScalingChatBubbleWithTail[a2]:Clone()
    v30.Name = "SmallTalkBubble"
    v30.AnchorPoint = Vector2.new(0, 0.5)
    v30.Position = UDim2.new(0, 0, 0.5, 0)
    v30.Visible = false
    local v31 = tbl_upv_5:CreateBubbleText("...")
    v31.TextScaled = true
    v31.TextWrapped = false
    v31.Visible = true
    v31.Parent = v30
    return v30
end
function tbl_upv_5.UpdateChatLinesForOrigin(a1, a2, a3)
    --[[
      name: UpdateChatLinesForOrigin
      line: 487
      upvalues:
        tbl_upv_5 (copy, index: 1)
    ]]
    local Fifo_1 = tbl_upv_5.CharacterSortedMsg:Get(a2).Fifo
    local v32 = Fifo_1:Size()
    local v33 = Fifo_1:GetData()
    if (#v33 <= 1) then
        return
    end
    for n_3 = #v33 - 1, 1, -1 do
        local RenderBubble_1 = v33[n_3].RenderBubble
        if not RenderBubble_1 then
            return
        end
        if not ((v32 - n_3) + 1 > 1) then
            RenderBubble_1:TweenPosition(UDim2.new(RenderBubble_1.Position.X.Scale, RenderBubble_1.Position.X.Offset, 1, (a3 - RenderBubble_1.Size.Y.Offset) - 14), Enum.EasingDirection.Out, Enum.EasingStyle.Bounce, 0.1, true)
            a3 = a3 - RenderBubble_1.Size.Y.Offset - 14
            continue
        end
        local ChatBubbleTail_1 = RenderBubble_1:FindFirstChild("ChatBubbleTail")
        if ChatBubbleTail_1 then
            ChatBubbleTail_1:Destroy()
        end
        local BubbleText_1 = RenderBubble_1:FindFirstChild("BubbleText")
        if BubbleText_1 then
            BubbleText_1.TextTransparency = 0.5
        end
        RenderBubble_1:TweenPosition(UDim2.new(RenderBubble_1.Position.X.Scale, RenderBubble_1.Position.X.Offset, 1, (a3 - RenderBubble_1.Size.Y.Offset) - 14), Enum.EasingDirection.Out, Enum.EasingStyle.Bounce, 0.1, true)
        a3 = a3 - RenderBubble_1.Size.Y.Offset - 14
    end
end
function tbl_upv_5.DestroyBubble(a1, a2, a3)
    --[[
      name: DestroyBubble
      line: 513
    ]]
    if not a2 or a2:Empty() then
        return
    end
    local v34 = a2:Front()
    local RenderBubble_upv_2 = v34.RenderBubble
    if RenderBubble_upv_2 then
        spawn(
            function()
                --[[
                  line: 523
                  upvalues:
                    a2 (copy, index: 1)
                    a3 (copy, index: 2)
                    RenderBubble_upv_2 (ref,  index: 3)
                ]]
                while a2:Front().RenderBubble ~= a3 do
                    wait()
                end
                RenderBubble_upv_2 = a2:Front().RenderBubble
                local BubbleText_2 = RenderBubble_upv_2:FindFirstChild("BubbleText")
                local ChatBubbleTail_2 = RenderBubble_upv_2:FindFirstChild("ChatBubbleTail")
                while RenderBubble_upv_2 and (RenderBubble_upv_2.ImageTransparency < 1) do
                    local time_yielded_1 = wait()
                    if not (RenderBubble_upv_2) then
                        continue
                    end
                    local v35 = time_yielded_1 * 1.5
                    RenderBubble_upv_2.ImageTransparency = RenderBubble_upv_2.ImageTransparency + v35
                    if BubbleText_2 then
                        BubbleText_2.TextTransparency = BubbleText_2.TextTransparency + v35
                    end
                    if ChatBubbleTail_2 then
                        ChatBubbleTail_2.ImageTransparency = ChatBubbleTail_2.ImageTransparency + v35
                    end
                end
                if not RenderBubble_upv_2 then
                    return
                end
                RenderBubble_upv_2:Destroy()
                a2:PopFront()
            end
        )
    else
        a2:PopFront()
    end
end
function tbl_upv_5.CreateChatLineRender(a1, a2, a3, a4, a5, a6)
    --[[
      name: CreateChatLineRender
      line: 551
      upvalues:
        tbl_upv_5 (copy, index: 1)
        TextService_upv_1 (copy, index: 2)
        SourceSans_upv_1 (copy, index: 3)
        u2 (ref,  index: 4)
    ]]
    if not a2 then
        return
    end
    if not (tbl_upv_5.CharacterSortedMsg:Get(a2).BillboardGui) then
        tbl_upv_5:CreateBillboardGuiHelper(a2, a4)
    end
    local BillboardGui_2 = tbl_upv_5.CharacterSortedMsg:Get(a2).BillboardGui
    if BillboardGui_2 then
        local u13 = tbl_upv_5.ChatBubbleWithTail[a3.BubbleColor]:Clone()
        u13.Visible = false
        local u14 = tbl_upv_5:CreateBubbleText(a3.Message, a6)
        u14.Parent = u13
        u13.Parent = BillboardGui_2.BillboardFrame
        a3.RenderBubble = u13
        local v36 = TextService_upv_1:GetTextSize(u14.Text, 24, SourceSans_upv_1, Vector2.new(400, 250))
        local v37 = v36.Y / 24
        if u2 then
            local v38 = math.ceil(v36.X + 24)
            local v39 = v37 * 34
            u13.Size = UDim2.fromOffset(0, 0)
            u13.Position = UDim2.fromScale(0.5, 1)
            u13:TweenSizeAndPosition(
                UDim2.fromOffset(v38, v39),
                UDim2.new(0.5, -v38 / 2, 1, -v39),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Elastic,
                0.1,
                true,
                function()
                    --[[
                      line: 590
                      upvalues:
                        u14 (copy, index: 1)
                    ]]
                    u14.Visible = true
                end
            )
            tbl_upv_5:SetBillboardGuiLOD(BillboardGui_2, a3.Origin)
            tbl_upv_5:UpdateChatLinesForOrigin(a3.Origin, -v39)
        else
            local v40 = math.max((v36.X + 30) / 400, 0.1)
            u13.Size = UDim2.new(0, 0, 0, 0)
            u13.Position = UDim2.new(0.5, 0, 1, 0)
            local v41 = v37 * 34
            u13:TweenSizeAndPosition(
                UDim2.new(v40, 0, 0, v41),
                UDim2.new((1 - v40) / 2, 0, 1, -v41),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Elastic,
                0.1,
                true,
                function()
                    --[[
                      line: 610
                      upvalues:
                        u14 (copy, index: 1)
                    ]]
                    u14.Visible = true
                end
            )
            tbl_upv_5:SetBillboardGuiLOD(BillboardGui_2, a3.Origin)
            tbl_upv_5:UpdateChatLinesForOrigin(a3.Origin, -v41)
        end
        delay(
            a3.BubbleDieDelay,
            function()
                --[[
                  line: 617
                  upvalues:
                    tbl_upv_5 (copy, index: 1)
                    a5 (copy, index: 2)
                    u13 (copy, index: 3)
                ]]
                tbl_upv_5:DestroyBubble(a5, u13)
            end
        )
    end
end
function tbl_upv_5.OnPlayerChatMessage(a1, a2, a3, a4)
    --[[
      name: OnPlayerChatMessage
      line: 623
      upvalues:
        tbl_upv_5 (copy, index: 1)
        Players_upv_1 (copy, index: 2)
        createChatLine (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    if not tbl_upv_5:BubbleChatEnabled() then
        return
    end
    local LocalPlayer_2 = Players_upv_1.LocalPlayer
    local v42 = createChatLine(tbl_upv_5:SanitizeChatLine(a3), tbl_upv_1.WHITE, LocalPlayer_2 == nil or a2 == LocalPlayer_2)
    if a2 then
        v42.User = a2.Name
        v42.Origin = a2.Character
    end
    if not a2 then
        return
    end
    if v42.Origin then
        local Fifo_2 = tbl_upv_5.CharacterSortedMsg:Get(v42.Origin).Fifo
        Fifo_2:PushBack(v42)
        tbl_upv_5:CreateChatLineRender(a2.Character, v42, true, Fifo_2, false)
    end
end
function tbl_upv_5.OnGameChatMessage(a1, a2, a3, a4)
    --[[
      name: OnGameChatMessage
      line: 642
      upvalues:
        u3 (ref,  index: 1)
        u4 (ref,  index: 2)
        Chat_upv_1 (copy, index: 3)
        Players_upv_1 (copy, index: 4)
        tbl_upv_5 (copy, index: 5)
        createChatLine (copy, index: 6)
        u1 (copy, index: 7)
    ]]
    if u3 or u4 and Chat_upv_1.BubbleChatEnabled then
        return
    end
    local LocalPlayer_3 = Players_upv_1.LocalPlayer
    local v43 = (LocalPlayer_3 ~= nil) and (LocalPlayer_3.Character ~= a2)
    local v44 = "dub"
    if a4 == Enum.ChatColor.Blue then
        v44 = "blu"
    elseif a4 == Enum.ChatColor.Green then
        v44 = "gre"
    elseif a4 == Enum.ChatColor.Red then
        v44 = "red"
    end
    local v45 = createChatLine(tbl_upv_5:SanitizeChatLine(a3), v44, not v43)
    v45.Origin = a2
    tbl_upv_5.CharacterSortedMsg:Get(v45.Origin).Fifo:PushBack(v45)
    if u1 then
        tbl_upv_5:CreateChatLineRender(a2, v45, false, tbl_upv_5.CharacterSortedMsg:Get(v45.Origin).Fifo, true)
    else
        tbl_upv_5:CreateChatLineRender(a2, v45, false, tbl_upv_5.CharacterSortedMsg:Get(v45.Origin).Fifo, false)
    end
end
function tbl_upv_5.BubbleChatEnabled(a1)
    --[[
      name: BubbleChatEnabled
      line: 668
      upvalues:
        u3 (ref,  index: 1)
        u4 (ref,  index: 2)
        Chat_upv_1 (copy, index: 3)
        Players_upv_1 (copy, index: 4)
    ]]
    if u3 or u4 and Chat_upv_1.BubbleChatEnabled then
        return false
    end
    local ClientChatModules_1 = Chat_upv_1:FindFirstChild("ClientChatModules")
    local v46 = nil
    if ClientChatModules_1 then
        v46 = ClientChatModules_1:FindFirstChild("ChatSettings")
        if v46 then
            v46 = require(v46)
            if v46.BubbleChatEnabled ~= nil then
                return v46.BubbleChatEnabled
            end
        end
    end
    return Players_upv_1.BubbleChat
end
function tbl_upv_5.ShowOwnFilteredMessage(a1)
    --[[
      name: ShowOwnFilteredMessage
      line: 685
      upvalues:
        Chat_upv_1 (copy, index: 1)
    ]]
    local ClientChatModules_2 = Chat_upv_1:FindFirstChild("ClientChatModules")
    if ClientChatModules_2 then
        local ChatSettings_1 = ClientChatModules_2:FindFirstChild("ChatSettings")
        if ChatSettings_1 then
            return require(ChatSettings_1).ShowUserOwnFilteredMessage
        end
    end
    return false
end
function findPlayer(a1)
    --[[
      name: findPlayer
      line: 697
      upvalues:
        Players_upv_1 (copy, index: 1)
    ]]
    for _, value_2 in pairs(Players_upv_1:GetPlayers()) do
        if value_2.Name ~= a1 then
            continue
        end
        return value_2
    end
end
Chat_upv_1.Chatted:connect(
    function(a1, a2, a3)
        --[[
          line: 705
          upvalues:
            tbl_upv_5 (copy, index: 1)
        ]]
        tbl_upv_5:OnGameChatMessage(a1, a2, a3)
    end
)
local u15 = nil
if game.Workspace.CurrentCamera then
    u15 = game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(
        function(a1)
            --[[
              line: 709
              upvalues:
                tbl_upv_5 (copy, index: 1)
            ]]
            tbl_upv_5:CameraCFrameChanged()
        end
    )
end
game.Workspace.Changed:Connect(
    function(a1)
        --[[
          line: 712
          upvalues:
            u15 (ref,  index: 1)
            tbl_upv_5 (copy, index: 2)
        ]]
        if a1 ~= "CurrentCamera" then
            return
        end
        if u15 then
            u15:disconnect()
        end
        if game.Workspace.CurrentCamera then
            local v47 = game.Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(
                function(a2)
                    --[[
                      line: 716
                      upvalues:
                        tbl_upv_5 (copy, index: 1)
                    ]]
                    tbl_upv_5:CameraCFrameChanged()
                end
            )
            u15 = v47
        end
    end
)
local u16 = nil
function getAllowedMessageTypes()
    --[[
      name: getAllowedMessageTypes
      line: 724
      upvalues:
        u16 (ref,  index: 1)
        Chat_upv_1 (copy, index: 2)
    ]]
    if u16 then
        return u16
    end
    local ClientChatModules_3 = Chat_upv_1:FindFirstChild("ClientChatModules")
    if not ClientChatModules_3 then
        return {"Message", "Whisper"}
    end
    local ChatSettings_2 = ClientChatModules_3:FindFirstChild("ChatSettings")
    if ChatSettings_2 then
        ChatSettings_2 = require(ChatSettings_2)
        if ChatSettings_2.BubbleChatMessageTypes then
            u16 = ChatSettings_2.BubbleChatMessageTypes
            return u16
        end
    end
    local ChatConstants_1 = ClientChatModules_3:FindFirstChild("ChatConstants")
    if ChatConstants_1 then
        ChatConstants_1 = require(ChatConstants_1)
        u16 = {ChatConstants_1.MessageTypeDefault, ChatConstants_1.MessageTypeWhisper}
    end
    return u16
end
function checkAllowedMessageType(a1)
    --[[
      name: checkAllowedMessageType
      line: 748
    ]]
    local v48 = getAllowedMessageTypes()
    for n_4 = 1, #v48 do
        if v48[n_4] ~= a1.MessageType then
            continue
        end
        return true
    end
    return false
end
local DefaultChatSystemChatEvents_1 = ReplicatedStorage_1:WaitForChild("DefaultChatSystemChatEvents")
local OnMessageDoneFiltering_1 = DefaultChatSystemChatEvents_1:WaitForChild("OnMessageDoneFiltering")
DefaultChatSystemChatEvents_1:WaitForChild("OnNewMessage").OnClientEvent:connect(
    function(a1, a2)
        --[[
          line: 762
          upvalues:
            LocalPlayer_upv_1 (ref,  index: 1)
            tbl_upv_5 (copy, index: 2)
        ]]
        if not checkAllowedMessageType(a1) then
            return
        end
        local v49 = findPlayer(a1.FromSpeaker)
        if not v49 then
            return
        end
        if (not a1.IsFiltered or a1.FromSpeaker == LocalPlayer_upv_1.Name) and a1.FromSpeaker == LocalPlayer_upv_1.Name and not (tbl_upv_5:ShowOwnFilteredMessage()) then
            tbl_upv_5:OnPlayerChatMessage(v49, a1.Message, nil)
        end
        tbl_upv_5:OnPlayerChatMessage(v49, a1.Message, nil)
    end
)
OnMessageDoneFiltering_1.OnClientEvent:connect(
    function(a1, a2)
        --[[
          line: 781
          upvalues:
            LocalPlayer_upv_1 (ref,  index: 1)
            tbl_upv_5 (copy, index: 2)
        ]]
        if not checkAllowedMessageType(a1) then
            return
        end
        local v50 = findPlayer(a1.FromSpeaker)
        if not v50 then
            return
        end
        if a1.FromSpeaker ~= LocalPlayer_upv_1.Name or tbl_upv_5:ShowOwnFilteredMessage() then
            tbl_upv_5:OnPlayerChatMessage(v50, a1.Message, nil)
        end
    end
)