require("__lilys-cubeine__.prototypes.fluid.cubeine-fusion-plasma")
local base_tint = { r = 1, g = 0.8, b = 0.8, a = 1 }
local emissive_tint = { r = 1, g = 0.2, b = 0.2, a = 1 }

local gfx = require("__lilys-cubeine__.prototypes.advanced.fusion-system-pictures")


data.extend({
    {
        type = "corpse",
        name = "cubeine-fusion-reactor-remnants",
        icon = "__lilys-cubeine__/graphics/icons/fusion-reactor.png",
        flags = { "placeable-neutral", "not-on-map" },
        hidden_in_factoriopedia = true,
        subgroup = "energy-remnants",
        order = "g[fusion-energy]-a[reactor]",
        selection_box = { { -3, -3 }, { 3, 3 } },
        tile_width = 6,
        tile_height = 6,
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 15, -- 15 minutes
        expires = false,
        final_render_layer = "remnants",
        remove_on_tile_placement = false,
        animation = util.sprite_load("__lilys-cubeine-asset-pack__/graphics/entity/fusion-reactor/fusion-reactor-remnants", {
            scale = 0.5,
            direction_count = 1
        })
    },
    {
        type = "corpse",
        name = "cubeine-fusion-generator-remnants",
        icon = "__lilys-cubeine__/graphics/icons/fusion-generator.png",
        flags = { "placeable-neutral", "not-on-map" },
        hidden_in_factoriopedia = true,
        subgroup = "energy-remnants",
        order = "g[fusion-energy]-b[generator]",
        selection_box = { { -1.5, -2.5 }, { 1.5, 2.5 } },
        tile_width = 3,
        tile_height = 5,
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 15, -- 15 minutes
        expires = false,
        final_render_layer = "remnants",
        remove_on_tile_placement = false,
        animation = util.sprite_load(
        "__lilys-cubeine-asset-pack__/graphics/entity/fusion-generator/fusion-generator-remnants",
            {
                scale = 0.5,
                direction_count = 4
            })
    },
})




local reactor_item = table.deepcopy(data.raw["item"]["fusion-reactor"])
reactor_item.name = "cubeine-fusion-reactor"
reactor_item.order = "mc[cubeine-fusion-energy]-a[reactor]"
reactor_item.place_result = "cubeine-fusion-reactor"
reactor_item.icons = {
    {
        icon = "__lilys-cubeine__/graphics/icons/fusion-reactor.png",
        icon_size = reactor_item.icon_size,
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 6, 6 }
    }
}


local reactor = table.deepcopy(data.raw["fusion-reactor"]["fusion-reactor"])
reactor.name = "cubeine-fusion-reactor"
reactor.minable.result = "cubeine-fusion-reactor"
reactor.max_health = 2000
reactor.resistances = {
    {
        type = "fire",
        percent = 99
    },
    {
        type = "explosion",
        percent = 70
    }
}
reactor.corpse = "cubeine-fusion-reactor-remnants"
reactor.target_temperature = 10 * 1e6
reactor.power_input = "20MW" -- at normal quality
reactor.max_fluid_usage = 80/second -- at normal quality
table.insert(reactor.flags, "get-by-unit-number")
reactor.neighbour_bonus = 10
reactor.burner =
    {
      type = "burner",
      fuel_categories = {"fusion", "cubic"},
      effectivity = 0.75,
      fuel_inventory_size = 1,
      emissions_per_minute = { pollution = 10 },
      light_flicker =
      {
        color = {1,0,0.2},
        minimum_intensity = 0.0,
        maximum_intensity = 0.1,
      }
    }
reactor.input_fluid_box =
    {
      production_type = "input",
      volume = 10000,
      filter = "cubeine-solution",
      pipe_connections =
      {
---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.west, position = {-2.5, -1.5} },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.west, position = {-2.5,  1.5} },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.east, position = { 2.5, -1.5} },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.east, position = { 2.5,  1.5} },
      },
    }
reactor.output_fluid_box =
{
    production_type = "output",
    volume = 100,
    filter = "cubeine-fusion-plasma",
    pipe_connections =
    {
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.south, position = { -1.5, 2.5 }, connection_category = { "fusion-plasma" } },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.south, position = { 1.5, 2.5 }, connection_category = { "fusion-plasma" } },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.north, position = { -1.5, -2.5 }, connection_category = { "fusion-plasma" } },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction = "input-output", direction = defines.direction.north, position = { 1.5, -2.5 }, connection_category = { "fusion-plasma" } },
    }
}

reactor.graphics_set = gfx.reactor_graphics_set





local generator_item = table.deepcopy(data.raw["item"]["fusion-generator"])
generator_item.name = "cubeine-fusion-generator"
generator_item.place_result = "cubeine-fusion-generator"
generator_item.order = "mc[cubeine-fusion-energy]-b[generator]"
generator_item.icons = {
    {
        icon = "__lilys-cubeine__/graphics/icons/fusion-generator.png",
    },
    {
        icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
        icon_size = 64,
        scale = 0.25,
        shift = { 6, 6 }
    }
}

local generator = table.deepcopy(data.raw["fusion-generator"]["fusion-generator"])
generator.name = "cubeine-fusion-generator"
generator.minable.result = "cubeine-fusion-generator"
generator.max_health = 2000
generator.corpse = "cubeine-fusion-generator-remnants"
generator.resistances = {
    {
        type = "fire",
        percent = 99
    },
    {
        type = "explosion",
        percent = 70
    }
}
generator.graphics_set = gfx.generator_graphics_set

generator.energy_source =
    {
      type = "electric",
      usage_priority = "secondary-output",
      output_flow_limit = "200MW", -- This is used to define max power output. 100MW at normal quality
    }
generator.max_fluid_usage = 80/second -- at normal quality

generator.input_fluid_box =
    {
      production_type = "input",
      --pipe_covers = pipecoverspictures(),
      volume = 100,
      filter = "cubeine-fusion-plasma",
      pipe_connections =
      {
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction="input",  direction = defines.direction.south, position = {-1,  2}, connection_category = {"fusion-plasma"} },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction="input",  direction = defines.direction.south, position = { 1,  2}, connection_category = {"fusion-plasma"} },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction="output", direction = defines.direction.north, position = { 0, -2}, connection_category = {"fusion-plasma"} },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction="output", direction = defines.direction.west,  position = {-1,  0}, connection_category = {"fusion-plasma"} },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction="output", direction = defines.direction.east,  position = { 1,  0}, connection_category = {"fusion-plasma"} },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction="output", direction = defines.direction.west,  position = {-1, -1}, connection_category = {"fusion-plasma"} },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction="output", direction = defines.direction.east,  position = { 1, -1}, connection_category = {"fusion-plasma"} },
      },
    }
generator.output_fluid_box =
    {
      production_type = "output",
---@diagnostic disable-next-line: undefined-global
      pipe_covers = pipecoverspictures(),
      volume = 1000,
      filter = "residue-cubeine-solution",
      pipe_connections =
      {
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction="output", direction = defines.direction.north, position = {-1, -2} },
        ---@diagnostic disable-next-line: assign-type-mismatch
        { flow_direction="output", direction = defines.direction.north, position = {1, -2} },
      }
    }

generator.graphics_set.glow_color = { 1, 0, 0.05, 1 }


local generator2_item = table.deepcopy(generator_item)
generator2_item.name = generator2_item.name .."-cold"
generator2_item.place_result = generator2_item.place_result .. "-cold"
table.insert(generator2_item.icons,
    {
        icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-blue.png",
        icon_size = 64,
        tint = { 0.65, 0.65, 0.65, 0.65 }
    })
generator2_item.hidden = true

local generator2 = table.deepcopy(generator)
generator2.name = generator2.name.."-cold"
generator2.order = "mc[cubeine-fusion-energy]-c[generator-cold]"
generator2.minable.result = generator2.minable.result .. "-cold"
generator2.input_fluid_box.maximum_temperature = 1001000
generator2.energy_source.usage_priority = "primary-output"
generator2.energy_source =
{
    type = "electric",
    usage_priority = "secondary-output",
    output_flow_limit = "400MW",   -- This is used to define max power output. 100MW at normal quality
}
generator2.max_fluid_usage = 160 / second
generator2.hidden = true

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({reactor_item, reactor, generator_item, generator, generator2_item, generator2})


data:extend({
    {
        type = "recipe",
        name = "cubeine-fusion-reactor",
        category = "cryogenics",
        energy_required = 60,
        enabled = false,
        ingredients =
        {
            { type = "item", name = "fusion-reactor",    amount = 1 },
            { type = "item", name = "cubeine-crystal",    amount = 200 },
            { type = "item", name = "low-density-structure",    amount = 200 },
            { type = "fluid",  name = "cubeine-solution",     amount = 1000 },
            { type = "fluid",  name = "pure-cubeplant-fluid",   amount = 100},
        },
        results = { { type = "item", name = "cubeine-fusion-reactor", amount = 1 } },
        requester_paste_multiplier = 1,
        crafting_machine_tint =
        {
            primary = { r = 0.298, g = 0.442, b = 0.518, a = 1.000 }, -- #4c7084ff
            secondary = { r = 1, g = 0.306, b = 0.402, a = 1.000 },      -- #dc8444ff
            tertiary = { r = 0.159, g = 0.136, b = 0.207, a = 1.000 }, -- #282234ff
            quaternary = { r = 0.945, g = 0.170, b = 0.200, a = 1.000 }, -- #f12e44ff
        },
        allow_productivity = false,
    },
    {
        type = "recipe",
        name = "cubeine-fusion-generator",
        category = "cryogenics",
        energy_required = 60,
        enabled = false,
        ingredients =
        {
            { type = "item", name = "fusion-generator",  amount = 1 },
            { type = "item",  name = "cubeine-crystal",       amount = 50 },
            { type = "item",  name = "low-density-structure", amount = 100 },
            { type = "fluid", name = "cubeine-solution",      amount = 500 },
            { type = "fluid", name = "pure-cubeplant-fluid",             amount = 50 },
        },
        results = { { type = "item", name = "cubeine-fusion-generator", amount = 1 } },
        requester_paste_multiplier = 1,
        crafting_machine_tint =
        {
            primary = { r = 0.298, g = 0.442, b = 0.518, a = 1.000 }, -- #4c7084ff
            secondary = { r = 1, g = 0.306, b = 0.402, a = 1.000 }, -- #dc8444ff
            tertiary = { r = 0.159, g = 0.136, b = 0.207, a = 1.000 }, -- #282234ff
            quaternary = { r = 0.945, g = 0.170, b = 0.200, a = 1.000 }, -- #f12e44ff
        },
        allow_productivity = false,
    },
    {
        type = "recipe",
        name = "cubeine-fusion-generator-cold",
        hidden = true,
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/fusion-generator.png",
                icon_size = 64,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.25,
                shift = { 6, 6 }
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-blue.png",
                icon_size = 64,
                tint = { 0.65, 0.65, 0.65, 0.65 }
            }
        },
        energy_required = 1,
        enabled = false,
        ingredients =
        {
            { type = "item",  name = "cubeine-fusion-generator", amount = 1 },
        },
        results = { { type = "item", name = "cubeine-fusion-generator-cold", amount = 1 } },
        allow_productivity= false,
        allow_quality = false,
    },
    {
        type = "recipe",
        name = "cubeine-fusion-generator-cold-not",
        hidden = true,
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/icons/fusion-generator.png",
                icon_size = 64,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.25,
                shift = { 6, 6 }
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/misc/signal-thermometer-blue.png",
                icon_size = 64,
                tint = { 0.65, 0.65, 0.65, 0.65 }
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/misc/signal-deny.png",
                icon_size = 64,
                tint = { 0.65, 0.65, 0.65, 0.65 }
            }
        },
        energy_required = 1,
        enabled = false,
        ingredients =
        {
            { type = "item", name = "cubeine-fusion-generator-cold", amount = 1 },
        },
        results = { { type = "item", name = "cubeine-fusion-generator", amount = 1 } },
        allow_productivity = false,
        allow_quality = false,
    },
})


--recipe
local solution = {

    type = "recipe",
    name = "cubeine-residue-reprocessing",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/fluid/cubeine-residue.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-recycle.png",
            icon_size = 64,
            tint = {0.65, 0.65, 0.65, 0.65}
        },
    },


    subgroup = "cubeine-processes",
    enabled = false,
    energy_required = 2,
    crafting_machine_tint = {
        primary = { r = 0.682, g = 0.6, b = 0.675, a = 1.000 },     --#e199ac
        secondary = { r = 0.655, g = 0.949, b = 0.659, a = 1.000 }, --#a75975
        tertiary = { r = 0.8, g = 0.8, b = 0.6, a = 1.000 },    --#9e1725
        quaternary = { r = 0.82, g = 0.8, b = 0.7, a = 1.000 },  --#9e1725
    },
    ingredients = {
        { type = "fluid", name = "residue-cubeine-solution", amount = 500 },
    },
    results = {
        { type = "fluid", name = "lubricant", amount = 50 },
        { type = "fluid", name = "steam", temperature = 1000, amount = 4500 },

    },
    category = "chemistry-or-cryogenics",
    main_product = "steam",
    allow_productivity = false

}


--recipe
local solution2 = {

    type = "recipe",
    name = "cubeine-residue-recondensation",
    icons = {
        {
            icon = "__lilys-cubeine__/graphics/icons/fluid/cubeine-residue.png",
            icon_size = 64,
        },
        {
            icon = "__lilys-cubeine__/graphics/icons/misc/signal-recycle.png",
            icon_size = 64,
            tint = { 0.0, 0.3, 0.65, 0.65 }
        },
    },


    subgroup = "cubeine-processes",
    enabled = false,
    energy_required = 2,
    crafting_machine_tint = {
        primary = { r = 0.1, g = 0.4, b = 0.675, a = 1.000 },     --#e199ac
        secondary = { r = 0.655, g = 0.949, b = 0.659, a = 1.000 }, --#a75975
        tertiary = { r = 0.8, g = 0.8, b = 0.6, a = 1.000 },        --#9e1725
        quaternary = { r = 0.82, g = 0.8, b = 0.7, a = 1.000 },     --#9e1725
    },
    ingredients = {
        { type = "fluid", name = "residue-cubeine-solution", amount = 500 },
    },
    results = {
        { type = "fluid", name = "lubricant", amount = 50 },
        { type = "fluid", name = "water", amount = 450 },

    },
    category = "cryogenics",
    main_product = "water",
    allow_productivity = false

}

data:extend({ solution, solution2 })


-- technology
data:extend({
    {
        type = "technology",
        name = "cubeine-fusion-reactor",
        icons = {
            {
                icon = "__lilys-cubeine__/graphics/technology/fusion-reactor.png",
                icon_size = 256,
            },
            {
                icon = "__lilys-cubeine__/graphics/icons/cubeine-crystal.png",
                icon_size = 64,
                scale = 0.5,
                shift = {48, 48}
            }
        },
        prerequisites = { "cubeine-solution", "fusion-reactor" },

        unit = {
            count = 10000,
            ingredients =
            {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "production-science-pack",      1 },
                { "utility-science-pack",         1 },
                { "metallurgic-science-pack",     1 },
                { "agricultural-science-pack",    1 },
                { "electromagnetic-science-pack", 1 },
                { "cryogenic-science-pack",       1 },
            },
            time = 60

        },
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "cubeine-fusion-reactor"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-fusion-generator"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-residue-reprocessing"
            },
            {
                type = "unlock-recipe",
                recipe = "cubeine-residue-recondensation"
            },
        }
    }
})
