extends Node
@onready var dialog_box = $CanvasLayer/DialogBox


var entries = [] 
var current_path = ""
var current_index = 0 
var can_advance = false

var story_stack = []
var visited_choices = {}

func _ready():
	dialog_box.dialog_finished.connect(_on_dialog_finished)
	dialog_box.choice_made.connect(_on_choice_made)
	
	start_game()

func _input(event):
	if not dialog_box.visible:
		return
		
	if event.is_action_pressed("ui_accept"):
		if not dialog_box.timer.is_stopped():
			dialog_box.complete_typing()
		elif can_advance:
			show_entry(current_index + 1)

func start_game():
	story_stack.clear()
	visited_choices.clear()
	var main_story_path = "res://Main-Game/Chapter1/Story-Chapter1/Chapter1a.txt"
	load_and_show(main_story_path)

func load_and_show(path):
	current_path = path
	load_entries(path)
	show_entry(0) 

func load_entries(path):
	entries.clear()
	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		print("ERROR: Gagal membuka file cerita di path: ", path)
		return

	while not file.eof_reached():
		var line = file.get_line().strip_edges()
		if line == "" or line.begins_with("#"): continue

		if line.begins_with("$"):
			var detail = line.trim_prefix("$").strip_edges().split("|", false, 2)
			if detail.size() < 2: continue
			entries.append({"type": "dialog", "name": detail[0].strip_edges(), "text": detail[1].strip_edges()})
		
		elif "%" in line or "&" in line or line.begins_with("@"):
			var choice_id = ""
			
			if line.begins_with("@"):
				var colon_pos = line.find(":")
				if colon_pos != -1:
					choice_id = line.substr(0, colon_pos).trim_prefix("@").strip_edges()
					line = line.substr(colon_pos + 1).strip_edges()

			var separator = "%" if "%" in line else "&"
			var parts = line.split(separator)

			var choice_options = []
			
			for part in parts:
				part = part.strip_edges()
				var option_data = {"text": part, "action": "continue"}
				if "->" in part:
					var action_parts = part.split("->", false, 2)
					option_data["text"] = action_parts[0].strip_edges()
					option_data["action"] = "load_file"
					option_data["path"] = action_parts[1].strip_edges()
				choice_options.append(option_data)
			
			entries.append({"type": "choice", "id": choice_id, "options": choice_options})

	file.close()

func show_entry(index):
	current_index = index
	
	if current_index >= entries.size():
		if not story_stack.is_empty():
			var return_state = story_stack.pop_back()
			load_and_show(return_state.path)
			show_entry(return_state.index)
		else:
			dialog_box.hide_all()
		return

	can_advance = false
	var entry = entries[current_index]

	if entry["type"] == "dialog":
		dialog_box.show_dialog(entry["name"], entry["text"])

	elif entry["type"] == "choice":
		var texts_for_buttons = []
		var original_indices = []
		
		if entry.id != "" and entry.id in visited_choices:
			var visited_indices = visited_choices[entry.id]
			if visited_indices.size() == entry.options.size():
				show_entry(current_index + 1)
				return
			
			for i in range(entry.options.size()):
				if not i in visited_indices:
					texts_for_buttons.append(entry.options[i].text)
					original_indices.append(i)
		else:
			for i in range(entry.options.size()):
				texts_for_buttons.append(entry.options[i].text)
				original_indices.append(i)
		
		entry["original_indices"] = original_indices
		dialog_box.show_choices(texts_for_buttons)

func _on_dialog_finished():
	can_advance = true

func _on_choice_made(filtered_index):
	var entry = entries[current_index]
	
	var original_index = entry.original_indices[filtered_index]
	var chosen_option = entry.options[original_index]
	
	if entry.id != "":
		if not entry.id in visited_choices:
			visited_choices[entry.id] = []
		visited_choices[entry.id].append(original_index)
		
		story_stack.push_back({"path": current_path, "index": current_index})
	
	match chosen_option.action:
		"load_file":
			load_and_show(chosen_option.path)
		"continue":
			show_entry(current_index + 1)
