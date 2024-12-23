-- ServerScriptService/Server/SprintManager.lua

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local sprintEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SprintToggle")

-- Konfiguration
local NORMAL_SPEED = 16
local SPRINT_SPEED = 30

local STAMINA_DRAIN_RATE = 15  -- pro Sekunde
local STAMINA_RECOVER_RATE = 5 -- pro Sekunde
local DEFAULT_MAX_STAMINA = 100

local playerData = {} 

-- Wenn PlayerAdded, initiiere Grundwerte
Players.PlayerAdded:Connect(function(player)
    -- Grunddaten
    playerData[player] = {
        CurrentStamina = DEFAULT_MAX_STAMINA,
        IsSprinting = false,
    }
    -- Setze Attribut, damit GUI es sehen kann
    player:SetAttribute("Stamina", DEFAULT_MAX_STAMINA)
    player:SetAttribute("IsSprinting", false)

    -- Wenn du magst, warte auf Character, damit du WalkSpeed setzen kannst
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = NORMAL_SPEED
    end)
end)

-- PlayerRemoving: räume auf
Players.PlayerRemoving:Connect(function(player)
    playerData[player] = nil
end)

-- Reagiere auf "SprintToggle"
sprintEvent.OnServerEvent:Connect(function(player, action)
    local pdata = playerData[player]
    if not pdata then return end

    if action == "StartSprint" then
        -- nur wenn Stamina > 0
        if pdata.CurrentStamina > 0 then
            pdata.IsSprinting = true
            player:SetAttribute("IsSprinting", true)
        end
    elseif action == "StopSprint" then
        pdata.IsSprinting = false
        player:SetAttribute("IsSprinting", false)
    end
end)

-- Haupt-Schleife pro Frame: Stamina berechnen, WalkSpeed anpassen
RunService.Heartbeat:Connect(function(dt)
    for plr, pdata in pairs(playerData) do
        local character = plr.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        if humanoid then
            if pdata.IsSprinting then
                -- stamina abbauen
                pdata.CurrentStamina = pdata.CurrentStamina - (STAMINA_DRAIN_RATE * dt)

                if pdata.CurrentStamina <= 0 then
                    pdata.CurrentStamina = 0
                    pdata.IsSprinting = false
                    plr:SetAttribute("IsSprinting", false)
                    humanoid.WalkSpeed = NORMAL_SPEED
                else
                    humanoid.WalkSpeed = SPRINT_SPEED
                end
            else
                -- stamina regenerieren
                if pdata.CurrentStamina < DEFAULT_MAX_STAMINA then
                    pdata.CurrentStamina = math.min(
                        pdata.CurrentStamina + (STAMINA_RECOVER_RATE * dt),
                        DEFAULT_MAX_STAMINA
                    )
                end
                humanoid.WalkSpeed = NORMAL_SPEED
            end

            -- Attribut für GUI aktualisieren (Stamina)
            plr:SetAttribute("Stamina", math.floor(pdata.CurrentStamina))
        end
    end
end)
