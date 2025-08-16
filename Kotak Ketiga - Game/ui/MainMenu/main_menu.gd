extends Control

@onready var optionspanel: Panel = $optionspanel
@onready var buttonstart: Button = $buttonstart
@onready var buttonoption: Button = $buttonoption
@onready var buttonclosepanel: Button = $optionspanel/buttonclosepanel
@onready var title: Label = $Title

func _ready():
	buttonoption.visible = true
	buttonstart.visible = true
	title.visible = true
	optionspanel.visible = false

func _on_buttonoption_pressed() -> void:
	buttonoption.visible = false
	buttonstart.visible = false
	title.visible = false
	optionspanel.visible = true

func _on_buttonclosepanel_pressed() -> void:
	buttonoption.visible = true
	buttonstart.visible = true
	title.visible = true
	optionspanel.visible = false

func _on_exitbutton_pressed() -> void:
	get_tree().quit()

func _on_buttonstart_pressed() -> void:
	get_tree().change_scene_to_file("res://Main-Game/Cutscene/Opening/Cutscene-Opening.tscn")
