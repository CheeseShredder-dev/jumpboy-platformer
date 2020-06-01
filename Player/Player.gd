extends KinematicBody2D

const speed = 500
var movement = Vector2()
var airbound = false
const gravity = Vector2(0, 50)
const jump_force = 1200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	
	move_and_slide(movement, Vector2(0, -1))
	
	#This adds gravity
	if is_on_floor():
		airbound = false
		movement.y = 0
	elif is_on_ceiling():
		movement.y = 0
	else:
		movement.y += gravity.y
	
	#This script handles horizontal movement
	if Input.is_action_pressed("ui_right"):
		movement.x = 1 * speed
	elif Input.is_action_pressed("ui_left"):
		movement.x = -1 * speed
	else:
		movement.x = 0
	
	
	#This handles jump
	if Input.is_action_just_pressed("ui_up") and airbound == false:
		airbound = true
		movement.y = -1 * jump_force
	
	
	#This part plays the right animations
	if movement.x > 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk_right")
	elif movement.x < 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk_right")
	else:
		$AnimatedSprite.play("stand_right")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
