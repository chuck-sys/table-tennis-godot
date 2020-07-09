extends Node

signal player_joined
signal player_left
signal paddle_info

onready var Utils = load("res://Scripts/Utils.gd").new()

const SERVER_PORT = 12345
var CLIENT_IP = null
var CLIENT_PORT = 0
var acc = Vector3(0, 0, 0)
var rot = [1, 1, 1, 0, 0]

var socketUDP = PacketPeerUDP.new()

func _ready():
	start_server()

func _process(delta):
	while socketUDP.get_available_packet_count() > 0:
		var buffer = StreamPeerBuffer.new()
		buffer.big_endian = true
		buffer.set_data_array(socketUDP.get_packet())
		var numElements = buffer.get_u32()
		acc.x = buffer.get_float()
		acc.y = buffer.get_float()
		acc.z = buffer.get_float()
		rot[0] = buffer.get_float()
		rot[1] = buffer.get_float()
		rot[2] = buffer.get_float()
		rot[3] = buffer.get_float()
		rot[4] = buffer.get_float()

		CLIENT_IP = socketUDP.get_packet_ip()
		CLIENT_PORT = socketUDP.get_packet_port()
#		print(CLIENT_IP, "-", CLIENT_PORT, ":", numElements)

func _exit_tree():
	print('Shutting down the server...')
	socketUDP.close()

func start_server():
	if socketUDP.listen(SERVER_PORT) != OK:
		print("Error listening on port " + str(SERVER_PORT))
	else:
		print("Listening on port " + str(SERVER_PORT))
