extends Node2D
@onready var marker_2d = $Marker2D
@onready var anim = $AnimatedSprite2D
var health
@onready var label = $Label
@onready var occupancy_map = $"../occupancy_map"
# Called when the node enters the scene tree for the first time.
func _ready():
	Globalvars.starbits -= int(Mitedata.data[2]['cost'])
	Globalvars.held = 'none'
	health = float(Mitedata.data[2]['health'])
	if Globalvars.debughealthllabels == true:
		$Label.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(health)
	if health <= 0:
		occupancy_map.set_cell(0,occupancy_map.local_to_map(global_position),0, Vector2(1,0))
		queue_free()


func _on_actiontimer_timeout():
	var glitchball = preload('res://glitchball.tscn').instantiate()
	anim.play("shoot")
	await get_tree().create_timer(.1).timeout
	add_child(glitchball)
	glitchball.position = marker_2d.position
	await get_tree().create_timer(.9).timeout
	anim.play('idle')
