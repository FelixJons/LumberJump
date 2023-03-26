extends Node2D

@export var log_scene: PackedScene
#const VIEWPORT_sprite_size = get_viewport().sprite_size.x/2


func _ready():
	var log = log_scene.instantiate()
	add_child(log)
	var sprite = log.get_node("Sprite2D")

	var sprite_size_scaled = sprite.texture.get_size()
	
	print(sprite_size_scaled.x)
	
	log.position = Vector2(90 - (sprite_size_scaled.x / 2), 0)
	#enemy.position = DisplayServer.screen_get_sprite_size()
	
	
