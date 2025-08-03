extends Node

@onready var MbaBerlina = $"."
@onready var Timer_MbaBerlina = $"../Timer"

func behaviour():
	var possible_behaviour = ["Blink", "Look_Around"]
	var choosen_behaviour = possible_behaviour.pick_random()
	
	var possible_wait_time = [5.0, 15.0, 10.0]
	var choosen_wait_time = possible_wait_time.pick_random()
	
	MbaBerlina.play(choosen_behaviour)
	Timer_MbaBerlina.wait_time = choosen_wait_time
	print(choosen_wait_time)
	Timer_MbaBerlina.start()

func _ready():
	behaviour()

func _on_timer_timeout():
	behaviour()
