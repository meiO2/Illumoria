extends Node

@onready var PakHari = $"."
@onready var Timer_PakHari = $"../Timer"

func behaviour():
	var possible_behaviour = ["Blink", "Look_Around"]
	var choosen_behaviour = possible_behaviour.pick_random()
	
	var possible_wait_time = [5.0, 15.0, 10.0]
	var choosen_wait_time = possible_wait_time.pick_random()
	
	PakHari.play(choosen_behaviour)
	Timer_PakHari.wait_time = choosen_wait_time
	Timer_PakHari.start()

func _ready():
	behaviour()

func _on_timer_timeout():
	behaviour()
