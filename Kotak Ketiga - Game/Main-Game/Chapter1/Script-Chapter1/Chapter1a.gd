extends Node

@onready var dialog_manager = $DialogManager
@onready var PakHari = $"Pak Hari/Pak-Hari"
@onready var pakhari = $"Pak Hari"

var last_count = 0
var frame_timer = 0.0
var frame_duration = 0.4
var tween_triggered = false
var start_pos = pakhari.position
var end_pos = Vector2(0, 0)


func _ready():
	var walk_tween = create_tween()
	walk_tween.tween_property(pakhari, "position:x", end_pos.x, 3)

	var bob_tween = create_tween().set_loops(3)
	bob_tween.tween_property(pakhari, "position:y", start_pos.y - 3, 0.5)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	bob_tween.tween_property(pakhari, "position:y", start_pos.y + 3, 0.5)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	walk_tween.finished.connect(_on_walk_finished)

func _process(_delta):
	# main talk animation
	if dialog_manager.check == true:
		PakHari.play("Talk")
	else:
		pass

	if dialog_manager.Line.size() > 0:
		var current_line = dialog_manager.Line[0]
		if current_line == "#2":
			if not tween_triggered:
				var exit_tween = create_tween()
				exit_tween.tween_property(pakhari, "position", start_pos.x, 1.5)

		else:
			tween_triggered = false  # reset supaya bisa jalan lagi di line #2 selanjutnya

func start_exit_tween():
	var end_pos = Vector2(500, pakhari.position.y)  # ganti sesuai posisi keluar


func _on_walk_finished():
	if dialog_manager:
		dialog_manager.all_dialog_finished.connect(_on_all_dialog_finished)
		var story_file = "res://Main-Game/Chapter1/Story-Chapter1/Chapter1a.txt"
		dialog_manager.start_dialog_from_file(story_file)
	else:
		printerr("ERROR: DialogManager belum di-assign!")

func _on_all_dialog_finished():
	print("Dialog selesai, lanjut scene berikutnya.")
	get_tree().change_scene_to_file("res://Main-Game/Chapter3/Scene-Chapter3/scenekantor/chapter3b.tscn")
