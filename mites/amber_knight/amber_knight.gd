extends Node2D
@onready var anim = $sprite
@onready var raycast = $RayCast2D
@onready var collision = $collision
@onready var label = $Label
@onready var occupancy_map = $"../occupancy_map"
@onready var timer = $Timer

var attacking = false
var can_attack = true
var health = float(Mitedata.data[5]['health'])
var damage = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	Globalvars.starbits -= int(Mitedata.data[5]['cost'])
	Globalvars.held = 'none'
	print(global_transform)
	if Globalvars.debughealthllabels == true:
		$Label.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if raycast.is_colliding() and not attacking and can_attack:
		attack()
	label.text = str(health)
	if health <= 0:
		occupancy_map.set_cell(0,occupancy_map.local_to_map(global_position),0, Vector2(1,0))
		queue_free()

func attack():
	print("attack placeholder")
	anim.play("attack")
	attacking = true
	can_attack = false
	timer.start()
	await get_tree().create_timer(.4).timeout
	if raycast.is_colliding():
		raycast.get_collider().health-=damage
	attacking = false
	await get_tree().create_timer(.5).timeout
	anim.play("default")


func _on_timer_timeout():
	can_attack = true
