-- Remotes.lua - Networking Definitions (ByteNet)
-- From: ReplicatedStorage.Modules.Remotes

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ByteNet = require(ReplicatedStorage.Modules.ByteNet)

return {
	Crops = ByteNet.defineNamespace("Crops", function()
		return {
			Collect = ByteNet.definePacket({
				value = ByteNet.array(ByteNet.inst)
			})
		}
	end),

	DailyQuests = ByteNet.defineNamespace("DailyQuests", function()
		return {
			Claim = ByteNet.definePacket({
				value = ByteNet.nothing
			})
		}
	end),

	SeedPack = ByteNet.defineNamespace("SeedPack", function()
		return {
			SpinFinished = ByteNet.definePacket({
				value = ByteNet.nothing
			}),
			Open = ByteNet.definePacket({
				value = ByteNet.string
			}),
			Result = ByteNet.definePacket({
				value = ByteNet.struct({
					seedPackType = ByteNet.string,
					resultIndex = ByteNet.uint8
				})
			})
		}
	end),

	InfinitePack = ByteNet.defineNamespace("InfinitePack", function()
		return {
			Claim = ByteNet.definePacket({
				value = ByteNet.nothing
			})
		}
	end),

	Tutorial = ByteNet.defineNamespace("Tutorial", function()
		return {
			Start = ByteNet.definePacket({
				value = ByteNet.nothing
			}),
			Complete = ByteNet.definePacket({
				value = ByteNet.uint8
			})
		}
	end),

	Pet = ByteNet.defineNamespace("Pet", function()
		return {
			Equip = ByteNet.definePacket({
				value = ByteNet.string -- petUUID
			}),
			Unequip = ByteNet.definePacket({
				value = ByteNet.string
			}),
			Feed = ByteNet.definePacket({
				value = ByteNet.struct({
					petUUID = ByteNet.string,
					fruitName = ByteNet.string,
					fruitWeight = ByteNet.float
				})
			}),
			Sell = ByteNet.definePacket({
				value = ByteNet.string
			}),
			HatchEgg = ByteNet.definePacket({
				value = ByteNet.string -- eggName
			}),
			Rename = ByteNet.definePacket({
				value = ByteNet.struct({
					petUUID = ByteNet.string,
					newName = ByteNet.string
				})
			}),
			SetActive = ByteNet.definePacket({
				value = ByteNet.struct({
					petUUID = ByteNet.string,
					active = ByteNet.bool
				})
			})
		}
	end),

	Farm = ByteNet.defineNamespace("Farm", function()
		return {
			Plant = ByteNet.definePacket({
				value = ByteNet.struct({
					seedName = ByteNet.string,
					position = ByteNet.vector3,
					plotId = ByteNet.uint8
				})
			}),
			Water = ByteNet.definePacket({
				value = ByteNet.uint8 -- plotId
			}),
			Harvest = ByteNet.definePacket({
				value = ByteNet.array(ByteNet.inst) -- plants
			}),
			Fertilize = ByteNet.definePacket({
				value = ByteNet.struct({
					fertilizerType = ByteNet.string,
					target = ByteNet.inst
				})
			})
		}
	end),

	Shop = ByteNet.defineNamespace("Shop", function()
		return {
			Buy = ByteNet.definePacket({
				value = ByteNet.struct({
					itemName = ByteNet.string,
					quantity = ByteNet.uint16,
					currency = ByteNet.string
				})
			}),
			Sell = ByteNet.definePacket({
				value = ByteNet.struct({
					itemName = ByteNet.string,
					quantity = ByteNet.uint16
				})
			})
		}
	end),

	Weather = ByteNet.defineNamespace("Weather", function()
		return {
			Changed = ByteNet.definePacket({
				value = ByteNet.struct({
					weather = ByteNet.string,
					remaining = ByteNet.int32,
					data = ByteNet.struct({
						name = ByteNet.string,
						icon = ByteNet.string,
						color = ByteNet.color3,
						petBuffs = ByteNet.struct({
							incomeMult = ByteNet.float,
							speedMult = ByteNet.float,
							xpMult = ByteNet.float,
							mutationChanceMult = ByteNet.float,
							happinessGain = ByteNet.int16,
							staminaRegenMult = ByteNet.float
						})
					})
				})
			}),
			Request = ByteNet.definePacket({
				value = ByteNet.nothing
			}),
			Force = ByteNet.definePacket({
				value = ByteNet.struct({
					weather = ByteNet.string,
					duration = ByteNet.int32
				})
			})
		}
	end),

	Quest = ByteNet.defineNamespace("Quest", function()
		return {
			Claim = ByteNet.definePacket({
				value = ByteNet.string -- questId
			}),
			Progress = ByteNet.definePacket({
				value = ByteNet.struct({
					questId = ByteNet.string,
					progress = ByteNet.int32
				})
			})
		}
	end),

	DataStream = ByteNet.defineNamespace("DataStream", function()
		return {
			Init = ByteNet.definePacket({
				value = ByteNet.struct({
					name = ByteNet.string,
					data = ByteNet.any
				})
			}),
			Update = ByteNet.definePacket({
				value = ByteNet.struct({
					name = ByteNet.string,
					changes = ByteNet.any
				})
			})
		}
	end),

	Events = ByteNet.defineNamespace("Events", function()
		return {
			Trigger = ByteNet.definePacket({
				value = ByteNet.struct({
					eventName = ByteNet.string,
					data = ByteNet.any
				})
			})
		}
	end)
}