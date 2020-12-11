extends Node2D

var customizationData = {
	body_equips = [
		{
			resource = null,
			animated = false
		},
		{
			resource = load("res://Sprites/Player/Customization/Body/1.png"),
			animated = false
		}
	],
	eyes = [
		{
			resource = load("res://Sprites/Player/Customization/Eyes/0.png"),
			animated = false
		},
		{
			resource = load("res://Sprites/Player/Customization/Eyes/1.png"),
			animated = false
		}
	],
	body_colors = [
		{
			body = Color(1,1,1,1),
			legs = Color(1,1,1,1)
		},
		{
			body = Color(0,0,0,1),
			legs = Color(0,0,0,1)
		}
	],
	eyes_colors = [
		Color(0,0,0,1),
		Color(01,0,0,1)		
	]
}

var customization = {
	body_equip = 0,
	body_color = 0,
	eyes = 0,
	eyes_color = 0,
	nickname = ""
}


func change_eyes(eyeIndex):
	customization.eyes = eyeIndex
	$Body/Eyes.texture = customizationData.eyes[customization["eyes"]].resource
	
func change_body_equip(eyeIndex):
	customization.body_equip = eyeIndex
	$Body/Body_Equip.texture = customizationData.body_equips[customization["body_equip"]].resource

func change_body_color(colorIndex):
	customization.body_color = colorIndex
	$Body.self_modulate = customizationData.body_colors[customization["body_color"]].body
	$Body/Leg_Left.self_modulate = customizationData.body_colors[customization["body_color"]].legs
	$Body/Leg_Right.self_modulate = customizationData.body_colors[customization["body_color"]].legs
	
func change_eyes_color(colorIndex):
	customization.eyes_color = colorIndex
	$Body/Eyes.self_modulate = customizationData.eyes_colors[customization["eyes_color"]]
	print('modu', $Body/Eyes.self_modulate)
	
func get_body_colors():
	return customizationData.body_colors[customization["body_color"]].body
