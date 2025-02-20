extends Control
@onready var portraits = $portraits
@onready var attribute_pentagon = $attribute_pentagon
@onready var name_text = $name_text
@onready var body_text = $body_text
@onready var selected_tablet = $selected_tablet
var selected
# Called when the node enters the scene tree for the first time.
func _ready():
	selected_tablet.button.disabled = true
	for i in get_children():
		if i.name.contains("tablet"):
			i.clicked.connect(_on_tablet_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var attribute_data : Dictionary = {
	"placeholder" = [3,3,3,3,3],
	"glitchwurm" = [1,3,4,2,5],
}
var id_linkage = {
	"placeholder" = 0,
	"glitchwurm" = 1,
}
var text_data = [
	{"id" = "placeholder",
	"name" = "Placeholder Empty",
	"body_text" = "Empty box used as placeholder, I didn't want to draw more portraits rn. Using a base attribute line of 3,3,3,3,3",
	},
	{"name" = "Glitchwurm",
	"body_text" = "Glitchwurms have been perceived as holograms, living computer programs, or other things that cement them as the personification of the machine age. They are so intelligent that they can manipulate the “code” of reality around them, however this comes with significant physical toll, causing Glitchwurms to regularly blink in and out of existence.",
	},
]
func _on_tablet_clicked(novamite):
	portraits.play(novamite)
	#compares the name of the clicked novamite to the id databank, then gets that id entery in text data and grabs either name data or body text data
	name_text.text = text_data[id_linkage[novamite]]["name"] 
	body_text.text = text_data[id_linkage[novamite]]["body_text"]
	attribute_pentagon.attribute_vals = attribute_data[novamite]


func _on_back_button_pressed():
	visible=false
