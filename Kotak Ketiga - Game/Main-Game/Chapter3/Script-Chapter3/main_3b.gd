extends Node

@export var dialog_manager: Node

func _ready():
	if dialog_manager:
		dialog_manager.all_dialog_finished.connect(_on_all_dialog_finished)
		
		var story_file = "res://Main-Game/Chapter3/Story-Chapter3/Chapter3b.txt"
		dialog_manager.start_dialog_from_file(story_file)
	else:
		printerr("ERROR: DialogManager belum di-assign!")

func _on_all_dialog_finished():
	print("Semua dialog selesai! Saatnya pindah scene.")
	get_tree().change_scene_to_file("res://Main-Game/Chapter3/Scene-Chapter3/scenekantor/chapter3b.tscn") #gantiscene
