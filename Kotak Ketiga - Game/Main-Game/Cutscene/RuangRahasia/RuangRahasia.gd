extends Node

@onready var cut = $AnimationPlayer
@onready var label = $Label
@onready var timer = $Timer

var subtitles = []
var subtitle_index = 0

func _ready():
	load_subtitles("res://Assets/Story/Cutscene-RuangRahasia.txt")
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
	if subtitle_index >= subtitles.size():
		return
	
	var anim_time = cut.current_animation_position
	var next_sub = subtitles[subtitle_index]
	
	if anim_time >= next_sub["time"]:
		show_subtitle(next_sub["text"])
		subtitle_index += 1

func show_subtitle(text):
	label.text = text
	timer.start()  # restart timer setiap ada subtitle baru

func _on_timer_timeout():
	label.text = ""
