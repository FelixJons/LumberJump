extends Node2D

@export var platform_scene: PackedScene
const NUMBER_OF_PLATFORMS = 100
const VIEWPORT_SIZE = Vector2(180,320)
var platform_sprite_size: Vector2
@onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var platform = platform_scene.instantiate()
	platform_sprite_size = platform.get_node("Sprite2D").texture.get_size()
	
	# Research difference between .free() and queue_free()
	platform.queue_free()
	
	var y_spawn_position = VIEWPORT_SIZE.y - platform_sprite_size.y
	
	rng.randomize()
	
	generate_platforms(NUMBER_OF_PLATFORMS)
	
func generate_platforms(number_of_platforms) -> void:
	var y_spawn_position = VIEWPORT_SIZE.y - platform_sprite_size.y
	for i in range(NUMBER_OF_PLATFORMS):
		var x = get_random_int(0,VIEWPORT_SIZE.x - platform_sprite_size.x)
		var spawn_position = Vector2(x, y_spawn_position)
		spawn_platform(spawn_position)
		y_spawn_position -= get_random_int(platform_sprite_size.y, 80)
		
func spawn_platform(spawn_position) -> void:
		var platform = platform_scene.instantiate()
		add_child(platform)
		platform.position = Vector2(spawn_position)
		
func get_random_int(min_value, max_value) -> int:
	var random_int = rng.randi_range(min_value, max_value)
	return random_int
	
