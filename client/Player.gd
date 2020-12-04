extends KinematicBody2D

const MOVE_SPEED = 300
const JUMP_FORCE = 675
const GRAVITY = 30
const MAX_FALL_SPEED = 1000
const WALL_SLIDE_ACCELERATION = 10
const MAX_WALL_SLIDE_SPEED = 120
const MAX_WALL_JUMP_KNOCKBACK = 225

var isInLobby = false

onready var anim_player = $AnimationPlayer
onready var leftCollider = $Colliders/WallCollider_Left
onready var rightCollider = $Colliders/WallCollider_Right

var customizationData = {
	colors = [
		{
			body = Color(1,1,1,1),
			legs = Color(1,1,1,1)
		},
		{
			body = Color(0.8,0.2,0.2,1),
			legs = Color(0.8,0.2,0.2,1)
		}
	]
}

var customization = {
	color = 0,
	eyes = 0,
	nickname = ""
}

var y_velocity = 0
var x_velocity = 0
var isWallSliding = false
var wallJumpKnockback = 0
var wallJumpDirection = 1
var canWallJump = true
var player_direction = 1
var current_animation = "idle"

var isDead = false

func get_player_customization_data(data):
	if data.nickname:
		customization.nickname = data.nickname
		

	if data.player_customization_eyes:
		$Rig.change_eyes(data.player_customization_eyes)
		#customization.eyes = data.player_customization_eyes
		
	if data.player_customization_color:
		$Rig.change_color(data.player_customization_color)

func _ready():
	pass
	
func _physics_process(delta):
	
	
	if wallJumpKnockback > 0:
		wallJumpKnockback -= 5
	elif wallJumpKnockback < 0:
		wallJumpKnockback += 5	
		
	var isGrounded = is_on_floor()
	var wallCollider = null
	if rightCollider.is_colliding() and rightCollider.get_collider().is_in_group("terrain"):
		wallCollider = "right"
	elif leftCollider.is_colliding() and leftCollider.get_collider().is_in_group("terrain"):
		wallCollider = "left"
	
	if isGrounded && !wallCollider:
		if wallJumpKnockback != 0:
			wallJumpKnockback = 0
		if canWallJump == false:
			canWallJump = true
			
	
	var movementX_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if !isDead:
		
		
		moveX(movementX_direction)
	
		moveY(isGrounded, wallCollider)
		
		x_velocity = movementX_direction
		
		animate(movementX_direction, isGrounded)
	
	
	
	if !isInLobby:
		var update_data = {
			x= position.x,
			y= position.y,
			animation= current_animation,
			dir= player_direction
		}
		get_tree().call_group("global", "update_player", update_data)
	
		
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
	
func moveY(isGrounded, wallCollider):
	

	if isGrounded and y_velocity > 0:
		y_velocity = 0
	elif is_on_ceiling():
		y_velocity = 1		
		
	if (wallCollider == "right" && Input.is_action_pressed("move_right")) || (wallCollider == "left" && Input.is_action_pressed("move_left")):
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
	
	if Input.is_action_just_released("jump") && y_velocity < 0:
		y_velocity = y_velocity / 2;
#	print(is_on_wall())	

	
		
	if isGrounded  and Input.is_action_just_pressed("jump"):
		y_velocity = -JUMP_FORCE
	elif wallCollider and Input.is_action_just_pressed("jump"):
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
		if isWallSliding:
			play_animation("wallslide")
		else:
			if y_velocity > 5:
				play_animation("fall")
			else: 
				play_animation("jump")

func play_animation(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	current_animation = anim_name
	
func on_hit_trap(force, trap_position):
	print('force', force)
	print('pos', trap_position)
	var xdir = -1 if trap_position.x > position.x else 1
	var ydir = 1 if trap_position.y > position.y else -1
	var xdist =  position.x - trap_position.x
	var ydist =  position.y - trap_position.y
	explode(xdir, ydir, xdist, ydist, force)
	$PlayerCamera/ScreenShake.start(0.5, 40,20, 0)

func explode(dirX, dirY, distX, distY, force):
	print('dir', dirX, dirY)
	print('distx ', distX, ' disty ', distY)
	$DeathController.explode(Vector2(dirX, dirY), Vector2(distX, distY), force)
	get_tree().call_group("global", "on_player_death", dirX, dirY, distX, distY, force)
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
	var checkpoint =  get_tree().get_root().find_node("Checkpoint", true, false)
	var y_velocity = 0
	var x_velocity = 0
	var isWallSliding = false
	position.x = checkpoint.position.x
	position.y = checkpoint.position.y
	
