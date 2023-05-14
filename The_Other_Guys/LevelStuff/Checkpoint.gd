extends StaticBody2D

onready var Spawn = get_node_or_null("/root/Game/Player_Container")
var points = true

func _ready():
	$AnimatedSprite.play("Inactive")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if points:
			Global.update_score(50)
		points = false
		$AnimatedSprite.play("Active")
		Spawn.initial_position = position
