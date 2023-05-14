extends Node2D


func _ready():
	$Music.play(Global.playback)


func _on_Cont_pressed():
	get_tree().change_scene("res://Between/Between6.tscn")


func _on_Quit_pressed():
	get_tree().quit()
