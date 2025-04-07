-- Client-side Script (LocalScript)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Wait for the RemoteEvents to be available
local playAudioEvent = ReplicatedStorage:WaitForChild("PlayAudioEvent")
local changeSkyboxEvent = ReplicatedStorage:WaitForChild("ChangeSkyboxEvent")

-- Function to play scary audio
playAudioEvent.OnClientEvent:Connect(function(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Parent = game.Workspace
    sound:Play()
end)

-- Function to change skybox to scary one
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
