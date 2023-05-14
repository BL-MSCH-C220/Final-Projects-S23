extends Node2D


func _ready():
	pass


func _on_Play_pressed():
	Global.playback = $Music.get_playback_position()
	get_tree().change_scene("res://Funeral/Funeral1.tscn")


func _on_Quit_pressed():
	get_tree().quit()
