--data.lua
local tint_color = { r = 192 / 255, g = 100 / 255, b = 208 / 255, a = 200 / 255 }


local recipe_category = {
  type = "recipe-category",
  name = "investment",
  hidden = true
}

local corpse = table.deepcopy(data.raw["corpse"]["electric-furnace-remnants"])
corpse.name = "investment-electric-furnace-remnants"
corpse.animation.layers = {
  {
    filename = "__base__/graphics/entity/electric-furnace/remnants/electric-furnace-remnants.png",
    tint = tint_color,
    line_length = 1,
    width = 454,
    height = 448,
    direction_count = 1,
    shift = util.by_pixel(-3.25, 7.25),
    scale = 1
  }
}

local Investment_electric_furnace_item = table.deepcopy(data.raw["item"]["electric-furnace"])
Investment_electric_furnace_item.name = "investment-electric-furnace"
Investment_electric_furnace_item.place_result = "investment-electric-furnace"
Investment_electric_furnace_item.icons = {
  {
    icon = Investment_electric_furnace_item.icon,
    icon_size = Investment_electric_furnace_item.icon_size,
    tint = tint_color
  },
}

local Investment_electric_furnace = table.deepcopy(data.raw["furnace"]["electric-furnace"])
Investment_electric_furnace.name = "investment-electric-furnace"
Investment_electric_furnace.icons = {
  {
    icon = Investment_electric_furnace.icon,
    icon_size = Investment_electric_furnace.icon_size,
    tint = tint_color
  },
}
Investment_electric_furnace.minable = {
  mining_time = 5,
  results =
  {
    {
      type = "item",
      name = "investment-electric-furnace",
      amount = 1
    }
  }
}
Investment_electric_furnace.corpse = "investment-electric-furnace-remnants"

-- 建物自体の色を変更する処理
Investment_electric_furnace.graphics_set.animation.layers = {
  {
    filename = "__base__/graphics/entity/electric-furnace/electric-furnace.png",
    tint = tint_color,
    priority = "high",
    width = 239,
    height = 219,
    shift = util.by_pixel(0.75, 5.75),
    scale = 1
  },
  {
    filename = "__base__/graphics/entity/electric-furnace/electric-furnace-shadow.png",
    priority = "high",
    width = 227,
    height = 171,
    draw_as_shadow = true,
    shift = util.by_pixel(11.25, 7.75),
    scale = 1
  }
}
Investment_electric_furnace.selection_box = { { -3, -3 }, { 3, 3 } }
Investment_electric_furnace.collision_box = { { -2.9, -2.9 }, { 2.9, 2.9 } }
Investment_electric_furnace.allowed_effects = { "speed", "productivity", "consumption" }
Investment_electric_furnace.energy_usage = "30MW"
Investment_electric_furnace.crafting_speed = 1
Investment_electric_furnace.module_slots = 4
Investment_electric_furnace.max_health = 1500
Investment_electric_furnace.crafting_categories = { "investment" }
if settings.startup["Return-of-materials-upon-dismantling"].value == false then
  Investment_electric_furnace.return_ingredients_on_change = false
else
  Investment_electric_furnace.return_ingredients_on_change = true
end

-- create the recipe prototype from scratch
local Investment_electric_furnace_recipe = {
  type = "recipe",
  name = "investment-electric-furnace",
  energy_required = 30, -- time to craft in seconds (at crafting speed 1)
  ingredients = {
    { type = "item", name = "processing-unit",      amount = 100 },
    { type = "item", name = "electric-engine-unit", amount = 100 },
    { type = "item", name = "concrete",             amount = 1000 },
    { type = "item", name = "steel-chest",          amount = 100 },
    { type = "item", name = "uranium-fuel-cell",    amount = 50 }
  },
  results = { { type = "item", name = "investment-electric-furnace", amount = 1 } },
  enabled = false
}

if mods["space-age"] then
  local Investment_lithium_plate = {
    type = "recipe",
    name = "investment_lithium_plate",
    category = "investment",
    ingredients = { { type = "item", name = "lithium", amount = 30000 } },
    results = { { type = "item", name = "lithium-plate", amount = 60000 } },
    energy_required = 3600,
    allow_productivity = true,
    enabled = false
  }

  data:extend { Investment_lithium_plate }
end

local Investment_copper_plate = {
  type = "recipe",
  name = "investment_copper_plate",
  category = "investment",
  ingredients = { { type = "item", name = "copper-ore", amount = 30000 } },
  results = { { type = "item", name = "copper-plate", amount = 60000 } },
  energy_required = 1800,
  allow_productivity = true,
  enabled = false
}

local Investment_steel_plate = {
  type = "recipe",
  name = "investment_steel_plate",
  category = "investment",
  ingredients = { { type = "item", name = "iron-plate", amount = 60000 } },
  results = { { type = "item", name = "steel-plate", amount = 30000 } },
  energy_required = 3600,
  allow_productivity = true,
  enabled = false
}

local Investment_stone_brick = {
  type = "recipe",
  name = "investment_stone_brick",
  category = "investment",
  ingredients = { { type = "item", name = "stone", amount = 30000 } },
  results = { { type = "item", name = "stone-brick", amount = 30000 } },
  energy_required = 1800,
  allow_productivity = true,
  enabled = false
}

local Investment_iron_plate = {
  type = "recipe",
  name = "investment_iron_plate",
  category = "investment",
  ingredients = { { type = "item", name = "iron-ore", amount = 30000 } },
  results = { { type = "item", name = "iron-plate", amount = 60000 } },
  energy_required = 1800,
  allow_productivity = true,
  enabled = false
}

local Investment_electric_furnace_technology = nil
if mods["space-age"] then
  Investment_electric_furnace_technology = {
    type = "technology",
    name = "investment-electric-furnace",
    icons = {
      {
        icon = "__base__/graphics/technology/advanced-material-processing-2.png",
        icon_size = 256,
        tint = tint_color
      }
    },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "investment-electric-furnace"
      },
      {
        type = "unlock-recipe",
        recipe = "investment_lithium_plate"
      },
      {
        type = "unlock-recipe",
        recipe = "investment_copper_plate"
      },
      {
        type = "unlock-recipe",
        recipe = "investment_steel_plate"
      },
      {
        type = "unlock-recipe",
        recipe = "investment_stone_brick"
      },
      {
        type = "unlock-recipe",
        recipe = "investment_iron_plate"
      }
    },
    unit =
    {
      count = 500,
      ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 }, { "chemical-science-pack", 1 }, { "production-science-pack", 1 } },
      time = 45
    },
    prerequisites = { "production-science-pack", "nuclear-power" },
    order = "c-a"
  }
else
  Investment_electric_furnace_technology = {
    type = "technology",
    name = "investment-electric-furnace",
    icons = {
      {
        icon = "__base__/graphics/technology/advanced-material-processing-2.png",
        icon_size = 256,
        tint = tint_color
      }
    },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "investment-electric-furnace"
      },
      {
        type = "unlock-recipe",
        recipe = "investment_copper_plate"
      },
      {
        type = "unlock-recipe",
        recipe = "investment_steel_plate"
      },
      {
        type = "unlock-recipe",
        recipe = "investment_stone_brick"
      },
      {
        type = "unlock-recipe",
        recipe = "investment_iron_plate"
      }
    },
    unit =
    {
      count = 500,
      ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 }, { "chemical-science-pack", 1 }, { "production-science-pack", 1 } },
      time = 45
    },
    prerequisites = { "production-science-pack", "nuclear-power" },
    order = "c-a"
  }
end

data:extend { recipe_category, corpse, Investment_electric_furnace, Investment_electric_furnace_item, Investment_electric_furnace_recipe, Investment_iron_plate, Investment_copper_plate, Investment_stone_brick, Investment_steel_plate, Investment_electric_furnace_technology }
