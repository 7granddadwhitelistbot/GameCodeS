local v1
local maxTextSize
local replicatedFirst = game:GetService("ReplicatedFirst")
pcall(
    function()
        --[[
          line: 10
          upvalues:
            replicatedFirst (copy, index: 1)
        ]]
        replicatedFirst:RemoveDefaultLoadingScreen()
    end
)
local timestamp = os.clock()
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local localPlayer = players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
pcall(
    function()
        --[[
          line: 23
          upvalues:
            playerGui (copy, index: 1)
        ]]
        playerGui.ScreenOrientation = Enum.ScreenOrientation.LandscapeSensor
    end
)
local v12 = {
    {"3V3 ARENA  ·  BEST OF 5", "ARENA 3V3  ·  AL MEJOR DE 5", "ARENA 3V3  ·  MELHOR DE 5", "АРЕНА 3 НА 3  ·  ДО 3 ПОБЕД", "อารีน่า 3V3  ·  ชนะ 3 ใน 5", "ARÈNE 3V3  ·  AU MEILLEUR DES 5"},
    {"TIP", "CONSEJO", "DICA", "СОВЕТ", "เคล็ดลับ", "ASTUCE"},
    {"LOADING…", "CARGANDO…", "CARREGANDO…", "ЗАГРУЗКА…", "กำลังโหลด…", "CHARGEMENT…"},
    {"ALMOST THERE…", "YA CASI…", "QUASE LÁ…", "ПОЧТИ ГОТОВО…", "ใกล้แล้ว…", "PRESQUE PRÊT…"},
    {"READY!", "¡LISTO!", "PRONTO!", "ГОТОВО!", "พร้อมแล้ว!", "PRÊT !"},
    {"SKIP  ›", "SALTAR  ›", "PULAR  ›", "ПРОПУСТИТЬ  ›", "ข้าม  ›", "PASSER  ›"},
    {
        "Best of 5: win three rounds to take the match. One life per round.",
        "Al mejor de 5: gana tres rondas para llevarte la partida. Una vida por ronda.",
        "Melhor de 5: vença três rodadas para levar a partida. Uma vida por rodada.",
        "До трёх побед: выиграйте три раунда, чтобы взять матч. Одна жизнь на раунд.",
        "ชนะ 3 ใน 5: ชนะสามรอบเพื่อคว้าแมตช์ หนึ่งชีวิตต่อรอบ",
        "Au meilleur des 5 : gagnez trois manches pour remporter la partie. Une vie par manche."
    },
    {
        "Arrows drop over distance. Aim a little high on far targets.",
        "Las flechas caen con la distancia. Apunta un poco más alto a los blancos lejanos.",
        "As flechas caem com a distância. Mire um pouco acima em alvos distantes.",
        "Стрелы падают на расстоянии. По дальним целям цельтесь чуть выше.",
        "ลูกธนูจะตกตามระยะ เล็งสูงขึ้นเล็กน้อยเมื่อยิงเป้าที่อยู่ไกล",
        "Les flèches retombent avec la distance. Visez un peu plus haut sur les cibles lointaines."
    },
    {"Headshots hit much harder. Aim for the head.", "Los tiros a la cabeza pegan mucho más fuerte. Apunta a la cabeza.", "Tiros na cabeça causam muito mais dano. Mire na cabeça.", "Попадания в голову бьют гораздо сильнее. Цельтесь в голову.", "การยิงโดนหัวแรงกว่ามาก เล็งที่หัว", "Les tirs à la tête font bien plus mal. Visez la tête."},
    {"Slide into cover, then jump out swinging.", "Deslízate a cubierto y sal saltando al ataque.", "Deslize até a cobertura e saia pulando no ataque.", "Подкатом в укрытие, затем выпрыгивайте в атаку.", "สไลด์เข้าที่กำบัง แล้วกระโดดออกมาโจมตี", "Glissez à couvert, puis jaillissez en frappant."},
    {
        "When the ring of fire closes in, fight in the middle or burn.",
        "Cuando el anillo de fuego se cierre, pelea en el centro o arde.",
        "Quando o anel de fogo fechar, lute no meio ou queime.",
        "Когда огненное кольцо сжимается, бейтесь в центре или сгорите.",
        "เมื่อวงไฟหดเข้ามา สู้ตรงกลางหรือไม่ก็โดนไฟเผา",
        "Quand l'anneau de feu se resserre, battez-vous au centre ou brûlez."
    },
    {
        "Open LOADOUT and spend your gear points on any mix you like.",
        "Abre EQUIPAMIENTO y gasta tus puntos de equipo como quieras.",
        "Abra EQUIPAMENTO e gaste seus pontos de equipamento como quiser.",
        "Откройте СНАРЯЖЕНИЕ и тратьте очки снаряжения как угодно.",
        "เปิด ชุดอุปกรณ์ แล้วใช้แต้มอุปกรณ์จัดชุดได้ตามใจ",
        "Ouvrez ÉQUIPEMENT et dépensez vos points d'équipement comme vous voulez."
    },
    {
        "Ammo is part of your loadout: bring enough arrows for the round.",
        "La munición es parte de tu equipamiento: lleva flechas suficientes para la ronda.",
        "A munição faz parte do seu equipamento: leve flechas suficientes para a rodada.",
        "Боеприпасы входят в снаряжение: берите достаточно стрел на раунд.",
        "กระสุนเป็นส่วนหนึ่งของชุดอุปกรณ์: พกลูกธนูให้พอสำหรับทั้งรอบ",
        "Les munitions font partie de votre équipement : prenez assez de flèches pour la manche."
    },
    {
        "Hold block with the Iron Sword to soften hits from the front.",
        "Mantén el bloqueo con la Espada de Hierro para amortiguar los golpes de frente.",
        "Segure o bloqueio com a Espada de Ferro para amortecer golpes de frente.",
        "Держите блок Железным мечом, чтобы смягчать удары спереди.",
        "กดค้างเพื่อป้องกันด้วยดาบเหล็ก ลดความแรงของการโจมตีจากด้านหน้า",
        "Maintenez la parade avec l'Épée de fer pour amortir les coups de face."
    },
    {"Throwing knives: 5 per round. Make them count.", "Cuchillos arrojadizos: 5 por ronda. Que cuenten.", "Facas de arremesso: 5 por rodada. Faça valer.", "Метательные ножи: 5 за раунд. Не тратьте зря.", "มีดขว้าง: 5 เล่มต่อรอบ ใช้ให้คุ้ม", "Couteaux de lancer : 5 par manche. Ne les gâchez pas."},
    {"Practise on the dummies in the lobby's training range.", "Practica con los muñecos en la zona de entrenamiento del lobby.", "Pratique nos bonecos na área de treino do lobby.", "Тренируйтесь на манекенах на полигоне в лобби.", "ฝึกกับหุ่นในลานฝึกของล็อบบี้", "Entraînez-vous sur les mannequins du terrain d'entraînement du lobby."}
}

pcall(
    function()
        --[[
          line: 48
          upvalues:
            runService (copy, index: 1)
            workspace (copy, index: 2)
            v12 (copy, index: 3)
        ]]
        local sourceLocaleId
        local localizationService = game:GetService("LocalizationService")

        if localizationService:FindFirstChild("TribesLoading") then
            return
        end

        local v15 = {"es", "pt", "ru", "th", "fr"}
        local v16 = if runService:IsStudio() then workspace:GetAttribute("LocTest") else nil
        local entries = {}

        for _, v19 in v12 do
            local values = {}

            for v21, v22 in v15 do
                values[v22] = v19[v21 + 1]

                if v22 == v16 then
                    values["en-us"] = v19[v21 + 1]
                end
            end

            table.insert(entries, {Key = "", Context = "", Example = "", Source = v19[1], Values = values})
        end

        local tribesLoading = Instance.new("LocalizationTable")
        tribesLoading.Name = "TribesLoading"

        if type(v16) ~= "string" or not table.find(v15, v16) then
            sourceLocaleId = "en-us"
        else
            sourceLocaleId = "zz-zz"
        end

        tribesLoading.SourceLocaleId = sourceLocaleId
        tribesLoading:SetEntries(entries)
        tribesLoading.Parent = localizationService
    end
)

local function touchLayout()
    --[[
      name: touchLayout
      line: 74
      upvalues:
        userInputService (copy, index: 1)
    ]]
    if not userInputService.TouchEnabled then
        return false
    end
    if not userInputService.KeyboardEnabled or not userInputService.MouseEnabled then
        return true
    end

    local success, isTouch = pcall(
        function()
            --[[
              line: 81
              upvalues:
                userInputService (copy, index: 1)
            ]]
            return userInputService.PreferredInput == Enum.PreferredInput.Touch
        end
    )

    return success and (isTouch == true)
end

if userInputService.TouchEnabled then
    if not userInputService.KeyboardEnabled or not userInputService.MouseEnabled then
        v1 = true
    else
        local success, isTouch = pcall(
            function()
                --[[
                  line: 81
                  upvalues:
                    userInputService (copy, index: 1)
                ]]
                return userInputService.PreferredInput == Enum.PreferredInput.Touch
            end
        )
        v1 = success
        v1 = v1 and isTouch == true
    end
else
    v1 = false
end

local fontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Heavy)
local fontFace2 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold)
local fontFace3 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold)
local fontFace4 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold)
local color3 = Color3.fromRGB(6, 7, 10)
local color32 = Color3.fromRGB(40, 150, 255)
local color33 = Color3.fromRGB(236, 240, 247)

local function new(a37: string, properties, a39)
    --[[
      name: new
      line: 96
    ]]
    local parent = Instance.new(a37)

    for v41, v42 in properties do
        if v41 ~= "Parent" then
            parent[v41] = v42
        end
    end

    if parent:IsA("GuiObject") then
        parent.BorderSizePixel = 0
    end

    if a39 then
        for _, uiComponent in a39 do
            uiComponent.Parent = parent
        end
    end

    if properties.Parent then
        parent.Parent = properties.Parent
    end

    return parent
end

local function tween(instance: Instance, a47: number?, propertyTable, a49, a50)
    --[[
      name: tween
      line: 117
      upvalues:
        tweenService (copy, index: 1)
    ]]
    local newTweenInfo = TweenInfo.new
    local v52 = a49 or Enum.EasingStyle.Quint
    local v53 = a50 or Enum.EasingDirection.Out
    local tween = tweenService:Create(instance, newTweenInfo(a47, v52, v53), propertyTable)
    tween:Play()

    return tween
end

local v55 = {Name = "TR_Loading", DisplayOrder = 100, IgnoreGuiInset = true, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = playerGui}
local parent = Instance.new("ScreenGui")

for v57, v58 in v55 do
    if v57 ~= "Parent" then
        parent[v57] = v58
    end
end

if parent:IsA("GuiObject") then
    parent.BorderSizePixel = 0
end

if v55.Parent then
    parent.Parent = v55.Parent
end

parent.ScreenInsets = Enum.ScreenInsets.None
local properties = {Active = true, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), Parent = parent}
local v60 = {}
local v61 = {Rotation = 90, Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 30, 40)), ColorSequenceKeypoint.new(0.55, Color3.fromRGB(14, 16, 22)), ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 7, 10))})}
local uiGradient = Instance.new("UIGradient")

for v63, v64 in v61 do
    local v65 = v64
    local v66 = v63

    if v66 ~= "Parent" then
        uiGradient[v66] = v65
    end
end

if uiGradient:IsA("GuiObject") then
    uiGradient.BorderSizePixel = 0
end

if v61.Parent then
    uiGradient.Parent = v61.Parent
end

v60[1] = uiGradient
local instance4 = new("Frame", properties, v60)
local vector2 = if v1 then Vector2.new(1280, 600) else Vector2.new(1600, 900)
local v69 = {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = parent}
local parent2 = Instance.new("Frame")

for v71, v72 in v69 do
    if v71 ~= "Parent" then
        parent2[v71] = v72
    end
end

if parent2:IsA("GuiObject") then
    parent2.BorderSizePixel = 0
end

if v69.Parent then
    parent2.Parent = v69.Parent
end

local v73 = {Parent = parent2}
local uiScale = Instance.new("UIScale")

for v75, frame in v73 do
    local frame2 = frame

    if v75 ~= "Parent" then
        uiScale[v75] = frame2
    end
end

if uiScale:IsA("GuiObject") then
    uiScale.BorderSizePixel = 0
end

if v73.Parent then
    uiScale.Parent = v73.Parent
end

local camera = workspace.CurrentCamera
local v79 = camera and camera.ViewportSize or vector2
local scale = math.clamp(math.min(v79.X / vector2.X, v79.Y / vector2.Y), 0.4, 1.6)
uiScale.Scale = scale
parent2.Size = UDim2.fromScale(1 / scale, 1 / scale)
local v81 = workspace.CurrentCamera

v81 = v81
    and workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(
        function()
            --[[
              name: rescale
              line: 152
              upvalues:
                workspace (copy, index: 1)
                vector2 (copy, index: 2)
                uiScale (copy, index: 3)
                parent2 (copy, index: 4)
            ]]
            local camera = workspace.CurrentCamera
            local v83 = camera and camera.ViewportSize or vector2
            local scale = math.clamp(math.min(v83.X / vector2.X, v83.Y / vector2.Y), 0.4, 1.6)
            uiScale.Scale = scale
            parent2.Size = UDim2.fromScale(1 / scale, 1 / scale)
        end
    )

local v85 = {BackgroundTransparency = 1, Size = UDim2.fromOffset(1, 1), Parent = parent2}
local frame = Instance.new("Frame")

for v87, v88 in v85 do
    local v89 = v88
    local v90 = v87

    if v90 ~= "Parent" then
        frame[v90] = v89
    end
end

if frame:IsA("GuiObject") then
    frame.BorderSizePixel = 0
end

if v85.Parent then
    frame.Parent = v85.Parent
end

local v91 = {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromOffset(1100, 300), Parent = parent2}
local parent3 = Instance.new("Frame")

for v93, v94 in v91 do
    local v95 = v93

    if v95 ~= "Parent" then
        parent3[v95] = v94
    end
end

if parent3:IsA("GuiObject") then
    parent3.BorderSizePixel = 0
end

if v91.Parent then
    parent3.Parent = v91.Parent
end

local v96 = {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(560, 116), Parent = parent3}
local parent4 = Instance.new("Frame")

for v98, v99 in v96 do
    if v98 ~= "Parent" then
        parent4[v98] = v99
    end
end

if parent4:IsA("GuiObject") then
    parent4.BorderSizePixel = 0
end

if v96.Parent then
    parent4.Parent = v96.Parent
end

local v100 = {Scale = 1.9, Parent = parent4}
local instance = Instance.new("UIScale")

for v102, v103 in v100 do
    if v102 ~= "Parent" then
        instance[v102] = v103
    end
end

if instance:IsA("GuiObject") then
    instance.BorderSizePixel = 0
end

if v100.Parent then
    instance.Parent = v100.Parent
end

local v104 = {BackgroundTransparency = 1, Text = "TRIBES", AutoLocalize = false, TextSize = 100, TextTransparency = 0.7, Position = UDim2.fromOffset(4, 7), Size = UDim2.fromScale(1, 1), FontFace = fontFace, TextColor3 = Color3.new(0, 0, 0), Parent = parent4}
local textLabel = Instance.new("TextLabel")

for v106, v107 in v104 do
    if v106 ~= "Parent" then
        textLabel[v106] = v107
    end
end

if textLabel:IsA("GuiObject") then
    textLabel.BorderSizePixel = 0
end

if v104.Parent then
    textLabel.Parent = v104.Parent
end

new("TextLabel", {BackgroundTransparency = 1, Text = "TRIBES", AutoLocalize = false, TextSize = 100, Size = UDim2.fromScale(1, 1), FontFace = fontFace, TextColor3 = Color3.new(1, 1, 1), Parent = parent4}, {})
local properties2 = {AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 238), Size = UDim2.fromOffset(180, 6), BackgroundColor3 = color32, Parent = parent3}
local v109 = {}
local v110 = {CornerRadius = UDim.new(1, 0)}
local uiCorner = Instance.new("UICorner")

for v112, udim in v110 do
    if v112 ~= "Parent" then
        uiCorner[v112] = udim
    end
end

if uiCorner:IsA("GuiObject") then
    uiCorner.BorderSizePixel = 0
end

if v110.Parent then
    uiCorner.Parent = v110.Parent
end

v109[1] = uiCorner
new("Frame", properties2, v109)
local properties3 = {BackgroundTransparency = 1, Text = "3V3 ARENA  ·  BEST OF 5", TextSize = 28, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 262), Size = UDim2.fromOffset(900, 36), FontFace = fontFace2, TextColor3 = color33, Parent = parent3}
local v115 = {}
local v116 = {Thickness = 2, Transparency = 0.3, Color = color3}
local uiStroke = Instance.new("UIStroke")

for v118, v119 in v116 do
    if v118 ~= "Parent" then
        uiStroke[v118] = v119
    end
end

if uiStroke:IsA("GuiObject") then
    uiStroke.BorderSizePixel = 0
end

if v116.Parent then
    uiStroke.Parent = v116.Parent
end

v115[1] = uiStroke
new("TextLabel", properties3, v115)
local v120 = {
    "Best of 5: win three rounds to take the match. One life per round.",
    "Arrows drop over distance. Aim a little high on far targets.",
    "Headshots hit much harder. Aim for the head.",
    "Slide into cover, then jump out swinging.",
    "When the ring of fire closes in, fight in the middle or burn.",
    "Open LOADOUT and spend your gear points on any mix you like.",
    "Ammo is part of your loadout: bring enough arrows for the round.",
    "Hold block with the Iron Sword to soften hits from the front.",
    "Throwing knives: 5 per round. Make them count.",
    "Practise on the dummies in the lobby's training range."
}
local v121 = v1 and 760 or 900
local properties4 = {BackgroundTransparency = 0.25, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -112), Size = UDim2.fromOffset(v121, 58), BackgroundColor3 = Color3.fromRGB(20, 22, 28), Parent = parent2}
local v123 = {}
local v124 = {CornerRadius = UDim.new(0, 12)}
local uiCorner2 = Instance.new("UICorner")

for v126, udim in v124 do
    if v126 ~= "Parent" then
        uiCorner2[v126] = udim
    end
end

if uiCorner2:IsA("GuiObject") then
    uiCorner2.BorderSizePixel = 0
end

if v124.Parent then
    uiCorner2.Parent = v124.Parent
end

local v128 = {Thickness = 2, Transparency = 0.7, Color = color33}
local uiStroke2 = Instance.new("UIStroke")

for v130, v131 in v128 do
    if v130 ~= "Parent" then
        uiStroke2[v130] = v131
    end
end

if uiStroke2:IsA("GuiObject") then
    uiStroke2.BorderSizePixel = 0
end

if v128.Parent then
    uiStroke2.Parent = v128.Parent
end

v123[1], v123[2] = uiCorner2, uiStroke2
local parent5 = new("Frame", properties4, v123)
local v133 = {BackgroundTransparency = 1, Text = "TIP", TextSize = 24, Position = UDim2.fromOffset(18, 0), Size = UDim2.new(0, 60, 1, 0), FontFace = fontFace, TextColor3 = color32, Parent = parent5}
textLabel = Instance.new("TextLabel")

for v134, v135 in v133 do
    if v134 ~= "Parent" then
        textLabel[v134] = v135
    end
end

if textLabel:IsA("GuiObject") then
    textLabel.BorderSizePixel = 0
end

if v133.Parent then
    textLabel.Parent = v133.Parent
end

local v136 = {BackgroundTransparency = 1, TextWrapped = true, TextSize = 19, Position = UDim2.fromOffset(84, 0), Size = UDim2.new(1, -102, 1, 0), Text = v120[math.random(1, #v120)], FontFace = fontFace4, TextColor3 = color33, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent5}
textLabel = Instance.new("TextLabel")

for v137, v138 in v136 do
    if v137 ~= "Parent" then
        textLabel[v137] = v138
    end
end

if textLabel:IsA("GuiObject") then
    textLabel.BorderSizePixel = 0
end

if v136.Parent then
    textLabel.Parent = v136.Parent
end

local properties5 = {BackgroundTransparency = 0.2, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -62), Size = UDim2.fromOffset(v121, 14), BackgroundColor3 = color3, Parent = parent2}
local v140 = {}
local v141 = {CornerRadius = UDim.new(1, 0)}
local uiCorner3 = Instance.new("UICorner")

for v143, udim in v141 do
    if v143 ~= "Parent" then
        uiCorner3[v143] = udim
    end
end

if uiCorner3:IsA("GuiObject") then
    uiCorner3.BorderSizePixel = 0
end

if v141.Parent then
    uiCorner3.Parent = v141.Parent
end

local v145 = {Thickness = 2, Transparency = 0.6, Color = color33}
local uiStroke3 = Instance.new("UIStroke")

for v147, v148 in v145 do
    if v147 ~= "Parent" then
        uiStroke3[v147] = v148
    end
end

if uiStroke3:IsA("GuiObject") then
    uiStroke3.BorderSizePixel = 0
end

if v145.Parent then
    uiStroke3.Parent = v145.Parent
end

v140[1], v140[2] = uiCorner3, uiStroke3
local parent6 = new("Frame", properties5, v140)
local properties6 = {Size = UDim2.fromScale(0.04, 1), BackgroundColor3 = Color3.new(1, 1, 1), Parent = parent6}
local v151 = {}
local v152 = {CornerRadius = UDim.new(1, 0)}
local uiCorner4 = Instance.new("UICorner")

for v154, udim in v152 do
    if v154 ~= "Parent" then
        uiCorner4[v154] = udim
    end
end

if uiCorner4:IsA("GuiObject") then
    uiCorner4.BorderSizePixel = 0
end

if v152.Parent then
    uiCorner4.Parent = v152.Parent
end

local v156 = {Color = ColorSequence.new(Color3.fromRGB(90, 180, 255), Color3.fromRGB(28, 132, 246))}
local uiGradient2 = Instance.new("UIGradient")

for v158, v159 in v156 do
    if v158 ~= "Parent" then
        uiGradient2[v158] = v159
    end
end

if uiGradient2:IsA("GuiObject") then
    uiGradient2.BorderSizePixel = 0
end

if v156.Parent then
    uiGradient2.Parent = v156.Parent
end

v151[1], v151[2] = uiCorner4, uiGradient2
local instance5 = new("Frame", properties6, v151)
local v161 = {BackgroundTransparency = 1, Text = "LOADING…", TextSize = 16, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -28), Size = UDim2.fromOffset(900, 24), FontFace = fontFace3, TextColor3 = Color3.fromRGB(130, 138, 156), Parent = parent2}
local textLabel2 = Instance.new("TextLabel")

for v163, v164 in v161 do
    if v163 ~= "Parent" then
        textLabel2[v163] = v164
    end
end

if textLabel2:IsA("GuiObject") then
    textLabel2.BorderSizePixel = 0
end

if v161.Parent then
    textLabel2.Parent = v161.Parent
end

local loadingSkipped = false
local v166 = false
local properties7 = {Name = "Skip", BackgroundTransparency = 1, AutoButtonColor = false, Text = "SKIP  ›", TextScaled = true, TextTransparency = 1, Visible = false, AnchorPoint = Vector2.new(1, 1), Position = if v1 then UDim2.new(1, -70, 1, -40) else UDim2.new(1, -36, 1, -36), Size = if v1 then UDim2.fromOffset(210, 80) else UDim2.fromOffset(180, 62)}
properties7.BackgroundColor3 = Color3.fromRGB(28, 132, 246)
properties7.FontFace = fontFace
properties7.TextColor3 = color33
properties7.Parent = parent2
local v168 = {}
local v169 = {CornerRadius = UDim.new(1, 0)}
local uiCorner5 = Instance.new("UICorner")

for v171, udim in v169 do
    if v171 ~= "Parent" then
        uiCorner5[v171] = udim
    end
end

if uiCorner5:IsA("GuiObject") then
    uiCorner5.BorderSizePixel = 0
end

if v169.Parent then
    uiCorner5.Parent = v169.Parent
end

local v173 = {MinTextSize = 14}

if v1 then
    maxTextSize = 34
else
    maxTextSize = 28
end

v173.MaxTextSize = maxTextSize
local uiTextSizeConstraint = Instance.new("UITextSizeConstraint")

for v175, v176 in v173 do
    if v175 ~= "Parent" then
        uiTextSizeConstraint[v175] = v176
    end
end

if uiTextSizeConstraint:IsA("GuiObject") then
    uiTextSizeConstraint.BorderSizePixel = 0
end

if v173.Parent then
    uiTextSizeConstraint.Parent = v173.Parent
end

local v177 = {PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14)}
local uiPadding = Instance.new("UIPadding")

for v179, udim in v177 do
    if v179 ~= "Parent" then
        uiPadding[v179] = udim
    end
end

if uiPadding:IsA("GuiObject") then
    uiPadding.BorderSizePixel = 0
end

if v177.Parent then
    uiPadding.Parent = v177.Parent
end

v168[1], v168[2], v168[3] = uiCorner5, uiTextSizeConstraint, uiPadding
local instance2 = new("TextButton", properties7, v168)
local v182 = {Thickness = 3, Transparency = 1, Color = color32, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = instance2}
local instance3 = Instance.new("UIStroke")

for v184, v185 in v182 do
    if v184 ~= "Parent" then
        instance3[v184] = v185
    end
end

if instance3:IsA("GuiObject") then
    instance3.BorderSizePixel = 0
end

if v182.Parent then
    instance3.Parent = v182.Parent
end

local function footer()
    --[[
      name: footer
      line: 338
      upvalues:
        uiScale (copy, index: 1)
        parent2 (copy, index: 2)
        instance2 (copy, index: 3)
        v1 (copy, index: 4)
        v121 (copy, index: 5)
        parent5 (copy, index: 6)
        parent6 (copy, index: 7)
        textLabel2 (copy, index: 8)
    ]]
    local v187 = math.max(uiScale.Scale, 0.01)
    local v188 = parent2.AbsoluteSize.X / v187

    if v188 < 10 then
        return
    end

    local v189 = (instance2.AbsolutePosition.X - parent2.AbsolutePosition.X) / v187

    if instance2.AbsoluteSize.X < 1 then
        local v190 = v1 and 280 or 216
        v189 = v188 - v190
    end

    local v191 = math.min(v188 - 40, v189 - 16)
    local v192 = math.min(v121, v191 - 40)
    local v193 = math.max((v192 / 2) + 40, (math.min(v188 / 2, v191 - (v192 / 2))))
    parent5.Size = UDim2.fromOffset(v192, 58)
    parent5.Position = UDim2.new(0, v193, 1, -112)
    parent6.Size = UDim2.fromOffset(v192, 14)
    parent6.Position = UDim2.new(0, v193, 1, -62)
    textLabel2.Size = UDim2.fromOffset(v192, 24)
    textLabel2.Position = UDim2.new(0, v193, 1, -28)
end

footer()
parent2:GetPropertyChangedSignal("AbsoluteSize"):Connect(footer)
instance2:GetPropertyChangedSignal("AbsolutePosition"):Connect(footer)

task.delay(
    0.6,
    function()
        --[[
          line: 362
          upvalues:
            v166 (ref,  index: 1)
            instance2 (copy, index: 2)
            tweenService (copy, index: 3)
            instance3 (copy, index: 4)
        ]]
        if v166 then
            return
        end

        instance2.Visible = true
        local propertyTable = {BackgroundTransparency = 0.1, TextTransparency = 0}
        tweenService:Create(instance2, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable):Play()
        local propertyTable2 = {Transparency = 0}
        tweenService:Create(instance3, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable2):Play()
    end
)

instance2.Activated:Connect(
    function()
        --[[
          line: 370
          upvalues:
            loadingSkipped (ref, index: 1)
        ]]
        loadingSkipped = true
    end
)

local inputBeganConnection = userInputService.InputBegan:Connect(
    function(input: InputObject)
        --[[
          line: 373
          upvalues:
            instance2 (copy, index: 1)
            loadingSkipped (ref,  index: 2)
        ]]
        if instance2.Visible
            and (input.KeyCode == Enum.KeyCode.Space
                or input.KeyCode == Enum.KeyCode.Return
                or input.KeyCode == Enum.KeyCode.ButtonA)
        then
            loadingSkipped = true
        end
    end
)

instance.Scale = 2.4
local propertyTable = {Scale = 1.9}
local back = Enum.EasingStyle.Back
local newTweenInfo = TweenInfo.new
local easingStyle = back or Enum.EasingStyle.Quint
tweenService:Create(instance, newTweenInfo(0.5, easingStyle, Enum.EasingDirection.Out), propertyTable):Play()

local function characterReady()
    --[[
      name: characterReady
      line: 384
      upvalues:
        runService (copy, index: 1)
        workspace (copy, index: 2)
        localPlayer (copy, index: 3)
    ]]
    if runService:IsStudio() and workspace:GetAttribute("UIHoldLoading") == true then
        return false
    end

    return localPlayer.Character ~= nil
end

local v203 = 0.04

local renderSteppedConnection = runService.RenderStepped:Connect(
    function(deltaTime: number)
        --[[
          line: 392
          upvalues:
            frame (copy, index: 1)
            timestamp (copy, index: 2)
            runService (copy, index: 3)
            workspace (copy, index: 4)
            localPlayer (copy, index: 5)
            textLabel2 (copy, index: 6)
            v203 (ref,  index: 7)
            instance5 (copy, index: 8)
        ]]
        local v206
        frame.Rotation = (frame.Rotation + (deltaTime * 3)) % 360
        local elapsedTime = os.clock() - timestamp
        local v208 = if runService:IsStudio() and workspace:GetAttribute("UIHoldLoading") == true then false else localPlayer.Character ~= nil

        if v208 then
            v206 = 1
            textLabel2.Text = "READY!"

            if not localPlayer:GetAttribute("CharacterAtMs") then
                localPlayer:SetAttribute("CharacterAtMs", (math.floor(elapsedTime * 1000)))
            end
        else
            local text
            v206 = (1 - math.exp(-elapsedTime / 4)) * 0.75 + 0.1

            if not (elapsedTime < 2) then
                text = "ALMOST THERE…"
            else
                text = "LOADING…"
            end

            textLabel2.Text = text
        end

        v203 += ((v206 - v203) * math.min(1, deltaTime * 6))
        instance5.Size = UDim2.fromScale(math.clamp(v203, 0.04, 1), 1)
    end
)

local v210 = runService:IsStudio() and workspace:GetAttribute("UIHoldLoading") == true and 120 or 25
local v211 = timestamp + v210

while not loadingSkipped do
    local v212 = if runService:IsStudio() and workspace:GetAttribute("UIHoldLoading") == true then false else localPlayer.Character ~= nil
    if v212 then
        break
    end
    if not (os.clock() < v211) then
        break
    end

    task.wait()
end

v166 = true
renderSteppedConnection:Disconnect()
inputBeganConnection:Disconnect()

if v81 then
    v81:Disconnect()
end

localPlayer:SetAttribute("LoadingShownMs", (math.floor((os.clock() - timestamp) * 1000)))
localPlayer:SetAttribute("LoadingSkipped", loadingSkipped)
instance4.Active = false

for _, descendant in parent:GetDescendants() do
    if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
        local propertyTable2 = {TextTransparency = 1, BackgroundTransparency = 1}
        tweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable2):Play()
    elseif descendant:IsA("Frame") then
        local propertyTable3 = {BackgroundTransparency = 1}
        tweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable3):Play()
    elseif descendant:IsA("UIStroke") then
        local propertyTable4 = {Transparency = 1}
        tweenService:Create(descendant, TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), propertyTable4):Play()
    end
end

task.wait(0.3)
parent:Destroy()