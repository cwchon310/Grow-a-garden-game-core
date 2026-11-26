-- PetStatesRegistry.lua - Pet State Definitions
-- From: ReplicatedStorage.Data.PetRegistry.PetStatesRegistry

return {
	Idle = {
		Priority = Enum.AnimationPriority.Idle,
		Loop = true,
		Speed = 1.0
	},
	Walk = {
		Priority = Enum.AnimationPriority.Movement,
		Loop = true,
		Speed = 1.0
	},
	Run = {
		Priority = Enum.AnimationPriority.Movement,
		Loop = true,
		Speed = 1.5
	},
	Dig = {
		Priority = Enum.AnimationPriority.Action,
		Loop = false,
		Speed = 1.0
	},
	Sleep = {
		Priority = Enum.AnimationPriority.Idle,
		Loop = true,
		Speed = 0.5
	},
	Eat = {
		Priority = Enum.AnimationPriority.Action,
		Loop = false,
		Speed = 1.0
	},
	Swim = {
		Priority = Enum.AnimationPriority.Movement,
		Loop = true,
		Speed = 1.0
	},
	Fly = {
		Priority = Enum.AnimationPriority.Movement,
		Loop = true,
		Speed = 1.2
	},
	Climb = {
		Priority = Enum.AnimationPriority.Action,
		Loop = true,
		Speed = 1.0
	},
	Graze = {
		Priority = Enum.AnimationPriority.Idle,
		Loop = true,
		Speed = 0.8
	},
	Roar = {
		Priority = Enum.AnimationPriority.Action,
		Loop = false,
		Speed = 1.0
	},
	Happy = {
		Priority = Enum.AnimationPriority.Action,
		Loop = false,
		Speed = 1.2
	},
	Sad = {
		Priority = Enum.AnimationPriority.Idle,
		Loop = true,
		Speed = 0.7
	},
	Angry = {
		Priority = Enum.AnimationPriority.Action,
		Loop = false,
		Speed = 1.5
	},
	Scared = {
		Priority = Enum.AnimationPriority.Action,
		Loop = false,
		Speed = 1.5
	},
	Dance = {
		Priority = Enum.AnimationPriority.Action,
		Loop = true,
		Speed = 1.3
	},
	Play = {
		Priority = Enum.AnimationPriority.Action,
		Loop = false,
		Speed = 1.2
	},
	Work = {
		Priority = Enum.AnimationPriority.Action,
		Loop = true,
		Speed = 1.0
	},
	Rest = {
		Priority = Enum.AnimationPriority.Idle,
		Loop = true,
		Speed = 0.6
	},
	Alert = {
		Priority = Enum.AnimationPriority.Action,
		Loop = false,
		Speed = 1.3
	},
	Hunt = {
		Priority = Enum.AnimationPriority.Action,
		Loop = true,
		Speed = 1.4
	},
	Sleepy = {
		Priority = Enum.AnimationPriority.Idle,
		Loop = true,
		Speed = 0.4
	}
}