extends CharacterBody2D

const Speed = 100.0
const JUMP_VELOCITY = -400
@onready var jump_height = 0.5 * JUMP_VELOCITY * JUMP_VELOCITY / gravity

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal player_jumped
signal player_traveled_spawn_distance

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle Jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		emit_signal("player_jumped", jump_height)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("ui_accept"):
		print("pressed")
		velocity = Vector2(0,0)
		position = get_viewport_center_position()
	
	if direction != 0:
		velocity.x = direction * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)

	
	move_and_slide()
	
	position.x = wrapf(position.x, 0, 180)
	
	# Check if player is moving upwards
	if velocity.y < 0:
		pass


func get_viewport_center_position() -> Vector2:
	var viewport = get_viewport()
	var camera = viewport.get_camera_2d()
	var viewport_center_position = viewport.get_visible_rect().size / 2
	
	# This gets the overwritten window size values!
	print(viewport.get_visible_rect().size)


	return viewport_center_position


