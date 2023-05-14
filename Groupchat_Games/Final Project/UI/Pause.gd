extends Control

func _input(_event):
	if Input.is_action_pressed("pause"):
		get_tree().paused = false
		hide()

func _on_Resume_pressed():
	get_tree().paused = false
	hide()

func _on_Quit_pressed():
	get_tree().quit()
