extends Node2D

var instanceId
var nickname

onready var anim_player = $AnimationPlayer

func playAnimation(anim):
	if anim_player.is_playing() and anim_player.current_animation == anim:
		return
	anim_player.play(anim)
