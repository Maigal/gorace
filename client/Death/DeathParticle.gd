extends RigidBody2D

var color

func _ready():
	$Sprite.self_modulate = color
