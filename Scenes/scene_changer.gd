extends CanvasLayer

onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass
#
#func _process(delta):
#	pass

func transit_scene(path):
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade")