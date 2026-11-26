-- InventoryService.lua - Inventory Management
-- From: ServerScriptService.Modules.InventoryService

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
local GetFarm = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("GetFarm"))

local InventoryService = {}
InventoryService.__index = InventoryService

local MAX_INVENTORY_ITEMS = 200

function InventoryService.new()
	return setmetatable({}, InventoryService)
end

function InventoryService:CreatePack(player, gearName, uses, quantity)
	local SeedPackUUID = HttpService:GenerateGUID(true)
	local inventory = PlayerData[player].Data

	inventory.InventoryData = inventory.InventoryData or {}

	local itemData = {
		ItemType = "Seed Pack",
		ItemData = {
			ItemName = gearName,
			Quantity = quantity or 1,
			UsesLeft = uses or 1,
			Variant = "Normal"
		}
	}
	inventory.InventoryData[SeedPackUUID] = itemData

	local SeedPackTool = ServerStorage:WaitForChild("Packs"):WaitForChild("PackTemplate"):Clone()
	SeedPackTool.Name = string.format("%s X%d", gearName, itemData.ItemData.Quantity)
	SeedPackTool.Parent = player:FindFirstChild("Backpack")

	SeedPackTool:SetAttribute("ITEM_TYPE", "Seed Pack")
	SeedPackTool:SetAttribute("ITEM_UUID", SeedPackUUID)
	SeedPackTool:SetAttribute("ItemName", gearName)
	SeedPackTool:SetAttribute("ItemType", "Seed Pack")
	SeedPackTool:SetAttribute("OWNER", player.UserId)
	SeedPackTool:SetAttribute("Quantity", itemData.ItemData.Quantity)
	SeedPackTool:SetAttribute("UsesLeft", itemData.ItemData.UsesLeft)

	return SeedPackUUID
end

function InventoryService:CreatePet(player, petname, scale)
	local Data = PlayerData[player].Data
	Data.PetsData = Data.PetsData or {
		MutableStats = { MaxEquippedPets = 3, MaxPetsInInventory = 60, MaxEggsInFarm = 3 },
		PurchasedEquipSlots = 0,
		PurchasedEggSlots = 0,
		EquippedPets = {},
		PetInventory = { Counter = 0, Data = {} },
	}

	local PetRegistry = require(ReplicatedStorage.Data.PetRegistry)
	local cfg = PetRegistry.PetList[petname]
	if not cfg then return false end

	local petUUID = HttpService:GenerateGUID(true)
	local DefaultPetNames = PetRegistry.DefaultPetNames
	local name = DefaultPetNames[math.random(1, #DefaultPetNames)]
	local weight = scale or 1.
	local level = 1
	local age = 1

	Data.PetsData.PetInventory.Counter += 1
	Data.PetsData.PetInventory.Data[petUUID] = {
		PetType = petname,
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

	return petUUID
end

function InventoryService:AddItem(player, itemName, quantity, properties)
	local Data = PlayerData[player].Data
	Data.InventoryData = Data.InventoryData or {}

	if not Data.InventoryData[itemName] then
		Data.InventoryData[itemName] = { Quantity = 0, Items = {} }
	end

	Data.InventoryData[itemName].Quantity = Data.InventoryData[itemName].Quantity + (quantity or 1)

	if properties then
		table.insert(Data.InventoryData[itemName].Items, properties)
	end

	return true
end

function InventoryService:RemoveItem(player, itemName, quantity)
	local Data = PlayerData[player].Data
	if not Data.InventoryData or not Data.InventoryData[itemName] then return false end

	Data.InventoryData[itemName].Quantity = math.max(0, Data.InventoryData[itemName].Quantity - (quantity or 1))

	if Data.InventoryData[itemName].Quantity <= 0 then
		Data.InventoryData[itemName] = nil
	end

	return true
end

function InventoryService:GetItemCount(player, itemName)
	local Data = PlayerData[player].Data
	if Data.InventoryData and Data.InventoryData[itemName] then
		return Data.InventoryData[itemName].Quantity
	end
	return 0
end

function InventoryService:HasSpace(player)
	local Data = PlayerData[player].Data
	local count = 0
	if Data.InventoryData then
		for _, v in pairs(Data.InventoryData) do
			count += v.Quantity or 0
		end
	end
	return count < MAX_INVENTORY_ITEMS
end

function InventoryService:GetInventory(player)
	local Data = PlayerData[player].Data
	return Data.InventoryData or {}
end

return InventoryService