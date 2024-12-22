-- SprintClient.lua (LocalScript)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local sprintEvent = ReplicatedStorage:WaitForChild("SprintToggle")

-- SHIFT gedrückt
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.LeftShift then
		-- Melde dem Server: "Ich will sprinten!"
		sprintEvent:FireServer("StartSprint")
	end
end)

-- SHIFT losgelassen
UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		-- Melde dem Server: "Ich hör auf zu sprinten!"
		sprintEvent:FireServer("StopSprint")
	end
end)
