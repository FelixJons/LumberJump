extends Area2D

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(_body):
	queue_free()

