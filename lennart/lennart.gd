extends CharacterBody2D

signal player_jumped
signal player_traveled_spawn_distance
signal player_moving_upwards

const Speed = 100.0
const JUMP_VELOCITY = -400

var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var jump_height = 0.5 * JUMP_VELOCITY * JUMP_VELOCITY / _gravity

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += _gravity * delta
		
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		emit_signal("player_jumped", jump_height)

	if Input.is_action_just_pressed("ui_accept"):
		velocity = Vector2(0,0)
		position = get_viewport_center_position()
	
	position.x = wrapf(position.x, 0, 180)
	
	if velocity.y < 0:
		pass
	
	horizontal_move()	
	move_and_slide()

func horizontal_move() -> void:
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	if horizontal_direction != 0:
		velocity.x = horizontal_direction * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)

func get_viewport_center_position() -> Vector2:
	var viewport = get_viewport()
	var viewport_center_position = viewport.get_visible_rect().size / 2
	
	# This gets the overwritten window size values!
	#print(viewport.get_visible_rect().size)


	return viewport_center_position


