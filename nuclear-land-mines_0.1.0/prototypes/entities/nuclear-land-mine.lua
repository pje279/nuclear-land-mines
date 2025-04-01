local Hit_Effects = require("__base__.prototypes.entity.hit-effects")
local Sounds = require("__base__.prototypes.entity.sounds")

local dir_prefix = "__nuclear-land-mines__."

local Constants = require(dir_prefix.. "libs.constants.constants")
local Settings_Constants = require(dir_prefix..  "libs.constants.settings-constants")
local Settings_Service = require(dir_prefix.. "libs.settings-service")

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
  timeout = Constants.time.TICKS_PER_SECOND * (Settings_Service.get_seconds_to_arm() or Settings_Constants.seconds_to_arm()),
  alert_when_damaged = Settings_Service.get_alert_when_damaged(),
  minable = {mining_time = 0.5, result = "nuclear-land-mine"},
  fast_replaceable_group = "nuclear-land-mine",
  mined_sound = Sounds.deconstruct_small(1.0),
  max_health = 15,
  corpse = "land-mine-remnants",
  dying_explosion = "land-mine-explosion",
  collision_box = {{-0.4,-0.4}, {0.4, 0.4}},
  selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
  damaged_trigger_effect = Hit_Effects.entity(),
  open_sound = Sounds.machine_open,
  close_sound = Sounds.machine_close,
  dying_trigger_effect =
  {
    type = "create-entity",
    entity_name = "land-mine-death-explosion-nuclear",
    position = { 0, 0 },
    target = { 0, 0 }
  },
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
  action =
  {
    type = "direct",
    action_delivery =
    {
      type = "instant",
      source_effects =
      {
        {
          type = "nested-result",
          affects_target = true,
          action =
          {
            type = "area",
            radius = 11,
            force = "enemy",
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                {
                  type = "damage",
                  damage = { amount = 1250, type = "explosion"}
                },
                {
                  type = "create-sticker",
                  sticker = "stun-sticker"
                }
              }
            }
          }
        },
        {
          type = "create-entity",
          entity_name = "land-mine-explosion-nuclear",
          position = { 0, 0 },
          target = { 0, 0 }
        },
        {
          type = "damage",
          damage = { amount = 2500, type = "explosion"}
        }
      }
    },
    type = "direct"
  },
}})