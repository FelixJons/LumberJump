extends Camera2D

@export var player_path: NodePath
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.y < position.y:
		position.y = player.position.y
