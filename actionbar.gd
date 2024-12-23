extends Node2D
@onready var starbittimer = $starbittimer
@onready var starbitprogress = $starbitprogress
@onready var starbitcount = $starbitcount
@onready var mousefollow = $mousefollow

var starbitwaittime : float = 2
var slot1 = 'novamite'
func _ready():
	starbitprogress.speed_scale = 1/starbitwaittime
	starbittimer.wait_time = starbitwaittime
	starbittimer.start()
	starbitprogress.play('default')
	mousefollow.play(Globalvars.held)
func _process(delta):
	starbitcount.text = str(Globalvars.starbits)
	mousefollow.global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("rightclick"):
		Globalvars.held='none'
		mousefollow.play(Globalvars.held)

func _on_starbittimer_timeout():
	Globalvars.starbits+=1
	print(str(Globalvars.starbits))


func _on_button_1_pressed():
	Globalvars.held = slot1
	mousefollow.play(Globalvars.held)
