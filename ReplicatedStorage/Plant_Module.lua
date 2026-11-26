--!native

local Plant_Module = {}

local TweenService = game:GetService("TweenService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local SHORT_TWEEN_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local LONG_TWEEN_INFO = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

local PlaySoundEvent = ReplicatedStorage.GameEvents.PlaySound
local DataModule = require(ReplicatedStorage.Data_Module)
local ItemModule = require(ReplicatedStorage.Item_Module)
local QuestsServiceModule = require(ServerScriptService.Modules.QuestsService)
local PlayerLuckModule = require(ReplicatedStorage.Modules.PlayerLuck)
local PlantScriptsContainer = game.ServerStorage.PlantHandler
local QuestsService = require(game.ServerScriptService.Modules.QuestsService)
local PlayerData = require(game.ServerStorage.PlayerData)

Plant_Module.Plant_Item = function(collectibleName, position, farmPlotInstance, playerInstance, attemptSuperVariant, seed, uuid, lastUpd, lastFruit, variant, age, plantedOn)
	local plantScriptInstance = PlantScriptsContainer:FindFirstChild(collectibleName)
	if not plantScriptInstance then
		return
	end

	local PlantConstructor = require(plantScriptInstance)

	if attemptSuperVariant then
		local plantSeed = seed or Random.new():NextInteger(1, 10000000)
		local collectibleTemplate = game.ServerStorage.Collectables[collectibleName]
		local newPlantInstance = collectibleTemplate:Clone()

		math.randomseed(newPlantInstance.Item_Seed.Value)
		newPlantInstance.Variant.Value = variant or ItemModule.Return_Random_Super_Rarity()
		newPlantInstance.Grow.Age.Value = age or 0
		newPlantInstance.Grow.Grow_Rate.Value *= 0.75
		newPlantInstance.Item_Seed.Value = plantSeed
		collectibleTemplate.Item_Seed.Value = plantSeed 
		newPlantInstance:AddTag(newPlantInstance.Name)

		local basePlantCFrame = CFrame.new(position - Vector3.new(0, newPlantInstance.Plant_Down.Value, 0))
		local yRotationDegrees = Random.new(seed):NextNumber(-180, 180)
		local finalPlantCFrame = basePlantCFrame * CFrame.Angles(0, math.rad(yRotationDegrees), 0)

		local obj = farmPlotInstance.Important.Plant_Locations:FindFirstChild(plantedOn)
		newPlantInstance:PivotTo(finalPlantCFrame)
		newPlantInstance:SetAttribute("Owner", playerInstance.Name)
		newPlantInstance:SetAttribute("PlantedOn", plantedOn)
		newPlantInstance.Parent = farmPlotInstance.Important.Plants_Physical

		PlantConstructor.Init(newPlantInstance)

		return newPlantInstance
	end

	local collectibleTemplate = game.ServerStorage.Collectables[collectibleName]
	local newPlantInstance = collectibleTemplate:Clone()

	math.randomseed(newPlantInstance.Item_Seed.Value)
	newPlantInstance.Variant.Value = variant or "Normal"
	newPlantInstance.Grow.Age.Value = age or 0
	newPlantInstance.Item_Seed.Value = seed or Random.new():NextInteger(1, 10000000)
	newPlantInstance:AddTag(newPlantInstance.Name)

	local basePlantCFrame = CFrame.new(position - Vector3.new(0, newPlantInstance.Plant_Down.Value, 0))
	local yRotationDegrees = Random.new(seed):NextNumber(-180, 180)
	local finalPlantCFrame = basePlantCFrame * CFrame.Angles(0, math.rad(yRotationDegrees), 0)

	local obj = farmPlotInstance.Important.Plant_Locations:FindFirstChild(plantedOn)
	newPlantInstance:PivotTo(finalPlantCFrame)
	newPlantInstance:SetAttribute("Owner", playerInstance.Name)
	newPlantInstance:SetAttribute("PlantedOn", plantedOn)
	newPlantInstance.Parent = farmPlotInstance.Important.Plants_Physical

	PlantConstructor.Init(newPlantInstance)

	return newPlantInstance
end

Plant_Module.Remove_Plant = function(plantInstance)
	if plantInstance then
		plantInstance:Destroy()
	end
end

Plant_Module.Harvest_Plant = function(plantInstance, playerInstance)
	local plantScript = PlantScriptsContainer:FindFirstChild(plantInstance.Name)
	if plantScript then
		local PlantConstructor = require(plantScript)
		if PlantConstructor.Harvest then
			return PlantConstructor.Harvest(plantInstance, playerInstance)
		end
	end
	return false
end

Plant_Module.Get_Plant_Data = function(plantInstance)
	local plantScript = PlantScriptsContainer:FindFirstChild(plantInstance.Name)
	if plantScript then
		local PlantConstructor = require(plantScript)
		if PlantConstructor.GetData then
			return PlantConstructor.GetData(plantInstance)
		end
	end
	return nil
end

Plant_Module.Apply_Fertilizer = function(plantInstance, fertilizerType)
	local plantScript = PlantScriptsContainer:FindFirstChild(plantInstance.Name)
	if plantScript then
		local PlantConstructor = require(plantScript)
		if PlantConstructor.ApplyFertilizer then
			return PlantConstructor.ApplyFertilizer(plantInstance, fertilizerType)
		end
	end
	return false
end

Plant_Module.Water_Plant = function(plantInstance)
	local plantScript = PlantScriptsContainer:FindFirstChild(plantInstance.Name)
	if plantScript then
		local PlantConstructor = require(plantScript)
		if PlantConstructor.Water then
			return PlantConstructor.Water(plantInstance)
		end
	end
	return false
end

return Plant_Module