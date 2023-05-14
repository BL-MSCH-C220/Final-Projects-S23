extends KinematicBody2D

onready var SM = $StateMachine

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1
var reverse = false
export var gravity = Vector2()
export var damage = 1

export var move_speed = 0
export var max_move = 0

export var jump_speed = 0
export var max_jump = 0

export var leap_speed = 100


var moving = false
var is_jumping = false
var double_jumped = false
var jump_reset = false
var should_direction_flip = true # whether or not player controls (left/right) can flip the player sprite


func _physics_process(_delta):
	velocity.x = clamp(velocity.x,-max_move,max_move)
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite.flip_h: 
			$AnimatedSprite.flip_h = true
			$Attack.cast_to.x = -1*abs($Attack.cast_to.x)
			$AnimatedSprite.offset.x = -5
		if direction > 0 and $AnimatedSprite.flip_h: 
			$AnimatedSprite.flip_h = false
			$Attack.cast_to.x = abs($Attack.cast_to.x)
			$AnimatedSprite.offset.x = 0
	
	if is_on_floor():
		double_jumped = false

	if Input.is_action_just_pressed("reverse"):
		var sound = get_node_or_null("/root/Game/Sounds/Reverse")
		if sound != null:
			sound.play()
		if reverse == true:
			reverse = false
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.offset.y = 0
		elif reverse == false:
			reverse = true
			SM.set_state("Idle")
			$AnimatedSprite.flip_v = true
			$AnimatedSprite.offset.y = 14

	if not Input.is_action_pressed("jump"):
		jump_reset = true

	if Input.is_action_just_pressed("attack"):
			SM.set_state("Attack")

	if reverse:
		gravity = Vector2(0,10)
		jump_speed = -40
		max_jump = -200
		move_speed = 30
		max_move = 150
	else:
		gravity = Vector2(0,15)
		jump_speed = 30
		max_jump = 100
		move_speed = 40
		max_move = 150

	if position.y <= -150 or position.y >= 700:
		die()


func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	if reverse == false:
		return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)
	elif reverse == true:
		return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),-1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1

func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func attack():
	if $Attack.is_colliding():
		var target = $Attack.get_collider()
		if target.has_method("hit"):
			var punch = get_node_or_null("/root/Game/Sounds/Attack")
			if punch != null:
				punch.play()
			target.hit(damage)

func hit(d):
	if $Invincible.is_stopped():
		$Invincible.start()
		var Hit = get_node_or_null("/root/Game/Sounds/Hit")
		if Hit != null:
			Hit.play()
		Global.update_health(d)
		$Effects.play("Hurt")
		$Effects.queue("Flash")
		if Global.health <= 0:
			SM.set_state("Dead")

func die():
	queue_free()

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Dead":
		queue_free()
	if $AnimatedSprite.animation == "Attack":
		SM.set_state("Idle")

func _on_Invincible_timeout():
	$Effects.play("Normal")
