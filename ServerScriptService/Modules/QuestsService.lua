-- QuestsService.lua - Quest Management System
-- From: ServerScriptService.Modules.QuestsService

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
local ItemModule = require(ReplicatedStorage.Item_Module)
local CurrencyService = require(script.Parent.CurrencyService)
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

local QuestsService = {}

-- Quest definitions
local QUEST_DEFINITIONS = {
	Daily = {
		WaterCrops = {
			name = "Water Crops",
			description = "Water 10 crops",
			type = "Water",
			target = 10,
			reward = { Sheckles = 500, XP = 100 }
		},
		HarvestCrops = {
			name = "Harvest Crops",
			description = "Harvest 20 crops",
			type = "Harvest",
			target = 20,
			reward = { Sheckles = 1000, XP = 200 }
		},
		PlantSeeds = {
			name = "Plant Seeds",
			description = "Plant 15 seeds",
			type = "Plant",
			target = 15,
			reward = { Sheckles = 750, XP = 150 }
		},
		FeedPets = {
			name = "Feed Pets",
			description = "Feed your pets 5 times",
			type = "FeedPet",
			target = 5,
			reward = { Sheckles = 500, XP = 100 }
		},
		SellItems = {
			name = "Market Trader",
			description = "Sell 10 items at the shop",
			type = "Sell",
			target = 10,
			reward = { Sheckles = 1000, XP = 200 }
		},
		HatchEggs = {
			name = "Egg Hatcher",
			description = "Hatch 3 eggs",
			type = "HatchEgg",
			target = 3,
			reward = { Sheckles = 2000, XP = 500 }
		}
	},
	Main = {
		FirstFarm = {
			name = "My First Farm",
			description = "Claim your first farm plot",
			type = "ClaimFarm",
			target = 1,
			reward = { Sheckles = 1000, XP = 500, Item = "Carrot Seed" }
		},
		PetTamer = {
			name = "Pet Tamer",
			description = "Hatch your first pet",
			type = "HatchEgg",
			target = 1,
			reward = { Sheckles = 5000, XP = 1000, Item = "Common Egg" }
		},
		MasterFarmer = {
			name = "Master Farmer",
			description = "Harvest 1000 crops",
			type = "Harvest",
			target = 1000,
			reward = { Sheckles = 50000, XP = 10000, Item = "Golden Seed" }
		},
		PetCollector = {
			name = "Pet Collector",
			description = "Own 10 different pets",
			type = "CollectPets",
			target = 10,
			reward = { Sheckles = 25000, XP = 5000, Item = "Rare Egg" }
		}
	}
}

function QuestsService:GetQuestDefinition(questId, category)
	category = category or "Daily"
	return QUEST_DEFINITIONS[category][questId]
end

function QuestsService:GetAllQuests(category)
	return QUEST_DEFINITIONS[category] or {}
end

function QuestsService:InitPlayer(player)
	local data = PlayerData[player].Data
	data.QuestData = data.QuestData or {
		ActiveQuests = {},
		CompletedQuests = {},
		DailyQuests = {}
	}
	
	-- Assign daily quests if empty
	if #data.QuestData.DailyQuests == 0 then
		self:AssignDailyQuests(player)
	end
end

function QuestsService:AssignDailyQuests(player)
	local data = PlayerData[player].Data
	local dailyQuests = {}
	
	-- Pick 3 random daily quests
	local questIds = {}
	for id, _ in pairs(QUEST_DEFINITIONS.Daily) do
		table.insert(questIds, id)
	end
	
	for i = 1, 3 do
		if #questIds == 0 then break end
		local idx = math.random(1, #questIds)
		local questId = table.remove(questIds, idx)
		table.insert(dailyQuests, {
			id = questId,
			progress = 0,
			completed = false,
			claimed = false,
			assignedAt = os.time()
		})
	end
	
	data.QuestData.DailyQuests = dailyQuests
	
	-- Notify client
	GameEvents:FireClient(player, "QuestsUpdated", data.QuestData)
end

function QuestsService:ProgressQuest(player, questType, amount)
	local data = PlayerData[player].Data
	if not data.QuestData then return end
	
	-- Check active quests
	for _, quest in ipairs(data.QuestData.ActiveQuests) do
		if not quest.completed then
			local def = QUEST_DEFINITIONS.Main[quest.id] or QUEST_DEFINITIONS.Daily[quest.id]
			if def and def.type == questType then
				quest.progress = math.min(quest.progress + (amount or 1), def.target)
				
				if quest.progress >= def.target then
					quest.completed = true
					self:CompleteQuest(player, quest)
				end
				
				GameEvents:FireClient(player, "QuestProgress", quest)
			end
		end
	end
	
	-- Check daily quests
	for _, quest in ipairs(data.QuestData.DailyQuests) do
		if not quest.completed then
			local def = QUEST_DEFINITIONS.Daily[quest.id]
			if def and def.type == questType then
				quest.progress = math.min(quest.progress + (amount or 1), def.target)
				
				if quest.progress >= def.target then
					quest.completed = true
					self:CompleteQuest(player, quest)
				end
				
				GameEvents:FireClient(player, "QuestProgress", quest)
			end
		end
	end
end

function QuestsService:CompleteQuest(player, quest)
	local data = PlayerData[player].Data
	local def = QUEST_DEFINITIONS.Main[quest.id] or QUEST_DEFINITIONS.Daily[quest.id]
	if not def then return end
	
	-- Give rewards
	if def.reward.Sheckles then
		CurrencyService:Add(player, "Sheckles", def.reward.Sheckles)
	end
	if def.reward.XP then
		-- Add XP via DataService
		local profile = PlayerData[player]
		if profile then
			profile.Data.XP = (profile.Data.XP or 0) + def.reward.XP
		end
	end
	if def.reward.Item then
		-- Add item to inventory
		local InventoryService = require(game.ServerScriptService.Modules.InventoryService)
		InventoryService:AddItem(player, def.reward.Item, 1)
	end
	
	quest.claimed = true
	table.insert(data.QuestData.CompletedQuests, {
		id = quest.id,
		completedAt = os.time(),
		rewards = def.reward
	})
	
	GameEvents:FireClient(player, "QuestCompleted", {
		questId = quest.id,
		rewards = def.reward
	})
end

function QuestsService:ClaimDailyQuest(player, questId)
	local data = PlayerData[player].Data
	for i, quest in ipairs(data.QuestData.DailyQuests) do
		if quest.id == questId and quest.completed and not quest.claimed then
			quest.claimed = true
			GameEvents:FireClient(player, "DailyQuestClaimed", questId)
			return true
		end
	end
	return false
end

-- Called when player completes actions
function QuestsService:OnCropHarvested(player, count)
	self:ProgressQuest(player, "Harvest", count)
end

function QuestsService:OnCropWatered(player, count)
	self:ProgressQuest(player, "Water", count)
end

function QuestsService:OnSeedPlanted(player, count)
	self:ProgressQuest(player, "Plant", count)
end

function QuestsService:OnPetFed(player, count)
	self:ProgressQuest(player, "FeedPet", count)
end

function QuestsService:OnItemSold(player, count)
	self:ProgressQuest(player, "Sell", count)
end

function QuestsService:OnEggHatched(player)
	self:ProgressQuest(player, "HatchEgg", 1)
end

function QuestsService:OnFarmClaimed(player)
	self:ProgressQuest(player, "ClaimFarm", 1)
end

function QuestsService:OnPetObtained(player, petType)
	self:ProgressQuest(player, "CollectPets", 1)
end

return QuestsService