--[[
Ceramic Tile Engine Snippet: Pathfinding Array Generator

Generates a pathfinding array from a Ceramic map.

Usage:

local ceramic=require("Ceramic")
local pag=require("pag")
local map=ceramic.buildMap("mapName.json")

local pathfindingArray=pag.generatePathfindingArrray(map, "baseLayer")

v1.0
--]]

local pag={}

pag.walkable=0
pag.blocked=1

--------------------------------------------------------------------------------
-- pag.testTile()
--[[
Takes a tile as an argument and returns whether the position is walkable or not.
In this function, you could put whatever you wanted, such as check for a tile
property "isBlocked" or something to that effect. The current function simply
checks for the existence of the tile. If the function returns true, that means
that the tile should be blocked. If it returns false, the tile is not a block
and the result will be walkable.
--]]
--------------------------------------------------------------------------------
pag.testTile=function(t)
	return t~=nil
end

--------------------------------------------------------------------------------
-- pag.generatePathfindingArray()
--[[
Generates a pathfinding array from a map. The second argument specifies which
layer to check in; this can be anything, as long as there exists a layer
map.layer[layerRef].
--]]
--------------------------------------------------------------------------------
function pag.generatePathfindingArray(map, layerRef)
	local array={}

	for y=1, map("mapHeight") do
		array[y]={}
		for x=1, map("mapWidth") do
			local result=pag.testTile(map.layer[layerRef].tile(x, y))
			if result==true then
				array[y][x]=pag.blocked
			elseif result==false then
				array[y][x]=pag.walkable
			else
				error("pag.testTile did not return a Boolean", 2)
			end
		end
	end

	return array
end

return pag