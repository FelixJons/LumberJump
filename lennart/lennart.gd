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
	
	if direction:
		velocity.x = direction * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)

	move_and_slide()
	
	# Check if player is moving upwards
	if velocity.y < 0:
		pass

