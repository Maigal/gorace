extends Node

var body_equips = [
	{
		index = 0,
		resource = null,
		animated = false
	},
	{
		index = 1,
		resource = load("res://Sprites/Player/Customization/Body/1.png"),
		animated = false
	}
]

var eyes = [
	{
		index = 0,
		resource = load("res://Sprites/Player/Customization/Eyes/0.png"),
		animated = false
	},
	{
		index = 1,
		resource = load("res://Sprites/Player/Customization/Eyes/1.png"),
		animated = false
	},
	{
		index = 2,
		resource = load("res://Sprites/Player/Customization/Eyes/2.tres"),
		animated = true
	}
]

var body_colors = [
	{
		index = 0,
		body = Color(1,1,1,1),
		legs = Color(1,1,1,1)
	},
	{
		index = 1,
		body = Color(0,0,0,1),
		legs = Color(0,0,0,1)
	}
]

var eyes_colors = [
	{
		index = 0,
		color = Color(0,0,0,1)
	},
	{
		index = 1,
		color = Color(01,0,0,1)	
	}
]
