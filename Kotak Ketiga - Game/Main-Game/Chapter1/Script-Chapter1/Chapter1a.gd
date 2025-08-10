extends Node

@onready var title = $Title
@onready var label = $Label
@onready var Option1 = $Option1
@onready var Option2 = $Option2

var entries = []
var current_index = 0
var waiting_for_choice = false

func _ready():
	load_entries("res://Main-Game/Chapter1/Story-Chapter1/Chapter1a.txt")
	show_entry(current_index)

func load_entries(path):
	var file = FileAccess.open(path, FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line().strip_edges()
		if line == "":
			continue

		if line.begins_with("$"):
			var without_dollar = line.trim_prefix("$").strip_edges()
			if "|" in without_dollar:
				var detail = without_dollar.split("|", false, 2)
				if detail.size() > 1:
					entries.append({
						"type": "dialog",
						"name": detail[0].strip_edges(),
						"text": detail[1].strip_edges() })

		elif "-" in line:
			var parts = line.split("-", false, 2)
			if parts.size() > 1:
				entries.append({
					"type": "choice",
					"op1": parts[0].strip_edges(),
					"op2": parts[1].strip_edges() })

		elif line.begins_with("#"):
			continue
			
		elif line.begins_with("#"):
			if line == "*1":
				pass

	file.close()

func show_entry(index):
	if index >= entries.size():
		return

	var entry = entries[index]

	if entry["type"] == "dialog":
		waiting_for_choice = false
		title.text = entry["name"]
		label.text = entry["text"]
		Option1.visible = false
		Option2.visible = false

	elif entry["type"] == "choice":
		waiting_for_choice = true
		Option1.text = entry["op1"]
		Option2.text = entry["op2"]
		Option1.visible = true
		Option2.visible = true

func _input(event):
	if waiting_for_choice:
		return

	if event.is_action_pressed("ui_accept") \
	or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		current_index += 1
		show_entry(current_index)

func _on_Option1_pressed():
	waiting_for_choice = false
	Option1.visible = false
	Option2.visible = false
	current_index += 1
	show_entry(current_index)

func _on_Option2_pressed():
	waiting_for_choice = false
	Option1.visible = false
	Option2.visible = false
	current_index += 1
	show_entry(current_index)
