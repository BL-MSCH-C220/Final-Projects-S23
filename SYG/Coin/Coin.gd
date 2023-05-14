extends Area2D

var score = 10

func _on_Coin_body_entered(body):
	if body.name == "Player":
		var _target = get_tree().change_scene("res://HUD/End_Game.tscn")
