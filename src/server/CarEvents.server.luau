-- ServerScriptService/Server/CarEvents.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local CarService = require(script.Parent.CarService)

local remoteFolder = ReplicatedStorage:WaitForChild("RemoteEvents")
local openCarShopEvent = remoteFolder:WaitForChild("OpenCarShop")
local openCarSpawnEvent = remoteFolder:WaitForChild("OpenCarSpawn")
local carActionsEvent = remoteFolder:WaitForChild("CarActions")

-- Wenn Client eine Aktion fordert (z. B. Kaufen, Spawnen, etc.)
carActionsEvent.OnServerEvent:Connect(function(player, action, carName)
    if action == "RequestShopCars" then
        local carsForSale = CarService.GetCarsForSale(player)
        carActionsEvent:FireClient(player, "ShopCarsData", carsForSale)
    elseif action == "RequestOwnedCars" then
        local ownedCars = CarService.GetCarsOwned(player)
        carActionsEvent:FireClient(player, "OwnedCarsData", ownedCars)
    elseif action == "BuyCar" then
        local success, msg = CarService.BuyCar(player, carName)
        carActionsEvent:FireClient(player, "BuyCarResult", success, msg)
        -- Bei Erfolg könnte man nochmal ShopCars updaten:
        if success then
            local updatedCarsForSale = CarService.GetCarsForSale(player)
            carActionsEvent:FireClient(player, "ShopCarsData", updatedCarsForSale)
        end
    elseif action == "SpawnCar" then
        local success, msg = CarService.SpawnCar(player, carName)
        carActionsEvent:FireClient(player, "SpawnCarResult", success, msg)
    end
end)
