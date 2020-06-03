extends Control

onready var animation_player = $AnimationPlayer
var in_play_label = false
var in_quit_label = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#warning-ignore:unused_argument
func _process(delta):

	if in_play_label and Input.is_action_just_released("ui_accept"):
		var level = load("res://Scenes/Level_1_.tscn")
		var scene_changer = load("res://Scenes/scene_changer.tscn")
		var layer = scene_changer.instance()
		get_node("/root/MainMenu/LevelChangerContainer").add_child(layer)
		$"/root/MainMenu/LevelChangerContainer/CanvasLayer".transit_scene(level.resource_path)
		

func _Play_mouse_entered():
	in_play_label = true
	animation_player.play("option_play_selected")


func _on_Play_mouse_exited():
	in_play_label = false
	animation_player.play_backwards("option_play_selected")


func _on_Quit_mouse_entered():
	in_quit_label = true
	animation_player.play("option_quit_selected")

func _on_Quit_mouse_exited():
	in_quit_label = false
	animation_player.play_backwards("option_quit_selected")
