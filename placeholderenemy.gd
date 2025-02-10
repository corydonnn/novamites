extends Area2D
var speed = 15
@onready var raycast = $RayCast2D
var is_attacking = false
@onready var anim = $AnimatedSprite2D
@onready var label = $Label
var health = 100
@onready var lane :int
# Called when the node enters the scene tree for the first time.
func _ready():
	if Globalvars.debughealthllabels == true:
		label.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	label.text = str(health)
	if raycast.is_colliding() == true:
		var targetmite = raycast.get_collider().get_parent()
		targetmite.health -=20*delta
		if is_attacking == false:
			anim.play('attack')
			is_attacking = true
	if raycast.is_colliding() == false:
		if is_attacking == true:
			is_attacking = false
			anim.play('default')
		position.x -= speed*delta;
		
	if health <= 0:
		queue_free()
