local Players = game:GetService("Players")

-- Importiere Modul-Scripts
local PlayerDataHandler = require(script.Parent:WaitForChild("PlayerDataHandler"))
local DefaultPlayerStats = require(script:WaitForChild("DefaultPlayerStats"))
local CarUpgradeManager = require(script:WaitForChild("CarUpgradeManager"))

-- Spieler-Join-Event
Players.PlayerAdded:Connect(function(player)
    print(player.Name .. " hat die Welt betreten.")

    -- Spieler-Daten laden oder initialisieren
    local playerData = PlayerDataHandler.LoadPlayerData(player)
    if not playerData then
        -- Falls keine gespeicherten Daten vorhanden sind, Standardwerte setzen
        playerData = DefaultPlayerStats.GetDefaultStats()
    end

    -- Spieler-Daten speichern (z. B. als Attribut oder in leaderstats)
    PlayerDataHandler.ApplyPlayerData(player, playerData)

    -- Spawn-Logik
    player.CharacterAdded:Connect(function(character)
        -- Spieler am Standard-Spawnpunkt spawnen
        local spawnPoint = workspace.Startworld:FindFirstChild("StartSP")
        if spawnPoint then
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
