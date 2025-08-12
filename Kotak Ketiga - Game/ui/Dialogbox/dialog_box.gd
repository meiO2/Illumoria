extends Control

signal dialog_finished
signal choice_made(index)

@onready var title = $Title
@onready var label = $Label
@onready var timer = $Timer
@onready var choice_container = $ChoiceContainer
@onready var choice_button_template = $ChoiceContainer/ChoiceButtonTemplate

var typing_speed = 0.05
var full_text = ""
var current_char_index = 0

func _ready():
	hide_all()
	timer.connect("timeout", _on_timer_timeout)


func show_dialog(character_name, text):
	hide_all()
	title.text = character_name
	full_text = text
	current_char_index = 0
	label.text = ""
	
	title.show()
	label.show()
	show()
	
	timer.wait_time = typing_speed
	timer.start()

func show_choices(options_array):
	hide_all()

	for button in choice_container.get_children():
		if button != choice_button_template:
			button.queue_free()

	for i in range(options_array.size()):
		var choice_text = options_array[i]
		
		var new_button = choice_button_template.duplicate()
		new_button.text = choice_text
		
		new_button.pressed.connect(func(): _on_choice_pressed(i))
		
		choice_container.add_child(new_button)
		new_button.show()

	choice_container.show()
	show()

func complete_typing():
	if not timer.is_stopped():
		timer.stop()
		label.text = full_text
		emit_signal("dialog_finished")

func hide_all():
	hide()
	title.hide()
	label.hide()
	choice_container.hide()
	timer.stop()

func _on_timer_timeout():
	if current_char_index < full_text.length():
		label.text += full_text[current_char_index]
		current_char_index += 1
		timer.start()
	else:
		emit_signal("dialog_finished")

func _on_choice_pressed(index):
	hide_all()
	emit_signal("choice_made", index)
