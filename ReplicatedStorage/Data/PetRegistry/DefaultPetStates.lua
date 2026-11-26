-- DefaultPetStates.lua - Default Pet State Values
-- From: ReplicatedStorage.Data.PetRegistry.DefaultPetStates

return {
	-- Base stats for new pets
	NewPet = {
		Hunger = 1000,
		Happiness = 100,
		Energy = 100,
		XP = 0,
		Level = 1,
		Age = 1,
		Weight = 1.0,
		Variant = "Normal",
		Mutations = {},
		Equipped = false
	},

	-- Hunger depletion rates (per second)
	HungerDepletion = {
		BaseRate = 0.025, -- per second
		PerWeight = 0.0005, -- additional per weight unit
		MinHunger = 0,
		MaxHunger = 1000
	},

	-- Happiness rates
	Happiness = {
		BaseDecay = 0.001, -- per second when not interacting
		MaxHappiness = 100,
		MinHappiness = 0,
		FeedBonus = 5,
		PlayBonus = 10,
		PetBonus = 2,
		TrainBonus = 3
	},

	-- Energy system
	Energy = {
		MaxEnergy = 100,
		RestRecovery = 2, -- per second when resting
		ActiveDrain = 0.5, -- per second when active
		SleepRecovery = 5 -- per second when sleeping
	},

	-- XP and Leveling
	Leveling = {
		BaseXP = 20,
		Exponent = 2.02,
		MaxLevel = 100,
		XPPerSecond = 0.5, -- when training
		XPPerFeed = 10,
		XPPerPlay = 25,
		XPPerTrain = 50
	},

	-- Weight scaling
	Weight = {
		BaseWeight = 1.0,
		ScalePerLevel = 0.1, -- 10% per level
		MinWeight = 0.5,
		MaxWeight = 5.0,
		HugeThreshold = 3.0,
		HugeChanceBase = 0.01, -- 1%
		HugeChancePerLevel = 0.001
	},

	-- Age system
	Age = {
		MaxAge = 1000, -- days
		AgePerDay = 1,
		SeniorAge = 500,
		ElderAge = 800
	},

	-- Breeding (if implemented)
	Breeding = {
		Cooldown = 86400, -- 24 hours
		MinLevel = 10,
		MaxOffspring = 3,
		InheritanceChance = 0.5 -- 50% chance to inherit parent traits
	},

	-- Mutation system
	Mutations = {
		MaxMutations = 3,
		MutationChance = 0.001, -- 0.1% base
		WeatherBonus = 2.0, -- 2x during weather events
		CompatibleMutations = {
			Wet = { "Frozen", "Chilled" },
			Frozen = { "Chilled", "Windstruck" },
			Chilled = { "Frozen", "Windstruck" },
			Moonlit = { "Celestial", "Dawnbound" },
			Celestial = { "Moonlit", "Galactic" },
			Dawnbound = { "Moonlit", "Sandy" },
			Sandy = { "Dawnbound", "Windstruck" },
			Pollinated = { "Choc", "Disco" },
			Choc = { "Pollinated", "Disco" },
			Disco = { "Pollinated", "Choc" },
			Heavenly = { "Divine", "Galactic" },
			Alienlike = { "Voidtouched", "Galactic" },
			Galactic = { "Alienlike", "Voidtouched", "Celestial" },
			Voidtouched = { "Alienlike", "Bloodlit" },
			Bloodlit = { "Voidtouched", "Twisted" },
			Twisted = { "Bloodlit", "Windstruck" },
			Windstruck = { "Frozen", "Chilled", "Sandy", "Twisted" },
			Sandy = { "Dawnbound", "Windstruck" },
			SheckleRain = { "Choc", "Disco" }
		}
	},

	-- Passive cooldowns
	PassiveCooldowns = {
		Default = 300, -- 5 minutes
		ScalePerLevel = -5, -- reduce by 5s per level
		MinCooldown = 60 -- 1 minute minimum
	},

	-- Pet aging effects
	AgingEffects = {
		Adult = { ageStart = 100, statMultiplier = 1.0 },
		Senior = { ageStart = 500, statMultiplier = 0.95 },
		Elder = { ageStart = 800, statMultiplier = 0.9 }
	},

	-- Size categories
	SizeCategories = {
		Tiny = { weightMax = 0.8, speedMult = 1.2, healthMult = 0.8 },
		Small = { weightMax = 1.5, speedMult = 1.1, healthMult = 0.9 },
		Medium = { weightMax = 2.5, speedMult = 1.0, healthMult = 1.0 },
		Large = { weightMax = 4.0, speedMult = 0.9, healthMult = 1.1 },
		Huge = { weightMax = 999, speedMult = 0.8, healthMult = 1.3 }
	}
}