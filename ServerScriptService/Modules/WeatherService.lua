-- WeatherService.lua - Original Garden Game Weather System
-- From: ServerScriptService.Modules.WeatherService

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

local Weathers = {
	{ name = "Rain",           eventLength = 300, weight = 40, attribute = "RainEvent",          mutations = { ["Wet"]          = 10 } },
	{ name = "Frost",          eventLength = 300, weight = 30, attribute = "FrostEvent",         mutations = { ["Frozen"]       = 5, ["Chilled"]    = 15 } },
	{ name = "Thunderstorm",   eventLength = 300, weight = 20, attribute = "Thunderstorm",       mutations = { ["Wet"]          = 10 } },
	{ name = "Night",          eventLength = 300, weight = 5,  attribute = "NightEvent",         mutations = { ["Moonlit"]      = 5 } },
	{ name = "MeteorShower",   eventLength = 300, weight = 3,  attribute = "MeteorShower",       mutations = { ["Celestial"]    = 5 } },
	{ name = "SunGod",         eventLength = 300, weight = 2,  attribute = "SunGod",             mutations = { ["Dawnbound"]    = 5 } },
	{ name = "Sandstorm",      eventLength = 300, weight = 2,  attribute = "Sandstorm",          mutations = { ["Sandy"]        = 5 } },
	{ name = "TropicalRain",   eventLength = 300, weight = 8,  attribute = "TropicalRain",       mutations = { ["Wet"]          = 10 } },
	{ name = "Drought",        eventLength = 300, weight = 5,  attribute = "DroughtEvent",       mutations = {} },

	-- Admin events (weight 0)
	{ name = "ChocolateRain",  eventLength = 300, weight = 0,  attribute = "ChocolateRain",      mutations = { ["Choc"]         = 100 } },
	{ name = "BeeNado",        eventLength = 300, weight = 0,  attribute = "BeenadoEvent",       mutations = { ["Pollinated"]   = 5 } },
	{ name = "BeeStorm",       eventLength = 300, weight = 0,  attribute = "Beestorm",           mutations = { ["Pollinated"]   = 5 } },
	{ name = "DJJhai",         eventLength = 300, weight = 0,  attribute = "DJJhai",             mutations = { ["Disco"]        = 15 } },
	{ name = "JandelFloat",    eventLength = 300, weight = 0,  attribute = "JandelFloat",        mutations = { ["Heavenly"]     = 15 } },
	{ name = "AlienInvasion",  eventLength = 300, weight = 0,  attribute = "AlienInvasion",      mutations = { ["Alienlike"]    = 5 } },
	{ name = "Gale",           eventLength = 300, weight = 0,  attribute = "Gale",               mutations = { ["Windstruck"]   = 5 } },
	{ name = "Blackhole",      eventLength = 300, weight = 0,  attribute = "Blackhole",          mutations = { ["Voidtouched"]  = 5 } },
	{ name = "Disco",          eventLength = 300, weight = 0,  attribute = "DiscoEvent",         mutations = { ["Disco"]        = 5 } },
	{ name = "BloodMoon",      eventLength = 300, weight = 0,  attribute = "BloodMoonEvent",     mutations = { ["Bloodlit"]     = 5 } },
	{ name = "BeeEvent",       eventLength = 300, weight = 0,  attribute = "BeeEvent",           mutations = { ["Pollinated"]   = 15 } },
	{ name = "SpaceTravel",    eventLength = 300, weight = 0,  attribute = "SpaceTravelEvent",   mutations = { ["Galactic"]     = 5 } },
	{ name = "SummerEvent",    eventLength = 300, weight = 0,  attribute = "SummerEvent",        mutations = {} },
}

local WeatherService = { activeEvents = {}, randomEnabled = false }

local function totalWeight()
	local sum = 0
	for _, w in ipairs(Weathers) do sum = sum + w.weight end
	return sum
end

function WeatherService:getRandomWeather()
	local roll, acc = math.random() * totalWeight(), 0
	for _, w in ipairs(Weathers) do
		acc = acc + w.weight
		if roll <= acc then return table.clone(w) end
	end
	return table.clone(Weathers[1])
end

function WeatherService:startRandomWeather()
	if self.randomEnabled then return end
	self.randomEnabled = true
	task.spawn(function()
		while self.randomEnabled do
			task.wait(math.random(300, 600))
			if not self.randomEnabled then break end
			self:activateWeather(self:getRandomWeather())
		end
	end)
end

function WeatherService:activateWeather(weatherData)
	if self.activeEvents[weatherData.attribute] then return end
	self.activeEvents[weatherData.attribute] = true
	GameEvents:SetAttribute(weatherData.attribute, true)
	task.delay(weatherData.eventLength, function()
		self.activeEvents[weatherData.attribute] = nil
		GameEvents:SetAttribute(weatherData.attribute, false)
	end)
end

function WeatherService:triggerEvent(weatherName)
	for _, w in ipairs(Weathers) do
		if w.name == weatherName then
			self:activateWeather(w)
			break
		end
	end
end

function WeatherService:getActiveEvents()
	local active = {}
	for attr, _ in pairs(self.activeEvents) do
		table.insert(active, attr)
	end
	return active
end

function WeatherService:getMutationChances()
	local chances = {}
	for _, w in ipairs(Weathers) do
		if self.activeEvents[w.attribute] then
			for mut, chance in pairs(w.mutations) do
				chances[mut] = (chances[mut] or 0) + chance
			end
		end
	end
	return chances
end

return WeatherService