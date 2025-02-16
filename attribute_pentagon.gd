extends Node2D
@onready var center_point = $"markers/center point"
@onready var shape = $Polygon2D
@onready var backing = $decorative_backing
@onready var line_0 = $line_0
@onready var line_1 = $line_1
@onready var line_2 = $line_2
@onready var line_3 = $line_3
@onready var line_4 = $line_4
@onready var stb_label = $stb
@onready var krm_label = $krm
@onready var tpr_label = $tpr
@onready var fbr_label = $fbr
@onready var att_label = $att




@export var ringsize :int = -7 #radius of each ring in pixels, neagtive to make a point directly up from center
@export var attribute_vals : Array = [0,0,0,0,0] #values for each attribute, default defined here

func _ready():
	var lines = [line_0,line_1,line_2,line_3,line_4]
	var labels = [stb_label,krm_label,tpr_label,fbr_label,att_label]
	for i in len(lines): #sets each ring to its correct vakue
		set_line_points(lines[i],i+1)
	for i in len(labels):
		labels[i].position = line_4.points[i] + Vector2(0,-11).rotated(deg_to_rad(72*i))
	
	set_points(backing,5,5,5,5,5)

func _process(delta): #im aware how gross it is to put this in the proccess loop but it was being weird and since
	#not much else is happening on this screen and it gets cleared ittl be ok i think
	var steps : int  = 20 # amount of interpolation steps
	var refreshrate : float = 0.0001 #time between each step
	var targetshape = [(Vector2(0,ringsize*attribute_vals[0])),Vector2(0,ringsize*attribute_vals[1]).rotated(deg_to_rad(72)),Vector2(0,ringsize*attribute_vals[2]).rotated(deg_to_rad(72*2)),Vector2(0,ringsize*attribute_vals[3]).rotated(deg_to_rad(72*3)),Vector2(0,ringsize*attribute_vals[4]).rotated(deg_to_rad(72*4))]
	for x in range(steps): #spl
		for i in range (5):
			var way = targetshape[i] - shape.polygon[i]
			shape.polygon[i] += way.normalized() * (way.length() / steps )
		await get_tree().create_timer(refreshrate).timeout #makes the tween tween

func set_points(shape,point0,point1,point2,point3,point4): #makes polygon from shape and strength values
	shape.polygon[0] = Vector2(0,ringsize*point0)
	shape.polygon[1] = Vector2(0,ringsize*point1).rotated(deg_to_rad(72))
	shape.polygon[2] = Vector2(0,ringsize*point2).rotated(deg_to_rad(72*2))
	shape.polygon[3] = Vector2(0,ringsize*point3).rotated(deg_to_rad(72*3))
	shape.polygon[4] = Vector2(0,ringsize*point4).rotated(deg_to_rad(72*4))

func set_line_points(line,ringnum): #makes pentagon from line2d in given ring
	var iteration = 0
	for i in line.points:
		line.points[iteration] = Vector2(0,ringsize*ringnum).rotated(deg_to_rad(72*iteration))
		iteration +=1

func tweenshape(): #manual tweening cuz apparently tweening points is impossible in godot :(
	pass
  
