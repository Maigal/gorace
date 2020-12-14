extends Node

var body_equips = [
	{
		id = 0,
		description = "None",
		resource = null,
		animated = false,
		img = ""
	},
	{
		id = 1,
		description = "BOKITA EL MAS GRANDE",
		resource = load("res://Sprites/Player/Customization/Body/1.png"),
		animated = false,
		img = "res://Sprites/Player/Customization/Body/1_list.png"
	}
]

var eyes = [
	{
		id = 0,
		resource = load("res://Sprites/Player/Customization/Eyes/0.png"),
		animated = false
	},
	{
		id = 1,
		resource = load("res://Sprites/Player/Customization/Eyes/1.png"),
		animated = false
	},
	{
		id = 2,
		resource = load("res://Sprites/Player/Customization/Eyes/2.tres"),
		animated = true
	}
]

var body_colors = [
	{
		id = 0,
		description = "White",
		body = Color(1,1,1,1),
		legs = Color(1,1,1,1),
		img = "res://Sprites/Player/Customization/Colors/0_list.png"
	},
	{
		id = 1,
		description = "Black",
		body = Color(0,0,0,1),
		legs = Color(0,0,0,1),
		img = "res://Sprites/Player/Customization/Colors/1_list.png"
	}
]

var eyes_colors = [
	{
		id = 0,
		color = Color(0,0,0,1)
	},
	{
		id = 1,
		color = Color(01,0,0,1)	
	}
]
