extends Node

var playback = 0

func _unhandled_input(_event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
