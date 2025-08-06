extends Node

func _ready():
	var path = get_tree().current_scene.scene_file_path
	if path.contains("res://Main-Game/Chapter2/Scene-Chapter2/Path-Kantor/StartPointChap2"):
		MusicOffice.playmusic()
