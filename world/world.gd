extends Node2D

@export var platform_scene: PackedScene
var platform_sprite_size: Vector2
var number_of_platforms_each_spawn = 100
const VIEWPORT_SIZE = Vector2(180,320)

# Called when the node enters the scene tree for the first time.
func _ready():
	var platform = platform_scene.instantiate()
	platform_sprite_size = platform.get_node("Sprite2D").texture.get_size()
	platform.queue_free()
	
	var y_spawn_position = VIEWPORT_SIZE.y - platform_sprite_size.y
	for i in range(number_of_platforms_each_spawn):
		var spawn_position = Vector2(90 - platform_sprite_size.x/2, y_spawn_position)
		spawn_platform(spawn_position)
		y_spawn_position -= 30
	
func spawn_platform(spawn_position):
		var platform = platform_scene.instantiate()
		add_child(platform)
		platform.position = Vector2(spawn_position)
