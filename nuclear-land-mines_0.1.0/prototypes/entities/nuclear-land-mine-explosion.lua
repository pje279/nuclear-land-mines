local nuclear_land_mine_explosion = util.table.deepcopy(data.raw["artillery-projectile"]["artillery-projectile"])
nuclear_land_mine_explosion.name = "land-mine-explosion-nuclear"

for k, v in pairs(data.raw["projectile"]["atomic-rocket"].action.action_delivery.target_effects) do
	table.insert(nuclear_land_mine_explosion.action.action_delivery.target_effects, v)
end

log(serpent.block(nuclear_land_mine_explosion.action))

data:extend({nuclear_land_mine_explosion})