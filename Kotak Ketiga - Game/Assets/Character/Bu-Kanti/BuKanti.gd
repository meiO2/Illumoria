extends Node

@onready var BuKanti = $"."
@onready var Timer_BuKanti = $"../Timer"

func behaviour():
	var possible_behaviour = ["Blink", "Look_Around"]
	var choosen_behaviour = possible_behaviour.pick_random()
	
	var possible_wait_time = [5.0, 15.0, 10.0]
	var choosen_wait_time = possible_wait_time.pick_random()
	
	BuKanti.play(choosen_behaviour)
	Timer_BuKanti.wait_time = choosen_wait_time
	print(choosen_wait_time)
	Timer_BuKanti.start()

func _ready():
	behaviour()

func _on_timer_timeout():
	behaviour()
