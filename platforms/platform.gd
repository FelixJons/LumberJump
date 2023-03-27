extends StaticBody2D

func _ready() -> void:
	get_node("VisibleOnScreenNotifier2D").screen_exited.connect(on_screen_exited)
	
func on_screen_exited() -> void:
	queue_free()
