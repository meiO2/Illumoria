extends Control

signal dialog_finished
signal choice_made(index)

@onready var name_label = $NameLabel
@onready var dialog_label = $DialogLabel
@onready var timer = $Timer
@onready var choice_container = $ChoiceContainer
@onready var option1_button = $ChoiceContainer/Option1Button
@onready var option2_button = $ChoiceContainer/Option2Button

var typing_speed = 0.05
var full_text = ""
var current_char_index = 0

func _ready():
	hide_all()

	timer.connect("timeout", _on_timer_timeout)
	option1_button.connect("pressed", func(): _on_choice_pressed(0))
	option2_button.connect("pressed", func(): _on_choice_pressed(1))

# --- Fungsi Dipanggil oleh StoryManager ---

func show_dialog(character_name, text):
	hide_all()
	name_label.text = character_name
	full_text = text
	current_char_index = 0
	dialog_label.text = ""
	
	name_label.show()
	dialog_label.show()
	show()
	
	timer.wait_time = typing_speed
	timer.start()

func show_choices(text1, text2):
	hide_all()
	option1_button.text = text1
	option2_button.text = text2
	
	choice_container.show()
	show()

func complete_typing():
	if not timer.is_stopped():
		timer.stop()
		dialog_label.text = full_text
		emit_signal("dialog_finished")

func hide_all():
	hide()
	name_label.hide()
	dialog_label.hide()
	choice_container.hide()
	timer.stop()


# --- Fungsi Internal & Sinyal ---

func _on_timer_timeout():
	if current_char_index < full_text.length():
		dialog_label.text += full_text[current_char_index]
		current_char_index += 1
		timer.start()
	else:
		emit_signal("dialog_finished")

func _on_choice_pressed(index):
	hide_all()
	emit_signal("choice_made", index)
