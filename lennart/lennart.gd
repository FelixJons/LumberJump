extends CharacterBody2D

const Speed = 100.0
const JumpVelocity = -400

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
		velocity.y = JumpVelocity
		emit_signal("player_jumped", JumpVelocity)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)

	move_and_slide()
	
	# Print "hi" every time lennart has jumped 30 pixels
	if velocity.y < 0:
		travel_distance -= velocity.y * delta
		print(travel_distance)
	
	if travel_distance > spawn_travel_distance_interval:
		travel_distance = 0
		print("Spawn log")
		emit_signal("player_traveled_spawn_distance")
		
	
	
@onready var initial_y = position.y
var spawn_travel_distance_interval = 80
@onready var travel_distance = 0

