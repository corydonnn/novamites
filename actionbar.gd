extends Node2D
@onready var starbitcount = $starbitcount
@onready var mousefollow = $mousefollow
@onready var slot_1_sprite = $button1/slot1sprite
@onready var slot_2_sprite = $button2/slot2sprite
@onready var slot_3_sprite = $button3/slot3sprite

var starbitwaittimeconst : float = 5
var starbitwaittime
#debug
var slot1 = 'glitchwurm'
var slot2 = 'spiland'
var slot3 = 'amber_knight'
func _ready():
	starbitwaittime = starbitwaittimeconst - Globalvars.channelers*.1
	mousefollow.play(Globalvars.held)
	slot_1_sprite.play(slot1)
	slot_2_sprite.play(slot2)
	slot_3_sprite.play(slot3)
	
	
func _process(delta):
	starbitwaittime = starbitwaittimeconst - Globalvars.channelers*.2
	$TextureProgressBar.value += delta * 1/starbitwaittime * 100 #times max value
	if $TextureProgressBar.value >= $TextureProgressBar.max_value: #on texture progress fill
		$TextureProgressBar.value = 0 #reset progress
		Globalvars.starbits+=1 #give starbit
		$starbit_sfx.play() #self explanatory
	starbitcount.text = str(Globalvars.starbits)
	mousefollow.global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("rightclick"):
		Globalvars.held='none'
	mousefollow.play(Globalvars.held)







#button code. banished to the ether
func _on_button_1_pressed():
	if Globalvars.starbits >= int(Mitedata.data[0]['cost']):
		Globalvars.held = slot1
		mousefollow.play(Globalvars.held)

func _on_button_2_pressed():
	if Globalvars.starbits >= int(Mitedata.data[4]['cost']):
		Globalvars.held = slot2
		mousefollow.play(Globalvars.held)


func _on_button_3_pressed():
	if Globalvars.starbits >= int(Mitedata.data[5]['cost']):
		Globalvars.held = slot3
		mousefollow.play(Globalvars.held)

