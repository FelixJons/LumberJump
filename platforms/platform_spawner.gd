extends Node

const NUMBER_OF_PLATFORMS: int = 20
const VIEWPORT_SIZE = Vector2i(180,320)

@export var platform_scene: PackedScene
@export var platform_spawn_collision_line_scene: PackedScene

var _platform_sprite_size: Vector2
@onready var _y_spawn_platform_position = VIEWPORT_SIZE.y - _platform_sprite_size.y
@onready var random_number_generator = RandomNumberGenerator.new()

func _ready() -> void:
	_platform_sprite_size = get_platform_sprite_size()
	random_number_generator.randomize()
	generate_platforms(NUMBER_OF_PLATFORMS)

func generate_platforms(number_of_platforms) -> void:
	var platform_spawn_collider_index = number_of_platforms / 10
	
	for i in range(number_of_platforms):
		var x = get_random_int(0, VIEWPORT_SIZE.x - _platform_sprite_size.x)
		var spawn_position = Vector2(x, _y_spawn_platform_position)
		if i == platform_spawn_collider_index:
			set_platform_spawn_collider(spawn_position)
		spawn_platform(spawn_position)
		_y_spawn_platform_position -= get_random_int(_platform_sprite_size.y, 80)
	
	
func set_platform_spawn_collider(position: Vector2i) -> Vector2i:
	var platform_spawn_collider = platform_spawn_collision_line_scene.instantiate()
	var collision_shape_2d = platform_spawn_collider.get_node("CollisionShape2D")
	var shape = collision_shape_2d.shape
	shape.a = Vector2i(0, position.y)
	shape.b = Vector2i(VIEWPORT_SIZE.x, position.y)
	call_deferred("add_child", platform_spawn_collider)
	platform_spawn_collider.body_entered.connect(spawn_platforms)
	return Vector2i(0,0)

# Note to self! When you connect a native engine signal you need to make sure
# that you are matching the signals signature! 
func spawn_platforms(_body):
	generate_platforms(NUMBER_OF_PLATFORMS)

func spawn_platform(spawn_position) -> void:
		var platform = platform_scene.instantiate()
		# Research call_deferred()
		call_deferred("add_child", platform)
		platform.call_deferred("set", "position", Vector2(spawn_position))

		
func get_random_int(min_value, max_value) -> int:
	var random_int = random_number_generator.randi_range(min_value, max_value)
	return random_int
	
func get_platform_sprite_size() -> Vector2i:
	var platform = platform_scene.instantiate()
	_platform_sprite_size = platform.get_node("Sprite2D").texture.get_size()
	platform.queue_free()
	return _platform_sprite_size
