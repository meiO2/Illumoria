extends Node

@onready var item = $"ID-Koperasi"
@onready var klik = $CanvasLayer

func _ready():
	klik.visible = false
