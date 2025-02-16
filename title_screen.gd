extends CanvasLayer
@onready var bg = $Sprite2D
signal playbuttonpressed

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(bg, "modulate", Color.WHITE, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_playbutton_pressed():

	playbuttonpressed.emit()


func _on_playbutton_mouse_entered():
	var hitsound = get_tree().get_root().get_node("main/sounds_handler").menu_click
	hitsound.pitch_scale = randf_range(.8,1.2)
	hitsound.play()
