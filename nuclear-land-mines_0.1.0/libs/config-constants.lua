-- If already defined, return
if _constants and config_constants.nuclear_land_mines then
  return _constants
end

local config_constants = {}

config_constants.nuclear_land_mine = {}
config_constants.nuclear_land_mine.SECONDS_TO_ARM = 6

config_constants.nuclear_land_mines = true

local _constants = config_constants

return config_constants