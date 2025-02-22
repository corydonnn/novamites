extends Node2D
@onready var spin_audio = $spin_audio
@onready var anim = $sprite
@onready var actiontimer = $actiontimer
@onready var cast = $RayCast2D
@onready var cast2 = $RayCast2D2
@onready var cast3 = $RayCast2D3
@onready var cast4 = $RayCast2D4
@onready var label = $Label
@onready var occupancy_map = $"../occupancy_map"

var attacking = false
var health

func _ready():
	Globalvars.starbits -= int(Mitedata.data[4]['cost'])
	Globalvars.held = 'none'
	health = float(Mitedata.data[4]['health'])
	print(global_transform)
	if Globalvars.debughealthllabels == true:
		$Label.show()

func _process(delta):
	var colliding
	if cast.is_colliding() == true or cast2.is_colliding() == true or cast3.is_colliding() == true or cast4.is_colliding() == true: #this is gross but it was buggin
		colliding = true
	else:
		colliding = false
	if colliding and not attacking:
		attack()
	if colliding == false and attacking:
		stop_attack()
	label.text = str(health)
	if health <= 0:
		occupancy_map.set_cell(0,occupancy_map.local_to_map(global_position),0, Vector2(1,0))
		queue_free()

#attack code
func attack():
	attacking = true
	anim.play("spin")
	spin_audio.playing = true #using this here so it loops i think
	actiontimer.start()
func stop_attack():
	attacking = false
	anim.play("idle")
	spin_audio.stop()
	actiontimer.stop()

func _spawn_drop(rotation,speed):
	var drop = preload("res://mites/spiland/spiland_drop.tscn").instantiate()
	drop.speed = speed
	drop.rotation_degrees = rotation
	add_child(drop)
func _on_actiontimer_timeout():
	for i in range(randi_range(7,20)):
		_spawn_drop(randi_range(-45,45), 150)
