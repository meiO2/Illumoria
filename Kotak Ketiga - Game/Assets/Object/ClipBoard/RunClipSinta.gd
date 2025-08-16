extends Node

func _ready():
	var path = get_tree().current_scene.scene_file_path
	if path.contains("StartPointChap1") or path.contains("StartPointChap2"):
		ClipboardSinta.show()
	else:
		ClipboardSinta.hide()
