extends Node
@onready var glitch_hit = $glitch_hit
@onready var glitch_shoot = $glitch_shoot
@onready var gunshot = $gunshot
@onready var cutscene_atmo = $cutscene_atmo
@onready var title_atmo = $title_atmo
@onready var menu_click = $menu_click

@export var volume : float = 1 #between 0 and 1, volume control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fadeouttitleatmo():
	var tween = get_tree().create_tween()
	tween.tween_property(title_atmo, "volume_db", -100, 1)
	await get_tree().create_timer(1).timeout
	cutscene_atmo.stop()

func fadeoutcutsceneatmo():
	var tween = get_tree().create_tween()
	tween.tween_property(cutscene_atmo, "volume_db", -50, 5)
	await get_tree().create_timer(6).timeout
	cutscene_atmo.stop()
	title_atmo.play()
	title_atmo.volume_db = linear_to_db(0.001)
	tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(title_atmo, "volume_db", -10, 1)
