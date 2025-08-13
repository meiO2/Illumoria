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
	nama.visible = false
	tempat.visible = false
	tanggal.visible = false
	pekerjaan.visible = false
	nomorkeanggotaan.visible = false
	keperluan.visible = false
	

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_X: 
		if at_first_position:
			clip.position = Vector2(721.0, 27.146)
		else:
			clip.position = Vector2(359.0, 27.146)

		at_first_position = !at_first_position

func _on_jumlah_pinjaman_pressed() -> void:
	pass

func _on_nama_pressed() -> void:
	nama.visible = true

func _on_tempat_pressed() -> void:
	tempat.visible = true

func _on_tanggal_lahir_pressed() -> void:
	tanggal.visible = true

func _on_alamat_pressed() -> void:
	pass

func _on_nomor_keanggotaan_pressed() -> void:
	nomorkeanggotaan.visible = true

func _on_jangka_waktu_pressed() -> void:
	pass

func _on_keperluan_pressed() -> void:
	keperluan.visible = true

func _on_catatan_pressed() -> void:
	pass 

func _on_pekerjaan_pressed() -> void:
	pekerjaan.visible = true
