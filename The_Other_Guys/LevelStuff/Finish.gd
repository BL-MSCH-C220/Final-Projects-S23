extends Area2D


func _ready():
	pass

func _on_Finish_body_entered(body):
	if body.name == "Player":
		var _scene = get_tree().change_scene("res://UI/End_Screen.tscn")
