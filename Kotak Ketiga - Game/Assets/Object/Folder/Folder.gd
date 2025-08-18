extends Node

@onready var buka = $CanvasLayer/Buka
@onready var tutup = $CanvasLayer/Tutup

func _ready():
	buka.visible = false
	tutup.visible = true

func _on_button_pressed():
	tutup.visible = false
	buka.visible = true
