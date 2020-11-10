extends KinematicBody2D

const MOVE_SPEED = 300
const JUMP_FORCE = 700
const GRAVITY = 30
const MAX_FALL_SPEED = 1000

onready var anim_player = $AnimationPlayer

var y_velocity = 0
var x_velocity = 0

func _ready():
	pass
	
func _physics_process(delta):
			
		
	var movementX_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	moveX(movementX_direction)
	
	var isGrounded = is_on_floor()
	moveY(isGrounded)
	
	x_velocity = movementX_direction
	
	animate(movementX_direction, isGrounded)
		
func moveX(direction):
	move_and_slide(Vector2(direction * MOVE_SPEED, y_velocity), Vector2.UP)
	if direction != 0:
		$Rig.scale.x = direction	
	
func moveY(isGrounded):
	
	
	
	if isGrounded and y_velocity > 0:
		y_velocity = 0
	elif is_on_ceiling():
		y_velocity = 1		
		
	y_velocity += GRAVITY
		
	if y_velocity > MAX_FALL_SPEED:
		y_velocity = MAX_FALL_SPEED
	
	print(isGrounded)
		
	if isGrounded and Input.is_action_just_pressed("jump"):
		y_velocity = -JUMP_FORCE
		
func animate(xDirection, isGrounded):
	if isGrounded:
		if xDirection == 0:
			play_animation("idle")
		else:
			play_animation("run")
	else:
		if y_velocity > 5:
			play_animation("fall")
		else: 
			play_animation("jump")

func play_animation(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
