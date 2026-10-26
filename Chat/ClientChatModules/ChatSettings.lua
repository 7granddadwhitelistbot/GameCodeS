local Players_1 = game:GetService("Players")
local ChatConstants_1 = require(script.Parent:WaitForChild("ChatConstants"))
local tbl_upv_1 = {}
tbl_upv_1.WindowDraggable = false
tbl_upv_1.WindowResizable = false
tbl_upv_1.ShowChannelsBar = false
tbl_upv_1.GamepadNavigationEnabled = false
tbl_upv_1.AllowMeCommand = false
tbl_upv_1.ShowUserOwnFilteredMessage = true
tbl_upv_1.ChatOnWithTopBarOff = false
tbl_upv_1.ScreenGuiDisplayOrder = 6
tbl_upv_1.ShowFriendJoinNotification = true
tbl_upv_1.BubbleChatEnabled = Players_1.BubbleChat
tbl_upv_1.ClassicChatEnabled = Players_1.ClassicChat
tbl_upv_1.ChatWindowTextSize = 18
tbl_upv_1.ChatChannelsTabTextSize = 18
tbl_upv_1.ChatBarTextSize = 18
tbl_upv_1.ChatWindowTextSizePhone = 14
tbl_upv_1.ChatChannelsTabTextSizePhone = 18
tbl_upv_1.ChatBarTextSizePhone = 14
tbl_upv_1.DefaultFont = Enum.Font.SourceSansBold
tbl_upv_1.ChatBarFont = Enum.Font.SourceSansBold
tbl_upv_1.BackGroundColor = Color3.new(0, 0, 0)
tbl_upv_1.DefaultMessageColor = Color3.new(1, 1, 1)
tbl_upv_1.DefaultNameColor = Color3.new(1, 1, 1)
tbl_upv_1.ChatBarBackGroundColor = Color3.new(0, 0, 0)
tbl_upv_1.ChatBarBoxColor = Color3.new(1, 1, 1)
tbl_upv_1.ChatBarTextColor = Color3.new(0, 0, 0)
tbl_upv_1.ChannelsTabUnselectedColor = Color3.new(0, 0, 0)
tbl_upv_1.ChannelsTabSelectedColor = Color3.new(0.11764705882352941, 0.11764705882352941, 0.11764705882352941)
tbl_upv_1.DefaultChannelNameColor = Color3.fromRGB(35, 76, 142)
tbl_upv_1.WhisperChannelNameColor = Color3.fromRGB(102, 14, 102)
tbl_upv_1.ErrorMessageTextColor = Color3.fromRGB(245, 50, 50)
tbl_upv_1.MinimumWindowSize = UDim2.new(0.3, 0, 0.25, 0)
tbl_upv_1.MaximumWindowSize = UDim2.new(1, 0, 1, 0)
tbl_upv_1.DefaultWindowPosition = UDim2.new(0, 0, 0, 0)
tbl_upv_1.DefaultWindowSizePhone = UDim2.new(0.5, 0, 0.5, 24)
tbl_upv_1.DefaultWindowSizeTablet = UDim2.new(0.4, 0, 0.3, 24)
tbl_upv_1.DefaultWindowSizeDesktop = UDim2.new(0.3, 0, 0.25, 24)
tbl_upv_1.ChatWindowBackgroundFadeOutTime = 3.5
tbl_upv_1.ChatWindowTextFadeOutTime = 30
tbl_upv_1.ChatDefaultFadeDuration = 0.8
tbl_upv_1.ChatShouldFadeInFromNewInformation = false
tbl_upv_1.ChatAnimationFPS = 20
tbl_upv_1.GeneralChannelName = "All"
tbl_upv_1.EchoMessagesInGeneralChannel = true
tbl_upv_1.ChannelsBarFullTabSize = 4
tbl_upv_1.MaxChannelNameLength = 12
tbl_upv_1.MaxChannelNameCheckLength = 50
tbl_upv_1.RightClickToLeaveChannelEnabled = false
tbl_upv_1.MessageHistoryLengthPerChannel = 50
tbl_upv_1.ShowJoinAndLeaveHelpText = false
tbl_upv_1.MaximumMessageLength = 200
tbl_upv_1.DisallowedWhiteSpace = {"\n", "\r", "\t", "\v", "\f"}
tbl_upv_1.ClickOnPlayerNameToWhisper = true
tbl_upv_1.ClickOnChannelNameToSetMainChannel = true
tbl_upv_1.BubbleChatMessageTypes = {ChatConstants_1.MessageTypeDefault, ChatConstants_1.MessageTypeWhisper}
tbl_upv_1.WhisperCommandAutoCompletePlayerNames = true
tbl_upv_1.PlayerDisplayNamesEnabled = true
tbl_upv_1.WhisperByDisplayName = true
local u1 = Instance.new("BindableEvent")
local tbl_2 = {}
local tbl_3 = {}
function tbl_3.__index(a1, a2)
    --[[
      name: __index
      line: 107
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return tbl_upv_1[a2]
end
function tbl_3.__newindex(a1, a2, a3)
    --[[
      name: __newindex
      line: 110
      upvalues:
        tbl_upv_1 (copy, index: 1)
        u1 (copy, index: 2)
    ]]
    tbl_upv_1[a2] = a3
    u1:Fire(a2, a3)
end
local v1 = setmetatable(tbl_2, tbl_3)
rawset(v1, "SettingsChanged", u1.Event)
return v1