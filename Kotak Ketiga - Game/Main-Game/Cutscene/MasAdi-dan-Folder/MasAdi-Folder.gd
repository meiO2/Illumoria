extends Node

@onready var cut = $AnimationPlayer
@onready var label = $Label

var pause_points = [2.5, 3.6, 4.0, 4.6, 6.5, 8.5, 12.5, 18.0]
var current_pause_index = 0
var is_waiting = false

var subtitles = []
var subtitle_index = 0
var showing_subtitle = false

func _ready():
	load_subtitles("res://Assets/Story/Cutscene-MasAdi&Folder.txt")
	label.text = ""
	label.visible = true
	cut.play("Cutscene")
	process_mode = Node.PROCESS_MODE_ALWAYS

func load_subtitles(path):
	var file = FileAccess.open(path, FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line()
		if "|" in line:
			var parts = line.split("|", false, 2)
			var time = float(parts[0])
			var text = parts[1]
			subtitles.append({ "time": time, "text": text })
	file.close()

func _process(delta):
	var anim_time = cut.current_animation_position
	
	if !is_waiting and current_pause_index < pause_points.size():
		var pause_time = pause_points[current_pause_index]
		if anim_time >= pause_time:
			cut.pause()
			is_waiting = true
			
	if subtitle_index < subtitles.size():
		var subtitle_time = subtitles[subtitle_index]["time"]
		if anim_time >= subtitle_time:
			label.text = subtitles[subtitle_index]["text"]
			showing_subtitle = true
			subtitle_index += 1

func _input(event):
	if is_waiting:
		if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT) or event.is_action_pressed("ui_accept"):
			is_waiting = false
			current_pause_index += 1
			cut.play()
			if showing_subtitle:
				label.text = ""
				showing_subtitle = false
