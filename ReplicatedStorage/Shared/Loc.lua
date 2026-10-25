local Players_upv_1 = game:GetService("Players")
local LocalizationService_upv_1 = game:GetService("LocalizationService")
local RunService_upv_1 = game:GetService("RunService")
local Workspace_upv_1 = game:GetService("Workspace")
local tbl_upv_1 = {}
tbl_upv_1.LANGS = {"es", "pt", "ru", "th", "fr"}
tbl_upv_1.Changed = require(script.Parent:WaitForChild("Signal")).new()
local u1 = "en"
local u2 = "en-us"
local u3 = nil
local u4 = nil
local u5 = false
local function langOf(a1)
    --[[
      name: langOf
      line: 52
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v1 = string.lower(string.sub(a1 or "", 1, 2))
    if table.find(tbl_upv_1.LANGS, v1) then
        return v1
    end
    return "en"
end
local function testLang()
    --[[
      name: testLang
      line: 57
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    if not RunService_upv_1:IsStudio() then
        return nil
    end
    local v2 = Workspace_upv_1:GetAttribute("LocTest")
    if type(v2) == "string" and table.find(tbl_upv_1.LANGS, v2) then
        return v2
    end
    return nil
end
local function retranslate(a1)
    --[[
      name: retranslate
      line: 96
    ]]
    for _, value_1 in a1:GetDescendants() do
        if (value_1:IsA("TextLabel") or value_1:IsA("TextButton") or value_1:IsA("TextBox")) and value_1.AutoLocalize then
            value_1.AutoLocalize = false
            value_1.AutoLocalize = true
        end
    end
end
local function setLocale(a1)
    --[[
      name: setLocale
      line: 105
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
        u2 (ref,  index: 4)
        u4 (ref,  index: 5)
        u3 (ref,  index: 6)
        u1 (ref,  index: 7)
    ]]
    local v3, v4 = nil, nil
    if RunService_upv_1:IsStudio() then
        v3 = Workspace_upv_1:GetAttribute("LocTest")
        v4 = type(v3) ~= "string" or not (table.find(tbl_upv_1.LANGS, v3)) or v3
    else
        v4 = nil
    end
    if v4 then
        a1 = "en-us"
    end
    u2 = a1
    local v5 = nil
    if v4 then
        v3 = v4
    else
        v5 = string.lower(string.sub(a1 or "", 1, 2))
        if table.find(tbl_upv_1.LANGS, v5) then
            v3 = v5
        else
            v3 = "en"
        end
    end
    u4 = nil
    if u3 then
        local success_1, v6 = pcall(
            function()
                --[[
                  line: 114
                  upvalues:
                    u3 (ref, index: 1)
                    a1 (ref, index: 2)
                ]]
                return u3:GetTranslator(a1)
            end
        )
        if success_1 then
            u4 = v6
        end
    end
    if v3 == u1 then
        return
    end
    u1 = v3
    tbl_upv_1.Changed:Fire(v3)
end
local function build()
    --[[
      name: build
      line: 65
      upvalues:
        RunService_upv_1 (copy, index: 1)
        Workspace_upv_1 (copy, index: 2)
        tbl_upv_1 (copy, index: 3)
    ]]
    local Strings_1 = require(script:WaitForChild("Strings"))
    local v7, v8 = nil, nil
    if RunService_upv_1:IsStudio() then
        v7 = Workspace_upv_1:GetAttribute("LocTest")
        v8 = type(v7) ~= "string" or not (table.find(tbl_upv_1.LANGS, v7)) or v7
    else
        v8 = nil
    end
    local v9 = table.create(#Strings_1)
    local tbl_2 = {}
    local v10 = nil
    for _, value_2 in Strings_1 do
        local v11 = value_2[1]
        if type(v11) ~= "string" or v11 == "" or tbl_2[v11] then
            continue
        end
        tbl_2[v11] = true
        local tbl_3 = {}
        for key_1, value_3 in tbl_upv_1.LANGS do
            v10 = value_2[key_1 + 1]
            if type(v10) ~= "string" then
                continue
            end
            if v10 ~= "" then
                tbl_3[value_3] = v10
            end
        end
        if v8 then
            tbl_3["en-us"] = tbl_3[v8] or v11
        end
        table.insert(v9, {Key = "", Example = "", Context = "", Source = v11, Values = tbl_3})
    end
    local v12 = Instance.new("LocalizationTable")
    v12.Name = "TribesStrings"
    v12.SourceLocaleId = (v8 and "zz-zz") or "en-us"
    v12:SetEntries(v9)
    return v12
end
function tbl_upv_1.Install()
    --[[
      name: Install
      line: 127
      upvalues:
        u5 (ref,  index: 1)
        u3 (ref,  index: 2)
        RunService_upv_1 (copy, index: 3)
        LocalizationService_upv_1 (copy, index: 4)
        build (copy, index: 5)
        Players_upv_1 (copy, index: 6)
        setLocale (copy, index: 7)
        retranslate (copy, index: 8)
    ]]
    if u5 then
        return u3
    end
    u5 = true
    if not RunService_upv_1:IsClient() then
        return nil
    end
    local TribesStrings_1 = LocalizationService_upv_1:FindFirstChild("TribesStrings")
    if TribesStrings_1 and TribesStrings_1:IsA("LocalizationTable") then
        u3 = TribesStrings_1
        local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
        setLocale((LocalPlayer_upv_1 and (LocalPlayer_upv_1.LocaleId)) or "en-us")
        if LocalPlayer_upv_1 then
            local v13 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
            if v13 then
                retranslate(v13)
            end
            task.spawn(
                function()
                    --[[
                      line: 155
                      upvalues:
                        LocalizationService_upv_1 (copy, index: 1)
                        LocalPlayer_upv_1 (copy, index: 2)
                        setLocale (copy, index: 3)
                    ]]
                    local success_2, u6 = pcall(
                        function()
                            --[[
                              line: 156
                              upvalues:
                                LocalizationService_upv_1 (copy, index: 1)
                                LocalPlayer_upv_1 (copy, index: 2)
                            ]]
                            return LocalizationService_upv_1:GetTranslatorForPlayerAsync(LocalPlayer_upv_1)
                        end
                    )
                    if not success_2 or not u6 then
                        return
                    end
                    setLocale(u6.LocaleId)
                    u6:GetPropertyChangedSignal("LocaleId"):Connect(
                        function()
                            --[[
                              line: 161
                              upvalues:
                                setLocale (copy, index: 1)
                                u6 (copy, index: 2)
                            ]]
                            setLocale(u6.LocaleId)
                        end
                    )
                end
            )
        end
        return u3
    end
    local success_3, v14 = pcall(build)
    if success_3 then
        u3 = v14
        v14.Parent = LocalizationService_upv_1
        local LocalPlayer_upv_1 = Players_upv_1.LocalPlayer
        setLocale((LocalPlayer_upv_1 and (LocalPlayer_upv_1.LocaleId)) or "en-us")
        if LocalPlayer_upv_1 then
            local v13 = LocalPlayer_upv_1:FindFirstChildOfClass("PlayerGui")
            if v13 then
                retranslate(v13)
            end
            task.spawn(
                function()
                    --[[
                      line: 155
                      upvalues:
                        LocalizationService_upv_1 (copy, index: 1)
                        LocalPlayer_upv_1 (copy, index: 2)
                        setLocale (copy, index: 3)
                    ]]
                    local success_2, u6 = pcall(
                        function()
                            --[[
                              line: 156
                              upvalues:
                                LocalizationService_upv_1 (copy, index: 1)
                                LocalPlayer_upv_1 (copy, index: 2)
                            ]]
                            return LocalizationService_upv_1:GetTranslatorForPlayerAsync(LocalPlayer_upv_1)
                        end
                    )
                    if not success_2 or not u6 then
                        return
                    end
                    setLocale(u6.LocaleId)
                    u6:GetPropertyChangedSignal("LocaleId"):Connect(
                        function()
                            --[[
                              line: 161
                              upvalues:
                                setLocale (copy, index: 1)
                                u6 (copy, index: 2)
                            ]]
                            setLocale(u6.LocaleId)
                        end
                    )
                end
            )
        end
        return u3
    end
    warn("[Loc] table not built: " .. tostring(v14))
    return nil
end
function tbl_upv_1.Lang()
    --[[
      name: Lang
      line: 170
      upvalues:
        u1 (ref, index: 1)
    ]]
    return u1
end
function tbl_upv_1.T(a1)
    --[[
      name: T
      line: 175
      upvalues:
        u1 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
        u4 (ref,  index: 5)
    ]]
    if u1 == "en" then
        local v15, v16 = nil, nil
        if RunService_upv_1:IsStudio() then
            v15 = Workspace_upv_1:GetAttribute("LocTest")
            v16 = type(v15) ~= "string" or not (table.find(tbl_upv_1.LANGS, v15)) or v15
        else
            v16 = nil
        end
        if not (v16) then
            return a1
        end
    end
    local u7 = u4
    if not u7 then
        return a1
    end
    local success_4, v17 = pcall(
        function()
            --[[
              line: 183
              upvalues:
                u7 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            return u7:Translate(game, a1)
        end
    )
    if success_4 and type(v17) == "string" then
        return v17
    end
    return a1
end
function tbl_upv_1.Pick(a1, a2)
    --[[
      name: Pick
      line: 193
      upvalues:
        u1 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
    ]]
    if u1 == "en" then
        local v18, v19 = nil, nil
        if RunService_upv_1:IsStudio() then
            v18 = Workspace_upv_1:GetAttribute("LocTest")
            v19 = type(v18) ~= "string" or not (table.find(tbl_upv_1.LANGS, v18)) or v18
        else
            v19 = nil
        end
        if not (v19) then
            return a2
        end
    end
    local v20 = tbl_upv_1.T(a1)
    if v20 ~= a1 then
        return v20
    end
    return a2
end
function tbl_upv_1.Rich(a1, a2)
    --[[
      name: Rich
      line: 204
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    a1.AutoLocalize = false
    a1.Text = tbl_upv_1.T(a2)
end
function tbl_upv_1.Off(a1)
    --[[
      name: Off
      line: 211
    ]]
    a1.AutoLocalize = false
    return a1
end
function tbl_upv_1.Fit(a1, a2, a3)
    --[[
      name: Fit
      line: 219
    ]]
    if a1:FindFirstChild("LocFit") then
        return a1
    end
    local u8 = Instance.new("UITextSizeConstraint")
    u8.Name = "LocFit"
    local TextSize_1 = a1.TextSize
    u8.MaxTextSize = math.max(1, TextSize_1)
    local v21 = a2 or (math.max(8, math.floor(TextSize_1 * 0.6)))
    u8.MinTextSize = math.min(TextSize_1, v21)
    u8.Parent = a1
    a1.TextScaled = true
    local function cap()
        --[[
          name: cap
          line: 226
          upvalues:
            a1 (copy, index: 1)
            u8 (copy, index: 2)
            a2 (copy, index: 3)
        ]]
        local TextSize_2 = a1.TextSize
        u8.MaxTextSize = math.max(1, TextSize_2)
        local v22 = a2 or (math.max(8, math.floor(TextSize_2 * 0.6)))
        u8.MinTextSize = math.min(TextSize_2, v22)
    end
    a1:GetPropertyChangedSignal("TextSize"):Connect(cap)
    if a3 and a3 > 0 and not (a1:FindFirstChildOfClass("UIPadding")) then
        local v23 = Instance.new("UIPadding")
        v23.PaddingLeft = UDim.new(a3, 0)
        v23.PaddingRight = UDim.new(a3, 0)
        v23.Parent = a1
    end
    return a1
end
function tbl_upv_1.Missing(a1)
    --[[
      name: Missing
      line: 245
      upvalues:
        u3 (ref,  index: 1)
        RunService_upv_1 (copy, index: 2)
        Workspace_upv_1 (copy, index: 3)
        tbl_upv_1 (copy, index: 4)
        u2 (ref,  index: 5)
    ]]
    local tbl_4 = {}
    if not u3 then
        return tbl_4
    end
    local tbl_5 = {}
    local v24, v25 = nil, nil
    if RunService_upv_1:IsStudio() then
        v24 = Workspace_upv_1:GetAttribute("LocTest")
        v25 = type(v24) ~= "string" or not (table.find(tbl_upv_1.LANGS, v24)) or v24
    else
        v25 = nil
    end
    local v26
    if v25 then
        v26 = "en-us"
    else
        v26 = u2
    end
    __setlist(tbl_5, 1, {u3:GetTranslator(v26), u3:GetTranslator("th")})
    local v27, v28, v29 = nil, nil, nil
    for _, value_upv_4 in a1:GetDescendants() do
        if value_upv_4:IsA("TextLabel") and (value_upv_4.AutoLocalize) and (value_upv_4.Visible) and value_upv_4.Text ~= "" or not value_upv_4:IsA("TextLabel") and (value_upv_4:IsA("TextButton")) and (value_upv_4.AutoLocalize) and (value_upv_4.Visible) and value_upv_4.Text ~= "" then
            local Text_upv_1 = value_upv_4.Text
            if not (string.find(Text_upv_1, "%a")) then
                continue
            end
            v27 = false
            for v32, value_upv_5 in tbl_5 do
                local success_5, v30 = pcall(
                    function()
                        --[[
                          line: 258
                          upvalues:
                            value_upv_5 (copy, index: 1)
                            value_upv_4 (copy, index: 2)
                            Text_upv_1 (copy, index: 3)
                        ]]
                        return value_upv_5:Translate(value_upv_4, Text_upv_1)
                    end
                )
                v27 = v27 or success_5 and v30 ~= Text_upv_1
            end
            if v27 then
                continue
            end
            v29 = true
            v28 = value_upv_4.Parent
            while v28 and v28 ~= a1 do
                if (v28:IsA("GuiObject")) and not v28.Visible then
                    v29 = false
                    break
                elseif not (v28:IsA("LayerCollector")) or v28.Enabled then
                    v28 = v28.Parent
                end
            end
            if v29 then
                local tbl_6 = {value_upv_4:GetFullName(), Text_upv_1}
                table.insert(tbl_4, tbl_6)
            end
        end
    end
    return tbl_4
end
return tbl_upv_1