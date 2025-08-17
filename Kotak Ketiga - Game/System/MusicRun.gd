extends Node

@onready var timer = $Timer

func loop():
	timer.wait_time = 7
	timer.start()
	await timer.timeout
	playmusic()

func playmusic():
	timer.wait_time = 3
	timer.start()
	await timer.timeout
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()

func _on_audio_stream_player_finished():
	loop()
