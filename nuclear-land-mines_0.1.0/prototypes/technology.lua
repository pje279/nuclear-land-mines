data:extend({
  {
    type = "technology",
    name = "nuclear-land-mine",
    icon = "__base__/graphics/technology/land-mine.png",
    icon_size = 256,
    localised_description = { "technology-description.nuclear-land-mine" },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "nuclear-land-mine"
      }
    },
    prerequisites = {
      "atomic-bomb",
      "quantum-processor"
    },
    unit =
    {
      ingredients =	{
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 1},
        {"utility-science-pack", 1},
        {"production-science-pack", 1},
        {"space-science-pack", 1},
        {"agricultural-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"metallurgic-science-pack", 1},
        {"cryogenic-science-pack", 1},
      },
      time = 60,
      count = 5000
    }
  }
})