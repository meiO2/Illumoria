extends Control

signal dialog_finished
signal choice_made(index)

# Variabel disesuaikan dengan nama yang Anda inginkan
@onready var title = $Title
@onready var label = $Label
@onready var timer = $Timer
@onready var choice_container = $ChoiceContainer
@onready var Option1 = $ChoiceContainer/Option1
@onready var Option2 = $ChoiceContainer/Option2

var typing_speed = 0.05
var full_text = ""
var current_char_index = 0

func _ready():
	hide_all()

	timer.connect("timeout", _on_timer_timeout)
	# Menggunakan variabel baru untuk menghubungkan sinyal
	Option1.connect("pressed", func(): _on_choice_pressed(0))
	Option2.connect("pressed", func(): _on_choice_pressed(1))

# --- Fungsi Dipanggil oleh StoryManager ---

func show_dialog(character_name, text):
	hide_all()
	# Menggunakan 'title' dan 'label'
	title.text = character_name
	full_text = text
	current_char_index = 0
	label.text = ""
	
	title.show()
	label.show()
	show()
	
	timer.wait_time = typing_speed
	timer.start()

func show_choices(text1, text2):
	hide_all()
	# Menggunakan variabel baru untuk tombol
	Option1.text = text1
	Option2.text = text2
	
	choice_container.show()
	show()

func complete_typing():
	if not timer.is_stopped():
		timer.stop()
		# Menggunakan 'label'
		label.text = full_text
		emit_signal("dialog_finished")

func hide_all():
	hide()
	# Menggunakan 'title' dan 'label'
	title.hide()
	label.hide()
	choice_container.hide()
	timer.stop()


# --- Fungsi Internal & Sinyal ---

func _on_timer_timeout():
	if current_char_index < full_text.length():
		# Menggunakan 'label'
		label.text += full_text[current_char_index]
		current_char_index += 1
		timer.start()
	else:
		emit_signal("dialog_finished")

func _on_choice_pressed(index):
	hide_all()
	emit_signal("choice_made", index)
