--========================================================
-- 67 HUB XoSh — Adopt Me Hub
-- Orange Theme | 30s Loading Screen
--========================================================

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local player           = Players.LocalPlayer

local openLauncher

local SCRIPTS = {}

table.insert(SCRIPTS, {
    name  = "Pet Spawner",
    icon  = "🐾",
    desc  = "SPAWN • PETS • ADOPT ME",
    isNew = true,
    kind  = "embed",
    code  = [=[
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PathfindingService = game:GetService("PathfindingService")
local StarterGui = game:GetService("StarterGui")
local lp = Players.LocalPlayer

local function block(plr)
    if not plr or plr == lp then return end
    pcall(function()
        StarterGui:SetCore("PromptBlockPlayer", plr)
    end)
end

_G.InstaPickup = true

local SCREEN_GUI = Instance.new("ScreenGui")
SCREEN_GUI.Name = "BrainrotTeleporter"
SCREEN_GUI.DisplayOrder = 999
SCREEN_GUI.ResetOnSpawn = false

local MAIN_FRAME = Instance.new("Frame")
MAIN_FRAME.Name = "MainFrame"
MAIN_FRAME.Size = UDim2.new(0, 500, 0, 600)
MAIN_FRAME.Position = UDim2.new(0.5, -250, 0.5, -300)
MAIN_FRAME.BackgroundColor3 = Color3.fromRGB(45, 20, 60)
MAIN_FRAME.BackgroundTransparency = 0.15
MAIN_FRAME.BorderSizePixel = 0
MAIN_FRAME.Active = true
MAIN_FRAME.Draggable = true
MAIN_FRAME.Parent = SCREEN_GUI

local CORNER = Instance.new("UICorner")
CORNER.CornerRadius = UDim.new(0, 12)
CORNER.Parent = MAIN_FRAME

local TITLE_BAR = Instance.new("Frame")
TITLE_BAR.Name = "TitleBar"
TITLE_BAR.Size = UDim2.new(1, 0, 0, 40)
TITLE_BAR.BackgroundColor3 = Color3.fromRGB(60, 25, 80)
TITLE_BAR.BackgroundTransparency = 0.2
TITLE_BAR.BorderSizePixel = 0
TITLE_BAR.Parent = MAIN_FRAME

local TITLE = Instance.new("TextLabel")
TITLE.Name = "Title"
TITLE.Size = UDim2.new(1, -10, 1, 0)
TITLE.Position = UDim2.new(0, 10, 0, 0)
TITLE.BackgroundTransparency = 1
TITLE.Text = "idk how to name"
TITLE.TextColor3 = Color3.fromRGB(255, 255, 255)
TITLE.TextScaled = true
TITLE.Font = Enum.Font.GothamBold
TITLE.TextXAlignment = Enum.TextXAlignment.Left
TITLE.Parent = TITLE_BAR

local SUBTITLE = Instance.new("TextLabel")
SUBTITLE.Name = "Subtitle"
SUBTITLE.Size = UDim2.new(1, -10, 0, 20)
SUBTITLE.Position = UDim2.new(0, 10, 0, 40)
SUBTITLE.BackgroundTransparency = 1
SUBTITLE.Text = "made by nanygata"
SUBTITLE.TextColor3 = Color3.fromRGB(200, 180, 255)
SUBTITLE.TextScaled = true
SUBTITLE.Font = Enum.Font.Gotham
SUBTITLE.TextXAlignment = Enum.TextXAlignment.Left
SUBTITLE.Parent = MAIN_FRAME

local SCROLL_FRAME = Instance.new("ScrollingFrame")
SCROLL_FRAME.Name = "ScrollFrame"
SCROLL_FRAME.Size = UDim2.new(1, -20, 1, -120)
SCROLL_FRAME.Position = UDim2.new(0, 10, 0, 70)
SCROLL_FRAME.BackgroundTransparency = 1
SCROLL_FRAME.BorderSizePixel = 0
SCROLL_FRAME.ScrollBarThickness = 8
SCROLL_FRAME.ScrollBarImageColor3 = Color3.fromRGB(120, 60, 160)
SCROLL_FRAME.CanvasSize = UDim2.new(0, 0, 0, 0)
SCROLL_FRAME.AutomaticCanvasSize = Enum.AutomaticSize.Y
SCROLL_FRAME.Parent = MAIN_FRAME

local UI_LIST_LAYOUT = Instance.new("UIListLayout")
UI_LIST_LAYOUT.Padding = UDim.new(0, 10)
UI_LIST_LAYOUT.Parent = SCROLL_FRAME

local CLOSE_BUTTON = Instance.new("TextButton")
CLOSE_BUTTON.Name = "CloseButton"
CLOSE_BUTTON.Size = UDim2.new(0, 30, 0, 30)
CLOSE_BUTTON.Position = UDim2.new(1, -35, 0, 5)
CLOSE_BUTTON.BackgroundColor3 = Color3.fromRGB(80, 30, 100)
CLOSE_BUTTON.BackgroundTransparency = 0.3
CLOSE_BUTTON.Text = "X"
CLOSE_BUTTON.TextColor3 = Color3.fromRGB(255, 255, 255)
CLOSE_BUTTON.TextScaled = true
CLOSE_BUTTON.Font = Enum.Font.GothamBold
CLOSE_BUTTON.Parent = TITLE_BAR

local CLOSE_CORNER = Instance.new("UICorner")
CLOSE_CORNER.CornerRadius = UDim.new(0, 8)
CLOSE_CORNER.Parent = CLOSE_BUTTON

local isTeleporting = false

local function extractValue(text)
    if not text then return 0 end
    local clean = text:gsub("[%$,/s]", ""):gsub(",", "")
    local mult = 1
    if clean:match("[kK]") then
        mult = 1e3
        clean = clean:gsub("[kK]", "")
    elseif clean:match("[mM]") then
        mult = 1e6
        clean = clean:gsub("[mM]", "")
    elseif clean:match("[bB]") then
        mult = 1e9
        clean = clean:gsub("[bB]", "")
    elseif clean:match("[tT]") then
        mult = 1e12
        clean = clean:gsub("[tT]", "")
    elseif clean:match("[qQ]") then
        mult = 1e15
        clean = clean:gsub("[qQ]", "")
    end
    local num = tonumber(clean)
    return num and num * mult or 0
end

local function formatValue(value)
    if value >= 1e15 then
        return string.format("%.1fQ", value / 1e15)
    elseif value >= 1e12 then
        return string.format("%.1fT", value / 1e12)
    elseif value >= 1e9 then
        return string.format("%.1fB", value / 1e9)
    elseif value >= 1e6 then
        return string.format("%.1fM", value / 1e6)
    elseif value >= 1e3 then
        return string.format("%.1fK", value / 1e3)
    else
        return tostring(math.floor(value))
    end
end

local function findAllBrainrots()
    local allPets = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "AnimalOverhead" then
            local petValue, petName, generation = 0, "Brainrot", "Gen 1"
            
            for _, child in ipairs(obj:GetChildren()) do
                if child:IsA("TextLabel") then
                    local text = child.Text
                    if text then
                        if child.Name == "DisplayName" and text ~= "" then
                            petName = text
                        elseif text:find("$") and text:find("/s") then
                            petValue = extractValue(text)
                        elseif child.Name == "Generation" then
                            generation = text
                        end
                    end
                end
            end
            
            local position = nil
            local current = obj.Parent
            while current and current ~= workspace do
                if current:IsA("BasePart") then
                    position = current.Position
                    break
                end
                current = current.Parent
            end
            
            if position and petValue > 0 then
                table.insert(allPets, {
                    position = position,
                    name = petName,
                    value = petValue,
                    formattedValue = formatValue(petValue),
                    generation = generation
                })
            end
        end
    end
    
    table.sort(allPets, function(a, b) 
        return a.value > b.value
    end)
    
    return allPets
end

local InstaPickupSystem = {}
InstaPickupSystem.currentPrompt = nil
InstaPickupSystem.currentDistance = math.huge
InstaPickupSystem.lastUpdate = 0

function InstaPickupSystem:parseMoneyPerSec(text)
    if not text then return 0 end
    local mult = 1
    local numberStr = text:match("[%d%.]+")
    if not numberStr then return 0 end
    if text:find("K") then mult = 1000
    elseif text:find("M") then mult = 1000000
    elseif text:find("B") then mult = 1000000000
    elseif text:find("T") then mult = 1000000000000
    elseif text:find("Q") then mult = 1000000000000000
    end
    return tonumber(numberStr) and tonumber(numberStr) * mult or 0
end

function InstaPickupSystem:getBrainrotValue(prompt)
    local parent = prompt.Parent
    if not parent or not parent.Parent then return 0 end
    local model = parent.Parent
    for _, desc in ipairs(model:GetDescendants()) do
        if desc:IsA("TextLabel") and desc.Name == "Rarity" then
            local gen = desc.Parent:FindFirstChild("Generation")
            if gen and gen:IsA("TextLabel") then
                return self:parseMoneyPerSec(gen.Text)
            end
        end
    end
    return 0
end

function InstaPickupSystem:getPromptPosition(prompt)
    local parent = prompt.Parent
    if parent:IsA("BasePart") then
        return parent.Position
    end
    if parent:IsA("Model") then
        local primary = parent.PrimaryPart or parent:FindFirstChildWhichIsA("BasePart")
        if primary then
            return primary.Position
        end
    end
    if parent:IsA("Attachment") then
        return parent.WorldPosition
    end
    return nil
end

function InstaPickupSystem:findHighestValuePrompt()
    local bestPrompt = nil
    local bestValue = 0
    local bestDist = math.huge
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil, math.huge end
    
    for _, obj in pairs(plots:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and obj.Enabled and obj.ActionText == "Steal" then
            local pos = self:getPromptPosition(obj)
            if pos then
                local dist = (self.hrp.Position - pos).Magnitude
                if dist <= obj.MaxActivationDistance then
                    local value = self:getBrainrotValue(obj)
                    if value > bestValue then
                        bestValue = value
                        bestPrompt = obj
                        bestDist = dist
                    end
                end
            end
        end
    end
    return bestPrompt, bestDist
end

function InstaPickupSystem:activatePrompt(prompt)
    prompt.RequiresLineOfSight = false
    fireproximityprompt(prompt, 20, math.huge)
    prompt:InputHoldBegin()
    prompt:InputHoldEnd()
end

function InstaPickupSystem:start()
    local function getCharacter()
        return lp.Character or lp.CharacterAdded:Wait()
    end
    
    local function getHRP()
        local char = getCharacter()
        return char:WaitForChild("HumanoidRootPart")
    end
    
    self.hrp = getHRP()
    local humanoid = getCharacter():WaitForChild("Humanoid")
    
    lp.CharacterAdded:Connect(function()
        self.hrp = getHRP()
        humanoid = getCharacter():WaitForChild("Humanoid")
    end)
    
    RunService.Heartbeat:Connect(function()
        local now = tick()
        if now - self.lastUpdate >= 0.05 then
            self.currentPrompt, self.currentDistance = self:findHighestValuePrompt()
            self.lastUpdate = now
        end
    end)
    
    task.spawn(function()
        while true do
            if _G.InstaPickup and humanoid.WalkSpeed > 25 then
                if self.currentPrompt and self.currentDistance <= self.currentPrompt.MaxActivationDistance then
                    self:activatePrompt(self.currentPrompt)
                    task.wait(1.5)
                else
                    task.wait(0.1)
                end
            else
                task.wait(0.5)
            end
        end
    end)
end

local function equipFlyingTool()
    local char = lp.Character
    if not char then return nil end
    
    local backpack = lp:FindFirstChild("Backpack")
    if not backpack then return nil end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return nil end
    
    local flyingCarpet = nil
    
    for _, item in ipairs(backpack:GetDescendants()) do
        if item:IsA("Tool") and item.Name == "Flying Carpet" then
            flyingCarpet = item
            break
        end
    end
    
    if flyingCarpet then
        humanoid:EquipTool(flyingCarpet)
        return "Flying Carpet"
    end
    
    local witchBroom = nil
    
    for _, item in ipairs(backpack:GetDescendants()) do
        if item:IsA("Tool") and item.Name == "Witch's Broom" then
            witchBroom = item
            break
        end
    end
    
    if witchBroom then
        humanoid:EquipTool(witchBroom)
        return "Witch's Broom"
    end
    
    return nil
end

local function teleportToWaypoints(waypoints)
    if isTeleporting then return end
    isTeleporting = true
    
    local char = lp.Character
    if not char then 
        isTeleporting = false
        return 
    end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then 
        isTeleporting = false
        return 
    end
    
    local toolEquipped = equipFlyingTool()
    if toolEquipped then
        task.wait(0.1)
    end
    
    for _, wp in ipairs(waypoints) do
        if not isTeleporting then break end
        
        local elevatedPos = Vector3.new(wp.Position.X, wp.Position.Y + 5, wp.Position.Z)
        hrp.CFrame = CFrame.new(elevatedPos)
        task.wait(0.02)
    end
    
    local players = Players:GetPlayers()
    local nearestPlayer = nil
    local nearestDist = math.huge
    
    for _, player in ipairs(players) do
        if player ~= lp and player.Character then
            local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local dist = (hrp.Position - targetHRP.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearestPlayer = player
                end
            end
        end
    end
    
    if nearestPlayer then
        block(nearestPlayer)
    end
    
    isTeleporting = false
end

local function teleportToPosition(targetPosition)
    local char = lp.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local path = PathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = true
    })
    
    local elevatedTarget = Vector3.new(targetPosition.X, targetPosition.Y + 5, targetPosition.Z)
    path:ComputeAsync(hrp.Position, elevatedTarget)
    
    if path.Status == Enum.PathStatus.Success then
        local waypointsPath = path:GetWaypoints()
        teleportToWaypoints(waypointsPath)
    else
        hrp.CFrame = CFrame.new(elevatedTarget)
        
        local players = Players:GetPlayers()
        local nearestPlayer = nil
        local nearestDist = math.huge
        
        for _, player in ipairs(players) do
            if player ~= lp and player.Character then
                local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
                if targetHRP then
                    local dist = (hrp.Position - targetHRP.Position).Magnitude
                    if dist < nearestDist then
                        nearestDist = dist
                        nearestPlayer = player
                    end
                end
            end
        end
        
        if nearestPlayer then
            block(nearestPlayer)
        end
    end
end

local function getValueColor(value)
    if value >= 1e12 then
        return Color3.fromRGB(255, 215, 0)
    elseif value >= 1e9 then
        return Color3.fromRGB(192, 192, 192)
    elseif value >= 1e6 then
        return Color3.fromRGB(205, 127, 50)
    else
        return Color3.fromRGB(120, 255, 120)
    end
end

local function createPetButton(petInfo, index)
    local button = Instance.new("TextButton")
    button.Name = "PetButton_" .. index
    button.Size = UDim2.new(1, 0, 0, 80)
    button.BackgroundColor3 = Color3.fromRGB(70, 30, 90)
    button.BackgroundTransparency = 0.2
    button.Text = ""
    button.AutoButtonColor = true
    button.Parent = SCROLL_FRAME
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    local rankFrame = Instance.new("Frame")
    rankFrame.Name = "RankFrame"
    rankFrame.Size = UDim2.new(0, 40, 1, 0)
    rankFrame.BackgroundColor3 = Color3.fromRGB(50, 20, 70)
    rankFrame.BackgroundTransparency = 0.3
    rankFrame.BorderSizePixel = 0
    rankFrame.Parent = button
    
    local rankCorner = Instance.new("UICorner")
    rankCorner.CornerRadius = UDim.new(0, 8)
    rankCorner.Parent = rankFrame
    
    local rankLabel = Instance.new("TextLabel")
    rankLabel.Name = "Rank"
    rankLabel.Size = UDim2.new(1, 0, 1, 0)
    rankLabel.BackgroundTransparency = 1
    rankLabel.Text = "#" .. index
    rankLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    rankLabel.TextScaled = true
    rankLabel.Font = Enum.Font.GothamBold
    rankLabel.Parent = rankFrame
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "Name"
    nameLabel.Size = UDim2.new(0.5, -50, 0.4, 0)
    nameLabel.Position = UDim2.new(0, 50, 0, 5)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = petInfo.name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = button
    
    local genLabel = Instance.new("TextLabel")
    genLabel.Name = "Generation"
    genLabel.Size = UDim2.new(0.5, -10, 0.4, 0)
    genLabel.Position = UDim2.new(0.5, 0, 0, 5)
    genLabel.BackgroundTransparency = 1
    genLabel.Text = petInfo.generation
    genLabel.TextColor3 = Color3.fromRGB(180, 220, 255)
    genLabel.TextScaled = true
    genLabel.TextXAlignment = Enum.TextXAlignment.Right
    genLabel.Font = Enum.Font.Gotham
    genLabel.Parent = button
    
    local valueColor = getValueColor(petInfo.value)
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(1, -60, 0.4, 0)
    valueLabel.Position = UDim2.new(0, 50, 0.4, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = "$" .. petInfo.formattedValue .. "/s"
    valueLabel.TextColor3 = valueColor
    valueLabel.TextScaled = true
    valueLabel.TextXAlignment = Enum.TextXAlignment.Left
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Parent = button
    
    local teleportLabel = Instance.new("TextLabel")
    teleportLabel.Name = "TeleportLabel"
    teleportLabel.Size = UDim2.new(1, -60, 0.2, 0)
    teleportLabel.Position = UDim2.new(0, 50, 0.8, 0)
    teleportLabel.BackgroundTransparency = 1
    teleportLabel.Text = "Clique para teleportar"
    teleportLabel.TextColor3 = Color3.fromRGB(200, 180, 255)
    teleportLabel.TextScaled = true
    teleportLabel.Font = Enum.Font.Gotham
    teleportLabel.TextXAlignment = Enum.TextXAlignment.Left
    teleportLabel.Parent = button
    
    if index == 1 then
        button.BackgroundColor3 = Color3.fromRGB(90, 40, 130)
        local crown = Instance.new("TextLabel")
        crown.Name = "Crown"
        crown.Size = UDim2.new(0, 20, 0, 20)
        crown.Position = UDim2.new(1, -25, 0, 5)
        crown.BackgroundTransparency = 1
        crown.Text = "👑"
        crown.TextColor3 = Color3.fromRGB(255, 215, 0)
        crown.TextScaled = true
        crown.Parent = button
    elseif index == 2 then
        button.BackgroundColor3 = Color3.fromRGB(80, 35, 115)
    elseif index == 3 then
        button.BackgroundColor3 = Color3.fromRGB(70, 30, 100)
    end
    
    button.MouseEnter:Connect(function()
        if index > 3 then
            button.BackgroundColor3 = Color3.fromRGB(90, 40, 120)
        end
    end)
    
    button.MouseLeave:Connect(function()
        if index == 1 then
            button.BackgroundColor3 = Color3.fromRGB(90, 40, 130)
        elseif index == 2 then
            button.BackgroundColor3 = Color3.fromRGB(80, 35, 115)
        elseif index == 3 then
            button.BackgroundColor3 = Color3.fromRGB(70, 30, 100)
        else
            button.BackgroundColor3 = Color3.fromRGB(70, 30, 90)
        end
    end)
    
    button.MouseButton1Click:Connect(function()
        teleportToPosition(petInfo.position)
    end)
    
    return button
end

local function updatePetList()
    local allPets = findAllBrainrots()
    
    for _, child in ipairs(SCROLL_FRAME:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local petCount = Instance.new("TextLabel")
    petCount.Name = "PetCount"
    petCount.Size = UDim2.new(1, 0, 0, 30)
    petCount.BackgroundTransparency = 1
    petCount.Text = "🎯 Pets encontrados: " .. #allPets
    petCount.TextColor3 = Color3.fromRGB(200, 180, 255)
    petCount.TextScaled = true
    petCount.Font = Enum.Font.GothamBold
    petCount.Parent = SCROLL_FRAME
    
    if #allPets == 0 then
        local noPetsLabel = Instance.new("TextLabel")
        noPetsLabel.Name = "NoPets"
        noPetsLabel.Size = UDim2.new(1, 0, 0, 100)
        noPetsLabel.BackgroundTransparency = 1
        noPetsLabel.Text = "Nenhum brainrot encontrado"
        noPetsLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        noPetsLabel.TextScaled = true
        noPetsLabel.Font = Enum.Font.GothamBold
        noPetsLabel.Parent = SCROLL_FRAME
    else
        for i, pet in ipairs(allPets) do
            createPetButton(pet, i)
        end
        
        local bestValue = allPets[1].formattedValue
        local bestLabel = Instance.new("TextLabel")
        bestLabel.Name = "BestValue"
        bestLabel.Size = UDim2.new(1, 0, 0, 25)
        bestLabel.Position = UDim2.new(0, 0, 0, 35)
        bestLabel.BackgroundTransparency = 1
        bestLabel.Text = "🎖️ Melhor valor: $" .. bestValue .. "/s"
        bestLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        bestLabel.TextScaled = true
        bestLabel.Font = Enum.Font.GothamBold
        bestLabel.Parent = SCROLL_FRAME
    end
end

local REFRESH_BUTTON = Instance.new("TextButton")
REFRESH_BUTTON.Name = "RefreshButton"
REFRESH_BUTTON.Size = UDim2.new(0, 140, 0, 40)
REFRESH_BUTTON.Position = UDim2.new(0.5, -150, 1, -50)
REFRESH_BUTTON.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
REFRESH_BUTTON.BackgroundTransparency = 0.2
REFRESH_BUTTON.Text = "🔄 Atualizar Lista"
REFRESH_BUTTON.TextColor3 = Color3.fromRGB(255, 255, 255)
REFRESH_BUTTON.TextScaled = true
REFRESH_BUTTON.Font = Enum.Font.GothamBold
REFRESH_BUTTON.Parent = MAIN_FRAME

local REFRESH_CORNER = Instance.new("UICorner")
REFRESH_CORNER.CornerRadius = UDim.new(0, 8)
REFRESH_CORNER.Parent = REFRESH_BUTTON

REFRESH_BUTTON.MouseButton1Click:Connect(function()
    updatePetList()
end)

local TELEPORT_BEST_BUTTON = Instance.new("TextButton")
TELEPORT_BEST_BUTTON.Name = "TeleportBestButton"
TELEPORT_BEST_BUTTON.Size = UDim2.new(0, 140, 0, 40)
TELEPORT_BEST_BUTTON.Position = UDim2.new(0.5, 10, 1, -50)
TELEPORT_BEST_BUTTON.BackgroundColor3 = Color3.fromRGB(40, 160, 200)
TELEPORT_BEST_BUTTON.BackgroundTransparency = 0.2
TELEPORT_BEST_BUTTON.Text = "🚀 Teleportar #1"
TELEPORT_BEST_BUTTON.TextColor3 = Color3.fromRGB(255, 255, 255)
TELEPORT_BEST_BUTTON.TextScaled = true
TELEPORT_BEST_BUTTON.Font = Enum.Font.GothamBold
TELEPORT_BEST_BUTTON.Parent = MAIN_FRAME

local TELEPORT_CORNER = Instance.new("UICorner")
TELEPORT_CORNER.CornerRadius = UDim.new(0, 8)
TELEPORT_CORNER.Parent = TELEPORT_BEST_BUTTON

TELEPORT_BEST_BUTTON.MouseButton1Click:Connect(function()
    local allPets = findAllBrainrots()
    if #allPets > 0 then
        teleportToPosition(allPets[1].position)
    end
end)

local AUTOGRAB_BUTTON = Instance.new("TextButton")
AUTOGRAB_BUTTON.Name = "AutoGrabButton"
AUTOGRAB_BUTTON.Size = UDim2.new(0, 140, 0, 40)
AUTOGRAB_BUTTON.Position = UDim2.new(0.5, -150, 1, -100)
AUTOGRAB_BUTTON.BackgroundColor3 = Color3.fromRGB(120, 40, 160)
AUTOGRAB_BUTTON.BackgroundTransparency = 0.2
AUTOGRAB_BUTTON.Text = "🤖 Auto Grab: ON"
AUTOGRAB_BUTTON.TextColor3 = Color3.fromRGB(255, 255, 255)
AUTOGRAB_BUTTON.TextScaled = true
AUTOGRAB_BUTTON.Font = Enum.Font.GothamBold
AUTOGRAB_BUTTON.Parent = MAIN_FRAME

local AUTOGRAB_CORNER = Instance.new("UICorner")
AUTOGRAB_CORNER.CornerRadius = UDim.new(0, 8)
AUTOGRAB_CORNER.Parent = AUTOGRAB_BUTTON

AUTOGRAB_BUTTON.MouseButton1Click:Connect(function()
    _G.InstaPickup = not _G.InstaPickup
    AUTOGRAB_BUTTON.Text = "🤖 Auto Grab: " .. (_G.InstaPickup and "ON" or "OFF")
    AUTOGRAB_BUTTON.BackgroundColor3 = _G.InstaPickup and Color3.fromRGB(120, 40, 160) or Color3.fromRGB(80, 40, 100)
end)

CLOSE_BUTTON.MouseButton1Click:Connect(function()
    SCREEN_GUI:Destroy()
end)

InstaPickupSystem:start()

local function initialize()
    updatePetList()
    
    if lp:FindFirstChild("PlayerGui") then
        SCREEN_GUI.Parent = lp:FindFirstChild("PlayerGui")
    else
        SCREEN_GUI.Parent = game:GetService("CoreGui")
    end
    
    task.spawn(function()
        while SCREEN_GUI.Parent do
            updatePetList()
            task.wait(3)
        end
    end)
end

initialize()
]=],
})


--========================================================
-- LOADING SCREEN (30 seconds) — Orange Theme
--========================================================

local DURATION = 30

local LoadGui = Instance.new("ScreenGui")
LoadGui.Name="67HUB_AM_Loading"; LoadGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
LoadGui.ResetOnSpawn=false; LoadGui.IgnoreGuiInset=true
LoadGui.Parent=player:WaitForChild("PlayerGui")

local LoadOverlay=Instance.new("Frame",LoadGui)
LoadOverlay.Size=UDim2.new(1,0,1,0); LoadOverlay.BackgroundColor3=Color3.fromRGB(0,0,0)
LoadOverlay.BackgroundTransparency=0.65; LoadOverlay.BorderSizePixel=0; LoadOverlay.ZIndex=1

for i=1,10 do
    local l=Instance.new("Frame",LoadOverlay); l.Size=UDim2.new(1,0,0,1)
    l.Position=UDim2.new(0,0,i/11,0); l.BackgroundColor3=Color3.fromRGB(140,80,0)
    l.BackgroundTransparency=0.92; l.BorderSizePixel=0
end
for i=1,16 do
    local l=Instance.new("Frame",LoadOverlay); l.Size=UDim2.new(0,1,1,0)
    l.Position=UDim2.new(i/17,0,0,0); l.BackgroundColor3=Color3.fromRGB(140,80,0)
    l.BackgroundTransparency=0.92; l.BorderSizePixel=0
end

local Card=Instance.new("Frame",LoadGui)
Card.Size=UDim2.new(0.72,0,0.72,0); Card.Position=UDim2.new(0.14,0,0.14,0)
Card.BackgroundColor3=Color3.fromRGB(22,12,6); Card.BackgroundTransparency=0
Card.BorderSizePixel=0; Card.ZIndex=2
Instance.new("UICorner",Card).CornerRadius=UDim.new(0,12)

local CardStroke=Instance.new("UIStroke",Card)
CardStroke.Thickness=1.5; CardStroke.Color=Color3.fromRGB(255,140,0)
task.spawn(function()
    while Card.Parent do
        TweenService:Create(CardStroke,TweenInfo.new(1.2,Enum.EasingStyle.Sine),{Color=Color3.fromRGB(255,200,60)}):Play(); task.wait(1.2)
        TweenService:Create(CardStroke,TweenInfo.new(1.2,Enum.EasingStyle.Sine),{Color=Color3.fromRGB(180,80,0)}):Play(); task.wait(1.2)
    end
end)

local function mkCorner(parent,ax,ay)
    local f=Instance.new("Frame",parent); f.Size=UDim2.new(0,14,0,14); f.AnchorPoint=Vector2.new(ax,ay)
    f.Position=UDim2.new(ax,ax==0 and 8 or -8,ay,ay==0 and 8 or -8)
    f.BackgroundTransparency=1; f.BorderSizePixel=0; f.ZIndex=5
    local h=Instance.new("Frame",f); h.Size=UDim2.new(1,0,0,2)
    h.Position=UDim2.new(0,0,ay==0 and 0 or 1,ay==0 and 0 or -2)
    h.BackgroundColor3=Color3.fromRGB(255,180,0); h.BorderSizePixel=0; h.ZIndex=5
    local v=Instance.new("Frame",f); v.Size=UDim2.new(0,2,1,0)
    v.Position=UDim2.new(ax==0 and 0 or 1,ax==0 and 0 or -2,0,0)
    v.BackgroundColor3=Color3.fromRGB(255,180,0); v.BorderSizePixel=0; v.ZIndex=5
end
mkCorner(Card,0,0); mkCorner(Card,1,0); mkCorner(Card,0,1); mkCorner(Card,1,1)

local LC=Instance.new("Frame",Card)
LC.Size=UDim2.new(1,-48,1,-44); LC.Position=UDim2.new(0,24,0,22)
LC.BackgroundTransparency=1; LC.BorderSizePixel=0; LC.ZIndex=3

local TopTag=Instance.new("TextLabel",LC)
TopTag.Size=UDim2.new(1,0,0,12); TopTag.Position=UDim2.new(0,0,0,0)
TopTag.BackgroundTransparency=1; TopTag.Text="SYS_INIT  //  ADOPT ME HUB"
TopTag.Font=Enum.Font.Code; TopTag.TextSize=9
TopTag.TextColor3=Color3.fromRGB(180,100,0); TopTag.TextXAlignment=Enum.TextXAlignment.Left; TopTag.ZIndex=3

local Logo67=Instance.new("TextLabel",LC)
Logo67.Size=UDim2.new(0,140,0,80); Logo67.Position=UDim2.new(0,0,0,16)
Logo67.BackgroundTransparency=1; Logo67.Text="67"
Logo67.Font=Enum.Font.GothamBold; Logo67.TextSize=76
Logo67.TextColor3=Color3.fromRGB(255,255,255); Logo67.TextXAlignment=Enum.TextXAlignment.Left; Logo67.ZIndex=3

local LogoHub=Instance.new("TextLabel",LC)
LogoHub.Size=UDim2.new(0,120,0,36); LogoHub.Position=UDim2.new(0,108,0,48)
LogoHub.BackgroundTransparency=1; LogoHub.Text="HUB"
LogoHub.Font=Enum.Font.GothamBold; LogoHub.TextSize=28
LogoHub.TextColor3=Color3.fromRGB(255,140,0); LogoHub.TextXAlignment=Enum.TextXAlignment.Left; LogoHub.ZIndex=3

local XoSh=Instance.new("TextLabel",LC)
XoSh.Size=UDim2.new(0,60,0,80); XoSh.Position=UDim2.new(1,-56,0,16)
XoSh.BackgroundTransparency=1; XoSh.Text="A\nd\no\np\nt"
XoSh.Font=Enum.Font.Code; XoSh.TextSize=9
XoSh.TextColor3=Color3.fromRGB(120,60,0); XoSh.TextXAlignment=Enum.TextXAlignment.Right
XoSh.LineHeight=1.2; XoSh.ZIndex=3

local LDiv=Instance.new("Frame",LC)
LDiv.Size=UDim2.new(1,0,0,1); LDiv.Position=UDim2.new(0,0,0,102)
LDiv.BackgroundColor3=Color3.fromRGB(255,140,0); LDiv.BackgroundTransparency=0.6; LDiv.BorderSizePixel=0; LDiv.ZIndex=3

local statuses={{txt="INJECTING ENV",state="done"},{txt="BYPASS ANTICHEAT",state="done"},{txt="LOAD MODULES",state="active"},{txt="FINALIZE CONTEXT",state="wait"}}
local sLabels,sDots={},{}
for i,s in ipairs(statuses) do
    local row=Instance.new("Frame",LC); row.Size=UDim2.new(1,0,0,16)
    row.Position=UDim2.new(0,0,0,112+(i-1)*20); row.BackgroundTransparency=1; row.BorderSizePixel=0; row.ZIndex=3
    local dot=Instance.new("Frame",row); dot.Size=UDim2.new(0,5,0,5)
    dot.Position=UDim2.new(0,0,0.5,-2.5); dot.BorderSizePixel=0; dot.ZIndex=4
    Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
    local lbl=Instance.new("TextLabel",row); lbl.Size=UDim2.new(1,-14,1,0)
    lbl.Position=UDim2.new(0,14,0,0); lbl.BackgroundTransparency=1
    lbl.Font=Enum.Font.Code; lbl.TextSize=10; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=4
    local suf=Instance.new("TextLabel",row); suf.Size=UDim2.new(0,50,1,0)
    suf.Position=UDim2.new(1,-50,0,0); suf.BackgroundTransparency=1
    suf.Font=Enum.Font.Code; suf.TextSize=10; suf.TextXAlignment=Enum.TextXAlignment.Right; suf.ZIndex=4
    if s.state=="done" then
        dot.BackgroundColor3=Color3.fromRGB(255,160,0); lbl.TextColor3=Color3.fromRGB(200,120,0); lbl.Text=s.txt
        suf.TextColor3=Color3.fromRGB(255,160,0); suf.Text="OK"
    elseif s.state=="active" then
        dot.BackgroundColor3=Color3.fromRGB(255,200,60); lbl.TextColor3=Color3.fromRGB(255,200,60); lbl.Text=s.txt
        suf.TextColor3=Color3.fromRGB(255,200,60); suf.Text="WAIT"
    else
        dot.BackgroundColor3=Color3.fromRGB(80,50,20); lbl.TextColor3=Color3.fromRGB(80,50,20); lbl.Text=s.txt
        suf.TextColor3=Color3.fromRGB(80,50,20); suf.Text="---"
    end
    sLabels[i]={lbl=lbl,suf=suf}; sDots[i]=dot
end

local blinkIdx=3
task.spawn(function()
    while Card.Parent do
        if sDots[blinkIdx] then
            TweenService:Create(sDots[blinkIdx],TweenInfo.new(0.5,Enum.EasingStyle.Sine),{BackgroundTransparency=0.85}):Play(); task.wait(0.5)
            TweenService:Create(sDots[blinkIdx],TweenInfo.new(0.5,Enum.EasingStyle.Sine),{BackgroundTransparency=0}):Play(); task.wait(0.5)
        else task.wait(0.5) end
    end
end)

local ProgY=112+4*20+10
local ProgTrack=Instance.new("Frame",LC); ProgTrack.Size=UDim2.new(1,0,0,2)
ProgTrack.Position=UDim2.new(0,0,0,ProgY); ProgTrack.BackgroundColor3=Color3.fromRGB(60,30,10)
ProgTrack.BorderSizePixel=0; ProgTrack.ZIndex=3
local ProgFill=Instance.new("Frame",ProgTrack); ProgFill.Size=UDim2.new(0,0,1,0)
ProgFill.BackgroundColor3=Color3.fromRGB(255,140,0); ProgFill.BorderSizePixel=0; ProgFill.ZIndex=4
local Shimmer=Instance.new("Frame",ProgFill); Shimmer.Size=UDim2.new(0,20,1,0)
Shimmer.AnchorPoint=Vector2.new(1,0); Shimmer.Position=UDim2.new(1,0,0,0)
Shimmer.BackgroundColor3=Color3.fromRGB(255,230,150); Shimmer.BackgroundTransparency=0.4; Shimmer.BorderSizePixel=0; Shimmer.ZIndex=5

local PctRow=Instance.new("Frame",LC); PctRow.Size=UDim2.new(1,0,0,14)
PctRow.Position=UDim2.new(0,0,0,ProgY+6); PctRow.BackgroundTransparency=1; PctRow.BorderSizePixel=0; PctRow.ZIndex=3
local PctLbl=Instance.new("TextLabel",PctRow); PctLbl.Size=UDim2.new(0.5,0,1,0)
PctLbl.BackgroundTransparency=1; PctLbl.Text="0%"; PctLbl.Font=Enum.Font.GothamBold
PctLbl.TextSize=10; PctLbl.TextColor3=Color3.fromRGB(255,140,0); PctLbl.TextXAlignment=Enum.TextXAlignment.Left; PctLbl.ZIndex=3
local TimeLbl=Instance.new("TextLabel",PctRow); TimeLbl.Size=UDim2.new(0.5,0,1,0)
TimeLbl.Position=UDim2.new(0.5,0,0,0); TimeLbl.BackgroundTransparency=1; TimeLbl.Text="30s"
TimeLbl.Font=Enum.Font.Code; TimeLbl.TextSize=9; TimeLbl.TextColor3=Color3.fromRGB(80,50,20)
TimeLbl.TextXAlignment=Enum.TextXAlignment.Right; TimeLbl.ZIndex=3

local BotLbl=Instance.new("TextLabel",LC); BotLbl.Size=UDim2.new(1,0,0,12)
BotLbl.Position=UDim2.new(0,0,1,-12); BotLbl.BackgroundTransparency=1
BotLbl.Text="DO NOT CLOSE  //  ADOPT ME HUB LOADING"
BotLbl.Font=Enum.Font.Code; BotLbl.TextSize=9
BotLbl.TextColor3=Color3.fromRGB(120,60,0); BotLbl.TextXAlignment=Enum.TextXAlignment.Center; BotLbl.ZIndex=3
task.spawn(function()
    while Card.Parent do
        TweenService:Create(BotLbl,TweenInfo.new(0.9,Enum.EasingStyle.Sine),{TextTransparency=0.6}):Play(); task.wait(0.9)
        TweenService:Create(BotLbl,TweenInfo.new(0.9,Enum.EasingStyle.Sine),{TextTransparency=0}):Play(); task.wait(0.9)
    end
end)

Card.BackgroundTransparency=1; Card.Position=UDim2.new(0.14,0,0.18,0)
LoadOverlay.BackgroundTransparency=1
TweenService:Create(LoadOverlay,TweenInfo.new(0.3),{BackgroundTransparency=0.65}):Play()
TweenService:Create(Card,TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
    BackgroundTransparency=0,Position=UDim2.new(0.14,0,0.14,0)
}):Play()

task.delay(4,function()
    sDots[3].BackgroundColor3=Color3.fromRGB(255,160,0); sLabels[3].lbl.TextColor3=Color3.fromRGB(200,120,0)
    sLabels[3].suf.TextColor3=Color3.fromRGB(255,160,0); sLabels[3].suf.Text="OK"; blinkIdx=4
    sDots[4].BackgroundColor3=Color3.fromRGB(255,200,60); sLabels[4].lbl.TextColor3=Color3.fromRGB(255,200,60)
    sLabels[4].suf.TextColor3=Color3.fromRGB(255,200,60); sLabels[4].suf.Text="WAIT"
end)
task.delay(27,function()
    sDots[4].BackgroundColor3=Color3.fromRGB(255,160,0); sLabels[4].lbl.TextColor3=Color3.fromRGB(200,120,0)
    sLabels[4].suf.TextColor3=Color3.fromRGB(255,160,0); sLabels[4].suf.Text="OK"; blinkIdx=0
    PctLbl.TextColor3=Color3.fromRGB(255,160,0); ProgFill.BackgroundColor3=Color3.fromRGB(255,160,0)
end)

local loadStart=tick(); local loadConn
loadConn=RunService.Heartbeat:Connect(function()
    local elapsed=tick()-loadStart; local progress=math.min(1,elapsed/DURATION)
    ProgFill.Size=UDim2.new(progress,0,1,0)
    PctLbl.Text=math.floor(progress*100).."%"; TimeLbl.Text=math.max(0,math.ceil(DURATION-elapsed)).."s"
    if progress>=1 then
        loadConn:Disconnect(); PctLbl.Text="100%"; TimeLbl.Text="0s"
        task.wait(0.4)
        TweenService:Create(Card,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency=1,Position=UDim2.new(0.14,0,0.08,0)}):Play()
        TweenService:Create(LoadOverlay,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play()
        task.wait(0.6); LoadGui:Destroy(); openLauncher()
    end
end)

--========================================================
-- LAUNCHER GUI — Orange Theme
--========================================================

local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="AM_Launcher"; ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn=false; ScreenGui.IgnoreGuiInset=true
ScreenGui.Parent=player:WaitForChild("PlayerGui")

local Overlay=Instance.new("Frame",ScreenGui)
Overlay.Size=UDim2.new(1,0,1,0); Overlay.BackgroundColor3=Color3.fromRGB(0,0,0)
Overlay.BackgroundTransparency=0.5; Overlay.BorderSizePixel=0; Overlay.ZIndex=1

local Panel=Instance.new("Frame",ScreenGui)
Panel.Name="Panel"; Panel.Size=UDim2.new(0.88,0,0.62,0); Panel.Position=UDim2.new(0.06,0,0.19,0)
Panel.BackgroundColor3=Color3.fromRGB(20,10,4); Panel.BackgroundTransparency=0.06
Panel.BorderSizePixel=0; Panel.Active=true; Panel.Draggable=true; Panel.ZIndex=2
Instance.new("UICorner",Panel).CornerRadius=UDim.new(0,14)

local panelStroke=Instance.new("UIStroke",Panel)
panelStroke.Thickness=1.8; panelStroke.Color=Color3.fromRGB(255,140,0)
task.spawn(function()
    while Panel.Parent do
        TweenService:Create(panelStroke,TweenInfo.new(0.7,Enum.EasingStyle.Sine),{Color=Color3.fromRGB(255,200,60)}):Play(); task.wait(0.7)
        TweenService:Create(panelStroke,TweenInfo.new(0.7,Enum.EasingStyle.Sine),{Color=Color3.fromRGB(180,80,0)}):Play(); task.wait(0.7)
    end
end)

local Sidebar=Instance.new("Frame",Panel)
Sidebar.Size=UDim2.new(0.32,0,1,0); Sidebar.BackgroundColor3=Color3.fromRGB(200,100,0)
Sidebar.BackgroundTransparency=0.88; Sidebar.BorderSizePixel=0
Instance.new("UICorner",Sidebar).CornerRadius=UDim.new(0,14)

local sideDiv=Instance.new("Frame",Sidebar); sideDiv.Size=UDim2.new(0,1,1,0); sideDiv.Position=UDim2.new(1,-1,0,0)
sideDiv.BackgroundColor3=Color3.fromRGB(255,140,0); sideDiv.BackgroundTransparency=0.7; sideDiv.BorderSizePixel=0

local SideHeader=Instance.new("Frame",Sidebar); SideHeader.Size=UDim2.new(1,0,0,56)
SideHeader.BackgroundColor3=Color3.fromRGB(200,100,0); SideHeader.BackgroundTransparency=0.82; SideHeader.BorderSizePixel=0
Instance.new("UICorner",SideHeader).CornerRadius=UDim.new(0,14)

local LogoBg=Instance.new("Frame",SideHeader); LogoBg.Size=UDim2.new(0,30,0,30); LogoBg.Position=UDim2.new(0,10,0.5,-15)
LogoBg.BackgroundColor3=Color3.fromRGB(255,140,0); LogoBg.BorderSizePixel=0
Instance.new("UICorner",LogoBg).CornerRadius=UDim.new(0,8)
local LogoLbl=Instance.new("TextLabel",LogoBg); LogoLbl.Size=UDim2.new(1,0,1,0); LogoLbl.BackgroundTransparency=1
LogoLbl.Text="67"; LogoLbl.Font=Enum.Font.GothamBold; LogoLbl.TextSize=13; LogoLbl.TextColor3=Color3.fromRGB(255,255,255)
task.spawn(function()
    while LogoBg.Parent do
        TweenService:Create(LogoBg,TweenInfo.new(0.9,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(180,80,0)}):Play(); task.wait(0.9)
        TweenService:Create(LogoBg,TweenInfo.new(0.9,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(255,180,0)}):Play(); task.wait(0.9)
    end
end)

local HubTitle=Instance.new("TextLabel",SideHeader); HubTitle.Size=UDim2.new(1,-50,0,18); HubTitle.Position=UDim2.new(0,48,0,9)
HubTitle.BackgroundTransparency=1; HubTitle.Text="67 HUB XoSh"; HubTitle.Font=Enum.Font.GothamBold; HubTitle.TextSize=13
HubTitle.TextColor3=Color3.fromRGB(255,220,180); HubTitle.TextXAlignment=Enum.TextXAlignment.Left

local HubSub=Instance.new("TextLabel",SideHeader); HubSub.Size=UDim2.new(1,-50,0,14); HubSub.Position=UDim2.new(0,48,0,29)
HubSub.BackgroundTransparency=1; HubSub.Text="ADOPT ME"; HubSub.Font=Enum.Font.GothamBold; HubSub.TextSize=9
HubSub.TextColor3=Color3.fromRGB(255,140,0); HubSub.TextTransparency=0.2; HubSub.TextXAlignment=Enum.TextXAlignment.Left

local NavScroll=Instance.new("ScrollingFrame",Sidebar)
NavScroll.Size=UDim2.new(1,0,1,-62); NavScroll.Position=UDim2.new(0,0,0,60)
NavScroll.BackgroundTransparency=1; NavScroll.BorderSizePixel=0
NavScroll.ScrollBarThickness=2; NavScroll.ScrollBarImageColor3=Color3.fromRGB(255,140,0)
NavScroll.CanvasSize=UDim2.new(0,0,0,0); NavScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
local NavList=Instance.new("UIListLayout",NavScroll); NavList.Padding=UDim.new(0,4)
local NavPad=Instance.new("UIPadding",NavScroll)
NavPad.PaddingTop=UDim.new(0,6); NavPad.PaddingBottom=UDim.new(0,6)
NavPad.PaddingLeft=UDim.new(0,7); NavPad.PaddingRight=UDim.new(0,7)

local Content=Instance.new("Frame",Panel); Content.Size=UDim2.new(0.68,-2,1,0); Content.Position=UDim2.new(0.32,2,0,0)
Content.BackgroundTransparency=1; Content.BorderSizePixel=0

local CloseBtn=Instance.new("TextButton",Content); CloseBtn.Size=UDim2.new(0,28,0,28); CloseBtn.Position=UDim2.new(1,-36,0,10)
CloseBtn.BackgroundColor3=Color3.fromRGB(40,20,10); CloseBtn.BackgroundTransparency=0.3; CloseBtn.BorderSizePixel=0
CloseBtn.Text="✕"; CloseBtn.Font=Enum.Font.GothamBold; CloseBtn.TextSize=13
CloseBtn.TextColor3=Color3.fromRGB(255,160,80); CloseBtn.ZIndex=5
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(1,0)

local CP=Instance.new("Frame",Content); CP.Size=UDim2.new(1,-24,1,-24); CP.Position=UDim2.new(0,12,0,12)
CP.BackgroundTransparency=1; CP.BorderSizePixel=0

local IconBox=Instance.new("Frame",CP); IconBox.Size=UDim2.new(0,52,0,52); IconBox.Position=UDim2.new(0,0,0,8)
IconBox.BackgroundColor3=Color3.fromRGB(180,80,0); IconBox.BackgroundTransparency=0.6; IconBox.BorderSizePixel=0
Instance.new("UICorner",IconBox).CornerRadius=UDim.new(0,13)
local IconStroke=Instance.new("UIStroke",IconBox); IconStroke.Thickness=1; IconStroke.Color=Color3.fromRGB(255,140,0); IconStroke.Transparency=0.4
local IconLbl=Instance.new("TextLabel",IconBox); IconLbl.Size=UDim2.new(1,0,1,0); IconLbl.BackgroundTransparency=1
IconLbl.TextSize=26; IconLbl.Font=Enum.Font.GothamBold

local CName=Instance.new("TextLabel",CP); CName.Size=UDim2.new(1,-70,0,28); CName.Position=UDim2.new(0,64,0,10)
CName.BackgroundTransparency=1; CName.Font=Enum.Font.GothamBold; CName.TextSize=18
CName.TextColor3=Color3.fromRGB(255,220,180); CName.TextXAlignment=Enum.TextXAlignment.Left; CName.TextTruncate=Enum.TextTruncate.AtEnd

local CDesc=Instance.new("TextLabel",CP); CDesc.Size=UDim2.new(1,-70,0,18); CDesc.Position=UDim2.new(0,64,0,38)
CDesc.BackgroundTransparency=1; CDesc.Font=Enum.Font.GothamBold; CDesc.TextSize=10
CDesc.TextColor3=Color3.fromRGB(255,140,0); CDesc.TextTransparency=0.2; CDesc.TextXAlignment=Enum.TextXAlignment.Left

local Div=Instance.new("Frame",CP); Div.Size=UDim2.new(1,0,0,1); Div.Position=UDim2.new(0,0,0,72)
Div.BackgroundColor3=Color3.fromRGB(255,140,0); Div.BackgroundTransparency=0.7; Div.BorderSizePixel=0

local SRow=Instance.new("Frame",CP); SRow.Size=UDim2.new(1,0,0,20); SRow.Position=UDim2.new(0,0,0,80)
SRow.BackgroundTransparency=1; SRow.BorderSizePixel=0
local SDot=Instance.new("Frame",SRow); SDot.Size=UDim2.new(0,7,0,7); SDot.Position=UDim2.new(0,0,0.5,-3.5)
SDot.BackgroundColor3=Color3.fromRGB(255,160,0); SDot.BorderSizePixel=0
Instance.new("UICorner",SDot).CornerRadius=UDim.new(1,0)
task.spawn(function()
    while SDot.Parent do
        TweenService:Create(SDot,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundTransparency=0.5}):Play(); task.wait(0.8)
        TweenService:Create(SDot,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundTransparency=0}):Play(); task.wait(0.8)
    end
end)
local STxt=Instance.new("TextLabel",SRow); STxt.Size=UDim2.new(0.5,0,1,0); STxt.Position=UDim2.new(0,13,0,0)
STxt.BackgroundTransparency=1; STxt.Text="READY TO LOAD"; STxt.Font=Enum.Font.GothamBold; STxt.TextSize=9
STxt.TextColor3=Color3.fromRGB(255,160,0); STxt.TextXAlignment=Enum.TextXAlignment.Left
local CTxt=Instance.new("TextLabel",SRow); CTxt.Size=UDim2.new(0.5,0,1,0); CTxt.Position=UDim2.new(0.5,0,0,0)
CTxt.BackgroundTransparency=1; CTxt.Text=#SCRIPTS.." SCRIPTS LOADED"; CTxt.Font=Enum.Font.GothamBold; CTxt.TextSize=9
CTxt.TextColor3=Color3.fromRGB(180,100,0); CTxt.TextTransparency=0.3; CTxt.TextXAlignment=Enum.TextXAlignment.Right

local ExecBtn=Instance.new("TextButton",CP); ExecBtn.Size=UDim2.new(0.55,0,0,36); ExecBtn.Position=UDim2.new(0,0,1,-44)
ExecBtn.BackgroundColor3=Color3.fromRGB(200,100,0); ExecBtn.BackgroundTransparency=0.25; ExecBtn.BorderSizePixel=0
ExecBtn.Text="▶   EXECUTE SCRIPT"; ExecBtn.Font=Enum.Font.GothamBold; ExecBtn.TextSize=13
ExecBtn.TextColor3=Color3.fromRGB(255,220,180); ExecBtn.AutoButtonColor=false
Instance.new("UICorner",ExecBtn).CornerRadius=UDim.new(0,10)
local ExecStroke=Instance.new("UIStroke",ExecBtn); ExecStroke.Thickness=1.2; ExecStroke.Color=Color3.fromRGB(255,180,0); ExecStroke.Transparency=0.3
ExecBtn.MouseEnter:Connect(function() TweenService:Create(ExecBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(255,140,0),BackgroundTransparency=0.1}):Play() end)
ExecBtn.MouseLeave:Connect(function() TweenService:Create(ExecBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(200,100,0),BackgroundTransparency=0.25}):Play() end)

local ReopenBtn=Instance.new("TextButton",ScreenGui); ReopenBtn.Name="ReopenBtn"
ReopenBtn.Size=UDim2.new(0,44,0,44); ReopenBtn.Position=UDim2.new(1,-56,0,14)
ReopenBtn.BackgroundColor3=Color3.fromRGB(200,100,0); ReopenBtn.BackgroundTransparency=0.1; ReopenBtn.BorderSizePixel=0
ReopenBtn.Text="67"; ReopenBtn.Font=Enum.Font.GothamBold; ReopenBtn.TextSize=14
ReopenBtn.TextColor3=Color3.fromRGB(255,255,255); ReopenBtn.ZIndex=20; ReopenBtn.Visible=false
Instance.new("UICorner",ReopenBtn).CornerRadius=UDim.new(1,0)
local orbStroke=Instance.new("UIStroke",ReopenBtn); orbStroke.Thickness=2; orbStroke.Color=Color3.fromRGB(255,200,60)
task.spawn(function()
    while ReopenBtn.Parent do
        TweenService:Create(ReopenBtn,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(180,80,0)}):Play(); task.wait(0.8)
        TweenService:Create(ReopenBtn,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(255,160,0)}):Play(); task.wait(0.8)
    end
end)

do
    local dragging,dragStart,startPos=false,nil,nil
    ReopenBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            dragging=true; dragStart=inp.Position; startPos=ReopenBtn.Position
        end
    end)
    ReopenBtn.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local d=inp.Position-dragStart
            ReopenBtn.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
end

local panelOpen=true; local selectedIndex=1; local selectedScript=SCRIPTS[1]

local function closePanel()
    panelOpen=false
    TweenService:Create(Panel,TweenInfo.new(0.28,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(0.88,0,0,0),Position=UDim2.new(0.06,0,0.5,0),BackgroundTransparency=1}):Play()
    TweenService:Create(Overlay,TweenInfo.new(0.22),{BackgroundTransparency=1}):Play()
    task.delay(0.3,function()
        Panel.Visible=false; Overlay.Visible=false; ReopenBtn.Visible=true
        ReopenBtn.Size=UDim2.new(0,0,0,0); ReopenBtn.Position=UDim2.new(1,-28,0,38)
        TweenService:Create(ReopenBtn,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,44,0,44),Position=UDim2.new(1,-56,0,14)}):Play()
    end)
end

local navBtns={}
local function updateContent(idx)
    local s=SCRIPTS[idx]; IconLbl.Text=s.icon; CName.Text=s.name; CDesc.Text=s.desc
    selectedScript=s; selectedIndex=idx
    for i,btn in ipairs(navBtns) do
        if i==idx then TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(180,80,0),BackgroundTransparency=0.22}):Play(); btn:FindFirstChild("NavStroke").Transparency=0
        else TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(100,50,0),BackgroundTransparency=0.88}):Play(); btn:FindFirstChild("NavStroke").Transparency=0.7 end
    end
end

for i,s in ipairs(SCRIPTS) do
    local NavBtn=Instance.new("TextButton",NavScroll); NavBtn.Name="Nav_"..i
    NavBtn.Size=UDim2.new(1,0,0,38); NavBtn.BackgroundColor3=Color3.fromRGB(100,50,0)
    NavBtn.BackgroundTransparency=0.88; NavBtn.BorderSizePixel=0; NavBtn.Text=""; NavBtn.AutoButtonColor=false
    Instance.new("UICorner",NavBtn).CornerRadius=UDim.new(0,9)
    local ns=Instance.new("UIStroke",NavBtn); ns.Name="NavStroke"; ns.Thickness=1; ns.Color=Color3.fromRGB(255,140,0); ns.Transparency=0.7
    if s.isNew then
        local nb=Instance.new("TextLabel",NavBtn); nb.Size=UDim2.new(0,28,0,14); nb.Position=UDim2.new(1,-32,0,4)
        nb.BackgroundColor3=Color3.fromRGB(255,140,0); nb.BackgroundTransparency=0.2; nb.BorderSizePixel=0
        nb.Text="NEW"; nb.Font=Enum.Font.GothamBold; nb.TextSize=7; nb.TextColor3=Color3.fromRGB(255,255,255); nb.ZIndex=3
        Instance.new("UICorner",nb).CornerRadius=UDim.new(0,4)
    end
    local NIcon=Instance.new("TextLabel",NavBtn); NIcon.Size=UDim2.new(0,28,1,0); NIcon.Position=UDim2.new(0,5,0,0)
    NIcon.BackgroundTransparency=1; NIcon.Text=s.icon; NIcon.TextSize=16; NIcon.Font=Enum.Font.GothamBold
    local NName=Instance.new("TextLabel",NavBtn); NName.Size=UDim2.new(1,-46,1,0); NName.Position=UDim2.new(0,36,0,0)
    NName.BackgroundTransparency=1; NName.Text=s.name; NName.Font=Enum.Font.GothamBold; NName.TextSize=12
    NName.TextColor3=Color3.fromRGB(255,200,150); NName.TextXAlignment=Enum.TextXAlignment.Left; NName.TextTruncate=Enum.TextTruncate.AtEnd
    NavBtn.MouseEnter:Connect(function() if i~=selectedIndex then TweenService:Create(NavBtn,TweenInfo.new(0.13),{BackgroundTransparency=0.7}):Play() end end)
    NavBtn.MouseLeave:Connect(function() if i~=selectedIndex then TweenService:Create(NavBtn,TweenInfo.new(0.13),{BackgroundTransparency=0.88}):Play() end end)
    NavBtn.MouseButton1Click:Connect(function() updateContent(i) end)
    table.insert(navBtns,NavBtn)
end

ExecBtn.MouseButton1Click:Connect(function()
    TweenService:Create(ExecBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(255,160,0),BackgroundTransparency=0.1}):Play()
    ExecBtn.Text="⏳   LOADING..."; task.wait(0.2); closePanel(); task.wait(0.1)
    local fn,err=loadstring(selectedScript.code)
    if fn then task.spawn(fn) else warn("[67HUB AM] "..tostring(err)) end
    task.delay(0.5,function()
        ExecBtn.Text="▶   EXECUTE SCRIPT"
        TweenService:Create(ExecBtn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(200,100,0),BackgroundTransparency=0.25}):Play()
    end)
end)

CloseBtn.MouseButton1Click:Connect(closePanel)
ReopenBtn.MouseButton1Click:Connect(function()
    panelOpen=true; Panel.Visible=true; Overlay.Visible=true
    Panel.Size=UDim2.new(0.88,0,0,0); Panel.Position=UDim2.new(0.06,0,0.5,0)
    Panel.BackgroundTransparency=1; Overlay.BackgroundTransparency=1
    TweenService:Create(Panel,TweenInfo.new(0.32,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0.88,0,0.62,0),Position=UDim2.new(0.06,0,0.19,0),BackgroundTransparency=0.06}):Play()
    TweenService:Create(Overlay,TweenInfo.new(0.22),{BackgroundTransparency=0.5}):Play()
    TweenService:Create(ReopenBtn,TweenInfo.new(0.15),{Size=UDim2.new(0,0,0,0)}):Play()
    task.delay(0.16,function() ReopenBtn.Visible=false end)
end)

Panel.Visible=false; Overlay.Visible=false

function openLauncher()
    Panel.Visible=true; Overlay.Visible=true
    Panel.Size=UDim2.new(0.88,0,0,0); Panel.Position=UDim2.new(0.06,0,0.5,0)
    Panel.BackgroundTransparency=1; Overlay.BackgroundTransparency=1
    TweenService:Create(Overlay,TweenInfo.new(0.3),{BackgroundTransparency=0.5}):Play()
    TweenService:Create(Panel,TweenInfo.new(0.38,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0.88,0,0.62,0),Position=UDim2.new(0.06,0,0.19,0),BackgroundTransparency=0.06}):Play()
    task.delay(0.05,function() updateContent(1) end)
end
