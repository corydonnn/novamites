extends Area2D
var damage = 5
var speed = 150
@export var lifetime = 3
@onready var lifetime_timer = $lifetime_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	lifetime_timer.wait_time=lifetime


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation_degrees)
	position+=speed*delta*direction


func _on_area_entered(area):
	area.health-=damage
	var hitsound = get_tree().get_root().get_node("main/sounds_handler").splash
	hitsound.pitch_scale = randf_range(.8,1.2)
	hitsound.play()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_lifetime_timer_timeout():
	queue_free()
