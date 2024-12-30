extends Node2D
@export var novamite :PackedScene
@onready var occupancy_map = $occupancy_map

var mite
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.
	
func gettiledata(tile_map, tile_mouse_pos, custom_data_layer, layer): #function that checks for specific custom data on a layer
	var tile_data : TileData = tile_map.get_cell_tile_data(layer, tile_mouse_pos)
	if tile_data:
		return tile_data.get_custom_data(custom_data_layer)
	else:
		return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var tilepos = occupancy_map.local_to_map(get_local_mouse_position())
	if Input.is_action_just_pressed('leftclick') and Globalvars.held != 'none' and tilepos.y>-3 and tilepos.x<5:
		var used = gettiledata(occupancy_map, occupancy_map.local_to_map(get_local_mouse_position()), "occupied", 0)
		print(used)
		if used == false:
			if Globalvars.held == 'channeler':
				mite = preload('res://channeler.tscn').instantiate() #assigns a instantiation as a variable
			if Globalvars.held == 'novamite':
				mite = preload('res://novamite.tscn').instantiate() #assigns a instantiation as a variable
			if Globalvars.held == 'glitchwurm':
				mite = preload("res://glitchwurm.tscn").instantiate()
			add_child(mite) #adds said variable as a child
			mite.position = occupancy_map.map_to_local(tilepos)
			occupancy_map.set_cell(0,tilepos,0, Vector2(0,0))
		if used == true:
			pass
	
	if Input.is_action_just_pressed("givestarbits") and Globalvars.cancheatstarbits == true:
		Globalvars.starbits += 10
