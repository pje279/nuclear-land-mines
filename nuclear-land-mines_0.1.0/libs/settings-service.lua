-- If already defined, return
if _settings_service and _settings_service.nuclear_land_mines then
  return _settings_service
end

local Settings_Constants = require("constants.settings-constants")

local settings_service = {}

-- SECONDS_TO_ARM
function settings_service.get_seconds_to_arm()
  return get_startup_setting(Settings_Constants.startup.SECONDS_TO_ARM)
end

-- ALERT_WHEN_DAMAGED
function settings_service.get_alert_when_damaged()
  return get_startup_setting(Settings_Constants.startup.ALERT_WHEN_DAMAGED)
end

-- EXPLOSION_MODIFIER
function settings_service.get_explosion_modifier()
  return get_startup_setting(Settings_Constants.startup.EXPLOSION_MODIFIER)
end

-- DAMAGE_MODIFIER
function settings_service.get_damage_modifier()
  return get_startup_setting(Settings_Constants.startup.DAMAGE_MODIFIER)
end

-- SHOCKWAVE_MODIFIER
function settings_service.get_shockwave_modifier()
  return get_startup_setting(Settings_Constants.startup.SHOCKWAVE_MODIFIER)
end

-- RECIPE_RESULT_COUNT
function settings_service.get_recipe_result_count()
  return get_startup_setting(Settings_Constants.startup.RECIPE_RESULT_COUNT)
end

-- CRAFTING_TIME
function settings_service.get_crafting_time()
  return get_startup_setting(Settings_Constants.startup.CRAFTING_TIME)
end

function get_startup_setting(setting)
  local _setting = setting.default_value

  if (settings and settings.startup and settings.startup[setting.name]) then
    _setting = settings.startup[setting.name].value
  end

  return _setting
end

settings_service.nuclear_land_mines = true

local _settings_service = settings_service

return settings_service