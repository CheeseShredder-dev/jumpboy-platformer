extends KinematicBody2D

signal level_completed

var speed = 500
var movement = Vector2()
var airbound = false
var gravity = Vector2(0, 50)
var jump_force = 1200
var label_node
var timer = Timer.new()
var jump_activated = true


func _ready():
	label_node = get_node("WinLabel")




func _process(delta):
	print(airbound)
	pass



func _physics_process(delta):
	move_character()


func move_character():
	
	
	#This script handles input and movement
	if Input.is_action_pressed("ui_right"):
		movement.x = 1 * speed
	elif Input.is_action_pressed("ui_left"):
		movement.x = -1 * speed
	else:
		movement.x = 0
	
	if Input.is_action_pressed("ui_up") and airbound == false and jump_activated:
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
	#'airbound' variable 
	if is_on_floor():
		airbound = false
		movement.y = 0
	else:
		airbound = true
	
	
	#This makes the player not gain speed while standing on the ground
	if is_on_ceiling():
		movement.y = 0
		movement.y += gravity.y
	else:
		movement.y += gravity.y


func _on_Area2D_body_entered(body):
	
	#Checks if the player has entered the Area2D
	if body == self:
		
		#sets both gravity and speed to half their original value for slow-mo effect
		#and makes it impossible for the player to jump
#		gravity = Vector2(0, 25)
		speed = 200
		jump_activated = false
		
		#Displays the label node with the message 'You Win'
		label_node.visible = true
		
		timer.set_wait_time(1)
		add_child(timer)
		timer.start()
		yield(timer, "timeout")
		
		set_physics_process(false)
		
		#Plays the right animation
		$AnimatedSprite.play("stand_right")
		
		emit_signal("level_completed")
