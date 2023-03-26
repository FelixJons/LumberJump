extends CharacterBody2D

var target_position
var initial_position
var move_speed = 1.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var monitoring = true

func _ready():
	initial_position = position
	

func on_player_jumped(jump_velocity):
	var initial_position_on_player_jumped = position
	var jump_height = 0.5 * jump_velocity * jump_velocity / gravity
	target_position = initial_position_on_player_jumped + Vector2(0, jump_height)


func _physics_process(delta):
	if target_position != null:
		position = position.lerp(target_position, move_speed * delta)

