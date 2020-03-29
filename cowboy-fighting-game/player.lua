Player = {}

function Player:new(playerName)
    local newObj = {name = playerName, hp = 100}
    self.__index = self
    return setmetatable(newObj, self)
end