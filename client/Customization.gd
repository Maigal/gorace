extends Node2D

var customizationData = {
	colors = [
		{
			body = Color(1,1,1,1),
			legs = Color(1,1,1,1)
		},
		{
			body = Color(0.8,0.2,0.2,1),
			legs = Color(0.8,0.2,0.2,1)
		}
	]
}

var customization = {
	color = 0,
	eyes = 0,
	nickname = ""
}


func change_eyes(eyeIndex):
	customization.eyes = eyeIndex

func change_color(colorIndex):
	customization.color = colorIndex
	$Body.self_modulate = customizationData.colors[customization["color"]].body
	$Body/Leg_Left.self_modulate = customizationData.colors[customization["color"]].legs
	$Body/Leg_Right.self_modulate = customizationData.colors[customization["color"]].legs
