extends Node2D
@export var novamite :PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tilepos = $TileMap.local_to_map(get_local_mouse_position())
	if Input.is_action_just_pressed('leftclick') and Globalvars.held != 'none' and tilepos.y>-3 and tilepos.x<5:
		var spawn
