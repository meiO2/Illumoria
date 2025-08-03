extends Node

@onready var PakTurah = $"."
@onready var Timer_PakTurah = $"../Timer"

func behaviour():
	var possible_behaviour = ["Blink", "Look_Around"]
	var choosen_behaviour = possible_behaviour.pick_random()
	
	var possible_wait_time = [5.0, 15.0, 10.0]
	var choosen_wait_time = possible_wait_time.pick_random()
	
	PakTurah.play(choosen_behaviour)
	Timer_PakTurah.wait_time = choosen_wait_time
	Timer_PakTurah.start()

func _ready():
	behaviour()

func _on_timer_timeout():
	behaviour()
