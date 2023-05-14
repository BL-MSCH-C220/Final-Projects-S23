extends Node2D


func _ready():
	pass


func _on_Cont_pressed():
	get_tree().change_scene("res://First/First2.tscn")
"res://Assets/Awkward Jazz.mp3"

func _on_Quit_pressed():
	get_tree().quit()
