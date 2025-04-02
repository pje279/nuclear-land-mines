local dir_prefix = "__nuclear-land-mines__."

local Settings_Service = require(dir_prefix.. "libs.settings-service")

local explosion_modifier = Settings_Service.get_explosion_modifier()
local damage_modifier = Settings_Service.get_damage_modifier()

local death_explosion_modifier = explosion_modifier * 0.01
local death_damage_modifier = damage_modifier * 0.4

local max_nuke_shockwave_movement_distance_deviation = 2

local max_nuke_shockwave_movement_distance = 19 + max_nuke_shockwave_movement_distance_deviation / 6

data:extend({
  {
    name = "land-mine-explosion-nuclear-backup",
    action = {
      action_delivery = {
        target_effects = {
          {
            action = {
              action_delivery = {
                target_effects = {
                  {
                    damage = {
                      amount = 1000 * damage_modifier,
                      type = "physical"
                    },
                    type = "damage"
                  },
                  {
                    damage = {
                      amount = 1000 * damage_modifier,
                      type = "explosion"
                    },
                    type = "damage"
                  }
                },
                type = "instant"
              },
              radius = 4 * explosion_modifier + 1,
              type = "area",
              show_in_tooltip = true
            },
            type = "nested-result"
          },
          {
            initial_height = 0,
            max_radius = 3.5 * explosion_modifier + 1,
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
            repeat_count = 240 * explosion_modifier,
            smoke_name = "artillery-smoke",
            speed_from_center = 0.05,
            speed_from_center_deviation = 0.005,
            type = "create-trivial-smoke"
          },
          {
            entity_name = "big-artillery-explosion",
            type = "create-entity"
          },
          {
            scale = 0.25 * explosion_modifier,
            type = "show-explosion-on-chart"
          },
          {
            apply_projection = true,
            radius = 12 * explosion_modifier + 1,
            tile_collision_mask = {
              layers = {
                water_tile = true
              }
            },
            tile_name = "nuclear-ground",
            type = "set-tile"
          },
          {
            explosion_at_trigger = "explosion",
            radius = 9 * explosion_modifier + 1,
            type = "destroy-cliffs"
          },
          {
            -- entity_name = "nuke-explosion",
            entity_name = "nuclear-land-mine-explosion",
            type = "create-entity",
            show_in_tooltip = true
          },
          {
            delay = 0,
            duration = 60,
            ease_in_duration = 5,
            ease_out_duration = 60,
            full_strength_max_distance = 200,
            max_distance = 800,
            strength = 6,
            type = "camera-effect"
          },
          {
            max_distance = 1000,
            play_on_target_position = false,
            sound = {
              aggregation = {
                max_count = 1,
                remove = true
              },
              audible_distance_modifier = 3,
              category = "explosion",
              game_controller_vibration_data = {
                duration = 800,
                low_frequency_vibration_intensity = 1,
                play_for = "everything"
              },
              switch_vibration_data = {
                filename = "__base__/sound/fight/nuclear-explosion.bnvib",
                play_for = "everything"
              },
              variations = {
                {
                  filename = "__base__/sound/fight/nuclear-explosion-1.ogg",
                  volume = 0.9
                },
                {
                  filename = "__base__/sound/fight/nuclear-explosion-2.ogg",
                  volume = 0.9
                },
                {
                  filename = "__base__/sound/fight/nuclear-explosion-3.ogg",
                  volume = 0.9
                }
              }
            },
            type = "play-sound"
          },
          {
            max_distance = 1000 * explosion_modifier,
            play_on_target_position = false,
            sound = {
              aggregation = {
                max_count = 1,
                remove = true
              },
              audible_distance_modifier = 3 * explosion_modifier,
              category = "explosion",
              filename = "__base__/sound/fight/nuclear-explosion-aftershock.ogg",
              volume = 0.4
            },
            type = "play-sound"
          },
          {
            damage = {
              amount = 4000 * damage_modifier,
              type = "explosion"
            },
            type = "damage",
            show_in_tooltip = true
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
            radius = 9 * explosion_modifier,
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
              radius = 7 * explosion_modifier + 1,
              repeat_count = 1000 * explosion_modifier + 1,
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
                projectile = "nuclear-land-mine-wave",
                starting_speed = 0.35,
                starting_speed_deviation = 0.075,
                type = "projectile"
              },
              radius = 35 * explosion_modifier + 1,
              repeat_count = 1000 * explosion_modifier + 1,
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
              radius = 26 * explosion_modifier + 1,
              repeat_count = 1000 * explosion_modifier + 1,
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
              radius = 4 * explosion_modifier + 1,
              repeat_count = 700 * explosion_modifier + 1,
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
                projectile = "atomic-bomb-wave-spawns-nuke-shockwave-explosion",
                starting_speed = 0.325,
                starting_speed_deviation = 0.075,
                type = "projectile"
              },
              radius = 8 * explosion_modifier + 1,
              repeat_count = 1000 * explosion_modifier + 1,
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
                projectile = "atomic-bomb-wave-spawns-nuclear-smoke",
                starting_speed = 0.325,
                starting_speed_deviation = 0.075,
                type = "projectile"
              },
              radius = 26 * explosion_modifier + 1,
              repeat_count = 300 * explosion_modifier + 1,
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
          -- {
          --   action = {
          --     action_delivery = {
          --       target_effects = {
          --         {
          --           entity_name = "fire-flame",
          --           type = "create-entity"
          --         }
          --       },
          --       type = "instant"
          --     },
          --     radius = 26 * explosion_modifier,
          --     repeat_count = 196 * explosion_modifier,
          --     -- repeat_count_deviation = 42 * explosion_modifier,
          --     show_in_tooltip = false,
          --     target_entities = false,
          --     trigger_from_target = true,
          --     type = "area"
          --   },
          --   type = "nested-result"
          -- },
        },
        type = "instant"
      },
      type = "direct"
      -- type = "damage"
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
            radius = 3.5 * explosion_modifier,
            to_render_layer = "object",
            type = "destroy-decoratives"
          },
          -- {
          --   type = "script",
          --   effect_id = "nuclear-land-mine-explosion-pollution"
          -- },
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
              radius = 32 * explosion_modifier + 1,
              repeat_count = 100 * explosion_modifier + 1,
              -- repeat_count_deviation = 42 * explosion_modifier,
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              type = "area"
            },
            type = "nested-result"
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












data:extend({
  {
    name = "land-mine-death-explosion-nuclear-backup",
    action = {
      action_delivery = {
        target_effects = {
          {
            action = {
              action_delivery = {
                target_effects = {
                  {
                    damage = {
                      amount = 1000 * death_damage_modifier,
                      type = "physical"
                    },
                    type = "damage"
                  },
                  {
                    damage = {
                      amount = 1000 * death_damage_modifier,
                      type = "explosion"
                    },
                    type = "damage"
                  }
                },
                type = "instant"
              },
              radius = 4 * death_explosion_modifier,
              type = "area"
            },
            type = "nested-result"
          },
          {
            initial_height = 0,
            max_radius = 3.5 * death_explosion_modifier,
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
          {
            scale = 0.25 * death_explosion_modifier,
            type = "show-explosion-on-chart"
          },
          {
            apply_projection = true,
            radius = 12 * death_explosion_modifier,
            tile_collision_mask = {
              layers = {
                water_tile = true
              }
            },
            tile_name = "nuclear-ground",
            type = "set-tile"
          },
          {
            explosion_at_trigger = "explosion",
            radius = 9 * death_explosion_modifier,
            type = "destroy-cliffs"
          },
          {
            entity_name = "land-mine-explosion",
            type = "create-entity"
          },
          {
            damage = {
              amount = 4000 * death_damage_modifier,
              type = "explosion"
            },
            type = "damage"
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
            radius = 14 * death_explosion_modifier,
            type = "destroy-decoratives"
          },
          {
            apply_projection = true,
            decorative = "nuclear-ground-patch",
            spawn_max = 40 * death_explosion_modifier,
            spawn_max_radius = 12.5 * death_explosion_modifier,
            spawn_min = 30 * death_explosion_modifier,
            spawn_min_radius = 11.5 * death_explosion_modifier,
            spread_evenly = true,
            type = "create-decorative"
          },
          {
            action = {
              action_delivery = {
                projectile = "nuclear-land-mine-death-ground-zero-projectile",
                starting_speed = 0.47999999999999998,
                starting_speed_deviation = 0.075,
                type = "projectile"
              },
              radius = 7 * death_explosion_modifier,
              repeat_count = 1000, -- * death_explosion_modifier,
              target_entities = false,
              trigger_from_target = true,
              type = "area"
            },
            type = "nested-result"
          },
          {
            action = {
              action_delivery = {
                projectile = "nuclear-land-mine-death-wave",
                starting_speed = 0.35,
                starting_speed_deviation = 0.075,
                type = "projectile"
              },
              radius = 35 * death_explosion_modifier,
              repeat_count = 1000, -- * death_explosion_modifier,
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
              radius = 26 * death_explosion_modifier,
              repeat_count = 1000, -- * death_explosion_modifier,
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
              radius = 4 * death_explosion_modifier,
              repeat_count = 700, -- * death_explosion_modifier,
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
                projectile = "atomic-bomb-wave-spawns-nuke-shockwave-explosion",
                starting_speed = 0.325,
                starting_speed_deviation = 0.075,
                type = "projectile"
              },
              radius = 8 * death_explosion_modifier,
              repeat_count = 1000, -- * death_explosion_modifier,
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
                projectile = "atomic-bomb-wave-spawns-nuclear-smoke",
                starting_speed = 0.325,
                starting_speed_deviation = 0.075,
                type = "projectile"
              },
              radius = 26 * death_explosion_modifier,
              repeat_count = 300, -- * death_explosion_modifier,
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
              radius = 8 * death_explosion_modifier,
              repeat_count = 10, -- * death_explosion_modifier,
              show_in_tooltip = false,
              target_entities = false,
              trigger_from_target = true,
              type = "area"
            },
            type = "nested-result"
          }
        },
        type = "instant"
      },
      type = "direct"
      -- type = "damage"
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
      -- type = "damage"
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