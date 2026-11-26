-- PetGrowthBuffs.lua - Apply pet growth buffs to plants
-- From: ServerScriptService.Modules.PetGrowthBuffs
-- Purpose: Check for active equipped pets and apply GrowthMultiplier/WetnessPerMinute to plant growth

local PetRegistry = require(script.Parent:WaitForChild("../Data/PetRegistry"))

local PetGrowthBuffs = {}

-- Check if player has any active equipped pet and return pet data
-- Returns: (hasActivePet: boolean, petData: table | nil, petName: string | nil)
function PetGrowthBuffs:GetActivePetData(playerData)
	if not playerData or not playerData.PetsData then
		return false, nil, nil
	end

	local equippedPets = playerData.PetsData.EquippedPets or {}
	if #equippedPets == 0 then
		return false, nil, nil
	end

	-- Get the first equipped pet's data
	local petUUID = equippedPets[1]
	local petInventoryData = playerData.PetsData.PetInventory.Data[petUUID]
	if not petInventoryData then
		return false, nil, nil
	end

	local petName = petInventoryData.PetType or "Bunny"
	local petData = PetRegistry:GetPetData(petName)

	return true, petData, petName
end

-- Apply GrowthMultiplier to plant grow time
-- If player has active equipped pet, grow time is reduced proportionally
-- Example: GrowthMultiplier = 1.1 means grow time is 1/1.1 ≈ 90.9% of original (10% faster)
--
-- @param growRate: current grow rate (time per growth stage)
-- @param playerData: player's PetsData from PlayerData
-- @return: adjusted grow rate, wetnessPerMinute value
function PetGrowthBuffs:ApplyGrowthMultiplier(growRate, playerData)
	local hasActivePet, petData, petName = self:GetActivePetData(playerData)

	if not hasActivePet or not petData then
		return growRate, 0
	end

	local growthMultiplier = petData.GrowthMultiplier or 1.0
	-- Reduce grow time: higher GrowthMultiplier = faster growth
	-- Formula: adjustedRate = originalRate / GrowthMultiplier
	local adjustedGrowRate = growRate / growthMultiplier

	local wetnessPerMinute = petData.WetnessPerMinute or 0

	return adjustedGrowRate, wetnessPerMinute
end

-- Apply WetnessPerMinute to increase plant humidity
-- This accumulates wetness that can affect plant state (e.g., reduce drought risk)
--
-- @param plantInstance: the plant Instance/Script object
-- @param wetnessPerMinute: value from pet's WetnessPerMinute config
-- @param deltaTime: time elapsed in seconds since last update
function PetGrowthBuffs:ApplyWetness(plantInstance, wetnessPerMinute, deltaTime)
	if not plantInstance then return end

	-- Accumulate wetness based on pet's WetnessPerMinute and time passed
	local wetnessIncrease = (wetnessPerMinute / 60) * deltaTime -- convert per-minute to per-second

	-- Get current wetness or start at 0
	local currentWetness = plantInstance:GetAttribute("Wetness") or 0
	local newWetness = currentWetness + wetnessIncrease

	-- Store the updated wetness level
	plantInstance:SetAttribute("Wetness", newWetness)

	-- Optional: cap wetness at a maximum value (e.g., 100)
	-- newWetness = math.min(newWetness, 100)
	-- plantInstance:SetAttribute("Wetness", newWetness)

	return newWetness
end

-- Get all pet data for display/debugging
function PetGrowthBuffs:GetAllPetsData()
	return PetRegistry:GetAllPets()
end

return PetGrowthBuffs