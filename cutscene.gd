extends CanvasLayer
@onready var anim = $AnimatedSprite2D
@onready var text = $Label
signal done
var finalscene = "3" #horrendous code but if it works yk
var playing = "0"
var canclick = true
# Called when the node enters the scene tree for the first time.
func _ready():
	var music = get_tree().get_root().get_node("main/sounds_handler").cutscene_atmo
	music.play()

var cutscenetext1 = {
	"0" = "meowmeow",
	"1" = "meowemowemowemwoemow",
	"2" = "oooooooooo gros",
	"3" = "freaky :0",
	}
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("leftclick") or Input.is_action_just_pressed("esc") and canclick:
		
		if playing == finalscene or Input.is_action_just_pressed("esc"):
			canclick=false
			var tween = get_tree().create_tween()
			tween.set_parallel(true)
			tween.tween_property(text, "modulate", Color.TRANSPARENT, 5)
			tween.tween_property(anim, "modulate", Color.BLACK, 5) #slow fade out
			
			await get_tree().create_timer(6).timeout
			done.emit() #putting this before timeout is spaghetti code but its ok this is a solor project
			queue_free()
		elif canclick:
			canclick = false
			var tween = get_tree().create_tween()
			tween.set_parallel(true)
			tween.tween_property(text, "modulate", Color.TRANSPARENT, 2)
			tween.tween_property(anim, "modulate", Color.BLACK, 2)
			
			await get_tree().create_timer(2).timeout
			tween.set_parallel(false)
			tween.kill()
			tween = get_tree().create_tween()
			tween.set_parallel(true)
			playing = str(int(playing) + 1)
			text.text = cutscenetext1[playing]
			tween.tween_property(text, "modulate", Color.WHITE, 2)
			tween.tween_property(anim, "modulate", Color.WHITE, 2)
			await get_tree().create_timer(2).timeout
			canclick = true
			
			
	
	if anim.animation != playing:
		anim.play(playing)
