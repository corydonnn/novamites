extends Node2D
@onready var needle = $needle
@onready var bg = $bg
@onready var marker = $Marker2D
@onready var marker2 = $Marker2D2

var targetpos
var targetrot

# Called when the node enters the scene tree for the first time.
func _ready():
	targetpos = marker2.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_top_mouse_entered():
	targetpos = $top.global_position
	var tween
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(needle, "rotation", -PI/2, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


func _on_bottom_mouse_entered():
	targetpos = $bottom.global_position
	var tween
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(needle, "rotation", -3*PI/2, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


func _on_right_mouse_entered():
	targetpos = $right.global_position
	var tween
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(needle, "rotation", -2*PI, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


func _on_left_mouse_entered():
	targetpos = $left.global_position
	var tween
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(needle, "rotation", -3*PI, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
