extends Node2D

var customization = {
	body_equip = 0,
	body_color = 0,
	eyes = 0,
	eyes_color = 0,
	head = 0,
	pants = 0,
	pattern = 0,
	nickname = ""
}

func change_pattern(patternIndex):
	print('new pattern')
	customization.pattern = patternIndex
	$Body.texture = customizationData.pattern[customization["pattern"]].resource_main
	$Body/Body_Secondary.texture = customizationData.pattern[customization["pattern"]].resource_secondary

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
	
func change_head(headIndex):
	customization.head = headIndex
	if customizationData.head[customization.head].animated:
		$Body/Head_Animated.show()
		$Body/Head.hide()
		$Body/Head_Animated.frames = customizationData.head[customization["head"]].resource
	else:
		$Body/Head_Animated.hide()
		$Body/Head.show()
		$Body/Head.texture = customizationData.head[customization["head"]].resource
		
func change_pants(pantsIndex):
	customization.pants = pantsIndex
	$Body/Leg_Left/PantsL.texture = customizationData.pants[customization["pants"]].resource
	$Body/Leg_Right/PantsR.texture = customizationData.pants[customization["pants"]].resource

func change_body_color(colorIndex):
	customization.body_color = colorIndex
	$Body.self_modulate = customizationData.body_colors[customization["body_color"]].body_main
	$Body/Body_Secondary.self_modulate = customizationData.body_colors[customization["body_color"]].body_secondary
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
