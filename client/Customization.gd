extends Node2D

var customizationData = {
	body_colors = [
		{
			body = Color(1,1,1,1),
			legs = Color(1,1,1,1)
		},
		{
			body = Color(0.8,0.2,0.2,1),
			legs = Color(0.8,0.2,0.2,1)
		}
	],
	eyes_colors = [
		Color(0,0,0,1),
		Color(0.2,0.2,0.8,1)		
	]
}

var customization = {
	body_color = 0,
	eyes = 0,
	eyes_color = 0,
	nickname = ""
}


func change_eyes(eyeIndex):
	customization.eyes = eyeIndex

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
