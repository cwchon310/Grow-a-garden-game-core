-- DataService.lua - ProfileStore-based Data Service
-- From: ServerScriptService.Modules.DataService

local ProfileStore = require(script.Parent.ProfileStore)
local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")

local DataService = {}

local PLAYER_PROFILE_TEMPLATE = {
	Sheckles = 20,
	SpecialCurrency = {
		Honey = 0,
		SummerCoins = 0
	},
	Level = 1,
	XP = 0,
	FirstTimeUser = true,
	LastSaveTime = 0,
	Backpack = {},
	InventoryData = {},
	PetsData = {
		MutableStats = { MaxEquippedPets = 3, MaxPetsInInventory = 60, MaxEggsInFarm = 3 },
		PurchasedEquipSlots = 0,
		PurchasedEggSlots = 0,
		EquippedPets = {},
		PetInventory = { Counter = 0, Data = {} }
	},
	QuestData = {
		ActiveQuests = {},
		CompletedQuests = {},
		DailyQuests = {}
	},
	Settings = {
		MusicVolume = 0.5,
		SFXVolume = 0.5,
		AutoSave = true
	},
	Stats = {
		TotalPlaytime = 0,
		CropsHarvested = 0,
		PetsHatched = 0,
		PetsSold = 0,
		TotalEarnings = 0
	}
}

local PROFILE_STORE_KEY = "PlayerData_22"
local profileStore = ProfileStore.New(PROFILE_STORE_KEY, PLAYER_PROFILE_TEMPLATE)

local profiles = {}

function DataService:GetPlayerDataAsync(player)
	if not player then return nil end
	
	local profile = profiles[player]
	if profile then
		return profile
	end
	
	-- Load profile
	local loadProfile = profileStore:LoadProfileAsync("Player_" .. player.UserId, "ForceLoad")
	if loadProfile then
		loadProfile:AddUserId(player.UserId)
		loadProfile:Reconcile()
		
		loadProfile:ListenToRelease(function()
			profiles[player] = nil
			player:Kick("Profile released - please rejoin")
		end)
		
		if player:IsDescendantOf(Players) then
			profiles[player] = loadProfile
			return loadProfile
		else
			loadProfile:Release()
		end
	end
	
	return nil
end

function DataService:SavePlayerDataAsync(player)
	local profile = profiles[player]
	if profile then
		profile:Release()
		profiles[player] = nil
		return true
	end
	return false
end

function DataService:AutoSave()
	for player, profile in pairs(profiles) do
		if profile and profile:IsActive() then
			profile.Data.LastSaveTime = DateTime.now().UnixTimestamp
		end
	end
end

-- Auto-save every 60 seconds
task.spawn(function()
	while true do
		task.wait(60)
		DataService:AutoSave()
	end
end)

Players.PlayerRemoving:Connect(function(player)
	DataService:SavePlayerDataAsync(player)
end)

return DataService