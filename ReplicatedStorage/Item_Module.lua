local stringUtilsModule = require(game.ReplicatedStorage.Modules.StringUtils);
local itemModule = {};
local itemData = {
	{
		"Carrot", -- name 
		0.275, -- base weight
		20,  -- value per kg
		100 -- 1/this = chance to grow huge
	}, 
	
	{
		"Super", 
		1,
		20,
		100
	}, 
	
	{
		"Nectarine",
		0.275,
		20,
		100
	}, 
	{
		"Strawberry", 
		0.3, 
		15, 
		100
	}, 
	{
		"Lavender", 
		0.5, 
		15, 
		100
	}, 
	
	{
		"Blueberry", 
		0.2, 
		20, 
		100
	}, 
	{
		"Orange Tulip", 
		0.05, 
		850, 
		55
	}, 
	{
		"Eden Fruit", 
		0.5, 
		500, 
		50
	}, 
	{
		"Watermelon", 
		2, 
		50, 
		100
	}, 
	{
		"Pumpkin", 
		5, 
		40, 
		100
	}, 
	{
		"Coconut", 
		1, 
		40, 
		100
	}, 
	{
		"Bamboo", 
		0.5, 
		25, 
		100
	}, 
	{
		"Apple", 
		0.5, 
		20, 
		100
	}, 
	{
		"Mango", 
		0.5, 
		20, 
		100
	}, 
	{
		"Dragon Fruit", 
		0.5, 
		20, 
		100
	}, 
	{
		"Cactus", 
		0.5, 
		20, 
		100
	}, 
	{
		"Cactus Fruit", 
		0.5, 
		20, 
		100
	}, 
	{
		"Tomato", 
		0.5, 
		20, 
		100
	}, 
	{
		"Corn", 
		0.5, 
		20, 
		100
	}, 
	{
		"Raspberry", 
		0.5, 
		20, 
		100
	}, 
	{
		"Grape", 
		0.5, 
		20, 
		100
	}, 
	{
		"Pepper", 
		0.5, 
		20, 
		100
	}, 
	{
		"Cauliflower", 
		0.5, 
		20, 
		100
	}, 
	{
		"Eggplant", 
		0.5, 
		20, 
		100
	}, 
	{
		"Sunflower", 
		0.5, 
		20, 
		100
	}, 
	{
		"Foxglove", 
		0.5, 
		20, 
		100
	}, 
	{
		"Moonflower", 
		0.5, 
		20, 
		100
	}, 
	{
		"Blood Rose", 
		0.5, 
		20, 
		100
	}, 
	{
		"Bone Flower", 
		0.5, 
		20, 
		100
	}, 
	{
		"Soul Flower", 
		0.5, 
		20, 
		100
	}, 
	{
		"Candy Sunflower", 
		0.5, 
		20, 
		100
	}, 
	{
		"Traveler's Fruit", 
		0.5, 
		20, 
		100
	}, 
	{
		"Moon Melon", 
		0.5, 
		20, 
		100
	}, 
	{
		"Starfruit", 
		0.5, 
		20, 
		100
	}, 
	{
		"Alien Fruit", 
		0.5, 
		20, 
		100
	}, 
	{
		"Glowing Mushroom", 
		0.5, 
		20, 
		100
	}, 
	{
		"Moon Blossom", 
		0.5, 
		20, 
		100
	}, 
	{
		"Fossil", 
		0.5, 
		20, 
		100
	}, 
	{
		"Amber", 
		0.5, 
		20, 
		100
	}, 
	{
		"Old Rope", 
		0.5, 
		20, 
		100
	}, 
	{
		"Ancient Seed", 
		0.5, 
		20, 
		100
	}, 
	{
		"Golden Apple", 
		0.5, 
		20, 
		100
	}, 
	{
		"Golden Carrot", 
		0.5, 
		20, 
		100
	}, 
	{
		"Golden Seed", 
		0.5, 
		20, 
		100
	}, 
	{
		"Golden Fruit", 
		0.5, 
		20, 
		100
	}, 
	{
		"Rainbow Fruit", 
		0.5, 
		20, 
		100
	}, 
	{
		"Prism Fruit", 
		0.5, 
		20, 
		100
	}, 
	{
		"Cosmic Fruit", 
		0.5, 
		20, 
		100
	}, 
	{
		"Void Fruit", 
		0.5, 
		20, 
		100
	}, 
}

-- Build lookup tables
itemModule.Data = {}
itemModule.Names = {}
itemModule.Weights = {}
itemModule.Values = {}
itemModule.HugeChances = {}

for i, data in ipairs(itemData) do
	local name = data[1]
	itemModule.Data[name] = {
		Name = name,
		BaseWeight = data[2],
		ValuePerKg = data[3],
		HugeChance = data[4]
	}
	itemModule.Names[i] = name
	itemModule.Weights[name] = data[2]
	itemModule.Values[name] = data[3]
	itemModule.HugeChances[name] = data[4]
end

-- Utility functions
function itemModule.GetData(itemName)
	return itemModule.Data[itemName]
end

function itemModule.GetBaseWeight(itemName)
	return itemModule.Weights[itemName] or 0
end

function itemModule.GetValuePerKg(itemName)
	return itemModule.Values[itemName] or 0
end

function itemModule.GetHugeChance(itemName)
	return itemModule.HugeChances[itemName] or 100
end

function itemModule.GetAllItems()
	return itemModule.Names
end

function itemModule.CalculateValue(itemName, weight)
	local valuePerKg = itemModule.GetValuePerKg(itemName)
	return math.floor(weight * valuePerKg)
end

function itemModule.Return_Random_Super_Rarity()
	local totalWeight = 0
	for _, w in ipairs(itemModule.Weights) do
		totalWeight = totalWeight + w
	end
	local roll = math.random() * totalWeight
	local cumulative = 0
	for name, weight in pairs(itemModule.Weights) do
		cumulative = cumulative + weight
		if roll <= cumulative then
			return name
		end
	end
	return "Carrot"
end

function itemModule.GetItemRarity(itemName)
	local weight = itemModule.GetBaseWeight(itemName)
	if weight >= 1 then return "Common"
	elseif weight >= 0.5 then return "Uncommon"
	elseif weight >= 0.2 then return "Rare"
	elseif weight >= 0.1 then return "Epic"
	elseif weight >= 0.05 then return "Legendary"
	else return "Mythic" end
end

return itemModule