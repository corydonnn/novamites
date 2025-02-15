extends Node2D
@onready var cam = $playarea/Camera2D2
@onready var playarea = preload("res://playarea.tscn").instantiate()
@onready var cutscene = preload("res://cutscene.tscn").instantiate()
@onready var titlescreen = preload("res://title_screen.tscn").instantiate()
@onready var sounds = $sounds_handler

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(cutscene)
	cutscene.done.connect(_on_cutscene_finished)
	titlescreen.playbuttonpressed.connect(start_gameplay)

func start_gameplay():
	sounds.fadeouttitleatmo()
	await get_tree().create_timer(1).timeout
	titlescreen.queue_free()
	add_child(playarea)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_cutscene_finished():
	sounds.fadeoutcutsceneatmo()
	add_child(titlescreen)
