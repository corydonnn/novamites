extends Control
@onready var text = $actiontext


# Called when the node enters the scene tree for the first time.
func _ready():
	text.text=""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var textdict = {
	"left":"Insert a lens into this slot to influence your summoned novamite.",
	"right":"Insert your summoning materials into this slot.",
	"top":"Insert a focus into this slot to enable that novamite's specific ritual.",
	"center":"Use a blank tablet and start the ritual.",
}
func _on_back_button_pressed():
	visible = false

func hoversound():
	var sound = get_tree().get_root().get_node("main/sounds_handler").menu_click_2
	sound.pitch_scale = randf_range(.8,1.2)
	sound.play()

func _on_left_mouse_entered():
	text.text=textdict["left"]
	hoversound()
func _on_top_mouse_entered():
	text.text=textdict["top"]
	hoversound()
func _on_right_mouse_entered():
	text.text=textdict["right"]
	hoversound()
func _on_center_mouse_entered():
	text.text=textdict["center"]
	hoversound()
