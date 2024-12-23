-- ServerScriptService/Server/CarService.lua

local CarService = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CarShopData = require(script.Parent.CarDefinitions)
local ownedCars = {}
local spawnedCars = {}

function CarService.GetCarsForSale(player)
    local userId = player.UserId
    local result = {}
    for carKey, info in pairs(CarShopData) do
        if not (ownedCars[userId] and ownedCars[userId][carKey]) then
            result[carKey] = info
        end
    end
    return result
end

function CarService.GetCarsOwned(player)
    local userId = player.UserId
    local result = {}
    if ownedCars[userId] then
        for carKey, _ in pairs(ownedCars[userId]) do
            result[carKey] = CarShopData[carKey]
        end
    end
    return result
end


function CarService.BuyCar(player, carName)
    local carInfo = CarShopData[carName]
    if not carInfo then
        return false, "Ungültiges Auto."
    end
    local stats = player:FindFirstChild("leaderstats")
    if not stats then
        return false, "Keine leaderstats vorhanden."
    end
    local cash = stats:FindFirstChild("Cash")
    if not cash then
        return false, "Keine Cash-Stat."
    end

    if cash.Value < carInfo.Price then
        return false, "Zu wenig Geld."
    end

    -- Bezahlen
    cash.Value -= carInfo.Price

    -- Markieren, dass Spieler das Auto besitzt
    local userId = player.UserId
    ownedCars[userId] = ownedCars[userId] or {}
    ownedCars[userId][carName] = true

    return true, "Gekauft: "..carInfo.Name
end

function CarService.SpawnCar(player, carName)
    local userId = player.UserId
    local carInfo = CarShopData[carName]
    if not carInfo then
        return false, "Ungültiges Auto."
    end

    -- Prüfen, ob Spieler das Auto besitzt
    if not (ownedCars[userId] and ownedCars[userId][carName]) then
        return false, "Du besitzt dieses Auto nicht."
    end

    -- Altes Auto löschen, falls vorhanden
    if spawnedCars[userId] and spawnedCars[userId].Parent then
        spawnedCars[userId]:Destroy()
        spawnedCars[userId] = nil
    end

    -- Neues Modell klonen und ins Workspace packen
    local carsFolder = ReplicatedStorage:WaitForChild("Cars")
    local model = carsFolder:FindFirstChild(carInfo.ModelName)
    if not model then
        return false, "Modell "..carInfo.ModelName.." nicht in ReplicatedStorage.Cars gefunden."
    end

    local clone = model:Clone()
    clone.Name = player.Name .. "_" .. carInfo.Name
    clone.Parent = workspace

    -- Positionieren
    local spawnPart = workspace:FindFirstChild("CarSpawn")
    if spawnPart and spawnPart:IsA("BasePart") then
        clone:WaitForChild("PrimaryPart", 5)
        if clone.PrimaryPart then
            clone:SetPrimaryPartCFrame(spawnPart.CFrame + Vector3.new(0, 5, 0))
        end
    end

    spawnedCars[userId] = clone

    return true, "Gespawnt: "..carInfo.Name
end

return CarService
