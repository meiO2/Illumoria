extends Node

@onready var dialog_manager = $DialogManager
@onready var dialog_box = $DialogManager/CanvasLayer/DialogBox # Path ke node DialogBox
@onready var PakHari = $"Pak Hari/Pak-Hari"
@onready var pakhari = $"Pak Hari"
@onready var BuSintaScene = preload("res://Assets/Character/Bu-Sinta/bu_sinta.tscn")

var tween_triggered = false
var start_pos = Vector2(806, 0)
var end_pos = Vector2(0, 0)
var exit_pos = Vector2(1200, 0)
var bu_sinta_spawned = false

func _ready():
	var walk_tween = create_tween()
	walk_tween.tween_property(pakhari, "position:x", end_pos.x, 3)

	var bob_tween = create_tween().set_loops(3)
	bob_tween.tween_property(pakhari, "position:y", start_pos.y - 3, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	bob_tween.tween_property(pakhari, "position:y", start_pos.y + 3, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	walk_tween.finished.connect(_on_walk_finished)
	dialog_manager.command_triggered.connect(_on_dialog_command)

func _process(_delta):
	if dialog_manager.check:
		PakHari.play("Talk")

func _on_dialog_command(command):
	if command == "#2" and not tween_triggered:
		tween_triggered = true
		dialog_manager.check = false # Hentikan sementara dialog
		_on_pakhari_exit_finished()

func _on_pakhari_exit_finished():
	if not bu_sinta_spawned:
		bu_sinta_spawned = true
		
		# Sembunyikan dialog box
		dialog_box.modulate.a = 0.0
		
		if dialog_box.modulate.a == 0.0:
			var exit_tween = create_tween()
			exit_tween.tween_property(pakhari, "position", exit_pos, 3)
			exit_tween.finished.connect(_on_pakhari_exit_finished)
		

		var bu_sinta = BuSintaScene.instantiate()
		get_parent().add_child(bu_sinta)
		bu_sinta.position = start_pos
		
		# Buat animasi untuk Bu Sinta masuk
		var enter_tween = create_tween()
		enter_tween.tween_property(bu_sinta, "position:x", end_pos.x, 3)
		
		# Hubungkan sinyal ke fungsi baru saat animasi selesai
		enter_tween.finished.connect(_on_businta_enter_finished)

# Fungsi ini dijalankan SETELAH Bu Sinta selesai masuk
func _on_businta_enter_finished():
	dialog_box.modulate.a = 1.0

	dialog_manager.check = true 
	dialog_manager.show_entry(dialog_manager.current_index)


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
