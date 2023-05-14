extends Node

onready var SM = get_parent()
onready var enemy = get_node("/root/Game/Enemy_Container/King")

func _ready():
	yield(enemy, "ready")

func start():
	print("die")
	enemy.set_animation("Die")
	enemy.velocity = Vector2.ZERO
	enemy.collision_layer = 0
	enemy.collision_mask = 0
	$Die.play()
