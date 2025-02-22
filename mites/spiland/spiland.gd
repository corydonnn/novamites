extends Node2D
@onready var spin_audio = $spin_audio
@onready var anim = $sprite
@onready var actiontimer = $actiontimer
@onready var cast = $RayCast2D
var attacking = false


func _ready():
	pass

func _process(delta):
	if cast.is_colliding() and not attacking:
		attack()
	if cast.is_colliding() == false and attacking:
		stop_attack()

#attack code
func attack():
	attacking = true
	anim.play("spin")
	spin_audio.playing = true #using this here so it loops i think
	actiontimer.start()
	for i in range(8):
		_spawn_drop(deg_to_rad(360/8*i), 150)
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
