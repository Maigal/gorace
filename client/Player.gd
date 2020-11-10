extends KinematicBody2D

const MOVE_SPEED = 300
const JUMP_FORCE = 700
const GRAVITY = 30
const MAX_FALL_SPEED = 1000
const WALL_SLIDE_ACCELERATION = 10
const MAX_WALL_SLIDE_SPEED = 120

onready var anim_player = $AnimationPlayer

var y_velocity = 0
var x_velocity = 0
var isWallSliding = false
var wallJumpKnockback = 0
var canWallJump = true
var player_direction = 1

func _ready():
	pass
	
func _physics_process(delta):
	
	if wallJumpKnockback > 0:
		wallJumpKnockback -= 2
	elif wallJumpKnockback < 0:
		wallJumpKnockback += 2	
		
	var isGrounded = is_on_floor()
	
	if isGrounded:
		if wallJumpKnockback != 0:
			wallJumpKnockback = 0
		if canWallJump == false:
			canWallJump = true
			
	
	var movementX_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	moveX(movementX_direction)

	moveY(isGrounded)
	
	x_velocity = movementX_direction
	
	animate(movementX_direction, isGrounded)
		
func moveX(direction):
	move_and_slide(Vector2((direction * MOVE_SPEED) + wallJumpKnockback, y_velocity), Vector2.UP)
	if direction != 0:
		if direction > 0:
			player_direction = 1
			
		elif direction < 0:
			player_direction = -1
			
		$Rig.scale.x = player_direction
	
func moveY(isGrounded):
	

	if isGrounded and y_velocity > 0:
		y_velocity = 0
	elif is_on_ceiling():
		y_velocity = 1		
		
	if is_on_wall() && (Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left")):
		if y_velocity >= 0:
			y_velocity = min(y_velocity + WALL_SLIDE_ACCELERATION, MAX_WALL_SLIDE_SPEED)
			isWallSliding = true
		else:
			y_velocity += GRAVITY
			isWallSliding = false
	else:
		y_velocity += GRAVITY
		isWallSliding = false
	
		
	if y_velocity > MAX_FALL_SPEED:
		y_velocity = MAX_FALL_SPEED
	
	print(is_on_wall())	
		
	if isGrounded  and Input.is_action_just_pressed("jump"):
		y_velocity = -JUMP_FORCE
	elif is_on_wall() and Input.is_action_just_pressed("jump") and canWallJump:
		y_velocity = -JUMP_FORCE * 0.65
		wallJumpKnockback = 200 * -player_direction
		
		
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
