extends KinematicBody2D

var velocity = Vector2.ZERO
export var gravity = 50
export var speed = 50
var dv = Vector2.ZERO 
export var jump = 1800

func _physics_process(_delta):

	dv = Vector2.ZERO
	if Input.is_action_pressed("left"):
		dv.x -= speed
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("right"):
		dv.x += speed
		$AnimatedSprite.flip_h = false
	if is_on_floor() == false:
		dv.y += gravity

	elif is_on_floor() == true:
		velocity.y = 0
		velocity.x = lerp(velocity.x, 0, .1)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		dv.y -= jump
	velocity += dv
	velocity.x = clamp(velocity.x, -300, 300)
	velocity = move_and_slide(velocity, Vector2.UP)
	if not is_on_floor():
		anim("Jump")
	elif abs(velocity.x) < 1:
		anim("Idle")
	elif abs(velocity.x) >= 1:
		anim("Run")
		
	print($AnimatedSprite.animation)
		
func _on_Timer_timeout():
	print(velocity)
	print(is_on_floor())
	
	
func anim(a):
	if $AnimatedSprite.animation != a: $AnimatedSprite.play(a)
