extends AnimatedSprite2D

@onready var Timer_PakHari = $"../Timer"
var is_talking = false

func behaviour():
	if is_talking: return
	var possible_behaviour = ["Blink", "Look_Around"]
	var choosen_behaviour = possible_behaviour.pick_random()
	var possible_wait_time = [5.0, 15.0, 10.0]
	var choosen_wait_time = possible_wait_time.pick_random()
	play(choosen_behaviour)
	Timer_PakHari.wait_time = choosen_wait_time
	Timer_PakHari.start()

func _ready():
	behaviour()

func _on_timer_timeout():
	behaviour()

func start_talking():
	is_talking = true
	animation = "talk"
	frame = 0
	play(animation)  

func advance_talk_frame():
	if animation != "talk":
		return
	frame += 1
	if frame >= sprite_frames.get_frame_count("talk"):
		frame = 0 

func stop_talking():
	is_talking = false
	play("idle")
	behaviour()
