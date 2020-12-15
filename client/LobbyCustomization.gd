extends CanvasLayer

var available_items = {
	body_colors = [0,1],
	body_equips = [0,1],
	eyes = [0,1,2],
	eyes_colors = [0,1,2]
}

var selectedCategory = "body_colors"

onready var list_item = preload("res://Misc/ListItem.tscn")

func _ready():
	_on_Change_Category_pressed('body_colors')
	
func populate_category():		
	for oldItem in $Background/ScrollContainer/GridContainer.get_children():
		oldItem.queue_free()
	for item in available_items[selectedCategory]:
		var itemData = customizationData[selectedCategory][item]
		var instancedItem = list_item.instance()
		instancedItem.name = "ListItem" + str(itemData.id)
		instancedItem.index = itemData.id
		instancedItem.item_name = itemData.description
		instancedItem.image = itemData.img
		instancedItem.animated = itemData.animated
		instancedItem.rarity = itemData.rarity
		if selectedCategory == "eyes":
			for node in get_tree().get_nodes_in_group("global"):
				var result = node.call("get_player_customization_data")
				print('res,: ', result)
				instancedItem.modulation = customizationData["eyes_colors"][result.eyes_color].color
		$Background/ScrollContainer/GridContainer.add_child(instancedItem)

func selected_item(index):
	print('cchanged')
	var data = {}
	data[selectedCategory] = index
	
	get_tree().call_group('global', 'update_customization_data', data)


func _on_Change_Category_pressed(arg):
	selectedCategory = arg
	for category in $Background/Categories.get_children():
		category.self_modulate = Color(1,1,1,1)
		if category.name == 'Pill_' + arg:
			category.self_modulate = Color(0.2,0.8,0.8,1)
	print('selectedCategory: ', selectedCategory)
	populate_category()
