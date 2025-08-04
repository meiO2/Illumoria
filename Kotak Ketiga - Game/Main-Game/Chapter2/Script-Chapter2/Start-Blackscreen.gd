extends Node

@onready var timer = $"../Timer"

func _ready():
	timer.wait_time = 3.0
	timer.start()
	await timer.timeout
	get_tree().change_scene_to_file("res://Main-Game/Chapter2/Scene-Chapter2/Chapter2-Beginning-of-The-Day.tscn")
