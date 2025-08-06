extends Node

@onready var Scene = $AnimationPlayer

func _ready():
	Scene.play("Cutscene")
