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