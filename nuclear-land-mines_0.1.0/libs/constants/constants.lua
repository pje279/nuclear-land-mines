-- If already defined, return
if _constants and _constants.nuclear_land_mines then
  return _constants
end

local constants = {}

constants.time = {}
constants.time.TICKS_PER_SECOND = 60
constants.time.SECONDS_PER_MINUTE = 60
constants.time.TICKS_PER_MINUTE = constants.time.TICKS_PER_SECOND * constants.time.SECONDS_PER_MINUTE

constants.nuclear_land_mines = true

local _constants = constants

return constants