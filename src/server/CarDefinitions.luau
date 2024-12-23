-- ReplicatedStorage/CarShopData.lua

local CarShopData = {
    Speedster = {
        Name = "Speedster",
        Description = "Schnelles, sportliches Auto.",
        Price = 1000,
        ImageId = "rbxassetid://1234567890",  -- Beispiel-AssetID
        ModelName = "Car_Speedster",
        Stats = {
            Boost = 80,
            Speed = 90,
            TurboChargeRate = 75,
            Defense = 40,
            Acceleration = 90,
            Grip = 20,
            Weight = 50,
        }
    },
    MonsterTruck = {
        Name = "Monster Truck",
        Description = "Fürs Grobe und Extra-Späßchen.",
        Price = 2500,
        ImageId = "rbxassetid://2345678901",
        ModelName = "Car_MonsterTruck",
        Stats = {
            Boost = 50,
            Speed = 60,
            TurboChargeRate = 30,
            Defense = 100,
            Acceleration = 40,
            Grip = 60,
            Weight = 90,
        }
    },
    DriftKing = {
        Name = "Drift King",
        Description = "Perfekt für seitliche Action.",
        Price = 3000,
        ImageId = "rbxassetid://3456789012",
        ModelName = "Car_DriftKing",
        Stats = {
            Boost = 70,
            Speed = 85,
            TurboChargeRate = 65,
            Defense = 30,
            Acceleration = 80,
            Grip = 40,
            Weight = 40,
        }
    },
    -- ... füge weitere Autos hinzu ...
}

return CarShopData
