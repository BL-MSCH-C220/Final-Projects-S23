extends Control


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _on_Continue_pressed():
	get_tree().paused = false
	hide()


func _on_Quit_pressed():
	get_tree().quit()
