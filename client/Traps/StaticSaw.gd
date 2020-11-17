extends Trap

export var rotation_speed = 10

func _process(delta):
	rotation_degrees += rotation_speed
