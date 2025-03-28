local Item_Sounds = require("__base__.prototypes.Item_Sounds")

data:extend({
  {
    type = "item",
    name = "nuclear-land-mine",
    icon = "__base__/graphics/icons/land-mine.png",
    subgroup = "defensive-structure",
    order = "g[land-mine]",
    inventory_move_sound = Item_Sounds.explosive_inventory_move,
    pick_sound = Item_Sounds.explosive_inventory_pickup,
    drop_sound = Item_Sounds.explosive_inventory_move,
    place_result = "nuclear-land-mine",
    stack_size = 10
  },
})