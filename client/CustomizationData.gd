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
		body = Color(1,1,1,1),
		legs = Color(1,1,1,1),
		img = "res://Sprites/Player/Customization/Colors/0_list.png",
		rarity = 0
	},
	{
		id = 1,
		animated = false,
		description = "Black",
		body = Color(0,0,0,1),
		legs = Color(0,0,0,1),
		img = "res://Sprites/Player/Customization/Colors/1_list.png",
		rarity = 2
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
		description = "Red eyes",
		color = Color(1,0,0,1),
		animated = false,
		img = "res://Sprites/Player/Customization/Eye_Colors/1_list.png",
		rarity = 0
	}
]
