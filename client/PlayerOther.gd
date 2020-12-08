extends Node2D

var instanceId
var nickname
var isDead = false

onready var anim_player = $AnimationPlayer

func get_other_player_customization_data(data):
	if data.eyes:
		$Rig.change_eyes(data.eyes)
		#customization.eyes = data.player_customization_eyes
		
	if data.color:
		$Rig.change_color(data.color)

func playAnimation(anim):
	if anim_player.is_playing() and anim_player.current_animation == anim:
		return
	anim_player.play(anim)
	
func explode(dirX, dirY, distX, distY, force):
	$DeathController.explode(Vector2(dirX, dirY), Vector2(distX, distY), force, $Rig.get_body_colors())
	die()
	
func die():
	isDead = true
	scale.x = 0
	scale.y = 0
	yield(get_tree().create_timer(4.5), "timeout")
	revive()

func revive():
	isDead = false
	scale.x = 1
	scale.y = 1
