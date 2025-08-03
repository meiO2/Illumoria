extends Node

@onready var PakBambang = $"."
@onready var Timer_PakBambang = $"../Timer"

func behaviour():
	var possible_behaviour = ["Blink", "Look_Around"]
	var choosen_behaviour = possible_behaviour.pick_random()
	
	var possible_wait_time = [5.0, 15.0, 10.0]
	var choosen_wait_time = possible_wait_time.pick_random()
	
	PakBambang.play(choosen_behaviour)
	Timer_PakBambang.wait_time = choosen_wait_time
	Timer_PakBambang.start()

func _ready():
	behaviour()

func _on_timer_timeout():
	behaviour()
