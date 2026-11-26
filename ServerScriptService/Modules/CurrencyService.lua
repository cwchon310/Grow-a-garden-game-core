-- CurrencyService.lua - Currency Management
-- From: ServerScriptService.Modules.CurrencyService

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local QuestsService = require(script.Parent.QuestsService)

local CurrencyService = {}

local CURRENCY_TYPES = {
	Sheckles = "Sheckles",
	Honey = "Honey",
	SummerCoins = "SummerCoins"
}

function CurrencyService:InitPlayer(player)
	local data = PlayerData[player].Data
	data.Sheckles = data.Sheckles or 0
	data.SpecialCurrency = data.SpecialCurrency or {}
	data.SpecialCurrency.Honey = data.SpecialCurrency.Honey or 0
	data.SpecialCurrency.SummerCoins = data.SpecialCurrency.SummerCoins or 0
end

function CurrencyService:Add(player, currencyType, amount)
	if currencyType == nil then
		currencyType = "Sheckles"
	end
	if not CURRENCY_TYPES[currencyType] then
		warn(string.format("Invalid currency type: %s", currencyType))
		currencyType = "Sheckles"
	end

	if not PlayerData[player] then
		warn(string.format("No player data found for %s", player.Name))
		return false
	end

	if not tonumber(amount) or amount < 0 then
		warn(string.format("Invalid amount: %s for player %s", tostring(amount), player.Name))
		return false
	end

	local data = PlayerData[player].Data
	if currencyType == CURRENCY_TYPES.Sheckles then
		data.Sheckles = (data.Sheckles or 0) + amount
	else
		data.SpecialCurrency[currencyType] = (data.SpecialCurrency[currencyType] or 0) + amount
	end

	if amount > 0 then
		local profile = PlayerData[player]
		if profile then
			GameEvents:FireClient(player, "CurrencyChanged", currencyType, data.Sheckles or 0)
		end
	end

	return true
end

function CurrencyService:Remove(player, currencyType, amount)
	if currencyType == nil then currencyType = "Sheckles" end
	if not CURRENCY_TYPES[currencyType] then return false end

	if not PlayerData[player] then return false end
	if not tonumber(amount) or amount < 0 then return false end

	local data = PlayerData[player].Data
	local current = 0
	if currencyType == CURRENCY_TYPES.Sheckles then
		current = data.Sheckles or 0
	else
		current = data.SpecialCurrency[currencyType] or 0
	end

	if current < amount then
		return false
	end

	if currencyType == CURRENCY_TYPES.Sheckles then
		data.Sheckles = current - amount
	else
		data.SpecialCurrency[currencyType] = current - amount
	end

	GameEvents:FireClient(player, "CurrencyChanged", currencyType, data.Sheckles or 0)
	return true
end

function CurrencyService:Get(player, currencyType)
	if currencyType == nil then currencyType = "Sheckles" end
	if not PlayerData[player] then return 0 end

	local data = PlayerData[player].Data
	if currencyType == CURRENCY_TYPES.Sheckles then
		return data.Sheckles or 0
	else
		return data.SpecialCurrency[currencyType] or 0
	end
end

function CurrencyService:CanAfford(player, currencyType, amount)
	return CurrencyService:Get(player, currencyType) >= amount
end

function CurrencyService:FormatNumber(num)
	if num >= 1e9 then
		return string.format("%.1fB", num / 1e9)
	elseif num >= 1e6 then
		return string.format("%.1fM", num / 1e6)
	elseif num >= 1e3 then
		return string.format("%.1fK", num / 1e3)
	else
		return tostring(num)
	end
end

return CurrencyService