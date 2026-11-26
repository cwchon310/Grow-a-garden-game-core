-- ReplicationClass.lua - Server-Client Data Replication
-- From: ServerScriptService.Modules.ReplicationClass

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ReplicationClass = {}
ReplicationClass.__index = ReplicationClass

function ReplicationClass.new()
	local self = setmetatable({}, ReplicationClass)
	self.namespaces = {}
	self.listeners = {}
	return self
end

function ReplicationClass:DefineNamespace(name, schema)
	self.namespaces[name] = schema
end

function ReplicationClass:InitData(player, name, data)
	local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
	local DataStream = GameEvents:WaitForChild("DataStream")
	
	if DataStream then
		DataStream:FireClient(player, "InitData", name, data)
	end
end

function ReplicationClass:UpdateData(name, changes)
	local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
	local DataStream = GameEvents:WaitForChild("DataStream")
	
	if DataStream then
		for _, player in ipairs(Players:GetPlayers()) do
			DataStream:FireClient(player, "UpdateData", name, changes)
		end
	end
end

function ReplicationClass:UpdatePlayerData(player, name, changes)
	local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
	local DataStream = GameEvents:WaitForChild("DataStream")
	
	if DataStream then
		DataStream:FireClient(player, "UpdateData", name, changes)
	end
end

function ReplicationClass:Listen(namespace, callback)
	if not self.listeners[namespace] then
		self.listeners[namespace] = {}
	end
	table.insert(self.listeners[namespace], callback)
end

function ReplicationClass:FireEvent(namespace, ...)
	local listeners = self.listeners[namespace]
	if listeners then
		for _, callback in ipairs(listeners) do
			task.spawn(callback, ...)
		end
	end
end

-- Deep clone utility
function ReplicationClass.DeepClone(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			copy[k] = ReplicationClass.DeepClone(v)
		else
			copy[k] = v
		end
	end
	return copy
end

-- Table listener for reactive updates
ReplicationClass.TableListener = {}
ReplicationClass.TableListener.__index = ReplicationClass.TableListener

function ReplicationClass.TableListener.new(initialData)
	local self = setmetatable({}, ReplicationClass.TableListener)
	self.data = initialData or {}
	self.listeners = {}
	return self
end

function ReplicationClass.TableListener:Get(key)
	return self.data[key]
end

function ReplicationClass.TableListener:Set(key, value)
	local oldValue = self.data[key]
	self.data[key] = value
	if oldValue ~= value then
		self:FireChanged(key, value, oldValue)
	end
end

function ReplicationClass.TableListener:FireChanged(key, newValue, oldValue)
	-- Fire listeners
end

function ReplicationClass.TableListener:Listen(callback)
	table.insert(self.listeners, callback)
end

-- Signal implementation
ReplicationClass.Signal = {}
ReplicationClass.Signal.__index = ReplicationClass.Signal

function ReplicationClass.Signal.new()
	local self = setmetatable({}, ReplicationClass.Signal)
	self.connections = {}
	return self
end

function ReplicationClass.Signal:Connect(callback)
	local connection = {
		callback = callback,
		connected = true
	}
	table.insert(self.connections, connection)
	return connection
end

function ReplicationClass.Signal:Fire(...)
	for _, connection in ipairs(self.connections) do
		if connection.connected then
			task.spawn(connection.callback, ...)
		end
	end
end

function ReplicationClass.Signal:DisconnectAll()
	self.connections = {}
end

-- Deferred signal (fires next frame)
ReplicationClass.Signal.Deferred = {}
ReplicationClass.Signal.Deferred.__index = ReplicationClass.Signal.Deferred

function ReplicationClass.Signal.Deferred.new()
	local self = setmetatable({}, ReplicationClass.Signal.Deferred)
	self.connections = {}
	return self
end

function ReplicationClass.Signal.Deferred:Connect(callback)
	local connection = {
		callback = callback,
		connected = true
	}
	table.insert(self.connections, connection)
	return connection
end

function ReplicationClass.Signal.Deferred:Fire(...)
	local args = {...}
	task.defer(function()
		for _, connection in ipairs(self.connections) do
			if connection.connected then
				task.spawn(connection.callback, unpack(args))
			end
		end
	end)
end

return ReplicationClass