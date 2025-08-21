extends Node

@onready var dialog_manager = $DialogManager
@onready var dialog_box = $DialogManager/CanvasLayer/DialogBox
@onready var PakHari = $"Pak Hari/Pak-Hari"
@onready var pakhari = $"Pak Hari"
@onready var BuSintaScene = preload("res://Assets/Character/Bu-Sinta/bu_sinta.tscn")
@onready var meja_scene = $detailmeja/Meja
@onready var folder = $detailmeja
@onready var tutorial_page = $"Meja-Kantor-Mas-Adi/Tutorial/CanvasLayer3"
@onready var tutorial_node = $"Meja-Kantor-Mas-Adi/Tutorial"
@onready var tutorial_button = $"Meja-Kantor-Mas-Adi/Tutorial/item"
@onready var foldersinta = $Foldermejadepan

var tween_triggered = false
var start_pos = Vector2(806, 0)
var end_pos = Vector2(0, 0)
var exit_pos = Vector2(1200, 0)
var bu_sinta_spawned = false
var bu_sinta = null
var is_waiting_for_tutorial = false

var meja_instance: Node = null 

func _ready():
	folder.visible = false
	foldersinta.visible = false
	var walk_tween = create_tween()
	walk_tween.tween_property(pakhari, "position:x", end_pos.x, 3)

	var bob_tween = create_tween().set_loops(3)
	bob_tween.tween_property(pakhari, "position:y", pakhari.position.y - 3, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	bob_tween.tween_property(pakhari, "position:y", pakhari.position.y + 3, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	walk_tween.finished.connect(_on_walk_finished)
	dialog_manager.command_triggered.connect(_on_dialog_command)
	
	tutorial_page.visible = false

func _process(_delta):
	if is_waiting_for_tutorial:
		if not tutorial_page.visible:
			is_waiting_for_tutorial = false
			_on_tutorial_selesai()

	if dialog_manager.check:
		PakHari.play("Talk")
		if bu_sinta != null:
			bu_sinta.get_node("Bu-Sinta").play("Talk")

func _on_dialog_command(command):
	if command == "#1":
		dialog_manager.check = false
		dialog_box.modulate.a = 0.0
		
		tutorial_page.visible = true
		tutorial_button.visible = false
		
		is_waiting_for_tutorial = true
		print("Tutorial diaktifkan oleh dialog #1")

	if command == "#2" and not tween_triggered:
		tween_triggered = true
		_start_character_swap()
		
	if command == "#3":
		foldersinta.visible = true

func _on_tutorial_button_pressed():
	print("Tombol tutorial ditekan.")
	tutorial_button.disabled = true
	tutorial_button.text = "Sudah diklik"

func _start_character_swap():
	if not bu_sinta_spawned:
		bu_sinta_spawned = true
		dialog_manager.check = false
		dialog_box.modulate.a = 0.0

		var exit_tween = create_tween()
		exit_tween.tween_property(pakhari, "position", exit_pos, 3)
		await exit_tween.finished

		
		bu_sinta = BuSintaScene.instantiate()
		get_node("place").add_child(bu_sinta)
		bu_sinta.position = start_pos
		var enter_tween = create_tween()
		enter_tween.tween_property(bu_sinta, "position:x", end_pos.x, 3)
		await enter_tween.finished
		
		_on_businta_enter_finished()

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

func _on_tutorial_selesai():
	print("Tutorial selesai, melanjutkan dialog.")
	dialog_manager.check = true
	dialog_box.modulate.a = 1.0
	dialog_manager.show_entry(dialog_manager.current_index)

func _on_all_dialog_finished():
	print("Dialog selesai, lanjut scene berikutnya.")
	get_tree().change_scene_to_file("res://Main-Game/Chapter3/Scene-Chapter3/scenekantor/chapter3b.tscn")

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_W:
		print("Tutup Meja")
		meja_scene.visible = false
		folder.visible = false

	if event is InputEventKey and event.pressed and event.keycode == KEY_S:
		print("Buka Meja")
		meja_scene.visible = true
		folder.visible = true
	if foldersinta.visible == true:
		if event is InputEventKey and event.pressed and event.keycode == KEY_F:
			if meja_instance == null:
				$Foldermejadepan.visible = false
				folder.visible = true
