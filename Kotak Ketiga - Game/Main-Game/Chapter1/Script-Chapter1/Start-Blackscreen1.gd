extends Node

@onready var timer = $"../Timer"

func _ready():
	timer.wait_time = 3.0
	timer.start()
	await timer.timeout
	get_tree().change_scene_to_file("res://Main-Game/Chapter1/Scene-Chapter1/PathKantor/Chapter1a.tscn")
