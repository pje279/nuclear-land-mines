local Hit_Effects = require("__base__.prototypes.entity.hit-effects")
local Sounds = require("__base__.prototypes.entity.sounds")

data:extend({
  {
    type = "land-mine",
    name = "nuclear-land-mine",
    icon = "__base__/graphics/icons/land-mine.png",
    flags =
    {
      "placeable-player",
      "placeable-enemy",
      "player-creation",
      "placeable-off-grid",
      "not-on-map"
    },
    minable = {mining_time = 0.5, result = "nuclear-land-mine"},
    fast_replaceable_group = "nuclear-land-mine",
    mined_sound = Sounds.deconstruct_small(1.0),
    max_health = 15,
    corpse = "land-mine-remnants",
    dying_explosion = "land-mine-explosion",
    dying_trigger_effect =
    {
      {
        type = "create-entity",
        entity_name = "land-mine-explosion-nuclear",
        position = { 0, 0 },
        target = { 0, 0 }
      }
    },
    collision_box = {{-0.4,-0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = Hit_Effects.entity(),
    open_sound = Sounds.machine_open,
    close_sound = Sounds.machine_close,
    picture_safe =
    {
      filename = "__base__/graphics/entity/land-mine/land-mine.png",
      priority = "medium",
      width = 64,
      height = 64,
      scale = 0.5
    },
    picture_set =
    {
      filename = "__base__/graphics/entity/land-mine/land-mine-set.png",
      priority = "medium",
      width = 64,
      height = 64,
      scale = 0.5
    },
    picture_set_enemy =
    {
      filename = "__base__/graphics/entity/land-mine/land-mine-set-enemy.png",
      priority = "medium",
      width = 32,
      height = 32
    },
    trigger_radius = 2.5,
    ammo_category = "landmine",
  }
})