extends Node

func _ready():
	var path = get_tree().current_scene.scene_file_path
	if path.contains("res://Main-Game/Chapter1/Scene-Chapter1/PathKantor/StartPointChap1.tscn"):
		ClipboardSinta.show()
	else:
		ClipboardSinta.hide()
