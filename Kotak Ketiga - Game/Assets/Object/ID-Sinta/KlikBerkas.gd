extends Node

@onready var item = $"ID-Koperasi"
@onready var klik = $CanvasLayer3

func _ready():
	klik.visible = false

func _on_button_pressed() -> void:
	klik.visible = true
	item.visible = false

func _on_out_pressed() -> void:
	klik.visible = false
	item.visible = true
