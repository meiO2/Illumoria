extends Node

@onready var PakDewa = $"."
@onready var Timer_PakDewa = $"../Timer"

func behaviour():
	var possible_behaviour = ["Blink", "Look_Around"]
	var choosen_behaviour = possible_behaviour.pick_random()
	
	var possible_wait_time = [5.0, 15.0, 10.0]
	var choosen_wait_time = possible_wait_time.pick_random()
	
	PakDewa.play(choosen_behaviour)
	Timer_PakDewa.wait_time = choosen_wait_time
	Timer_PakDewa.start()

func _ready():
	behaviour()

func _on_timer_timeout():
	behaviour()
