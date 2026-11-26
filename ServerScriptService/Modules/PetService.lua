local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local HttpService = game:GetService("HttpService")

local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
local PetRegistry = require(ReplicatedStorage:WaitForChild("Data"):WaitForChild("PetRegistry"))
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local ActivePetsService = require(game.ServerScriptService.Modules.ActivePetsService)
local DefaultPetNames = require(ReplicatedStorage.Data.PetRegistry.DefaultPetNames)

local PetService = {}

function PetService:GetHolding(player, itemType)
	local character = player.Character
	if not character then return nil end
	for _, tool in ipairs(character:GetChildren()) do
		if tool:IsA("Tool") and (not itemType or tool:GetAttribute("ItemType") == itemType) then
			return tool
		end
	end
	return nil
end

function PetService:Create(player, petName, scale, level, age)
	local Data = PlayerData[player] and PlayerData[player].Data
	if not Data then return false, "No data" end

	Data.PetsData = Data.PetsData or {
		MutableStats = { MaxEquippedPets = 3, MaxPetsInInventory = 60, MaxEggsInFarm = 3 },
		PurchasedEquipSlots = 0,
		PurchasedEggSlots = 0,
		EquippedPets = {},
		PetInventory = { Counter = 0, Data = {} },
	}
	Data.InventoryData = Data.InventoryData or {}

	local cfg = PetRegistry.PetList[petName]
	if not cfg then return false, "Invalid pet type" end

	local petUUID = HttpService:GenerateGUID(true)
	local name = DefaultPetNames[math.random(1, #DefaultPetNames)]
	local weight = scale or 1.
	local level = level or 1
	local age = age or 1

	Data.PetsData.PetInventory.Counter += 1
	Data.PetsData.PetInventory.Data[petUUID] = {
		PetType = petName,
		PetData = {
			Name = name,
			Weight = weight,
			Level = level,
			Age = age,
			XP = 0,
			Hunger = cfg.DefaultHunger or 1000,
			Equipped = false,
			Variant = "Normal",
			Mutations = {},
			CreatedAt = os.time(),
		}
	}

	ActivePetsService:InitPlayer({Data = Data}, player)

	return true, petUUID
end

function PetService:Equip(player, petUUID)
	local Data = PlayerData[player] and PlayerData[player].Data
	if not Data or not Data.PetsData then return false end

	local pet = Data.PetsData.PetInventory.Data[petUUID]
	if not pet then return false, "Pet not found" end

	if #Data.PetsData.EquippedPets >= Data.PetsData.MutableStats.MaxEquippedPets then
		return false, "Max equipped pets reached"
	end

	pet.Equipped = true
	table.insert(Data.PetsData.EquippedPets, petUUID)

	ActivePetsService:EquipPet(player, petUUID)

	return true
end

function PetService:Unequip(player, petUUID)
	local Data = PlayerData[player] and PlayerData[player].Data
	if not Data or not Data.PetsData then return false end

	local pet = Data.PetsData.PetInventory.Data[petUUID]
	if not pet then return false end

	pet.Equipped = false
	for i, uuid in ipairs(Data.PetsData.EquippedPets) do
		if uuid == petUUID then
			table.remove(Data.PetsData.EquippedPets, i)
			break
		end
	end

	ActivePetsService:UnequipPet(player, petUUID)

	return true
end

function PetService:Feed(player, petUUID, fruitName, fruitWeight)
	local Data = PlayerData[player] and PlayerData[player].Data
	if not Data or not Data.PetsData then return false end

	local pet = Data.PetsData.PetInventory.Data[petUUID]
	if not pet then return false end

	-- Consume fruit from inventory
	-- ... feeding logic

	return true
end

function PetService:Sell(player, petUUID)
	local Data = PlayerData[player] and PlayerData[player].Data
	if not Data or not Data.PetsData then return false end

	local pet = Data.PetsData.PetInventory.Data[petUUID]
	if not pet then return false end

	local cfg = PetRegistry.PetList[pet.PetType]
	if not cfg then return false end

	local price = cfg.SellPrice or 0
	-- Apply level/weight multipliers
	price = math.floor(price * (1 + (pet.Level - 1) * 0.1) * pet.Weight)

	Data.PetsData.PetInventory.Data[petUUID] = nil
	Data.PetsData.PetInventory.Counter -= 1

	-- Add currency
	Data.Sheckles = (Data.Sheckles or 0) + price

	return true, price
end

function PetService:HatchEgg(player, eggName)
	local Data = PlayerData[player] and PlayerData[player].Data
	if not Data then return false end

	local eggData = PetRegistry.PetEggs[eggName]
	if not eggData then return false end

	-- Check if player has egg
	-- ... egg hatching logic with weighted random selection

	return true, hatchedPetName
end

return PetService