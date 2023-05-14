extends Area2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		var _target = get_tree().change_scene("res://Levels/Level2.tscn")
