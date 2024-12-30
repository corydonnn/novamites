extends Node2D
var health
@onready var label = $Label #debug healthbar
@onready var occupancy_map = $"../occupancy_map"
var tilepos
# Called when the node enters the scene tree for the first time.
func _ready():
	Globalvars.starbits -= int(Mitedata.data[1]['cost'])
	Globalvars.held = 'none'
	Globalvars.channelers +=1
	health = float(Mitedata.data[1]['health'])
	if Globalvars.debughealthllabels == true:
		$Label.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(health)
	if health <= 0:
		occupancy_map.set_cell(0,occupancy_map.local_to_map(global_position),0, Vector2(1,0))
		queue_free()

func _on_tree_exited():
	Globalvars.channelers -=1
	
