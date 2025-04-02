local Smoke_Animations = require("__base__.prototypes.entity.smoke-animations")
local Sounds = require("__base__.prototypes.entity.sounds")

local dir_prefix = "__nuclear-land-mines__."

local Settings_Service = require(dir_prefix.. "libs.settings-service")

local explosion_modifier = Settings_Service.get_explosion_modifier()
local damage_modifier = Settings_Service.get_damage_modifier()
local shockwave_modifier = Settings_Service.get_shockwave_modifier()

local death_explosion_modifier = explosion_modifier * 0.5 --0.141592653 -- * 2
local death_damage_modifier = damage_modifier * 0.666

local max_nuke_shockwave_movement_distance_deviation = 2

-- local max_nuke_shockwave_movement_distance = 19 + max_nuke_shockwave_movement_distance_deviation / 6
local max_nuke_shockwave_movement_distance = 13 + max_nuke_shockwave_movement_distance_deviation / 4

local nuclear_land_mine_shockwave = function()
  return
  {
    {
      filename = "__base__/graphics/entity/smoke/nuke-shockwave-1.png",
      draw_as_glow = true,
      priority = "high",
      flags = {"smoke"},
      line_length = 8,
      width = 132,
      height = 136,
      frame_count = 32,
      animation_speed = 0.5,
      shift = util.by_pixel(-0.5,0),
      scale = 1.5 * ((explosion_modifier + shockwave_modifier)/2),
      usage = "explosion"
    },
    {
      filename = "__base__/graphics/entity/smoke/nuke-shockwave-2.png",
      draw_as_glow = true,
      priority = "high",
      flags = {"smoke"},
      line_length = 8,
      width = 110,
      height = 128,
      frame_count = 32,
      animation_speed = 0.5,
      shift = util.by_pixel(0,3),
      scale = 1.5 * ((explosion_modifier + shockwave_modifier)/2),
      usage = "explosion"
    }
  }
end

local land_mine_death_explosion_nuclear_probability = function()
  local probability = 1 * death_explosion_modifier * shockwave_modifier + 0.5
  if (probability > 1) then probability = 1 end
  log(serpent.block(probability))
  return probability
end

-------------------------------------------------------
-- land-mine-explosion-nuclear
-------------------------------------------------------
data:extend({
  {
    name = "land-mine-explosion-nuclear",
    action = {
      action_delivery = {
        target_effects = {
          {
            action = {
              action_delivery = {
                target_effects = {
                  {
                    damage = {
                      amount = 600 * damage_modifier,
                      type = "physical"
                    },
                    type = "damage"
                  },
                  {
                    damage = {
                      amount = 600 * damage_modifier,
                      type = "explosion"
                    },
                    type = "damage"
                  }
                },
                type = "instant"
              },
              radius = 2 * explosion_modifier + 1,
              type = "area",
              show_in_tooltip = true
            },
            type = "nested-result"
          },
          {
            type = "nested-result",
            action = {
              action_delivery = {
                target_effects = {
                  {
                    explosion_at_trigger = "explosion",
                    radius = 2 * ((explosion_modifier + shockwave_modifier) / 2) + 1,
                    type = "destroy-cliffs"
                  },
                },
                type = "instant"
              },
              radius = 8 * ((explosion_modifier + shockwave_modifier) / 2) + 9,
              repeat_count = 100 * shockwave_modifier + 1,
              type = "area",
              show_in_tooltip = true
            }
          },
          {
            entity_name = "nuclear-land-mine-explosion",
            type = "create-entity",
          },
          {
            damage = {
              amount = 200 * damage_modifier,
              type = "explosion"
            },
            type = "damage",
            show_in_tooltip = true
          },
          { -- Damage dealer
            action = {
              action_delivery = {
                projectile = "nuclear-land-mine-ground-zero-projectile",
                starting_speed = 0.47999999999999998,
                starting_speed_deviation = 0.075,
                type = "projectile"
              },
              -- radius = 6 * shockwave_modifier + 1,
              radius = 4 * shockwave_modifier + 1,
              repeat_count = 1000 * shockwave_modifier + 1,
              target_entities = false,
              trigger_from_target = true,
              type = "area",
              show_in_tooltip = true
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
              -- radius = 26 * shockwave_modifier + 1,
              radius = 17 * shockwave_modifier + 1,
              repeat_count = 1000 * shockwave_modifier + 1,
              show_in_tooltip = true,
              target_entities = false,
              trigger_from_target = true,
              type = "area",
              show_in_tooltip = true
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
              -- radius = 4 * shockwave_modifier + 1,
              radius = 3 * shockwave_modifier + 1,
              repeat_count = 700 * shockwave_modifier + 1,
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              type = "area",
              show_in_tooltip = true
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
              radius = 7 * shockwave_modifier + 1,
              repeat_count = 1000 * shockwave_modifier + 1,
              show_in_tooltip = true,
              target_entities = false,
              trigger_from_target = true,
              type = "area",
              show_in_tooltip = true
            },
            type = "nested-result"
          },
          { -- Damage dealer
            action = {
              action_delivery = {
                projectile = "nuclear-land-mine-wave",
                starting_speed = 0.35,
                starting_speed_deviation = 0.075,
                type = "projectile"
              },
              -- radius = 35 * shockwave_modifier + 1,
              radius = 17 * shockwave_modifier + 1,
              repeat_count = 1000 * shockwave_modifier + 1,
              target_entities = false,
              trigger_from_target = true,
              type = "area",
              show_in_tooltip = true
            },
            type = "nested-result"
          },
          { -- Damage dealer
            action = {
              action_delivery = {
                projectile = "nuclear-land-mine-wave-aftershock",
                starting_speed = 0.35,
                starting_speed_deviation = 0.075,
                type = "projectile"
              },
              -- radius = 35 * shockwave_modifier + 1,
              radius = 19 * ((explosion_modifier + shockwave_modifier) / 2) + 1,
              repeat_count = 1000 * shockwave_modifier + 1,
              -- repeat_count = 100 * shockwave_modifier + 1,
              target_entities = false,
              trigger_from_target = true,
              type = "area",
              show_in_tooltip = true
            },
            type = "nested-result"
          },
        },
        type = "instant"
      },
      type = "direct"
    },
    chart_picture = {
      filename = "__base__/graphics/entity/artillery-projectile/artillery-shoot-map-visualization.png",
      flags = {
        "icon"
      },
      height = 64,
      priority = "high",
      scale = 0.25,
      width = 64
    },
    final_action = {
      action_delivery = {
        target_effects = {
          {
            check_buildability = true,
            entity_name = "medium-scorchmark-tintable",
            type = "create-entity"
          },
          {
            repeat_count = 1,
            type = "invoke-tile-trigger"
          },
          {
            decoratives_with_trigger_only = false,
            from_render_layer = "decorative",
            include_decals = false,
            include_soft_decoratives = true,
            invoke_decorative_trigger = true,
            -- radius = 3.5 * explosion_modifier,
            radius = 2.5 * ((explosion_modifier + shockwave_modifier) / 2) ,
            to_render_layer = "object",
            type = "destroy-decoratives"
          }
        },
        type = "instant"
      },
      type = "direct"
    },
    flags = {
      "not-on-map"
    },
    height_from_ground = 4.375,
    hidden = true,
    map_color = {
      1,
      1,
      0
    },
    reveal_map = true,
    shadow = {
      filename = "__base__/graphics/entity/artillery-projectile/shell-shadow.png",
      height = 64,
      scale = 0.5,
      width = 64
    },
    type = "artillery-projectile"
  },
})

-------------------------------------------------------
-- land-mine-death-explosion-nuclear
-------------------------------------------------------
data:extend({
  {
    name = "land-mine-death-explosion-nuclear",
    action = {
      action_delivery = {
        target_effects = {
          {
            type = "nested-result",
            affects_target = true,
            action =
            {
              type = "area",
              -- radius = 11 * shockwave_modifier + 11,
              radius = 7 * shockwave_modifier + 7,
              repeat_count = 1 * shockwave_modifier + 1,
              probability = 0.8 * ((explosion_modifier + shockwave_modifier) / 22) + 0.1,
              force = "enemy",
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = { amount = 50 * death_damage_modifier * damage_modifier, type = "physical"}
                  },
                  {
                    type = "damage",
                    damage = { amount = 50 * death_damage_modifier * damage_modifier, type = "explosion"}
                  },
                  {
                    type = "create-sticker",
                    sticker = "stun-sticker"
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion"
                  },
                  {
                    type = "invoke-tile-trigger",
                    repeat_count = 1
                  }
                }
              }
            }
          },
          {
            initial_height = 0,
            max_radius = 3.5 * ((death_explosion_modifier + shockwave_modifier) / 2) + 1,
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
            repeat_count = 240, -- * death_explosion_modifier,
            smoke_name = "artillery-smoke",
            speed_from_center = 0.05,
            speed_from_center_deviation = 0.005,
            type = "create-trivial-smoke"
          },
          {
            entity_name = "big-artillery-explosion",
            type = "create-entity"
          },
        },
        type = "instant"
      },
      type = "direct"
    },
    chart_picture = {
      filename = "__base__/graphics/entity/artillery-projectile/artillery-shoot-map-visualization.png",
      flags = {
        "icon"
      },
      height = 64,
      priority = "high",
      scale = 0.25,
      width = 64
    },
    final_action = {
      action_delivery = {
        target_effects = {
          {
            check_buildability = true,
            entity_name = "medium-scorchmark-tintable",
            type = "create-entity"
          },
          {
            repeat_count = 1,
            type = "invoke-tile-trigger"
          },
          {
            decoratives_with_trigger_only = false,
            from_render_layer = "decorative",
            include_decals = false,
            include_soft_decoratives = true,
            invoke_decorative_trigger = true,
            radius = 3.5 * death_explosion_modifier,
            to_render_layer = "object",
            type = "destroy-decoratives"
          },
          {
            type = "script",
            effect_id = "nuclear-land-mine-death-pollution"
          }
        },
        type = "instant"
      },
      type = "direct"
    },
    flags = {
      "not-on-map"
    },
    height_from_ground = 4.375,
    hidden = true,
    map_color = {
      1,
      1,
      0
    },
    reveal_map = true,
    shadow = {
      filename = "__base__/graphics/entity/artillery-projectile/shell-shadow.png",
      height = 64,
      scale = 0.5,
      width = 64
    },
    type = "artillery-projectile"
  }
})