extends Node2D
@onready var playarea = $playarea
@onready var cam = $playarea/Camera2D2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Globalvars.camerapos = cam.global_position
