-- PetConfig.lua - Pet Configuration
-- From: ReplicatedStorage.Data.PetRegistry.PetConfig

local PetData = {
	Bunny = {
		GrowthMultiplier = 1.1,
		WetnessPerMinute = 0.5,
		Rarity = "Common"
	},
	Turtle = {
		GrowthMultiplier = 1.15,
		WetnessPerMinute = 0.3,
		Rarity = "Rare"
	},
	Bird = {
		GrowthMultiplier = 1.05,
		WetnessPerMinute = 0.8,
		Rarity = "Uncommon"
	}
}

-- Get pet data by name
function GetPetData(petName)
	return PetData[petName]
end

-- Get all pet data
function GetAllPets()
	local result = {}
	for petName, data in pairs(PetData) do
		table.insert(result, {
			Name = petName,
			Data = data
		})
	end
	return result
end

return {
	PET_FEEDING_CONFIG = {
		HUNGER_PER_WEIGHT = 0.25,
		TOTAL_HUNGER_DEPLETION_TIME = 43200,
		MINIMUM_DISTANCE_FOR_FEEDING = 5
	},
	PET_GIFTING_CONFIG = {
		MINIMUM_DISTANCE_FOR_GIFTING = 5
	},
	XP_CONFIG = {
		XP_EXPONENTIAL = 2.02,
		XP_BASE_COST = 20,
		XP_GAIN_PER_SECOND = 0.5,
		MAX_LEVEL = 100
	},
	EGG_CONFIG = {
		DEFAULT_HATCH_TIME = 6
	},
	WEIGHT_CONFIG = {
		SCALE_PERCENTAGE_OF_BASE_WEIGHT_PER_LEVEL = 0.1
	},
	HEIGHT_MAP_CONFIG = {
		TOP_OFFSET = Vector3.new(0, 5, 0, 0),
		BOTTOM_OFFSET = Vector3.new(0, -5, 0, 0),
		MAP_QUALITY = 1,
		RESET_AMOUNT_PER_QUEUE = 3,
		CHANGE_QUEUE_TIME = 0.25
	},
	PetData = PetData,
	GetPetData = GetPetData,
	GetAllPets = GetAllPets
}