-- MutationHandler.lua - Plant/Pet Mutation System
-- From: ReplicatedStorage.Modules.MutationHandler
-- NOTE: This is the PLANT mutation system. For pets, we need to adapt it.

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TableUtils = require(game.ReplicatedStorage.Modules.TableUtils)
local CalculateWeight = require(game.ReplicatedStorage.Calculate_Weight)

local MutationHandler = {}
local activeMutations = {}

-- Check if object can be mutated (plants/fruits)
MutationHandler.CanBeMutated = function(plant)
	if not plant then
		warn("MutationHandler.CanBeMutated | No plant given!")
		return false
	else
		return plant:HasTag("Harvestable") or plant:HasTag("FruitTool")
	end
end

-- Apply mutation to a plant/fruit
MutationHandler.ApplyMutation = function(plant, mutationName, mutationData)
	if not MutationHandler.CanBeMutated(plant) then
		return false
	end
	
	-- Visual effects
	MutationHandler.ApplyVisuals(plant, mutationName, mutationData)
	
	-- Update value
	if mutationData.ValueMultiplier then
		plant:SetAttribute("MutationValueMult", mutationData.ValueMultiplier)
	end
	
	-- Tag for collection
	plant:AddTag("Mutated_" .. mutationName)
	
	return true
end

-- Visual effects for mutations
MutationHandler.ApplyVisuals = function(plant, mutationName, mutationData)
	-- Particle effects, color changes, etc.
	if mutationData.ParticleEffect then
		local emitter = Instance.new("ParticleEmitter")
		emitter.Name = "Mutation_" .. mutationName
		emitter.Texture = mutationData.ParticleEffect
		emitter.Parent = plant
	end
	
	if mutationData.Color then
		for _, part in ipairs(plant:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Color = mutationData.Color
			end
		end
	end
end

-- Get active weather mutations
MutationHandler.GetWeatherMutations = function()
	local GameEvents = game.ReplicatedStorage:WaitForChild("GameEvents")
	local mutations = {}
	
	for _, weather in pairs(MutationHandler.WEATHER_MUTATIONS) do
		if GameEvents:GetAttribute(weather.attribute) then
			for mutName, chance in pairs(weather.mutations) do
				table.insert(mutations, { name = mutName, chance = chance })
			end
		end
	end
	
	return mutations
end

-- Weather mutation definitions (from WeatherService)
MutationHandler.WEATHER_MUTATIONS = {
	{ name = "Rain", eventLength = 300, weight = 40, attribute = "RainEvent", mutations = { ["Wet"] = 10 } },
	{ name = "Frost", eventLength = 300, weight = 30, attribute = "FrostEvent", mutations = { ["Frozen"] = 5, ["Chilled"] = 15 } },
	{ name = "Thunderstorm", eventLength = 300, weight = 20, attribute = "Thunderstorm", mutations = { ["Wet"] = 10 } },
	{ name = "Night", eventLength = 300, weight = 5, attribute = "NightEvent", mutations = { ["Moonlit"] = 5 } },
	{ name = "MeteorShower", eventLength = 300, weight = 3, attribute = "MeteorShower", mutations = { ["Celestial"] = 5 } },
	{ name = "SunGod", eventLength = 300, weight = 2, attribute = "SunGod", mutations = { ["Dawnbound"] = 5 } },
	{ name = "Sandstorm", eventLength = 300, weight = 2, attribute = "Sandstorm", mutations = { ["Sandy"] = 5 } },
	{ name = "TropicalRain", eventLength = 300, weight = 8, attribute = "TropicalRain", mutations = { ["Wet"] = 10 } },
	{ name = "Drought", eventLength = 300, weight = 5, attribute = "DroughtEvent", mutations = {} },
	
	-- Admin events (weight 0)
	{ name = "ChocolateRain", eventLength = 300, weight = 0, attribute = "ChocolateRain", mutations = { ["Choc"] = 100 } },
	{ name = "BeeNado", eventLength = 300, weight = 0, attribute = "BeenadoEvent", mutations = { ["Pollinated"] = 5 } },
	{ name = "BeeStorm", eventLength = 300, weight = 0, attribute = "Beestorm", mutations = { ["Pollinated"] = 5 } },
	{ name = "DJJhai", eventLength = 300, weight = 0, attribute = "DJJhai", mutations = { ["Disco"] = 15 } },
	{ name = "JandelFloat", eventLength = 300, weight = 0, attribute = "JandelFloat", mutations = { ["Heavenly"] = 15 } },
	{ name = "AlienInvasion", eventLength = 300, weight = 0, attribute = "AlienInvasion", mutations = { ["Alienlike"] = 5 } },
	{ name = "Gale", eventLength = 300, weight = 0, attribute = "Gale", mutations = { ["Windstruck"] = 5 } },
	{ name = "Blackhole", eventLength = 300, weight = 0, attribute = "Blackhole", mutations = { ["Voidtouched"] = 5 } },
	{ name = "Disco", eventLength = 300, weight = 0, attribute = "DiscoEvent", mutations = { ["Disco"] = 5 } },
	{ name = "BloodMoon", eventLength = 300, weight = 0, attribute = "BloodMoonEvent", mutations = { ["Bloodlit"] = 5 } },
	{ name = "BeeEvent", eventLength = 300, weight = 0, attribute = "BeeEvent", mutations = { ["Pollinated"] = 15 } },
	{ name = "SpaceTravel", eventLength = 300, weight = 0, attribute = "SpaceTravelEvent", mutations = { ["Galactic"] = 5 } },
	{ name = "SummerEvent", eventLength = 300, weight = 0, attribute = "SummerEvent", mutations = {} },
}

-- Pet mutation adaptation
MutationHandler.PetMutations = {
	-- These would be applied to pets instead of plants
	Wet = { petBuff = "waterAffinity", description = "Pet enjoys rain, gains happiness" },
	Frozen = { petBuff = "iceResistance", description = "Pet resists cold, gains speed in frost" },
	Chilled = { petBuff = "coldAdaptation", description = "Pet adapts to cold" },
	Moonlit = { petBuff = "nightVision", description = "Pet sees better at night" },
	Celestial = { petBuff = "cosmicPower", description = "Pet gains cosmic energy" },
	Dawnbound = { petBuff = "solarPower", description = "Pet empowered by sun" },
	Sandy = { petBuff = "desertWalker", description = "Pet moves faster on sand" },
	Wet = { petBuff = "waterAffinity", description = "Pet loves water" },
	Pollinated = { petBuff = "natureBond", description = "Pet bonds with nature" },
	Choc = { petBuff = "sweetTooth", description = "Pet loves chocolate, gains hunger" },
	Disco = { petBuff = "partyAnimal", description = "Pet dances, gains happiness" },
	Heavenly = { petBuff = "divineBlessing", description = "Pet receives divine blessing" },
	Alienlike = { petBuff = "alienTech", description = "Pet gains alien technology" },
	Galactic = { petBuff = "spaceTraveler", description = "Pet travels through space" },
	Voidtouched = { petBuff = "voidWalker", description = "Pet walks through void" },
	Bloodlit = { petBuff = "bloodRage", description = "Pet enters blood rage" },
	Twisted = { petBuff = "realityWarper", description = "Pet warps reality" },
	Windstruck = { petBuff = "windRider", description = "Pet rides the wind" },
}

-- Roll for mutation based on chance
MutationHandler.RollMutation = function(chance)
	return math.random() * 100 <= chance
end

return MutationHandler