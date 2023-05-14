extends Control

func _ready():
	$"VBoxContainer/Start Button".grab_focus()


func _on_Start_Button_pressed():
	get_tree().change_scene("res://Level1.tscn")


func _on_Quit_Button_pressed():
	get_tree().quit()
