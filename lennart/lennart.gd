extends CharacterBody2D

signal player_jumped
signal player_traveled_spawn_distance

const HORIZONTAL_SPEED = 100.0
const DECELERATION = 100.0
const JUMP_VELOCITY = -400

var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Formula for maximum height of a projectile above its launch position.
# Depends only on the vertical component of the initial velocity, i.e. the
# y component. 
@onready var jump_height = 0.5 * JUMP_VELOCITY * JUMP_VELOCITY / _gravity

func _physics_process(delta: float) -> void:
	# Apply gravity to the player when player is in the air.
	if not is_on_floor():
		velocity.y += _gravity * delta
		
	# Apply an impulse (sort of) to the player to make it jump when it touches 
	# the floor. 
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		emit_signal("player_jumped", jump_height)

	# Debug function to reset the player in the middle of the screen. 
	if Input.is_action_just_pressed("ui_accept"):
		reset()
	
	horizontal_move()	
	move_and_slide()

func horizontal_move() -> void:
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	# If the input vector is non-zero, set the horizontal speed with the input
	# direction. 
	if horizontal_direction != 0:
		velocity.x = horizontal_direction * HORIZONTAL_SPEED
	# Else decelerate the x component of the velocity vector to 0. 
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
	# Handles player positioning when going outside the screen horizontally.
	position.x = wrapf(position.x, 0, 180)
	
func reset() -> void:
	velocity = Vector2(0,0)
	var camera_position = get_viewport().get_camera_2d().global_position
	position = camera_position
