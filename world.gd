extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Node path syntax, shorthand for get_node("Lennart")
	#$Lennart.player_jumped.connect($Log.on_player_jumped)
	for l in get_tree().get_nodes_in_group("Logs"):
		$Lennart.player_jumped.connect(l.on_player_jumped)

#func activate_smart_bomb():
	#get_tree().call_group("enemies", "explode")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
