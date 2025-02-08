extends Node2D
@onready var marker_2d = $Marker2D
@onready var anim = $AnimatedSprite2D
var health
var canshoot = true
@onready var label = $Label
@onready var occupancy_map = $"../occupancy_map"
@onready var raycast = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Globalvars.starbits -= int(Mitedata.data[2]['cost'])
	Globalvars.held = 'none'
	health = float(Mitedata.data[2]['health'])
	print(global_transform)
	if Globalvars.debughealthllabels == true:
		$Label.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = str(health)
	if canshoot and raycast.is_colliding():
		shoot()
	if health <= 0:
		occupancy_map.set_cell(0,occupancy_map.local_to_map(global_position),0, Vector2(1,0))
		queue_free()

func shoot():
	$actiontimer.start()
	var hitsound = get_tree().get_root().get_node("main/sounds_handler").glitch_shoot
	hitsound.pitch_scale = randf_range(.9,1.1)
	hitsound.play()
	canshoot = false
	var glitchball = preload('res://glitchball.tscn').instantiate()
	anim.play("shoot")
	await get_tree().create_timer(.1).timeout
	add_child(glitchball)
	glitchball.position = marker_2d.position
	await get_tree().create_timer(.9).timeout
	anim.play('idle')

func _on_actiontimer_timeout():
	canshoot = true
