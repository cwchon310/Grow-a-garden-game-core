-- BATCH PATCH -- existing modules only
local BatchMapRebuild = require(game.ReplicatedStorage.Modules:WaitForChild("BatchMapRebuild"))
local VisualUtils = require(game.ReplicatedStorage:WaitForChild("VisualUtils"))
local Plant_Module = require(game.ReplicatedStorage:WaitForChild("Plant_Module"))
local BatchPatch = {}; BatchPatch.__index = BatchPatch
function BatchPatch.new() local self=setmetatable({},BatchPatch); self.batch=BatchMapRebuild.new(20); return self end
function BatchPatch:placeBatch(plants,positions,farmPlot)
  for i,plantName in ipairs(plants) do self.batch:addRuins(farmPlot,"GardenRuins") end
  local result = self.batch:executeBatch()
  for _,p in ipairs(plants) do Plant_Module.Plant_Item(p,positions[i],farmPlot,nil) end
  return result
end
return BatchPatch
