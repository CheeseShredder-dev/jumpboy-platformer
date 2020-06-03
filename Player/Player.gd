extends KinematicBody2D

const speed = 500
var movement = Vector2()
var airbound = false
const gravity = Vector2(0, 50)
const jump_force = 1200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _physics_process(delta):
	
	
	#This script handles input and movement
	if Input.is_action_pressed("ui_right"):
		movement.x = 1 * speed
	elif Input.is_action_pressed("ui_left"):
		movement.x = -1 * speed
	else:
		movement.x = 0
	
	if Input.is_action_pressed("ui_up") and airbound == false:
		airbound = true
		movement.y = -1 * jump_force
	
	
	#This part plays the right animations
	if airbound:
		$AnimatedSprite.play("jumping")
	elif movement.x:
		$AnimatedSprite.play("walk_right")
	else:
		$AnimatedSprite.play("stand_right")
	
	if movement.x  > 0:
		$AnimatedSprite.flip_h = false
	elif movement.x < 0:
		$AnimatedSprite.flip_h = true
	
	
	#This moves the player along the vector 'movement'
	move_and_slide(movement, Vector2(0, -1))
	
	
	#This checks wether the player is in mid-air or not and updates the
	#	'airbound' variable 
	if not is_on_floor():
		airbound = true
	else:
		airbound = false
		movement.y = 0
	
	
	#This makes the player not gain speed while standing on the ground
	if is_on_ceiling():
		movement.y = 0
		movement.y += gravity.y
	else:
		movement.y += gravity.y
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
