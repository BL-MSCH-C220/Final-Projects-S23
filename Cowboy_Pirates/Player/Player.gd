extends KinematicBody2D

onready var SM = $StateMachine

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1

var flipped=false

export var gravity = Vector2(0,30)

export var move_speed = 20
export var max_move = 300

export var jump_speed = 200
export var max_jump = 500


var moving = false
var is_jumping = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite


func _physics_process(_delta):
	if Input.is_action_just_pressed("flip"):
		max_jump*=-1
		jump_speed*=-1
		velocity.y=0
		if flipped==false:
			gravity=Vector2(0,-30)
			$Floor.rotation_degrees=180
			$AnimatedSprite.flip_v=true
			$AnimatedSprite.position.y=6
			flipped=true
		elif flipped==true:
			gravity=Vector2(0,30)
			$Floor.rotation_degrees=0
			$AnimatedSprite.flip_v=false
			$AnimatedSprite.position.y=-4
			flipped=false
		
	velocity.x = clamp(velocity.x,-max_move,max_move)
		
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite.flip_h: 
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.position.x=-10
		if direction > 0 and $AnimatedSprite.flip_h: 
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.position.x=10
	
	
	if position.y > 1500:
		queue_free()
		

func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),0.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1

func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func is_on_floor():
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			return true
	return false



func die():
	queue_free()









func _on_Level_2_Exit_body_entered(body):
	if body.name == "Player":
		var _scene = get_tree().change_scene("res://Level3.tscn")


func _on_Level_1_Exit_body_entered(body):
	if body.name=="Player":
		var _scene = get_tree().change_scene("res://Level2.tscn")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		var _scene = get_tree().change_scene("res://End_Screen.tscn")
