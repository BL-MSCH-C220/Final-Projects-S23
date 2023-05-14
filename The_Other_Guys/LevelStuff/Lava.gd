extends Area2D


func _ready():
	pass


func _on_Lava_body_entered(body):
	if body.name == "Player":
		var lava = get_node_or_null("/root/Game/Sounds/Lava")
		if lava != null:
			lava.play()
		body.queue_free()
