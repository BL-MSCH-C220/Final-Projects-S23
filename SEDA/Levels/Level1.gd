extends Node2D


func _physics_process(_delta):
	var c = get_node_or_null("Player")
	if c != null:
		$Camera2D.position.y = c.position.y
