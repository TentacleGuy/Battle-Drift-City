local Players = game:GetService("Players")

local PlayerDataHandler = require(script.Parent:WaitForChild("PlayerDataHandler"))
local DefaultPlayerStats = require(script.Parent:WaitForChild("DefaultPlayerStats"))
local CarUpgradeManager = require(script.Parent:WaitForChild("CarUpgradeManager"))

-- Spieler-Join-Event
Players.PlayerAdded:Connect(function(player)
    print(player.Name .. " hat die Welt betreten.")

    -- 1) Spieler-Daten laden
    local playerData = PlayerDataHandler.LoadPlayerData(player)
    if not playerData then
        -- Falls keine gespeicherten Daten vorhanden sind, Default-Werte generieren
        playerData = DefaultPlayerStats.GetDefaultStats()
    end

    -- 2) Daten anwenden (Attributes + leaderstats anlegen)
    PlayerDataHandler.ApplyPlayerData(player, playerData)

    -- 3) Sobald Character erstellt wird -> zum Startpunkt teleportieren
    player.CharacterAdded:Connect(function(character)
        local spawnPoint = workspace:WaitForChild("Startworld"):FindFirstChild("StartSP")
        if spawnPoint then
            -- Nur sicherstellen, dass character.PrimaryPart gesetzt ist (meist HumanoidRootPart)
            character:WaitForChild("HumanoidRootPart")
            character:SetPrimaryPartCFrame(spawnPoint.CFrame)
        end
    end)
end)

-- Spieler-Leave-Event
Players.PlayerRemoving:Connect(function(player)
    print(player.Name .. " hat die Welt verlassen.")
    -- Spieler-Daten speichern
    PlayerDataHandler.SavePlayerData(player)
end)
