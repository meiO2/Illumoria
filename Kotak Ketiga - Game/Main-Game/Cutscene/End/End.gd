extends Node

@onready var cut = $AnimationPlayer

func _ready():
	cut.play("cutscene")
