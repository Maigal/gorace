extends Node

var body_equips = [
	{
		id = 0,
		description = "None",
		resource = null,
		animated = false,
		img = "",
		rarity = 0
	},
	{
		id = 1,
		description = "BOKITA EL MAS GRANDE",
		resource = load("res://Sprites/Player/Customization/Body/1.png"),
		animated = false,
		img = "res://Sprites/Player/Customization/Body/1_list.png",
		rarity = 3
	},
	{
		id = 2,
		description = "Chainmail",
		resource = load("res://Sprites/Player/Customization/Body/2.png"),
		animated = false,
		img = "res://Sprites/Player/Customization/Body/2_list.png",
		rarity = 1
	}
]

var eyes = [
	{
		id = 0,
		description = "Regular eyes",
		resource = load("res://Sprites/Player/Customization/Eyes/0.png"),
		animated = false,
		img = "res://Sprites/Player/Customization/Eyes/0_list.png",
		rarity = 0,
	},
	{
		id = 1,
		description = "Angry eyes",
		resource = load("res://Sprites/Player/Customization/Eyes/1.png"),
		animated = false,
		img = "res://Sprites/Player/Customization/Eyes/1_list.png",
		rarity = 1,
	},
	{
		id = 2,
		description = "Dizzy eyes",
		resource = load("res://Sprites/Player/Customization/Eyes/2.tres"),
		animated = true,
		img = "res://Sprites/Player/Customization/Eyes/2_list.png",
		rarity = 2,
	}
]

var body_colors = [
	{
		id = 0,
		animated = false,
		description = "White",
		body_main = Color(1,1,1,1),
		body_secondary = Color(1,1,1,1),
		legs = Color(1,1,1,1),
		img = "res://Sprites/Player/Customization/Colors/0_list.png",
		rarity = 0
	},
	{
		id = 1,
		animated = false,
		description = "Black",
		body_main = Color(0,0,0,1),
		body_secondary = Color(0,0,0,1),
		legs = Color(0,0,0,1),
		img = "res://Sprites/Player/Customization/Colors/1_list.png",
		rarity = 2
	},
	{
		id = 2,
		animated = false,
		description = "Bee",
		body_main = Color(1,0.8,0,1),
		body_secondary = Color(0,0,0,1),
		legs = Color(1,0.8,0,1),
		img = "res://Sprites/Player/Customization/Colors/2_list.png",
		rarity = 1
	}
]

var eyes_colors = [
	{
		id = 0,
		description = "Black eyes",
		color = Color(0,0,0,1),
		animated = false,
		img = "res://Sprites/Player/Customization/Colors/1_list.png",
		rarity = 0
	},
	{
		id = 1,
		description = "White eyes",
		color = Color(1,1,1,1),
		animated = false,
		img = "res://Sprites/Player/Customization/Colors/0_list.png",
		rarity = 0
	},
	{
		id = 2,
		description = "Red eyes",
		color = Color(1,0,0,1),
		animated = false,
		img = "res://Sprites/Player/Customization/Eye_Colors/1_list.png",
		rarity = 1
	}
]

var head = [
	{
		id = 0,
		animated = false,
		description = "None",
		resource = null,
		img = "",
		rarity = 0
	},
	{
		id = 1,
		animated = false,
		description = "Horns",
		resource = load("res://Sprites/Player/Customization/Head/1.png"),
		img = "res://Sprites/Player/Customization/Head/1_list.png",
		rarity = 1
	},
	{
		id = 2,
		animated = true,
		description = "Unicorn",
		resource = load("res://Sprites/Player/Customization/Head/2.tres"),
		img = "res://Sprites/Player/Customization/Head/2_list.png",
		rarity = 3
	}
]

var pants = [
	{
		id = 0,
		animated = false,
		description = "None",
		resource = null,
		img = "",
		rarity = 0
	},
	{
		id = 1,
		animated = false,
		description = "Pajama",
		resource = load("res://Sprites/Player/Customization/Pants/1.png"),
		img = "res://Sprites/Player/Customization/Pants/1_list.png",
		rarity = 1
	}
]

var pattern = [
	{
		id = 0,
		animated = false,
		description = "None",
		resource_main = load("res://Sprites/Player/Customization/Patterns/0_main.png"),
		resource_secondary = load("res://Sprites/Player/Customization/Patterns/0_secondary.png"),
		img = "res://Sprites/Player/Customization/Patterns/0_list.png",
		rarity = 0
	},
	{
		id = 1,
		animated = false,
		description = "None",
		resource_main = load("res://Sprites/Player/Customization/Patterns/1_main.png"),
		resource_secondary = load("res://Sprites/Player/Customization/Patterns/1_secondary.png"),
		img = "res://Sprites/Player/Customization/Patterns/1_list.png",
		rarity = 1
	}
]

