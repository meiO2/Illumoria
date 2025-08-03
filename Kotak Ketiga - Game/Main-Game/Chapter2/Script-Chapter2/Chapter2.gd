extends Node

var blackscreen = preload("res://Main-Game/Chapter2/Scene-Chapter2/Black-Screen.tscn")

func start():
	var screen = blackscreen.instantiate()
	add_child(screen)
	
	screen.position = Vector2(0, 0)
