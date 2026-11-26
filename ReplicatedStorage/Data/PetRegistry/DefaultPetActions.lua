-- DefaultPetActions.lua - Default Pet Actions
-- From: ReplicatedStorage.Data.PetRegistry.DefaultPetActions

return {
	Feed = {
		Name = "Feed",
		Description = "Give food to your pet",
		Cooldown = 5,
		Range = 10,
		Action = function(player, petUUID, fruitName, fruitWeight)
			-- Feeding logic handled by PetService
			return true
		end
	},
	Pet = {
		Name = "Pet",
		Description = "Pet your companion",
		Cooldown = 2,
		Range = 5,
		Action = function(player, petUUID)
			-- Increases happiness
			return true
		end
	},
	Play = {
		Name = "Play",
		Description = "Play with your pet",
		Cooldown = 10,
		Range = 8,
		Action = function(player, petUUID)
			-- Increases happiness and XP
			return true
		end
	},
	Train = {
		Name = "Train",
		Description = "Train your pet for XP",
		Cooldown = 30,
		Range = 5,
		Action = function(player, petUUID)
			-- Grants XP
			return true
		end
	},
	Equip = {
		Name = "Equip",
		Description = "Equip this pet",
		Cooldown = 1,
		Range = 100,
		Action = function(player, petUUID)
			-- Equip logic
			return true
		end
	},
	Unequip = {
		Name = "Unequip",
		Description = "Unequip this pet",
		Cooldown = 1,
		Range = 100,
		Action = function(player, petUUID)
			-- Unequip logic
			return true
		end
	},
	Rename = {
		Name = "Rename",
		Description = "Give your pet a new name",
		Cooldown = 60,
		Range = 100,
		Action = function(player, petUUID, newName)
			-- Rename logic
			return true
		end
	},
	Sell = {
		Name = "Sell",
		Description = "Sell this pet",
		Cooldown = 5,
		Range = 100,
		Action = function(player, petUUID)
			-- Sell logic
			return true
		end
	},
	Release = {
		Name = "Release",
		Description = "Release this pet into the wild",
		Cooldown = 10,
		Range = 100,
		Action = function(player, petUUID)
			-- Release logic
			return true
		end
	},
	Hatch = {
		Name = "Hatch",
		Description = "Hatch this egg",
		Cooldown = 1,
		Range = 5,
		Action = function(player, eggName)
			-- Hatch logic
			return true
		end
	},
	Inspect = {
		Name = "Inspect",
		Description = "View pet details",
		Cooldown = 1,
		Range = 20,
		Action = function(player, petUUID)
			-- Open inspection UI
			return true
		end
	}
}