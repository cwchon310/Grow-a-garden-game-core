-- ActivePetsService.lua - Active Pet Management (Equipped Pets, Passives, etc.)
-- From: ServerScriptService.Modules.ActivePetsService

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local ServerReplicationService = require(script.Parent:WaitForChild("ReplicationClass"))
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry)
local PetConfig = require(ReplicatedStorage.Data.PetRegistry:WaitForChild("PetConfig"))
local DataStream = ReplicatedStorage:WaitForchild("GameEvents"):WaitForchild("DataStream")
local GetFarm = require(ReplicatedStorage.Modules.GetFarm)
local PetZoneAbility = ReplicatedStorage:WaitForchild("GameEvents"):WaitForchild("PetZoneAbility")
local DefaultPetNames = PetRegistry.DefaultPetNames

-- Ensure ActivePets Folder exists in Workspace
local function GetActivePetsFolder()
	local folder = Workspace:FindFirstChild("ActivePets")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "ActivePets"
		folder.Parent = Workspace
	end
	return folder
end

function ServerReplicationService:InitData(player, name, data)
	DataStream:FireClient(player, "InitData", name, data)
end

function ServerReplicationService:UpdateData(name, changes)
	for _, pl in ipairs(Players:GetPlayers()) do
		DataStream:FireClient(pl, "UpdateData", name, changes)
	end
end

local ActivePetsService = {}
local PetList = PetRegistry.PetList
local ActivePetStates = {}
local PlayerPetData = {}
local PassiveCooldowns = {}

function GetHolding(player)
	local character = player.Character
	if not character then return end
	return character:FindFirstChildWhichIsA("Tool")
end

function ActivePetsService:InitPlayer(profile, player)
	local data = profile.Data
	data.PetsData = data.PetsData or {
		MutableStats = { MaxEquippedPets=3, MaxPetsInInventory=60, MaxEggsInFarm=3 },
		PurchasedEquipSlots = 0,
		PurchasedEggSlots   = 0,
		EquippedPets        = {},
		PetInventory        = { Counter=0, Data={} },
	}

	ActivePetStates[player.Name] = ActivePetStates[player.Name] or {}
	PlayerPetData[player.Name]   = PlayerPetData[player.Name]   or data.PetsData
	PassiveCooldowns[player.Name] = PassiveCooldowns[player.Name] or {}

	-- Initialize passive cooldowns
	for petUUID, petData in pairs(data.PetsData.PetInventory.Data) do
		if petData.Equipped then
			local cfg = PetList[petData.PetType]
			if cfg and cfg.Passives then
				for _, passiveName in ipairs(cfg.Passives) do
					local passive = PetRegistry.PassiveRegistry[passiveName]
					if passive then
						PassiveCooldowns[player.Name][passiveName] = {
							lastTrigger = 0,
							cooldown = passive.States.Cooldown and passive.States.Cooldown.Base or 300
						}
					end
				end
			end
		end
	end
end

function ActivePetsService:EquipPet(player, petUUID)
	local profile = PlayerData[player]
	if not profile then return false end

	local data = profile.Data
	local petData = data.PetsData.PetInventory.Data[petUUID]
	if not petData then return false end

	if petData.Equipped then return false end

	-- Check max equipped
	if #data.PetsData.EquippedPets >= data.PetsData.MutableStats.MaxEquippedPets then
		return false, "Max equipped pets reached"
	end

	petData.Equipped = true
	table.insert(data.PetsData.EquippedPets, petUUID)

	-- Initialize passive cooldowns for this pet
	local cfg = PetList[petData.PetType]
	if cfg and cfg.Passives then
		for _, passiveName in ipairs(cfg.Passives) do
			local passive = PetRegistry.PassiveRegistry[passiveName]
			if passive then
				PassiveCooldowns[player.Name][passiveName] = {
					lastTrigger = 0,
					cooldown = passive.States.Cooldown and passive.States.Cooldown.Base or 300
				}
			end
		end
	end

	-- Spawn pet model
	self:SpawnPetModel(player, petUUID)

	ServerReplicationService:UpdateData("PetsData", {
		EquippedPets = data.PetsData.EquippedPets
	})

	return true
end

function ActivePetsService:UnequipPet(player, petUUID)
	local profile = PlayerData[player]
	if not profile then return false end

	local data = profile.Data
	local petData = data.PetsData.PetInventory.Data[petUUID]
	if not petData then return false end

	petData.Equipped = false
	for i, uuid in ipairs(data.PetsData.EquippedPets) do
		if uuid == petUUID then
			table.remove(data.PetsData.EquippedPets, i)
			break
		end
	end

	-- Despawn pet model
	self:DespawnPetModel(player, petUUID)

	ServerReplicationService:UpdateData("PetsData", {
		EquippedPets = data.PetsData.EquippedPets
	})

	return true
end

function ActivePetsService:SpawnPetModel(player, petUUID)
	local profile = PlayerData[player]
	if not profile then return end

	local data = profile.Data
	local petData = data.PetsData.PetInventory.Data[petUUID]
	if not petData then return end

	local cfg = PetList[petData.PetType]
	if not cfg or not cfg.Model then return end

	local character = player.Character
	if not character then return end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local petModel = cfg.Model:Clone()
	petModel.Name = "ActivePet_" .. petUUID

	-- Parent to ActivePets Folder instead of workspace
	petModel.Parent = GetActivePetsFolder()

	-- Scale
	local scale = 1 + (petData.Level - 1) * (cfg.ModelScalePerLevel or 0.005)
	petModel:ScaleTo(scale)

	-- Apply color based on pet rarity
	local rarity = petData.Rarity or "Common"
	local rarityColor = PetRegistry.PetRarities[rarity]
	if rarityColor then
		local primaryPart = petModel.PrimaryPart or petModel:FindFirstChildWhichIsA("BasePart")
		if primaryPart then
			primaryPart.Color = rarityColor.Color
		end
	end

	-- Position behind player
	local offset = hrp.CFrame * CFrame.new(-5, 0, 3)
	petModel:PivotTo(offset)

	-- Weld to player
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = hrp
	weld.Part1 = petModel.PrimaryPart or petModel:FindFirstChildWhichIsA("BasePart")
	weld.Parent = petModel

	-- Store reference
	ActivePetStates[player.Name][petUUID] = {
		model = petModel,
		petData = petData,
		weld = weld,
		lastPassiveCheck = 0
	}
end

function ActivePetsService:DespawnPetModel(player, petUUID)
	local state = ActivePetStates[player.Name] and ActivePetStates[player.Name][petUUID]
	if state and state.model then
		state.model:Destroy()
	end
	ActivePetStates[player.Name][petUUID] = nil
end

function ActivePetsService:UpdatePetPosition(player, petUUID)
	local state = ActivePetStates[player.Name] and ActivePetStates[player.Name][petUUID]
	if not state or not state.model then return end

	local character = player.Character
	if not character then return end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local offset = hrp.CFrame * CFrame.new(-5, 0, 3)
	state.model:PivotTo(offset)
end

-- Passive ability system
function ActivePetsService:CheckPassives(player)
	local now = os.time()
	local cooldowns = PassiveCooldowns[player.Name]
	if not cooldowns then return end

	for passiveName, cdData in pairs(cooldowns) do
		if now - cdData.lastTrigger >= cdData.cooldown then
			-- Trigger passive
			self:TriggerPassive(player, passiveName)
			cdData.lastTrigger = now
		end
	end
end

function ActivePetsService:TriggerPassive(player, passiveName)
	local passive = PetRegistry.PassiveRegistry[passiveName]
	if not passive then return end

	-- Execute passive logic based on type
	if passiveName == "Digging Buddy" or passiveName == "Digging Friend" then
		self:Passive_DiggingBuddy(player, passive)
	elseif passiveName == "Milk of the Land" then
		self:Passive_MilkOfLand(player, passive)
	elseif passiveName == "For the Blue Colony" or passiveName == "For the Red Colony" then
		self:Passive_DuplicateCrops(player, passive)
	-- ... more passives
	end
end

-- Heartbeat update
RunService.Heartbeat:Connect(function()
	for _, player in ipairs(Players:GetPlayers()) do
		-- Update pet positions
		local states = ActivePetStates[player.Name]
		if states then
			for petUUID, petState in pairs(states) do
				if petState.model and petState.model.Parent then
					ActivePetsService:UpdatePetPosition(player, petUUID)
				end
			end
		end

		-- Check passives
		ActivePetsService:CheckPassives(player)
	end
end)

return ActivePetsService