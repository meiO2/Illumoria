extends Node

@onready var cut = $AnimationPlayer

var pause_points = [3.6, 6.0, 7.5]
var current_pause_index = 0
var is_waiting = false

func _ready():
	cut.play("Cutscene2")

func _process(delta):
	if !is_waiting and current_pause_index < pause_points.size():
		var pause_time = pause_points[current_pause_index]
		if cut.current_animation_position >= pause_time:
			cut.pause()
			is_waiting = true

func _input(event):
	if is_waiting:
		if ( event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT or event.is_action_pressed("ui_accept")):
			is_waiting = false
			current_pause_index += 1
			cut.play()
