extends Control


onready var animation_player = $AnimationPlayer
onready var quit_prompt = $ConfirmationDialog
onready var quit_button = $QuitButton
onready var play_button = $PlayButton

var level_name = "LEVEL ONE"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


#When the play button is pressed
func _on_PlayButton_pressed():
	
	#Loads the level
	var level_scene = load("res://Scenes/Level_1_.tscn")
	
	#Loads the scene_changer scene
	var scene_changer_scene = load("res://Scenes/scene_changer.tscn")
	
	#Instances the scene_changer scene
	var scene_changer_node = scene_changer_scene.instance()
	
	#Adds it as a child of '/root'
	get_node("/root").add_child(scene_changer_node)
	
	#Runs its 'transit_scene' function and passes it the level's name
	$"/root/CanvasLayer".transit_scene(level_scene.resource_path, level_name)


#When the quit button is pressed
func _on_QuitButton_pressed():
	
	#Displays the popup
	quit_prompt.popup_centered()


#When the confirmation dialogue is confirmed
func _on_ConfirmationDialog_confirmed():
	
	#Quits the application
	self.get_tree().quit()
