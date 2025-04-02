local Log = require("libs.log.log")

script.on_event(defines.events.on_script_trigger_effect, function (event)
  Log.info(event)
  if (  event
    and event.effect_id
    and
      (not event.effect_id == "nuclear-land-mine-explosion-pollution"
    or not event.effect_id == "nuclear-land-mine-death-pollution"
    or not event.effect_id == "land-mine-explosion-nuclear")) then return end
  if (not game or not event.surface_index or game.surfaces[event.surface_index] == nil) then return end

  local position = event.source_position or event.target_position
  local surface = game.surfaces[event.surface_index]

  if (position and event.effect_id == "nuclear-land-mine-explosion-pollution") then
    Log.debug("detonation; polluting")
    surface.pollute(position, 10, "nuclear-land-mine")
  elseif (position and event.effect_id == "nuclear-land-mine-death-pollution") then
    Log.debug("death; polluting")
    surface.pollute(position, 2.5, "nuclear-land-mine")
  end

  if (position and event.effect_id == "land-mine-explosion-nuclear") then
    surface.create_entity({
      name = "land-mine-explosion-nuclear",
      position = position,
      target = position
    })
  end

end)