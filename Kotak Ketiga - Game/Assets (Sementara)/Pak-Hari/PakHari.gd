extends Node

@onready var PakHari = $"Pak-Hari"

func _ready():
	behaviour()

func behaviour():
	var possible_behaviour = ["Blink", "Look_Around", "Normal"]
	var possible_wait_time = [30, 60, 120, 90]
	var choosen_behaviour = possible_behaviour.pick_random()
	var choosen_wait_time = possible_wait_time.pick_random()

	$"Pak-Hari".play(choosen_behaviour)
	_on_pak_hari_animation_finished(choosen_wait_time)


func _on_pak_hari_animation_finished(choosen_wait_time):
	$Timer.wait_time = choosen_wait_time
