extends Node

@onready var screen = $"."
@onready var animation = $"../AnimationPlayer"

func _ready():
	animation.play("transition-in")
