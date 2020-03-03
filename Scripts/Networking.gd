extends Node

signal player_joined
signal player_left
signal paddle_info

onready var Utils = load("res://Scripts/Utils.gd").new()

const SERVER_PORT = 15267
var CLIENT_IP = null
var CLIENT_PORT = 0

var socketUDP = PacketPeerUDP.new()

func _ready():
	start_server()

func _process(delta):
	if socketUDP.get_available_packet_count() > 0:
		var bytes = socketUDP.get_packet()
		CLIENT_IP = socketUDP.get_packet_ip()
		CLIENT_PORT = socketUDP.get_packet_port()
		print(CLIENT_IP, "-", CLIENT_PORT, ":", bytes.get_string_from_ascii())

func _exit_tree():
	print('Shutting down the server...')
	socketUDP.close()

func start_server():
	if socketUDP.listen(SERVER_PORT) != OK:
		print("Error listening on port " + str(SERVER_PORT))
	else:
		print("Listening on port " + str(SERVER_PORT))
