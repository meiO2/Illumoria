extends Node

@onready var MasAdi = $"."
@onready var Timer_MasAdi = $"../Timer"

func behaviour():
	var possible_behaviour = ["Blink", "Look_Around"]
	var choosen_behaviour = possible_behaviour.pick_random()
	
	var possible_wait_time = [5.0, 15.0, 10.0]
	var choosen_wait_time = possible_wait_time.pick_random()
	
	MasAdi.play(choosen_behaviour)
	Timer_MasAdi.wait_time = choosen_wait_time
	Timer_MasAdi.start()

func _ready():
	behaviour()

func _on_timer_timeout():
	behaviour()
