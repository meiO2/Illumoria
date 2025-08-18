extends Node

@onready var item = $item
@onready var klik = $CanvasLayer3

var pos = true
var stat = false

func _ready():
	klik.visible = false

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if klik.visible == false:
			if event.keycode == KEY_T:
				klik.visible = true
				item.visible = false
				pos = false
				stat = true
		elif klik.visible == true:
			if event.keycode == KEY_T:
				klik.visible = false
				item.visible = true
				pos = true
				stat = false
