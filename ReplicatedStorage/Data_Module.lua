-- Data_Module.lua
-- ReplicatedStorage.Data_Module
-- Main data management module for Garden Game

local dataModule = {};
local dataStoreService = game:GetService("DataStoreService");
local _ = game:GetService("ReplicatedStorage");
local serverStorageService = game:GetService("ServerStorage");
local serverScriptService = game:GetService("ServerScriptService");
local replicatedStorage = game:GetService("ReplicatedStorage");
local httpService = game:GetService("HttpService");
local modulesFolder = replicatedStorage:WaitForChild("Modules");
local getFarmFunction = require(modulesFolder:WaitForChild("GetFarm"));
local mutationHandler = require(game.ReplicatedStorage.Modules.MutationHandler);
local remotesModule = require(replicatedStorage.Modules.Remotes);
local inventoryDataStore = dataStoreService:GetDataStore("Inventory_22");
local dataService = require(serverScriptService.Modules.DataService);
local gardenBadgeAwarderModule = require(serverScriptService.Modules.GardenBadgeAwarder);
local invalidBackpackItems = {};

dataModule.Setup = function(playerInstance)
	task.delay(0, function()
		if not playerInstance then return end
		if not playerInstance.UserId then return end
		
		local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance)
		if not playerInstance.Character then
			playerInstance.CharacterAdded:Wait()
		end
		if not playerDataAsync then return end
		
		if playerDataAsync.Sheckles == 20 and playerDataAsync.FirstTimeUser then
			remotesModule.Tutorial.Start.sendTo(nil, playerInstance)
			playerInstance:SetAttribute("FirstTimePlayer", true)
			task.delay(20, function()
				playerDataAsync.FirstTimeUser = false
			end)
		end
		
		local timeSinceLastSave = DateTime.now().UnixTimestamp - playerDataAsync.LastSaveTime
		playerInstance:SetAttribute("Grow_Amount", timeSinceLastSave)
		
		if table.find(invalidBackpackItems, playerInstance.Name) then
			playerDataAsync.Backpack = {}
		end
		
		playerInstance:SetAttribute("Setup_Finished", true)
		playerInstance:SetAttribute("Finished_Loading", true)
	end)
end

dataModule.Save = function(playerInstance)
	if not playerInstance or not playerInstance.UserId then return end
	
	local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance)
	if not playerDataAsync then return end
	
	playerDataAsync.LastSaveTime = DateTime.now().UnixTimestamp
	
	-- Save backpack, stats, etc.
	local success = dataService:SavePlayerDataAsync(playerInstance)
	return success
end

dataModule.GetStat = function(playerInstance, statName)
	local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance)
	if playerDataAsync and playerDataAsync[statName] then
		return playerDataAsync[statName]
	end
	return nil
end

dataModule.SetStat = function(playerInstance, statName, value)
	local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance)
	if playerDataAsync then
		playerDataAsync[statName] = value
	end
end

dataModule.AddStat = function(playerInstance, statName, amount)
	local current = dataModule.GetStat(playerInstance, statName) or 0
	dataModule.SetStat(playerInstance, statName, current + amount)
end

dataModule.AddItem = function(playerInstance, itemName, quantity, properties)
	local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance)
	if not playerDataAsync then return false end
	
	if not playerDataAsync.Backpack then
		playerDataAsync.Backpack = {}
	end
	
	if not playerDataAsync.Backpack[itemName] then
		playerDataAsync.Backpack[itemName] = { Quantity = 0, Items = {} }
	end
	
	playerDataAsync.Backpack[itemName].Quantity = playerDataAsync.Backpack[itemName].Quantity + (quantity or 1)
	
	-- Add individual items with properties if provided
	if properties then
		table.insert(playerDataAsync.Backpack[itemName].Items, properties)
	end
	
	return true
end

dataModule.RemoveItem = function(playerInstance, itemName, quantity)
	local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance)
	if not playerDataAsync or not playerDataAsync.Backpack then return false end
	
	if not playerDataAsync.Backpack[itemName] then return false end
	
	playerDataAsync.Backpack[itemName].Quantity = math.max(0, playerDataAsync.Backpack[itemName].Quantity - (quantity or 1))
	
	if playerDataAsync.Backpack[itemName].Quantity <= 0 then
		playerDataAsync.Backpack[itemName] = nil
	end
	
	return true
end

dataModule.GetInventory = function(playerInstance)
	local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance)
	if playerDataAsync and playerDataAsync.Backpack then
		return playerDataAsync.Backpack
	end
	return {}
end

dataModule.GetSheckles = function(playerInstance)
	local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance)
	if playerDataAsync then
		return playerDataAsync.Sheckles or 0
	end
	return 0
end

dataModule.AddSheckles = function(playerInstance, amount)
	dataModule.AddStat(playerInstance, "Sheckles", amount)
end

dataModule.RemoveSheckles = function(playerInstance, amount)
	local current = dataModule.GetSheckles(playerInstance)
	if current >= amount then
		dataModule.AddStat(playerInstance, "Sheckles", -amount)
		return true
	end
	return false
end

dataModule.GetLevel = function(playerInstance)
	local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance)
	if playerDataAsync then
		return playerDataAsync.Level or 1
	end
	return 1
end

dataModule.AddXP = function(playerInstance, amount)
	local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance)
	if not playerDataAsync then return end
	
	playerDataAsync.XP = (playerDataAsync.XP or 0) + amount
	
	-- Level up logic
	local currentLevel = dataModule.GetLevel(playerInstance)
	local xpNeeded = currentLevel * 1000
	while playerDataAsync.XP >= xpNeeded do
		playerDataAsync.XP = playerDataAsync.XP - xpNeeded
		playerDataAsync.Level = (playerDataAsync.Level or 1) + 1
		currentLevel = currentLevel + 1
		xpNeeded = currentLevel * 1000
	end
end

return dataModule