extends KinematicBody2D

const MOVE_SPEED = 300
const JUMP_FORCE = 700
const GRAVITY = 30
const MAX_FALL_SPEED = 1000
const WALL_SLIDE_ACCELERATION = 10
const MAX_WALL_SLIDE_SPEED = 120
const MAX_WALL_JUMP_KNOCKBACK = 200

onready var anim_player = $AnimationPlayer
onready var leftCollider = $Colliders/WallCollider_Left
onready var rightCollider = $Colliders/WallCollider_Right

var y_velocity = 0
var x_velocity = 0
var isWallSliding = false
var wallJumpKnockback = 0
var wallJumpDirection = 1
var canWallJump = true
var player_direction = 1

func _ready():
	pass
	
func _physics_process(delta):
	
	
	if wallJumpKnockback > 0:
		wallJumpKnockback -= 4
	elif wallJumpKnockback < 0:
		wallJumpKnockback += 4	
		
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
	var knockbackMovespeed = 1
	if (wallJumpKnockback != 0):
		if (wallJumpDirection != player_direction):
			if wallJumpDirection == 1:
				knockbackMovespeed = max((wallJumpKnockback * 100 / MAX_WALL_JUMP_KNOCKBACK), 1)
			elif wallJumpDirection == -1:
				knockbackMovespeed = min((wallJumpKnockback * 100 / MAX_WALL_JUMP_KNOCKBACK), -1)
		else:
			knockbackMovespeed = 2
			
	
	
	move_and_slide(Vector2((direction * (MOVE_SPEED / knockbackMovespeed)) + wallJumpKnockback, y_velocity), Vector2.UP)
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
	
#	print(is_on_wall())	

	var wallCollider = null
	if rightCollider.is_colliding() and rightCollider.get_collider().is_in_group("terrain"):
		wallCollider = "right"
	elif leftCollider.is_colliding() and leftCollider.get_collider().is_in_group("terrain"):
		wallCollider = "left"
		
	if isGrounded  and Input.is_action_just_pressed("jump"):
		y_velocity = -JUMP_FORCE
	elif wallCollider and Input.is_action_just_pressed("jump") and (canWallJump or wallJumpDirection != -player_direction):
		var dir
		if wallCollider == "right":
			dir = -1
		elif wallCollider == "left":
			dir = 1
		y_velocity = -JUMP_FORCE * 0.65
		wallJumpKnockback = MAX_WALL_JUMP_KNOCKBACK * dir
		wallJumpDirection = 1 * dir
		canWallJump = false
		
		
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
