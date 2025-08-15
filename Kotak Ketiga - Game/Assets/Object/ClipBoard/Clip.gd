extends Node

@onready var clip = $Sprite2D2
@onready var nama = $"Sprite2D2/Nama-isi"
@onready var tempat = $"Sprite2D2/Tempat-isi"
@onready var tanggal = $"Sprite2D2/Tanggal-isi"
@onready var pekerjaan = $"Sprite2D2/Pekerjaan-isi"
@onready var nomorkeanggotaan = $"Sprite2D2/NomorKeanggotaan-isi"
@onready var keperluan = $"Sprite2D2/Keperluan-isi"

var at_first_position := true

func _ready():
	nama.visible = Global.nama_visible_set
	tempat.visible = Global.tempat_visible_set
	tanggal.visible = Global.tanggal_visible_set
	pekerjaan.visible = Global.pekerjaan_visible_set
	nomorkeanggotaan.visible = Global.nomorkeanggotaan_visible_set
	keperluan.visible = Global.keperluan_visible_set

	clip.position = Vector2(721.0, 27.146)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_X: 
		if at_first_position:
			clip.position = Vector2(721.0, 27.146)
		else:
			clip.position = Vector2(359.0, 27.146)
		at_first_position = !at_first_position
	elif event is InputEventKey and event.pressed and event.keycode == KEY_W: 
		get_tree().change_scene_to_file("res://Main-Game/Chapter1/Scene-Chapter1/PathKantor/Chapter1a.tscn")

func _on_nama_pressed() -> void:
	nama.visible = true
	Global.nama_visible_set = true

func _on_tempat_pressed() -> void:
	tempat.visible = true
	Global.tempat_visible_set = true

func _on_tanggal_lahir_pressed() -> void:
	tanggal.visible = true
	Global.tanggal_visible_set = true

func _on_nomor_keanggotaan_pressed() -> void:
	nomorkeanggotaan.visible = true
	Global.nomorkeanggotaan_visible_set = true

func _on_keperluan_pressed() -> void:
	keperluan.visible = true
	Global.keperluan_visible_set = true

func _on_pekerjaan_pressed() -> void:
	pekerjaan.visible = true
	Global.pekerjaan_visible_set = true
