-- Client-Side Script
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create the GUI in CoreGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui
screenGui.Name = "CustomAdminGUI"

-- Create the main frame for the GUI
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
mainFrame.Size = UDim2.new(0, 200, 0, 300)
mainFrame.Active = true
mainFrame.Draggable = true

-- Create a title label for the GUI
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 30)
title.Font = Enum.Font.SourceSansBold
title.Text = "Admin Controls"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18

-- Create a Scrolling Frame to hold buttons
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Parent = mainFrame
scrollingFrame.Position = UDim2.new(0, 0, 0, 30)
scrollingFrame.Size = UDim2.new(1, 0, 1, -30)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600) -- Adjust based on content
scrollingFrame.ScrollBarThickness = 8
scrollingFrame.BackgroundTransparency = 1

-- UI List Layout to automatically layout buttons
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = scrollingFrame
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 5)

-- Function to create buttons in the GUI
local function createButton(name, callback)
    local button = Instance.new("TextButton")
    button.Parent = scrollingFrame
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Font = Enum.Font.SourceSans
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Wait for RemoteEvents from the server to trigger actions
local playAudioEvent = ReplicatedStorage:WaitForChild("PlayAudioEvent")
local changeSkyboxEvent = ReplicatedStorage:WaitForChild("ChangeSkyboxEvent")

-- Function to play scary audio when triggered
playAudioEvent.OnClientEvent:Connect(function(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Parent = game.Workspace
    sound:Play()
end)

-- Function to change the skybox when triggered
changeSkyboxEvent.OnClientEvent:Connect(function(skyboxId)
    local lighting = game:GetService("Lighting")
    local sky = lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", lighting)
    sky.SkyboxBk = skyboxId
    sky.SkyboxDn = skyboxId
    sky.SkyboxFt = skyboxId
    sky.SkyboxLf = skyboxId
    sky.SkyboxRt = skyboxId
    sky.SkyboxUp = skyboxId
end)

-- Create Buttons in the GUI
createButton("Play Audio", function()
    playAudioEvent:FireServer("rbxassetid://9043345732") -- Replace with actual audio ID
end)

createButton("Change Skybox", function()
    changeSkyboxEvent:FireServer("rbxassetid://10798732439") -- Replace with actual skybox ID
end)
