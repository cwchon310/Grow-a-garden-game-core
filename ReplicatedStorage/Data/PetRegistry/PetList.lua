-- PetList.lua - Complete Pet Definitions
-- From: ReplicatedStorage.Data.PetRegistry.PetList

local l_Assets_0 = game:GetService("ReplicatedStorage"):WaitForChild("Assets")
local l_PetAssets_0 = l_Assets_0.Models.PetAssets
local l_PetAnimations_0 = l_Assets_0:WaitForChild("Animations"):WaitForChild("PetAnimations")

local v3 = {
	Dog = {
		Description = "Digging Buddy: Occasionally digs up a random seed",
		Actions = {},
		Model = l_PetAssets_0:FindFirstChild("Dog"),
		DefaultHunger = 1000,
		WeldOffset = CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966),
		ModelScalePerLevel = 0.005,
		Icon = "rbxassetid://135018170520317",
		HungerFruitMultipliers = {},
		MovementType = "Grounded",
		MovementSpeed = 10,
		SellPrice = 55000,
		Rarity = "Common",
		Passives = { "Digging Buddy" },
		YHeightScaler = 0.4,
		Animations = {
			Idle = l_PetAnimations_0.Dog.Idle,
			Walk = l_PetAnimations_0.Dog.Walk,
			Dig = l_PetAnimations_0.Dog.Dig
		},
		States = {}
	},
	["Golden Lab"] = {
		Description = "Digging Friend: Occasionally digs up a random seed at a higher chance",
		Actions = {},
		Model = l_PetAssets_0:FindFirstChild("Dog"),
		Variant = "Golden Lab",
		DefaultHunger = 1200,
		WeldOffset = CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966),
		ModelScalePerLevel = 0.005,
		Icon = "rbxassetid://99376934607716",
		HungerFruitMultipliers = {},
		MovementType = "Grounded",
		MovementSpeed = 10,
		SellPrice = 55000,
		Rarity = "Common",
		Passives = { "Digging Friend" },
		YHeightScaler = 0.4,
		Animations = {
			Idle = l_PetAnimations_0.Dog.Idle,
			Walk = l_PetAnimations_0.Dog.Walk,
			Dig = l_PetAnimations_0.Dog.Dig
		},
		States = {}
	},
	Cat = {
		Description = "Napping Companion: Takes naps near crops, increasing growth speed",
		Actions = {},
		Model = l_PetAssets_0:FindFirstChild("Cat"),
		DefaultHunger = 800,
		WeldOffset = CFrame.Angles(0, 0, 0),
		ModelScalePerLevel = 0.003,
		Icon = "rbxassetid://...",
		HungerFruitMultipliers = {},
		MovementType = "Grounded",
		MovementSpeed = 8,
		SellPrice = 65000,
		Rarity = "Uncommon",
		Passives = { "Cat Nap" },
		YHeightScaler = 0.35,
		Animations = {
			Idle = l_PetAnimations_0.Cat.Idle,
			Walk = l_PetAnimations_0.Cat.Walk,
			Sleep = l_PetAnimations_0.Cat.Sleep
		},
		States = {}
	},
	["Silver Monkey"] = {
		Description = "Mischievous: Steals fruit from other farms",
		Actions = {},
		Model = l_PetAssets_0:FindFirstChild("Monkey"),
		DefaultHunger = 1500,
		WeldOffset = CFrame.Angles(0, 0, 0),
		ModelScalePerLevel = 0.004,
		Icon = "rbxassetid://...",
		HungerFruitMultipliers = {},
		MovementType = "Grounded",
		MovementSpeed = 12,
		SellPrice = 250000,
		Rarity = "Legendary",
		Passives = { "Thief" },
		YHeightScaler = 0.5,
		Animations = {
			Idle = l_PetAnimations_0.Monkey.Idle,
			Walk = l_PetAnimations_0.Monkey.Walk,
			Climb = l_PetAnimations_0.Monkey.Climb
		},
		States = {}
	},
	Cow = {
		Description = "Milk Producer: Produces milk that can be sold or used in recipes",
		Actions = {},
		Model = l_PetAssets_0:FindFirstChild("Cow"),
		DefaultHunger = 2000,
		WeldOffset = CFrame.Angles(0, 0, 0),
		ModelScalePerLevel = 0.006,
		Icon = "rbxassetid://...",
		HungerFruitMultipliers = {},
		MovementType = "Grounded",
		MovementSpeed = 6,
		SellPrice = 300000,
		Rarity = "Legendary",
		Passives = { "Milk Production" },
		YHeightScaler = 0.6,
		Animations = {
			Idle = l_PetAnimations_0.Cow.Idle,
			Walk = l_PetAnimations_0.Cow.Walk,
			Graze = l_PetAnimations_0.Cow.Graze
		},
		States = {}
	},
	["Sea Otter"] = {
		Description = "Aquatic: Swims in water areas, finds rare items",
		Actions = {},
		Model = l_PetAssets_0:FindFirstChild("Otter"),
		DefaultHunger = 1200,
		WeldOffset = CFrame.Angles(0, 0, 0),
		ModelScalePerLevel = 0.004,
		Icon = "rbxassetid://...",
		HungerFruitMultipliers = {},
		MovementType = "Amphibious",
		MovementSpeed = 10,
		SellPrice = 500000,
		Rarity = "Mythical",
		Passives = { "Treasure Hunter" },
		YHeightScaler = 0.4,
		Animations = {
			Idle = l_PetAnimations_0.Otter.Idle,
			Walk = l_PetAnimations_0.Otter.Walk,
			Swim = l_PetAnimations_0.Otter.Swim
		},
		States = {}
	},
	Turtle = {
		Description = "Slow but steady: Increases crop quality over time",
		Actions = {},
		Model = l_PetAssets_0:FindFirstChild("Turtle"),
		DefaultHunger = 800,
		WeldOffset = CFrame.Angles(0, 0, 0),
		ModelScalePerLevel = 0.002,
		Icon = "rbxassetid://...",
		HungerFruitMultipliers = {},
		MovementType = "Grounded",
		MovementSpeed = 4,
		SellPrice = 750000,
		Rarity = "Mythical",
		Passives = { "Quality Boost" },
		YHeightScaler = 0.3,
		Animations = {
			Idle = l_PetAnimations_0.Turtle.Idle,
			Walk = l_PetAnimations_0.Turtle.Walk
		},
		States = {}
	},
	["Polar Bear"] = {
		Description = "Ice King: Freezes nearby crops for preservation bonus",
		Actions = {},
		Model = l_PetAssets_0:FindFirstChild("PolarBear"),
		DefaultHunger = 2500,
		WeldOffset = CFrame.Angles(0, 0, 0),
		ModelScalePerLevel = 0.008,
		Icon = "rbxassetid://...",
		HungerFruitMultipliers = {},
		MovementType = "Grounded",
		MovementSpeed = 8,
		SellPrice = 1000000,
		Rarity = "Divine",
		Passives = { "Frost Aura" },
		YHeightScaler = 0.7,
		Animations = {
			Idle = l_PetAnimations_0.PolarBear.Idle,
			Walk = l_PetAnimations_0.PolarBear.Walk,
			Roar = l_PetAnimations_0.PolarBear.Roar
		},
		States = {}
	},
	Raptor = {
		Description = "Swift Hunter: Chases away pests from crops",
		Actions = {},
		Model = l_PetAssets_0:FindFirstChild("Raptor"),
		DefaultHunger = 1800,
		WeldOffset = CFrame.Angles(0, 0, 0),
		ModelScalePerLevel = 0.005,
		Icon = "rbxassetid://...",
		HungerFruitMultipliers = {},
		MovementType = "Grounded",
		MovementSpeed = 15,
		SellPrice = 200000,
		Rarity = "Legendary",
		Passives = { "Pest Control" },
		YHeightScaler = 0.5,
		Animations = {
			Idle = l_PetAnimations_0.Raptor.Idle,
			Walk = l_PetAnimations_0.Raptor.Walk,
			Run = l_PetAnimations_0.Raptor.Run
		},
		States = {}
	},
	-- Add more pets as needed
}

return v3