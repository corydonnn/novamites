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
	get_tree().get_root().get_node("./sounds handler").glich_hit.play()
	queue_free()
