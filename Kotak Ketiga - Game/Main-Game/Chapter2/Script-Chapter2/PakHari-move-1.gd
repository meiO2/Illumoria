extends Node

@onready var timer = $Timer

var pakhari = preload("res://Assets/Character/Pak-Hari/PakHari.gd")

func _ready():
	timer.wait_time = 1.0
	timer.start()
	await timer.timeout
	var PHari = pakhari.instantiate()
	add_child(PHari)
	PHari.position = Vector2()
