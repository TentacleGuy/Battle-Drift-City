-- ServerScriptService/PlayerSpawnManager.lua

local Players = game:GetService("Players")
local PlayerDataHandler = require(script.Parent.PlayerDataHandler)

-- Beispiel: Deine vorhandene Spawn-Funktion
-- Passen wir hier als Dummy an, damit du siehst, wo dein eigentlicher Code hin kann
local function spawnPlayer(player)
    -- Falls du spezielle Spawn-Logik hast (z. B. bestimmte SpawnPoints),
    -- lass sie hier drin oder rufe "player:LoadCharacter()" auf, etc.
    
    print("Spawning player:", player.Name)
    player:LoadCharacter()  -- Roblox-Standard: Lädt das Character-Model
end

Players.PlayerAdded:Connect(function(player)
    print("Player joined:", player.Name)

    -- 1) PlayerData anlegen (leaderstats & NonLeaderStats)
    PlayerDataHandler.InitializePlayerData(player)

    -- 2) Eigentlicher Spawn
    spawnPlayer(player)

    -- Optional: Character-Events
    player.CharacterAdded:Connect(function(character)
        print("Character spawned for:", player.Name)
    end)
end)
