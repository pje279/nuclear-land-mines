-- If already defined, return
if _settings_constants and _settings_constants.nuclear_land_mines then
  return _settings_constants
end

local settings_constants = {}

settings_constants.startup = {}

settings_constants.startup.SECONDS_TO_ARM = {
  type = "double-setting",
  name = "nuclear-land-mines-seconds-to-arm",
  setting_type = "startup",
  order = "a",
  default_value = 6,
  minimum_value = 0,
}

settings_constants.startup.ALERT_WHEN_DAMAGED = {
  type = "bool-setting",
  name = "nuclear-land-mines-alert-when-damaged",
  setting_type = "startup",
  order = "a",
  default_value = true,
}

settings_constants.startup.EXPLOSION_MODIFIER = {
  type = "double-setting",
  name = "nuclear-land-mines-explosion-modifier",
  setting_type = "startup",
  order = "a",
  default_value = 0.4,
  maximum_value = 11,
  minimum_value = 0
}

settings_constants.nuclear_land_mines = true

local _settings_constants = settings_constants

return settings_constants