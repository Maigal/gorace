extends Node

var body_equips = [
	{
		resource = null,
		animated = false
	},
	{
		resource = load("res://Sprites/Player/Customization/Body/1.png"),
		animated = false
	}
]

var eyes = [
	{
		resource = load("res://Sprites/Player/Customization/Eyes/0.png"),
		animated = false
	},
	{
		resource = load("res://Sprites/Player/Customization/Eyes/1.png"),
		animated = false
	},
	{
		resource = load("res://Sprites/Player/Customization/Eyes/2.tres"),
		animated = true
	}
]

var body_colors = [
	{
		body = Color(1,1,1,1),
		legs = Color(1,1,1,1)
	},
	{
		body = Color(0,0,0,1),
		legs = Color(0,0,0,1)
	}
]

var eyes_colors = [
	Color(0,0,0,1),
	Color(01,0,0,1)		
]
