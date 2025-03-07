extends Node2D
@onready var anim = $AnimatedSprite2D
@onready var label = $Label
@onready var occupancy_map = $"../occupancy_map"
@onready var raycast = $RayCast2D
@onready var marker_2d = $Marker2D

var health
var canshoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Globalvars.starbits -= int(Mitedata.data[3]['cost'])
	Globalvars.held = 'none'
	health = float(Mitedata.data[3]['health'])
	print(global_transform)
	if Globalvars.debughealthllabels == true:
		$Label.show()

func _process(delta):
	label.text = str(health)
	if canshoot and raycast.is_colliding():
		shoot()
	if health <= 0:
		occupancy_map.set_cell(0,occupancy_map.local_to_map(global_position),0, Vector2(1,0))
		queue_free()

func shoot():
	$actiontimer.start()
	#handles sound effects
	var hitsound = get_tree().get_root().get_node("main/sounds_handler").gunshot
	hitsound.pitch_scale = randf_range(.9,1.2)
	canshoot = false
	var bullet = preload('res://bullet.tscn').instantiate()
	anim.play("shoot")
	await get_tree().create_timer(.2).timeout
	hitsound.play()
	add_child(bullet)
	bullet.position = marker_2d.position
	await get_tree().create_timer(.9).timeout
	anim.play('idle')

func _on_actiontimer_timeout():
	canshoot = true
