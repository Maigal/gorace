extends TextureRect

export var item_name = ""
export var image = ""
export var index = 0

var isSelected = false

func _ready():
	$ItemImg.texture_normal = load(image)
	$ItemImg.hint_tooltip = item_name

func _on_ItemImg_pressed():
	isSelected = true
	get_tree().call_group("lobbyCustomization", "selected_item", index)
