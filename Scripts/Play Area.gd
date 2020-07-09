extends Spatial

onready var Networking = load("res://Scripts/Networking.gd").new()
onready var Paddle1 = get_node("Paddle 1")
onready var Paddle2 = get_node("Paddle 2")

func _ready():
	Networking._ready()
	
func _process(delta):
	Networking._process(delta)
	
#	var v = Vector3(Networking.rot[1], Networking.rot[2], Networking.rot[0])
#	Paddle1.set_rotation(v)
	Paddle1.move_and_slide(Networking.acc * delta * 100)
