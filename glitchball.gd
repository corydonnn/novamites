extends Area2D
var damage = 10
var speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x+=speed*delta


func _on_area_entered(area):
	area.health-=damage
	area.position.x += 60
	var hitsound = get_tree().get_root().get_node("main/sounds_handler").glitch_hit
	hitsound.pitch_scale = randf_range(.8,1.2)
	hitsound.play()
	queue_free()
