local dir_prefix = "__nuclear-land-mines__."

local Settings_Service = require(dir_prefix.. "libs.settings-service")

data:extend({
  {
    type = "recipe",
    name = "nuclear-land-mine",
    enabled = true,
    energy_required = 15,
    ingredients =
    {
      { type = "item", name = "steel-plate", amount = 8 },
      { type = "item", name = "quantum-processor", amount = 4 },
      { type = "item", name = "atomic-bomb", amount = 1 },
    },
    results = {{ type = "item", name = "nuclear-land-mine", amount = Settings_Service.get_recipe_result_count()}}
  },
})