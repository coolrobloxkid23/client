-- Client-Side GUI Setup
local replicatedStorage = game:GetService("ReplicatedStorage")
local nukeEvent = replicatedStorage:WaitForChild("NukeEvent")
local backdoorEvent = replicatedStorage:WaitForChild("BackdoorEvent")

-- Create the UI (Dark Purple and Gray)
local function createUI()
    local ui = Instance.new("ScreenGui")
    ui.Parent = game.CoreGui
    ui.Name = "AdminUI"

    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = ui
    mainFrame.BackgroundColor3 = Color3.fromRGB(48, 32, 72)  -- Dark Purple
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Active = true
    mainFrame.Draggable = true

    local title = Instance.new("TextLabel")
    title.Parent = mainFrame
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Font = Enum.Font.SourceSansBold
    title.Text = "Admin Controls"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18

    local buttonLayout = Instance.new("UIListLayout")
    buttonLayout.Parent = mainFrame
    buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    buttonLayout.Padding = UDim.new(0, 10)

    -- Create buttons
    local function createButton(name, callback)
        local button = Instance.new("TextButton")
        button.Parent = mainFrame
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        button.Size = UDim2.new(0.9, 0, 0, 40)
        button.Font = Enum.Font.SourceSans
        button.Text = name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 14
        button.MouseButton1Click:Connect(callback)
    end

    -- Create the buttons and connect the functions
    createButton("Nuke Server", function() nukeEvent:FireServer() end)
    createButton("Find Backdoors", function() backdoorEvent:FireServer() end)
end

-- Call the function to create the UI
createUI()
