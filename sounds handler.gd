extends Node
@onready var glitch_hit = $glitch_hit
@onready var glitch_shoot = $glitch_shoot
@onready var gunshot = $gunshot
@onready var cutscene_atmo = $cutscene_atmo
@onready var title_atmo = $title_atmo
@onready var menu_click = $menu_click
@onready var menu_click_2 = $menu_click_2
@onready var rest_ambience = $rest_ambience
var tween
var active = false

@export var volume : float = 1 #between 0 and 1, volume control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fadeouttitleatmo():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(title_atmo, "volume_db", -100, 1)
	await get_tree().create_timer(1).timeout
	cutscene_atmo.stop()

func fadeoutcutsceneatmo():
	active = true
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(cutscene_atmo, "volume_db", -50, 5)
	title_atmo.play()
	title_atmo.volume_db = linear_to_db(0.001)
	tween.tween_property(title_atmo, "volume_db", -15, 2)
	await get_tree().create_timer(3).timeout
	active = false
	
	cutscene_atmo.stop()
	
