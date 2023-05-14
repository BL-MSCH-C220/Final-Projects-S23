extends Node

var health = 10
var score = 0

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func update_health(h):
	health = clamp(health - h, 0, 10)

func update_score(s):
	score += s

func reset():
	score = 0
	health = 10

func _unhandled_input(_event):
	if Input.is_action_just_pressed("menu"):
		var Pause_Menu = get_node_or_null("/root/Game/UI/Pause_Menu")
		if Pause_Menu == null:
			get_tree().quit()
		else:
			if Pause_Menu.visible:
				Pause_Menu.hide()
				get_tree().paused = false
			else:
				Pause_Menu.show()
				get_tree().paused = true
