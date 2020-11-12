extends Node2D

func _ready():
	get_tree().call_group("global", "on_join_room", "openWorld", "AAAA")
