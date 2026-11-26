-- PassiveRegistry.lua - Pet Passive Abilities
-- From: ReplicatedStorage.Data.PetRegistry.PassiveRegistry

return {
	["Digging Buddy"] = {
		Description = "Occasionally digs up a random seed",
		States = {
			Chance = { Base = 5, Scale = 0.05 },
			Cooldown = { Base = 300, Scale = -5 }
		}
	},
	["Digging Friend"] = {
		Description = "Occasionally digs up a random seed at a higher chance",
		States = {
			Chance = { Base = 8, Scale = 0.08 },
			Cooldown = { Base = 240, Scale = -5 }
		}
	},
	["Milk of the Land"] = {
		Description = "All plants within <Range> studs grow <Multiplier>x faster!",
		States = {
			Range = { Base = 10, Scale = 0.1 },
			Multiplier = { Base = 1.25, Scale = 0.0125 }
		}
	},
	["For the Blue Colony"] = {
		Description = "<Chance>% chance harvested crops duplicate! Rarer crops have lower chance to duplicate.",
		States = {
			Chance = { Base = 10, Scale = 0.1 }
		}
	},
	["Nine-Tailed Myth"] = {
		Description = "Every <Cooldown>m, goes to another player's crop, mutates it with Chakra then steals (duplicate) and gives it to you! Very rare chance to mutate with Foxfire Chakra mutation instead!",
		States = {
			Cooldown = {
				Min = 60,
				Base = 1344.5,
				Scale = -6,
				Formatter = "ColonTime"
			}
		}
	},
	["For the Red Colony"] = {
		Description = "<Chance>% chance harvested crops duplicate! Rarer crops have lower chance to duplicate.",
		States = {
			Chance = { Base = 5, Scale = 0.1 }
		}
	},
	["Wife Wake Uper"] = {
		Description = "Every <Cooldown>m, wakes up his wife, causing a random fruit to receive all mutations",
		States = {
			Cooldown = { Min = 1, Base = 3, Scale = -8, Formatter = "ColonTime" }
		}
	},
	["Cat Nap"] = {
		Description = "Takes naps near crops, increasing growth speed by <Multiplier>x",
		States = {
			Multiplier = { Base = 1.15, Scale = 0.01 },
			Range = { Base = 15, Scale = 0.5 }
		}
	},
	["Thief"] = {
		Description = "Steals fruit from other farms with <Chance>% chance",
		States = {
			Chance = { Base = 3, Scale = 0.05 },
			Cooldown = { Base = 600, Scale = -10 }
		}
	},
	["Milk Production"] = {
		Description = "Produces milk every <Cooldown>m that can be sold for <Value> Sheckles",
		States = {
			Cooldown = { Base = 600, Scale = -10 },
			Value = { Base = 500, Scale = 50 }
		}
	},
	["Treasure Hunter"] = {
		Description = "Finds rare items while swimming with <Chance>% chance",
		States = {
			Chance = { Base = 10, Scale = 0.1 },
			Cooldown = { Base = 300, Scale = -5 }
		}
	},
	["Quality Boost"] = {
		Description = "Nearby crops have <Chance>% chance to gain +1 quality tier",
		States = {
			Chance = { Base = 8, Scale = 0.08 },
			Range = { Base = 10, Scale = 0.5 }
		}
	},
	["Frost Aura"] = {
		Description = "Freezes nearby crops for <Duration>s, preserving them and granting <Bonus>% value",
		States = {
			Duration = { Base = 30, Scale = 1 },
			Bonus = { Base = 25, Scale = 2 },
			Range = { Base = 20, Scale = 1 }
		}
	},
	["Pest Control"] = {
		Description = "Chases away pests from crops within <Range> studs",
		States = {
			Range = { Base = 25, Scale = 1 },
			Effectiveness = { Base = 0.9, Scale = 0.01 }
		}
	},
	["Thief"] = {
		Description = "Steals fruit from other farms with <Chance>% chance",
		States = {
			Chance = { Base = 3, Scale = 0.05 },
			Cooldown = { Base = 600, Scale = -10 }
		}
	},
	["Foxfire Chakra"] = {
		Description = "Mutates crops with Foxfire mutation",
		States = {
			Chance = { Base = 1, Scale = 0.01 }
		}
	},
	["Windstruck"] = {
		Description = "Increases movement speed by <Multiplier>x during windy weather",
		States = {
			Multiplier = { Base = 1.3, Scale = 0.02 }
		}
	},
	["Pollinated"] = {
		Description = "<Chance>% chance to pollinate nearby crops, increasing yield",
		States = {
			Chance = { Base = 15, Scale = 0.1 },
			Range = { Base = 12, Scale = 0.5 }
		}
	},
	["Choc"] = {
		Description = "Turns harvested crops into chocolate variants worth <Multiplier>x value",
		States = {
			Multiplier = { Base = 2.5, Scale = 0.1 },
			Chance = { Base = 50, Scale = 1 }
		}
	},
	["Disco"] = {
		Description = "Causes nearby pets to dance, granting <XP>% bonus XP",
		States = {
			XP = { Base = 20, Scale = 2 },
			Range = { Base = 15, Scale = 0.5 }
		}
	},
	["Heavenly"] = {
		Description = "Grants <Blessing>% bonus to all stats for <Duration>s",
		States = {
			Blessing = { Base = 15, Scale = 1 },
			Duration = { Base = 60, Scale = 2 },
			Cooldown = { Base = 1800, Scale = -20 }
		}
	},
	["Alienlike"] = {
		Description = "Mutates crops with Alien mutation",
		States = {
			Chance = { Base = 2, Scale = 0.02 }
		}
	},
	["Galactic"] = {
		Description = "Grants <Multiplier>x XP during Space Travel event",
		States = {
			Multiplier = { Base = 3, Scale = 0.1 }
		}
	},
	["Voidtouched"] = {
		Description = "Mutates crops with Void mutation",
		States = {
			Chance = { Base = 3, Scale = 0.03 }
		}
	},
	["Bloodlit"] = {
		Description = "Mutates crops with Bloodlit mutation during Blood Moon",
		States = {
			Chance = { Base = 5, Scale = 0.05 }
		}
	},
	["Twisted"] = {
		Description = "Mutates crops with Twisted mutation during Tornado",
		States = {
			Chance = { Base = 3, Scale = 0.03 }
		}
	},
	["Windstruck"] = {
		Description = "Increases flight speed by <Multiplier>x during Gale",
		States = {
			Multiplier = { Base = 1.5, Scale = 0.02 }
		}
	},
	["Moonlit"] = {
		Description = "Grants <Multiplier>x crop value during Night",
		States = {
			Multiplier = { Base = 1.2, Scale = 0.02 }
		}
	},
	["Celestial"] = {
		Description = "Mutates crops with Celestial mutation during Meteor Shower",
		States = {
			Chance = { Base = 2, Scale = 0.02 }
		}
	},
	["Dawnbound"] = {
		Description = "Grants <Multiplier>x crop growth speed during SunGod",
		States = {
			Multiplier = { Base = 2, Scale = 0.05 }
		}
	},
	["Sandy"] = {
		Description = "Reduces water consumption by <Reduction>% during Sandstorm",
		States = {
			Reduction = { Base = 50, Scale = 2 }
		}
	},
	["Wet"] = {
		Description = "Auto-waters crops during Rain/Thunderstorm",
		States = {
			Efficiency = { Base = 1.5, Scale = 0.05 }
		}
	},
	["Frozen"] = {
		Description = "Preserves crops for <Duration>s during Frost",
		States = {
			Duration = { Base = 60, Scale = 2 }
		}
	},
	["Chilled"] = {
		Description = "Slows crop growth by <Reduction>% during Frost",
		States = {
			Reduction = { Base = 30, Scale = 2 }
		}
	},
	["SheckleRain"] = {
		Description = "Rain that gives <Amount> Sheckles per drop",
		States = {
			Amount = { Base = 100, Scale = 10 }
		}
	},
}