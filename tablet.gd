extends Node2D
@export var novamite = 'placeholder'

@onready var anim = $sprite
@onready var button = $button
signal clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play(novamite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	clicked.emit(novamite)
