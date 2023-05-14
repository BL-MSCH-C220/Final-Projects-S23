extends KinematicBody2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		var _scene = get_tree().change_scene("res://UI/End.tscn")
