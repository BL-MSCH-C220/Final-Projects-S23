extends Node

onready var SM = get_parent()
onready var player = get_node("../..")
export var velocity = Vector2.ZERO

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Jumping")

func physics_process(delta):
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		var input_vector = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), 1.0)
		player.jump_power.x = clamp(player.jump_power.x + (input_vector.x * player.leap_speed), -player.max_leap, player.max_leap)
	
	if Input.is_action_pressed("jump"):
		player.jump_power.y = clamp(player.jump_power.y - player.jump_speed, -player.max_jump, 0)
		SM.set_state("Jumping")
	else:
		player.velocity += player.jump_power
		SM.set_state("Falling")
	
	if player.is_on_floor():
		player.jump_power.y = 0
		if player.velocity.y > 0:
			SM.set_state("Landing")
		else:
			SM.set_state("Idle")

		player.velocity.y = 0
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			SM.set_state("Moving")
		else:
			SM.set_state("Idle")
	player.velocity = move_and_slide (player.velocity, Vector2.UP)
