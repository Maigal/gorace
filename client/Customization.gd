extends Node2D

var customization = {
	body_equip = 0,
	body_color = 0,
	eyes = 0,
	eyes_color = 0,
	nickname = ""
}

func change_eyes(eyeIndex):
	customization.eyes = eyeIndex
	if customizationData.eyes[eyeIndex].animated:
		$Body/Eyes_Animated.frames = customizationData.eyes[customization["eyes"]].resource
		$Body/Eyes.hide()
		$Body/Eyes_Animated.show()
	else:
		$Body/Eyes.texture = customizationData.eyes[customization["eyes"]].resource
		$Body/Eyes.show()
		$Body/Eyes_Animated.hide()
	change_eyes_color(customization.eyes_color)
		
	
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
	
	if customizationData.eyes[customization.eyes].animated:
		$Body/Eyes_Animated.self_modulate = customizationData.eyes_colors[customization["eyes_color"]].color
	else:
		$Body/Eyes.self_modulate = customizationData.eyes_colors[customization["eyes_color"]].color
	
	print('modu', $Body/Eyes.self_modulate)
	
func get_body_colors():
	return customizationData.body_colors[customization["body_color"]].body
