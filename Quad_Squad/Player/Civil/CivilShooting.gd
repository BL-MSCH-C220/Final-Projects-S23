extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("")

func physics_process(_delta):
	player.shoot()
	if not player.is_on_floor() and not player.detects_ground:
		SM.set_state("In_Air")
	else:
		SM.set_state("Idle")
