local dir_prefix = "__nuclear-land-mines__."

local Settings_Service = require(dir_prefix.. "libs.settings-service")
local Smoke_Animations = require("__base__.prototypes.entity.smoke-animations")
local Sounds = require("__base__.prototypes.entity.sounds")

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

-------------------------------------------------------
-- nuclear-land-mine-explosion
-------------------------------------------------------
data:extend({
  {
    type = "explosion",
    name = "nuclear-land-mine-explosion",
    flags = {"not-on-map"},
    hidden = true,
    icons =
    {
      {icon = "__base__/graphics/icons/explosion.png"},
      {icon = "__base__/graphics/icons/atomic-bomb.png"}
    },
    order = "a-d-a",
    subgroup = "explosions",
    height = 0,
    animations = nuclear_land_mine_shockwave(),
    sound = Sounds.large_explosion(1.0),
  }
})

-------------------------------------------------------
-- nuclear-land-mine-cluster-nuke-explosion
-------------------------------------------------------
data:extend({
  {
    type = "explosion",
    name = "nuclear-land-mine-cluster-nuke-explosion",
    icon = "__base__/graphics/icons/atomic-bomb-light.png",
    flags = {"not-on-map"},
    hidden = true,
    subgroup = "explosions",
    order = "a-d-b",
    animations = Smoke_Animations.trivial_smoke_animation(
    {
      tint = {r = 0.627, g = 0.478, b = 0.345, a = 0.500},
      scale = 2.5, -- * explosion_modifier,
    }),
    scale_increment_per_tick = 0.002,
    fade_out_duration = 30,
    scale_out_duration = 20,
    scale_in_duration = 10,
    scale_initial = 0.1,
    correct_rotation = true,
    scale_animation_speed = true,
  },
})


-------------------------------------------------------
-- nuclear-land-mine-nuke-shockwave
-------------------------------------------------------
data:extend({
  {
    type = "explosion",
    name = "nuclear-land-mine-nuke-shockwave",
    icon = "__base__/graphics/icons/destroyer.png",
    flags = {"not-on-map"},
    hidden = true,
    subgroup = "explosions",
    height = 1.4,
    rotate = true,
    correct_rotation = true,
    fade_out_duration = 30,
    scale_out_duration = 40,
    scale_in_duration = 10,
    scale_initial = 0.1,
    scale = 1, -- * explosion_modifier,
    scale_deviation = 0.2,
    scale_end = 0.5,
    scale_increment_per_tick = 0.005,
    scale_animation_speed = true,
  
    animations = nuclear_land_mine_shockwave(),
  },
})
