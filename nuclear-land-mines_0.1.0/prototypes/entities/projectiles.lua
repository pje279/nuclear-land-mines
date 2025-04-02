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

-------------------------------------------------------
-- nuclear-land-mine-wave-spawns-fire-smoke-explosion
-------------------------------------------------------
data:extend({
  {
    type = "projectile",
    name = "nuclear-land-mine-wave-spawns-fire-smoke-explosion",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0,
    speed_modifier = { 1, 0.707 },
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-explosion",
              entity_name = "atomic-fire-smoke",
              max_movement_distance = max_nuke_shockwave_movement_distance * shockwave_modifier,
              max_movement_distance_deviation = max_nuke_shockwave_movement_distance_deviation,
              inherit_movement_distance_from_projectile = true,
              cycle_while_moving = true
            }
          }
        }
      }
    },
    animation = nil,
    shadow = nil
  },
})

-------------------------------------------------------
-- nuclear-land-mine-ground-zero-projectile
-------------------------------------------------------
data:extend({
  {
    type = "projectile",
    name = "nuclear-land-mine-ground-zero-projectile",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0,
    speed_modifier = { 1.0, 0.707 },
    action =
    {
      {
        type = "area",
        radius = 3 * shockwave_modifier + 1,
        ignore_collision_condition = true,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "damage",
            vaporize = true,
            lower_distance_threshold = 0,
            -- upper_distance_threshold = 35 * shockwave_modifier,
            upper_distance_threshold = 19 * shockwave_modifier,
            lower_damage_modifier = 10 * damage_modifier,
            upper_damage_modifier = 0.1 * damage_modifier,
            damage =
            {
              amount = 100 * damage_modifier,
              type = "explosion"
            }
          }
        }
      }
    },
    animation = nil,
    shadow = nil
  }
})

-------------------------------------------------------
-- nuclear-land-mine-death-ground-zero-projectile
-------------------------------------------------------
data:extend({
  {
    type = "projectile",
    name = "nuclear-land-mine-death-ground-zero-projectile",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0,
    speed_modifier = { 1.0, 0.707 },
    action =
    {
      {
        type = "area",
        radius = 3 * death_explosion_modifier,
        ignore_collision_condition = true,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "damage",
            vaporize = true,
            lower_distance_threshold = 0,
            -- upper_distance_threshold = 35 * death_explosion_modifier,
            upper_distance_threshold = 21 * death_explosion_modifier,
            lower_damage_modifier = 10 * death_damage_modifier,
            upper_damage_modifier = 0.1 * death_damage_modifier,
            damage =
            {
              amount = 50 * death_damage_modifier,
              type = "explosion"
            }
          }
        }
      }
    },
    animation = nil,
    shadow = nil
  }
})

-------------------------------------------------------
-- nuclear-land-mine-wave-spawns-nuclear-smoke
-------------------------------------------------------
data:extend({
  {
    type = "projectile",
    name = "nuclear-land-mine-wave-spawns-nuclear-smoke",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0,
    speed_modifier = { 1.000, 0.707 },
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              repeat_count = 9 * shockwave_modifier + 1,
              type = "create-trivial-smoke",
              smoke_name = "nuclear-smoke",
              offset_deviation = {{-2, -2}, {2, 2}},
              starting_frame = 10,
              starting_frame_deviation = 20,
              speed_from_center = 0.035
            }
          }
        }
      }
    },
    animation = nil,
    shadow = nil
  },
})

-------------------------------------------------------
-- nuclear-land-mine-wave-spawns-cluster-nuke-explosion
-------------------------------------------------------
data:extend({
  {
    type = "projectile",
    name = "nuclear-land-mine-wave-spawns-cluster-nuke-explosion",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0.001,
    speed_modifier = { 1.0, 0.707 },
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "nuclear-land-mine-cluster-nuke-explosion",
              -- following properties are recognized only be "create-explosion" trigger
              --max_movement_distance = max_nuke_shockwave_movement_distance,
              --max_movement_distance_deviation = max_nuke_shockwave_movement_distance_deviation,
              --inherit_movement_distance_from_projectile = true
            }
          }
        }
      }
    },
    animation = nil,
    shadow = nil
  }
})

-------------------------------------------------------
-- nuclear-land-mine-wave
-------------------------------------------------------
data:extend({
  {
    type = "projectile",
    name = "nuclear-land-mine-wave",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0,
    speed_modifier = { 1.0, 0.707 },
    action =
    {
      {
        type = "area",
        radius = 2 * shockwave_modifier + 1,
        ignore_collision_condition = true,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "damage",
            vaporize = false,
            lower_distance_threshold = 0,
            -- upper_distance_threshold = 34 * shockwave_modifier + 1,
            upper_distance_threshold = 21 * shockwave_modifier + 1,
            lower_damage_modifier = 0.1 * damage_modifier,
            upper_damage_modifier = 1 * damage_modifier,
            damage =
            {
              amount = 100 * damage_modifier,
              type = "explosion"
            }
          }
        }
      }
    },
    animation = nil,
    shadow = nil
  }
})

-------------------------------------------------------
-- nuclear-land-mine-wave-aftershock
-------------------------------------------------------
data:extend({
  {
    type = "projectile",
    name = "nuclear-land-mine-wave-aftershock",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0,
    speed_modifier = { 1.0, 0.707 },
    action =
    {
      {
        type = "area",
        radius = 12 * shockwave_modifier + 1,
        probability = 0.9,
        repeat_count = 4 * shockwave_modifier,
        ignore_collision_condition = true,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "damage",
            vaporize = false,
            lower_distance_threshold = 0,
            upper_distance_threshold = 42 * shockwave_modifier + 1,
            lower_damage_modifier = 0.1 * damage_modifier,
            upper_damage_modifier = 1  * damage_modifier,
            damage =
            {
              amount = 0.4 * damage_modifier,
              type = "explosion"
            }
          }
        }
      }
    },
    animation = nil,
    shadow = nil
  }
})

-------------------------------------------------------
-- nuclear-land-mine-death-wave
-------------------------------------------------------
data:extend({
  {
    type = "projectile",
    name = "nuclear-land-mine-death-wave",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0,
    speed_modifier = { 1.0, 0.707 },
    action =
    {
      {
        type = "area",
        radius = 2 * ((death_explosion_modifier  + shockwave_modifier) / 2) + 1,
        ignore_collision_condition = true,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "damage",
            vaporize = false,
            lower_distance_threshold = 0,
            -- upper_distance_threshold = 35 * death_explosion_modifier * shockwave_modifier,
            upper_distance_threshold = 14 * ((death_explosion_modifier + shockwave_modifier) / 2),
            lower_damage_modifier = 0.1 * death_damage_modifier,
            upper_damage_modifier = 1 * death_damage_modifier,
            damage =
            {
              amount = 50 * death_damage_modifier * damage_modifier,
              type = "explosion"
            }
          }
        }
      }
    },
    animation = nil,
    shadow = nil
  }
})

-------------------------------------------------------
-- nuclear-land-mine-wave-spawns-nuke-shockwave-explosion
-------------------------------------------------------
data:extend({
  {
    type = "projectile",
    name = "nuclear-land-mine-wave-spawns-nuke-shockwave-explosion",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0,
    speed_modifier = { 1, 0.707 },
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-explosion",
              entity_name = "nuclear-land-mine-nuke-shockwave",
              max_movement_distance = max_nuke_shockwave_movement_distance * shockwave_modifier,
              max_movement_distance_deviation = max_nuke_shockwave_movement_distance_deviation,
              inherit_movement_distance_from_projectile = true,
              cycle_while_moving = true
            }
          }
        }
      }
    },
    animation = nil,
    shadow = nil
  }
})

-------------------------------------------------------
-- nuclear-land-mine-death-explosion
-------------------------------------------------------
data:extend({
  {
    type = "projectile",
    name = "nuclear-land-mine-death-explosion",
    flags = {"not-on-map"},
    hidden = true,
    acceleration = 0,
    speed_modifier = { 1, 0.707 },
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-explosion",
              entity_name = "atomic-fire-smoke",
              max_movement_distance = max_nuke_shockwave_movement_distance * shockwave_modifier,
              max_movement_distance_deviation = max_nuke_shockwave_movement_distance_deviation,
              inherit_movement_distance_from_projectile = true,
              cycle_while_moving = true
            },
            {
              type = "nested-result",
              affects_target = true,
              action =
              {
                type = "area",
                -- radius = 11 * shockwave_modifier + 11,
                radius = 2 * shockwave_modifier + 7,
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
          }
        }
      }
    },
    animation = nil,
    shadow = nil
  },
})