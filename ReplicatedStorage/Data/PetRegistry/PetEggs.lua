-- PetEggs.lua - Complete Pet Egg Definitions
-- From: ReplicatedStorage.Data.PetRegistry.PetEggs

return {
	["Common Egg"] = {
		Color = Color3.fromRGB(150, 150, 150),
		HatchTime = 300,
		RarityData = {
			Items = {
				Dog = { ItemOdd = 50, GeneratedPetData = { WeightRange = {0.8, 1.2}, HugeChance = 0.01 } },
				Cat = { ItemOdd = 30, GeneratedPetData = { WeightRange = {0.8, 1.2}, HugeChance = 0.01 } },
				Rabbit = { ItemOdd = 20, GeneratedPetData = { WeightRange = {0.8, 1.2}, HugeChance = 0.01 } },
			}
		}
	},

	["Uncommon Egg"] = {
		Color = Color3.fromRGB(100, 200, 100),
		HatchTime = 1800,
		RarityData = {
			Items = {
				["Golden Lab"] = { ItemOdd = 40, GeneratedPetData = { WeightRange = {0.9, 1.5}, HugeChance = 0.005 } },
				Fox = { ItemOdd = 30, GeneratedPetData = { WeightRange = {0.9, 1.5}, HugeChance = 0.005 } },
				Raccoon = { ItemOdd = 30, GeneratedPetData = { WeightRange = {0.9, 1.5}, HugeChance = 0.005 } },
			}
		}
	},

	["Rare Egg"] = {
		Color = Color3.fromRGB(100, 100, 255),
		HatchTime = 7200,
		RarityData = {
			Items = {
				["Red Panda"] = { ItemOdd = 40, GeneratedPetData = { WeightRange = {1.0, 2.0}, HugeChance = 0.002 } },
				Capybara = { ItemOdd = 35, GeneratedPetData = { WeightRange = {1.0, 2.0}, HugeChance = 0.002 } },
				["Fennec Fox"] = { ItemOdd = 25, GeneratedPetData = { WeightRange = {1.0, 2.0}, HugeChance = 0.002 } },
			}
		}
	},

	["Legendary Egg"] = {
		Color = Color3.fromRGB(163, 120, 45),
		HatchTime = 14400,
		RarityData = {
			Items = {
				["Silver Monkey"] = { ItemOdd = 20, GeneratedPetData = { WeightRange = {0.8, 2}, HugeChance = 0.001 } },
				Cow = { ItemOdd = 20, GeneratedPetData = { WeightRange = {0.8, 2}, HugeChance = 0.001 } },
				["Sea Otter"] = { ItemOdd = 5, GeneratedPetData = { WeightRange = {0.8, 2}, HugeChance = 0.001 } },
				Turtle = { ItemOdd = 1, GeneratedPetData = { WeightRange = {0.8, 2}, HugeChance = 0.001 } },
				["Polar Bear"] = { ItemOdd = 1, GeneratedPetData = { WeightRange = {0.8, 2}, HugeChance = 0.001 } },
				Raptor = { ItemOdd = 10, GeneratedPetData = { WeightRange = {0.8, 2}, HugeChance = 0.001 } },
				["Giant Panda"] = { ItemOdd = 5, GeneratedPetData = { WeightRange = {0.8, 2}, HugeChance = 0.001 } },
				["Snow Leopard"] = { ItemOdd = 3, GeneratedPetData = { WeightRange = {0.8, 2}, HugeChance = 0.001 } },
				["Red Panda"] = { ItemOdd = 8, GeneratedPetData = { WeightRange = {0.8, 2}, HugeChance = 0.001 } },
			}
		}
	},

	["Mythical Egg"] = {
		Color = Color3.fromRGB(170, 85, 255),
		HatchTime = 28800,
		RarityData = {
			Items = {
				Dragon = { ItemOdd = 30, GeneratedPetData = { WeightRange = {1.5, 3}, HugeChance = 0.0005 } },
				Phoenix = { ItemOdd = 20, GeneratedPetData = { WeightRange = {1.5, 3}, HugeChance = 0.0005 } },
				["Nine-Tailed Fox"] = { ItemOdd = 10, GeneratedPetData = { WeightRange = {1.5, 3}, HugeChance = 0.0005 } },
				Kirin = { ItemOdd = 5, GeneratedPetData = { WeightRange = {1.5, 3}, HugeChance = 0.0005 } },
			}
		}
	},

	["Divine Egg"] = {
		Color = Color3.fromRGB(255, 85, 0),
		HatchTime = 86400,
		RarityData = {
			Items = {
				["Cosmic Dragon"] = { ItemOdd = 50, GeneratedPetData = { WeightRange = {2.0, 5}, HugeChance = 0.0001 } },
				["Void Walker"] = { ItemOdd = 30, GeneratedPetData = { WeightRange = {2.0, 5}, HugeChance = 0.0001 } },
				["Primordial Beast"] = { ItemOdd = 20, GeneratedPetData = { WeightRange = {2.0, 5}, HugeChance = 0.0001 } },
			}
		}
	},

	-- Admin/Event eggs (weight 0, only obtainable via admin)
	["Chocolate Egg"] = {
		Color = Color3.fromRGB(100, 60, 30),
		HatchTime = 300,
		RarityData = {
			Items = {
				["Chocolate Bunny"] = { ItemOdd = 100, GeneratedPetData = { WeightRange = {1, 1.5}, HugeChance = 0.1 } },
			}
		}
	},

	["Bee Egg"] = {
		Color = Color3.fromRGB(255, 200, 50),
		HatchTime = 1800,
		RarityData = {
			Items = {
				["Bee"] = { ItemOdd = 60, GeneratedPetData = { WeightRange = {0.5, 1}, HugeChance = 0.02 } },
				["Queen Bee"] = { ItemOdd = 5, GeneratedPetData = { WeightRange = {1, 2}, HugeChance = 0.01 } },
			}
		}
	},

	["Nightmare Egg"] = {
		Color = Color3.fromRGB(50, 0, 80),
		HatchTime = 14400,
		RarityData = {
			Items = {
				["Shadow Wolf"] = { ItemOdd = 40, GeneratedPetData = { WeightRange = {1.2, 2.5}, HugeChance = 0.001 } },
				["Void Cat"] = { ItemOdd = 30, GeneratedPetData = { WeightRange = {1, 2}, HugeChance = 0.001 } },
				["Nightmare"] = { ItemOdd = 5, GeneratedPetData = { WeightRange = {2, 3}, HugeChance = 0.0005 } },
			}
		}
	},
}