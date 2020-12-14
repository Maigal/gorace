extends TextureRect

var item_name = ""
var image = ""
var index = 0
var rarity = 0
var animated = false
var modulation = Color(1,1,1,1)
var isSelected = false

func _ready():
	
	print('modulation: ', modulation)
	$ItemImg.texture_normal = load(image)
	$ItemImg.hint_tooltip = item_name
	
	match rarity:
		1:
			self_modulate = Color(0.2, 0.7, 0.8, 1)
		2:
			self_modulate = Color(0.4, 0.3, 0.6, 1)
		3:
			self_modulate = Color(0.8, 0.6, 0.1, 1)
			
	$ItemImg.self_modulate = modulation
	
	if !animated:
		$AnimatedTag.hide()

func _on_ItemImg_pressed():
	isSelected = true
	get_tree().call_group("lobbyCustomization", "selected_item", index)
