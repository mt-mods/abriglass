
-- clear glass recipe
minetest.register_craft({
	output = 'abriglass:clear_glass 4', -- intentional lower yield
	recipe = {
		{'default:glass', '', 'default:glass' },
		{'', 'default:glass', '' },
		{'default:glass', '', 'default:glass' },
	}
})

-- undecorated coloured glass recipes / light glass
local dye_list = {
	{"black", "black",},
	{"blue", "blue",},
	{"cyan", "cyan",},
	{"green", "green",},
	{"magenta", "magenta",},
	{"orange", "orange",},
	{"purple", "violet",},
	{"red", "red",},
	{"yellow", "yellow",},
	{"frosted", "white",},
}

sg_conversion_table = {}

for k, v in pairs(dye_list) do
    local out_item = ItemStack(minetest.itemstring_with_palette("abriglass:stained_glass_hardware", k - 1))
    out_item:get_meta():set_string("description", v[1] .. " glass")
    minetest.register_craft({
        output = out_item:to_string(),
        recipe = {
			{'abriglass:clear_glass', '', 'abriglass:clear_glass' },
			{'abriglass:clear_glass', 'dye:'..v[2], 'abriglass:clear_glass' },
			{'abriglass:clear_glass', '', 'abriglass:clear_glass' },
		}
    })

	minetest.register_craft({
		type = "cooking",
		recipe = out_item:to_string(),
		output = "abriglass:clear_glass",
	})

	sg_conversion_table[v[1]] = out_item:to_string()

	out_item = ItemStack(minetest.itemstring_with_palette("abriglass:glass_light_hardware", k - 1))
    out_item:get_meta():set_string("description", v[1] .. " glass light")
	minetest.register_craft({
		output = out_item:to_string(),
		recipe = {
			{'abriglass:clear_glass', 'default:torch', 'abriglass:clear_glass' },
			{'abriglass:clear_glass', 'dye:'..v[2], 'abriglass:clear_glass' },
		}
	})

	minetest.register_craft({
		type = "cooking",
		recipe = out_item:to_string(),
		output = "abriglass:clear_glass",
	})
end


-- patterned glass recipes
minetest.register_craft({
	output = 'abriglass:stainedglass_pattern01 9',
	recipe = {
		{sg_conversion_table['yellow'], sg_conversion_table['yellow'], sg_conversion_table['yellow'] },
		{sg_conversion_table['yellow'], sg_conversion_table['yellow'], sg_conversion_table['yellow'] },
		{sg_conversion_table['yellow'], sg_conversion_table['yellow'], sg_conversion_table['yellow'] },
	}
})

minetest.register_craft({
	output = 'abriglass:stainedglass_pattern02 9',
	recipe = {
		{'abriglass:clear_glass', 'abriglass:clear_glass', 'abriglass:clear_glass' },
		{'abriglass:clear_glass', 'abriglass:clear_glass', 'abriglass:clear_glass' },
		{'abriglass:clear_glass', 'abriglass:clear_glass', 'abriglass:clear_glass' },
	}
})

minetest.register_craft({
	output = 'abriglass:stainedglass_pattern03 9',
	recipe = {
		{sg_conversion_table['red'], 'abriglass:clear_glass', sg_conversion_table['red'] },
		{'abriglass:clear_glass', 'abriglass:clear_glass', 'abriglass:clear_glass' },
		{sg_conversion_table['red'], 'abriglass:clear_glass', sg_conversion_table['red'] },
	}
})

minetest.register_craft({
	output = 'abriglass:stainedglass_pattern04 9',
	recipe = {
		{sg_conversion_table['green'], sg_conversion_table['red'], sg_conversion_table['green'] },
		{sg_conversion_table['red'], sg_conversion_table['blue'], sg_conversion_table['red'] },
		{sg_conversion_table['green'], sg_conversion_table['red'], sg_conversion_table['green'] },
	}
})

minetest.register_craft({
	output = 'abriglass:stainedglass_pattern05 9',
	recipe = {
		{sg_conversion_table['blue'], sg_conversion_table['blue'], sg_conversion_table['blue'] },
		{sg_conversion_table['blue'], sg_conversion_table['green'], sg_conversion_table['blue'] },
		{sg_conversion_table['blue'], sg_conversion_table['blue'], sg_conversion_table['blue'] },
	}
})

minetest.register_craft({
	output = 'abriglass:stainedglass_tiles_dark 7',
	recipe = {
		{sg_conversion_table['red'], sg_conversion_table['green'], sg_conversion_table['blue'] },
		{sg_conversion_table['yellow'], sg_conversion_table['magenta'], sg_conversion_table['cyan'] },
		{'', sg_conversion_table['black'], '' },
	}
})

minetest.register_craft({
	output = 'abriglass:stainedglass_tiles_pale 7',
	recipe = {
		{sg_conversion_table['red'], sg_conversion_table['green'], sg_conversion_table['blue'] },
		{sg_conversion_table['yellow'], sg_conversion_table['magenta'], sg_conversion_table['cyan'] },
		{'', sg_conversion_table['frosted'], '' },
	}
})


-- cooking recipes
local cook_list = {
	"stainedglass_pattern01",
	"stainedglass_pattern02",
	"stainedglass_pattern03",
	"stainedglass_pattern04",
	"stainedglass_pattern05",
	"stainedglass_tiles_dark",
	"stainedglass_tiles_pale"
}

for i = 1, #cook_list do
	local name = cook_list[i]

	minetest.register_craft({
		type = "cooking",
		recipe = "abriglass:"..name,
		output = "abriglass:clear_glass",
	})
end


-- porthole recipes
local port_recipes = {
	{"wood",}, {"junglewood",},
}

for i in ipairs(port_recipes) do
	local name = port_recipes[i][1]

	minetest.register_craft({
		output = "abriglass:porthole_"..name.." 4",
		recipe = {
			{"default:glass", "", "default:glass",},
			{"default:"..name, "", "default:steel_ingot",},
			{"default:glass", "", "default:glass",},
		}
	})
end


-- one-way recipes
local oneway_recipe_list = {
	{"abriglass:oneway_glass_desert_brick", "default:desert_stonebrick",},
	{"abriglass:oneway_glass_stone_brick", "default:stonebrick",},
	{"abriglass:oneway_glass_sandstone_brick", "default:sandstonebrick",},
	{"abriglass:oneway_glass_dark", "abriglass:oneway_wall_dark",},
	{"abriglass:oneway_glass_pale", "abriglass:oneway_wall_pale",},
}

for i in ipairs(oneway_recipe_list) do
	local name = oneway_recipe_list[i][1]
	local ingredient = oneway_recipe_list[i][2]

	minetest.register_craft({
		output = name.." 2",
		recipe = {
			{'abriglass:clear_glass', 'default:mese_crystal_fragment', ingredient },
		}
	})
end

minetest.register_craft({
	output = 'abriglass:oneway_wall_dark 2',
	recipe = {
		{'default:clay_lump', 'default:clay_lump', 'default:clay_lump'},
		{'default:clay_lump', 'dye:black', 'default:clay_lump'},
		{'default:clay_lump', 'default:clay_lump', 'default:clay_lump'},
	}
})

minetest.register_craft({
	output = 'abriglass:oneway_wall_pale 2',
	recipe = {
		{'default:clay_lump', 'default:clay_lump', 'default:clay_lump'},
		{'default:clay_lump', 'dye:white', 'default:clay_lump'},
		{'default:clay_lump', 'default:clay_lump', 'default:clay_lump'},
	}
})

