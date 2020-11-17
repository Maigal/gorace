extends Node2D

class_name Trap

export(String, "static", "pendulum", "horizontal") var type = "static"
export var force = 0

func on_player_collision():
	get_tree().call_group("player", "on_hit_trap", force, $TrapCenter.global_position)
