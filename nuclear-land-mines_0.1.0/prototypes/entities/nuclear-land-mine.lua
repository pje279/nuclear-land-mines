local Hit_Effects = require("__base__.prototypes.entity.hit-effects")
local Sounds = require("__base__.prototypes.entity.sounds")

local dir_prefix = "__nuclear-land-mines__."

local Constants = require(dir_prefix.. "libs.constants.constants")
local Settings_Constants = require(dir_prefix..  "libs.constants.settings-constants")
local Settings_Service = require(dir_prefix.. "libs.settings-service")

local explosion_modifier = Settings_Service.get_explosion_modifier()
local damage_modifier = Settings_Service.get_damage_modifier()
local shockwave_modifier = Settings_Service.get_shockwave_modifier()

local death_explosion_modifier = explosion_modifier * 0.141592653 -- * 2
local death_damage_modifier = damage_modifier * 0.4

local land_mine_death_explosion_nuclear_probability = function()
  local probability = 1 * death_explosion_modifier * shockwave_modifier + 0.5
  if (probability > 1) then probability = 1 end
  log(serpent.block(probability))
  return probability
end

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
  max_health = 50,
  resistances =
  {
    {
      type = "fire",
      percent = 100
    },
    {
      type = "physical",
      percent = 95,
      decrease = 10
    },
    {
      type = "explosion",
      percent = 95,
      decrease = 10
    },
  },
  corpse = "land-mine-remnants",
  dying_explosion = "nuclear-land-mine-death-explosion",
  dying_explosion = "explosion",
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
        -- {
        --   type = "nested-result",
        --   affects_target = true,
        --   action =
        --   {
        --     type = "area",
        --     -- radius = 11 * shockwave_modifier + 11,
        --     radius = 7 * shockwave_modifier + 7,
        --     repeat_count = 1 * shockwave_modifier + 1,
        --     -- radius = 11 * explosion_modifier,
        --     force = "enemy",
        --     action_delivery =
        --     {
        --       type = "instant",
        --       target_effects =
        --       {
        --         {
        --           type = "damage",
        --           damage = { amount = 400 * damage_modifier, type = "physical"}
        --         },
        --         {
        --           type = "damage",
        --           damage = { amount = 400 * damage_modifier, type = "explosion"}
        --         },
        --         {
        --           type = "create-sticker",
        --           sticker = "stun-sticker"
        --         }
        --       }
        --     }
        --   }
        -- },
        -- {
        --   type = "damage",
        --   damage = { amount = 1000 * damage_modifier, type = "explosion"}
        -- },
        -- {
        --   action = {
        --     action_delivery = {
        --       projectile = "nuclear-land-mine-wave",
        --       starting_speed = 0.35,
        --       starting_speed_deviation = 0.075,
        --       type = "projectile"
        --     },
        --     -- radius = 35 * shockwave_modifier,
        --     radius = 21 * shockwave_modifier,
        --     -- repeat_count = 1000 * shockwave_modifier,
        --     repeat_count = 100 * shockwave_modifier,
        --     target_entities = false,
        --     trigger_from_target = true,
        --     type = "area"
        --   },
        --   type = "nested-result"
        -- },
        -- {
        --   action = {
        --     action_delivery = {
        --       target_effects = {
        --         {
        --           damage = {
        --             amount = 200 * damage_modifier,
        --             type = "physical"
        --           },
        --           type = "damage"
        --         },
        --         {
        --           damage = {
        --             amount = 200 * damage_modifier,
        --             type = "explosion"
        --           },
        --           type = "damage"
        --         }
        --       },
        --       type = "instant"
        --     },
        --     radius = 3 * explosion_modifier + 1,
        --     type = "area",
        --     show_in_tooltip = true
        --   },
        --   type = "nested-result"
        -- },
        -- {
        --   type = "nested-result",
        --   action = {
        --     action_delivery = {
        --       target_effects = {
        --         {
        --           explosion_at_trigger = "explosion",
        --           radius = 3 * shockwave_modifier + 1,
        --           type = "destroy-cliffs"
        --         },
        --       },
        --       type = "instant"
        --     },
        --     -- radius = 8 * explosion_modifier + 1,
        --     radius = 5 * explosion_modifier + 1,
        --     repeat_count = 1 * explosion_modifier + 1,
        --     type = "area",
        --     show_in_tooltip = true
        --   }
        -- },
        -- {
        --   entity_name = "nuclear-land-mine-explosion",
        --   type = "create-entity",
        -- },
        -- {
        --   damage = {
        --     amount = 400 * damage_modifier,
        --     type = "explosion"
        --   },
        --   type = "damage",
        --   show_in_tooltip = true
        -- },
        -- {
        --   action = {
        --     action_delivery = {
        --       projectile = "nuclear-land-mine-ground-zero-projectile",
        --       starting_speed = 0.47999999999999998,
        --       starting_speed_deviation = 0.075,
        --       type = "projectile"
        --     },
        --     -- radius = 6 * shockwave_modifier + 1,
        --     radius = 3 * shockwave_modifier + 1,
        --     -- repeat_count = 1000 * shockwave_modifier + 1,
        --     repeat_count = 100 * shockwave_modifier + 1,
        --     target_entities = false,
        --     trigger_from_target = true,
        --     type = "area",
        --     show_in_tooltip = true
        --   },
        --   type = "nested-result"
        -- },
        -- {
        --   action = {
        --     action_delivery = {
        --       projectile = "nuclear-land-mine-wave-spawns-cluster-nuke-explosion",
        --       starting_speed = 0.35,
        --       starting_speed_deviation = 0.075,
        --       type = "projectile"
        --     },
        --     -- radius = 26 * shockwave_modifier + 1,
        --     radius = 13 * shockwave_modifier + 1,
        --     -- repeat_count = 1000 * shockwave_modifier + 1,
        --     repeat_count = 100 * shockwave_modifier + 1,
        --     show_in_tooltip = true,
        --     target_entities = false,
        --     trigger_from_target = true,
        --     type = "area",
        --     show_in_tooltip = true
        --   },
        --   type = "nested-result"
        -- },
        -- {
        --   action = {
        --     action_delivery = {
        --       projectile = "nuclear-land-mine-wave-spawns-fire-smoke-explosion",
        --       starting_speed = 0.325,
        --       starting_speed_deviation = 0.075,
        --       type = "projectile"
        --     },
        --     -- radius = 4 * shockwave_modifier + 1,
        --     radius = 2 * shockwave_modifier + 1,
        --     -- repeat_count = 700 * shockwave_modifier + 1,
        --     repeat_count = 70 * shockwave_modifier + 1,
        --     show_in_tooltip = false,
        --     target_entities = false,
        --     trigger_from_target = true,
        --     type = "area",
        --     show_in_tooltip = true
        --   },
        --   type = "nested-result"
        -- },
        -- {
        --   action = {
        --     action_delivery = {
        --       projectile = "nuclear-land-mine-wave-spawns-nuke-shockwave-explosion",
        --       starting_speed = 0.325,
        --       starting_speed_deviation = 0.075,
        --       type = "projectile"
        --     },
        --     -- radius = 8 * shockwave_modifier + 1,
        --     radius = 3 * shockwave_modifier + 1,
        --     -- repeat_count = 1000 * shockwave_modifier + 1,
        --     repeat_count = 100 * shockwave_modifier + 1,
        --     show_in_tooltip = true,
        --     target_entities = false,
        --     trigger_from_target = true,
        --     type = "area",
        --     show_in_tooltip = true
        --   },
        --   type = "nested-result"
        -- },

        {
          action = {
            action_delivery = {
              target_effects = {
                {
                  type = "script",
                  effect_id = "land-mine-explosion-nuclear"
                }
              },
              type = "instant"
            },
            radius = 1, --32 * explosion_modifier + 1,
            repeat_count = 1, -- * explosion_modifier + 1,
            show_in_tooltip = true,
            target_entities = false,
            trigger_from_target = true,
            type = "area"
          },
          type = "nested-result"
        },
        {
          action = {
            action_delivery = {
              target_effects = {
                {
                  type = "script",
                  effect_id = "nuclear-land-mine-explosion-pollution"
                }
              },
              type = "instant"
            },
            -- radius = 64 * explosion_modifier + 1,
            radius = 48 * explosion_modifier + 1,
            -- repeat_count = 128 * explosion_modifier + 1,
            repeat_count = 96 * explosion_modifier + 1,
            repeat_count_deviation = 42 * explosion_modifier,
            show_in_tooltip = false,
            target_entities = false,
            trigger_from_target = true,
            type = "area"
          },
          type = "nested-result"
        }


      },
      target_effects =
      {
        {
          type = "nested-result",
          action = {
            action_delivery = {
              target_effects = {
                {
                  damage = {
                    amount = 400 * damage_modifier,
                    type = "physical"
                  },
                  type = "damage"
                },
                {
                  damage = {
                    amount = 400 * damage_modifier,
                    type = "explosion"
                  },
                  type = "damage"
                }
              },
              type = "instant"
            },
            radius = 4 * explosion_modifier + 1,
            type = "area"
          }
        },
        {
          initial_height = 0,
          -- max_radius = 3.5 * explosion_modifier + 1,
          max_radius = 2.5 * ((explosion_modifier + shockwave_modifier) / 2) + 1,
          offset_deviation = {
            {
              -4,
              -4
            },
            {
              4,
              4
            }
          },
          repeat_count = 240 * ((explosion_modifier + shockwave_modifier) / 2) + 1,
          smoke_name = "artillery-smoke",
          speed_from_center = 0.05,
          speed_from_center_deviation = 0.005,
          type = "create-trivial-smoke"
        },
        {
          entity_name = "big-artillery-explosion",
          -- entity_name = "land-mine-explosion",
          type = "create-entity"
        },
        {
          scale = 0.25 * ((explosion_modifier + shockwave_modifier) / 2),
          type = "show-explosion-on-chart"
        },
        {
          apply_projection = true,
          -- radius = 12
          radius = 5 * explosion_modifier,
          tile_collision_mask = {
            layers = {
              water_tile = true
            }
          },
          tile_name = "nuclear-ground",
          type = "set-tile"
        },
        -- {
        --   explosion_at_trigger = "explosion",
        --   radius = 9 * explosion_modifier + 1,
        --   type = "destroy-cliffs"
        -- },
        {
          type = "nested-result",
          action = {
            action_delivery = {
              target_effects = {
                {
                  explosion_at_trigger = "explosion",
                  radius = 3 * shockwave_modifier + 1,
                  type = "destroy-cliffs"
                },
              },
              type = "instant"
            },
            radius = 8 * explosion_modifier + 1,
            type = "area",
            show_in_tooltip = true
          }
        },
        {
          entity_name = "nuclear-land-mine-explosion",
          type = "create-entity"
        },
        {
          damage = {
            amount = 200 * damage_modifier,
            type = "explosion"
          },
          type = "damage"
        },
        {
          delay = 0,
          duration = 60,
          ease_in_duration = 5,
          ease_out_duration = 60,
          full_strength_max_distance = 200 * explosion_modifier,
          max_distance = 800 * explosion_modifier,
          strength = 6,
          type = "camera-effect"
        },
        {
          check_buildability = true,
          entity_name = "huge-scorchmark",
          offsets = {
            {
              0,
              -0.5
            }
          },
          type = "create-entity"
        },
        {
          repeat_count = 1,
          type = "invoke-tile-trigger"
        },
        {
          decoratives_with_trigger_only = false,
          include_decals = true,
          include_soft_decoratives = true,
          invoke_decorative_trigger = true,
          -- radius = 14,
          radius = 9 * shockwave_modifier,
          type = "destroy-decoratives"
        },
        {
          apply_projection = true,
          decorative = "nuclear-ground-patch",
          spawn_max = 40 * explosion_modifier,
          spawn_max_radius = 12.5 * explosion_modifier < 24 and 12.5 * explosion_modifier or 24,
          spawn_min = 30 * explosion_modifier,
          spawn_min_radius = 11.5 * explosion_modifier,
          spread_evenly = true,
          type = "create-decorative"
        },
        {
          action = {
            action_delivery = {
              projectile = "nuclear-land-mine-ground-zero-projectile",
              starting_speed = 0.47999999999999998,
              starting_speed_deviation = 0.075,
              type = "projectile"
            },
            -- radius = 7 * explosion_modifier + 1,
            radius = 5 * explosion_modifier + 1,
            -- repeat_count = 1000 * explosion_modifier + 1,
            repeat_count = 100 * explosion_modifier + 1,
            target_entities = false,
            trigger_from_target = true,
            type = "area"
          },
          type = "nested-result"
        },
        {
          action = {
            action_delivery = {
              projectile = "nuclear-land-mine-wave",
              starting_speed = 0.35,
              starting_speed_deviation = 0.075,
              type = "projectile"
            },
            -- radius = 35 * shockwave_modifier + 1,
            radius = 19 * shockwave_modifier + 1,
            repeat_count = 1000 * shockwave_modifier + 1,
            target_entities = false,
            trigger_from_target = true,
            type = "area"
          },
          type = "nested-result"
        },
        {
          action = {
            action_delivery = {
              projectile = "nuclear-land-mine-wave-spawns-cluster-nuke-explosion",
              starting_speed = 0.35,
              starting_speed_deviation = 0.075,
              type = "projectile"
            },
            -- radius = 26 * explosion_modifier + 1,
            radius = 19 * explosion_modifier + 1,
            repeat_count = 1000 * explosion_modifier + 1,
            show_in_tooltip = true,
            target_entities = false,
            trigger_from_target = true,
            type = "area"
          },
          type = "nested-result"
        },
        {
          action = {
            action_delivery = {
              projectile = "nuclear-land-mine-wave-spawns-fire-smoke-explosion",
              starting_speed = 0.325,
              starting_speed_deviation = 0.075,
              type = "projectile"
            },
            radius = 4 * explosion_modifier + 1,
            repeat_count = 700 * explosion_modifier + 1,
            show_in_tooltip = false,
            target_entities = false,
            trigger_from_target = true,
            type = "area"
          },
          type = "nested-result"
        },
        {
          action = {
            action_delivery = {
              projectile = "nuclear-land-mine-wave-spawns-nuke-shockwave-explosion",
              starting_speed = 0.325,
              starting_speed_deviation = 0.075,
              type = "projectile"
            },
            -- radius = 8 * shockwave_modifier + 1,
            radius = 5 * shockwave_modifier + 1,
            repeat_count = 1000 * shockwave_modifier + 1,
            show_in_tooltip = true,
            target_entities = false,
            trigger_from_target = true,
            type = "area"
          },
          type = "nested-result"
        },
        {
          action = {
            action_delivery = {
              projectile = "nuclear-land-mine-wave-spawns-nuclear-smoke",
              starting_speed = 0.325,
              starting_speed_deviation = 0.075,
              type = "projectile"
            },
            -- radius = 26 * shockwave_modifier + 1,
            radius = 19 * shockwave_modifier + 1,
            repeat_count = 300 * shockwave_modifier + 1,
            show_in_tooltip = false,
            target_entities = false,
            trigger_from_target = true,
            type = "area"
          },
          type = "nested-result"
        },
        {
          action = {
            action_delivery = {
              target_effects = {
                {
                  entity_name = "nuclear-smouldering-smoke-source",
                  tile_collision_mask = {
                    layers = {
                      water_tile = true
                    }
                  },
                  type = "create-entity"
                }
              },
              type = "instant"
            },
            radius = 8 * explosion_modifier + 1,
            repeat_count = 10 * explosion_modifier + 1,
            show_in_tooltip = false,
            target_entities = false,
            trigger_from_target = true,
            type = "area"
          },
          type = "nested-result"
        },
      }
    },
  },
}})