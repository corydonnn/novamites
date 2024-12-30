extends Node2D
@onready var label = $Label

var health
var tilepos
@onready var occupancy_map = $"../occupancy_map"
# Called when the node enters the scene tree for the first time.
func _ready():
	Globalvars.starbits -= int(Mitedata.data[0]['cost'])
	Globalvars.held = 'none'
	health = float(Mitedata.data[0]['health'])
	if Globalvars.debughealthllabels == true:
		$Label.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(health)
	if health <= 0:
		occupancy_map.set_cell(0,occupancy_map.local_to_map(global_position),0, Vector2(1,0))
		queue_free()
