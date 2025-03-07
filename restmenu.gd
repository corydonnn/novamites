extends Node2D
@onready var needle = $needle
@onready var bg = $bg
@onready var marker = $Marker2D
@onready var marker2 = $Marker2D2
@onready var desc = $description_label
@onready var selectionscreen = preload("res://selection_interface.tscn").instantiate()
@onready var summonscreen = preload("res://summoning_interface.tscn").instantiate()


var targetpos
var targetrot

func hoversound():
	var sound = get_tree().get_root().get_node("main/sounds_handler").menu_click_2
	sound.pitch_scale = randf_range(.8,1.2)
	sound.play()
# Called when the node enters the scene tree for the first time.
func _ready():
	targetpos = marker2.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var desctext = { #using a library for futureproofing bc im so smart
	"hone" = "focus your scills & attributes to influence your gameplay (NYI)",
	"embark" = "forge onward, forfeitting all remaining stability (NYI)",
	"manage" = "view your currently collected novamites (PARTIALLY IMPLEMENTED)",
	"summon" = "attempt to recruit new novamites to your team through the dark arts. (NYI)",
}

func _on_top_mouse_entered(): #manage button. too lazy to change function name. will do maybe eventually
	targetpos = $manage.global_position
	var tween
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(needle, "rotation", -PI*2, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	hoversound()
	desc.text = desctext["manage"]


func _on_bottom_mouse_entered(): #embark button
	targetpos = $embark.global_position
	var tween
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(needle, "rotation", -3*PI/2, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	hoversound()
	desc.text = desctext["embark"]


func _on_right_mouse_entered(): #summon button
	targetpos = $summon.global_position
	var tween
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(needle, "rotation", -PI/2, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	hoversound()
	desc.text = desctext["summon"]


func _on_left_mouse_entered(): #hone button
	targetpos = $hone.global_position
	var tween
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(needle, "rotation", -3*PI, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	hoversound()
	desc.text = desctext["hone"]


func _on_top_pressed():
	add_child(selectionscreen)
	selectionscreen.visible = true


func _on_back_pressed():
	queue_free()


func _button_mouse_exited():
	desc.text = ""

signal embark
func _on_embark_pressed():
	embark.emit()

signal summon
func _on_summon_pressed():
	add_child(summonscreen)
	summonscreen.visible = true
