-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui
screenGui.Name = "CustomAdminGUI"

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
mainFrame.Size = UDim2.new(0, 200, 0, 300)
mainFrame.Active = true
mainFrame.Draggable = true

-- Create Title Label
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 30)
title.Font = Enum.Font.SourceSansBold
title.Text = "Admin Controls"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18

-- Create Scrolling Frame
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Parent = mainFrame
scrollingFrame.Position = UDim2.new(0, 0, 0, 30)
scrollingFrame.Size = UDim2.new(1, 0, 1, -30)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 600) -- Adjust based on content
scrollingFrame.ScrollBarThickness = 8
scrollingFrame.BackgroundTransparency = 1

-- UIListLayout for automatic layout
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = scrollingFrame
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 5)

-- Function to create buttons
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

-- Play Scary Audio Function (Client-side, triggers the server action)
local function playScaryAudio()
    game.ReplicatedStorage.PlaySoundEvent:FireServer()  -- Call to server script (uses a remote)
end

-- Change Skybox Function (Client-side, triggers the server action)
local function changeSkybox()
    game.ReplicatedStorage.ChangeSkyboxEvent:FireServer()  -- Call to server script (uses a remote)
end

-- Backdoor Finder Function
local function findBackdoors()
    local suspiciousScripts = {}
    local function scan(obj)
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("Script") or child:IsA("LocalScript") then
                local source = child.Source
                if source:find("require") or source:find("getfenv") then
                    table.insert(suspiciousScripts, child:GetFullName())
                end
            end
            scan(child)
        end
    end
    scan(game)
    if #suspiciousScripts > 0 then
        warn("Suspicious scripts found:")
        for _, scriptName in ipairs(suspiciousScripts) do
            warn(scriptName)
        end
    else
        print("No suspicious scripts found.")
    end
end

-- Destroy GUI Function
local function destroyGUI()
    screenGui:Destroy()
end

-- Create Buttons
createButton("Play Scary Audio", playScaryAudio)
createButton("Change Skybox", changeSkybox)
createButton("Find Backdoors", findBackdoors)
createButton("Destroy GUI", destroyGUI)

-- Adjust CanvasSize based on content
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y + 10)
