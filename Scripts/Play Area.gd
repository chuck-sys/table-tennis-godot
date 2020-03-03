extends Spatial

onready var Networking = load("res://Scripts/Networking.gd").new()

func _ready():
	Networking._ready()
	
func _process(delta):
	Networking._process(delta)
