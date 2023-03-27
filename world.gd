extends Node2D

@export var log_scene: PackedScene
var sprite_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	for log in get_tree().get_nodes_in_group("Logs"):
		$Lennart.player_jumped.connect(log.on_player_jumped)
		
	# Set spawn position
	var log = log_scene.instantiate()
	var sprite = log.get_node("Sprite2D")
	sprite_size = sprite.texture.get_size()
	$Lennart.player_traveled_spawn_distance.connect(spawn_platform)
	
	

func spawn_platform():
		var log = log_scene.instantiate()
		add_child(log)
		print(sprite_size.x)
		$Lennart.player_jumped.connect(log.on_player_jumped)
		log.position = Vector2(90 - sprite_size.x/2, 0)

	

