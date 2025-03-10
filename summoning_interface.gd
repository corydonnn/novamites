extends Control
@onready var text = $actiontext
@onready var camera = $Camera2D
@onready var motion_lines = $Camera2D/motion_lines
@onready var space = $Camera2D/space
@onready var jingle = $jingle
@onready var hover = $hover
@onready var thunder = $thunder
@onready var pillars = $pillars
@onready var pillars_bright = $pillars/pillars_bright
@onready var lightning_bolt = $lightning_bolt
@onready var rising_woosh = $rising_woosh
@onready var tablet = $Camera2D/tablet_placeholder

var decreasing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	text.text=""



func _process(delta):
	if Input.is_action_just_pressed("leftclick"):
		startsummonsequence()

var textdict = {
	"left":"Insert a lens into this slot to influence your summoned novamite.",
	"right":"Insert your summoning materials into this slot.",
	"top":"Insert a focus into this slot to enable that novamite's specific ritual.",
	"center":"Use a blank tablet and start the ritual.",
}
func _on_back_button_pressed():
	visible = false

func hoversound():
	hover.pitch_scale = randf_range(.8,1.2)
	hover.play()

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

func startsummonsequence():
	
	#lightning sequence
	pillars_bright.modulate = Color.WHITE
	lightning_bolt.modulate = Color.WHITE
	thunder.play()
	var brightnesstween = get_tree().create_tween()
	brightnesstween.set_parallel(true)
	brightnesstween.tween_property(pillars_bright, "modulate", Color.TRANSPARENT, .5)
	brightnesstween.tween_property(lightning_bolt, "modulate", Color.TRANSPARENT, .5)
	await get_tree().create_timer(1).timeout 
	
	#beginning of rising requence
	#btw this is horrendous code, come back here with animationplayer later pls and ty
	var tablettween = get_tree().create_tween()
	tablettween.set_parallel(true)
	tablettween.tween_property(tablet, "scale", Vector2(.5,.5), 2).set_trans(Tween.TRANS_EXPO)
	tablettween.tween_property(tablet, "position", position+Vector2(0,-250), 3).set_trans(Tween.TRANS_EXPO)
	rising_woosh.play()
	
	var cameratween = get_tree().create_tween()
	cameratween.tween_property(camera, "global_position", camera.global_position+Vector2(0,-1000), 5).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(2).timeout
	var tablettween2 = get_tree().create_tween()
	tablettween2.tween_property(tablet, "position", position+Vector2(0,10), 3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(.5).timeout
	jingle.play()
	await get_tree().create_timer(3).timeout
	var tablettween3 = get_tree().create_tween()
	tablettween3.tween_property(tablet, "position", position+Vector2(-20,0), .5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(3).timeout
	var tablettween4 = get_tree().create_tween()
	tablettween4.tween_property(tablet, "position", position+Vector2(20,0), .5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(1.5).timeout
	var tablettween5 = get_tree().create_tween()
	tablettween5.tween_property(tablet, "position", position+Vector2(0,50), .5).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(.75).timeout
	var tablettween6 = get_tree().create_tween()
	tablettween6.tween_property(tablet, "position", position+Vector2(0,-500), .5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT)
