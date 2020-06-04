extends CanvasLayer

onready var animation_player = $AnimationPlayer
onready var level_name_label = $LevelName

#func _ready():
#	animation_player.play_backwards("fade")
#
#func _process(delta):
#	pass

func transit_scene(path, level_name = "DEFAULTLEVEL"):
	
	level_name_label.text = level_name
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	self.queue_free()