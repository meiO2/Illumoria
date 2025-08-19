extends Node

@onready var buka = $CanvasLayer/Buka
@onready var tutup = $CanvasLayer/Tutup
@onready var folder = $"."

func _ready():
	buka.visible = false
	tutup.visible = true

func _input(event):
	if folder.visible:
		if event is InputEventKey and event.pressed and event.keycode == KEY_F:
			buka.visible = true
			tutup.visible = false
