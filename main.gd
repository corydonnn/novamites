extends Node2D
@onready var cam = $playarea/Camera2D2
@onready var playarea = preload("res://playarea.tscn").instantiate()
@onready var cutscene = preload("res://cutscene.tscn").instantiate()
@onready var titlescreen = preload("res://title_screen.tscn").instantiate()
@onready var restscreen = preload("res://restmenu.tscn").instantiate()
@onready var sounds = $sounds_handler

var active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if Globalvars.showcutsceneonstartup:
		add_child(cutscene)
		cutscene.done.connect(_on_cutscene_finished)
	else:
		_on_cutscene_finished()
	titlescreen.playbuttonpressed.connect(start_gameplay)

func start_gameplay():
	if active == false:
		active = true
		sounds.fadeouttitleatmo()
		await get_tree().create_timer(1).timeout
		titlescreen.queue_free()
		add_child(restscreen)
		restscreen.embark.connect(_on_embark)
		sounds.rest_ambience.play()
		active = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_cutscene_finished():
	sounds.fadeoutcutsceneatmo()
	add_child(titlescreen)

func _on_embark():
	sounds.rest_ambience.stop()
	add_child(playarea)
	restscreen.visible = false
