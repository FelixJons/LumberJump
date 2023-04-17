extends Camera2D

@export var player_path: NodePath
var _player

func _ready():
	_player = get_node(player_path)

func _process(_delta):
	if _player.position.y < position.y:
		position.y = _player.position.y
