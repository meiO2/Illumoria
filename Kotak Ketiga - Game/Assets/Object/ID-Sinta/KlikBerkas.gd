extends Node

@onready var item = $item
@onready var klik = $CanvasLayer3

var pos = true

func _ready():
	klik.visible = false

func _input(event):
	if klik.visible:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
				klik.visible = false
				item.visible = true
				pos=true
	if event is InputEventKey:
		if event.keycode == KEY_T and event.is_pressed():
			print("Tombol T ditekan!")
			klik.visible = true
			item.visible = false
			pos = false
