extends Node

@onready var kk = $KK
@onready var id = $"ID CARD2"
@onready var gaji = $SlipGaji
@onready var tanah = $"Surat Tanah"

func _on_kk_pressed():
	kk.visible = false

func _on_id_pressed():
	id.visible = false

func _on_slip_gaji_pressed():
	gaji.visible = false

func _on_surat_tanah_pressed():
	tanah.visible = false
