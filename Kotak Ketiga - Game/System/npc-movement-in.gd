extends Node

func _ready():
	var tween = create_tween()
	tween.tween_property($".", "position", Vector2(0,0), 2.5)
 
