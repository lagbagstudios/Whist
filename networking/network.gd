# Network
# Controller script for connecting to/hosting the server

extends Node

var peer
const DEFAULT_PORT = 11598

func _ready() -> void:
	pass
	
func host(port: int = DEFAULT_PORT) -> void:
	peer = WebSocketServer.new()
	var err = peer.listen(port, [], true)
	get_tree().set_network_peer(peer)
	err += get_tree().connect("network_peer_connected", self, "_player_connected")
	err += get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	if err != OK:
		printerr("Error hosting")
	else:
		print("Hosting game")
	
func join(ip: String, port: int = DEFAULT_PORT) -> void:
	peer = WebSocketClient.new()
	var err = peer.connect_to_url("%s:%d" % [ip, port])
	if err != OK:
		printerr("Could not connect to %s:%d" % [ip, port])
	else:
		print("Joined game")

func _player_connected(id: int) -> void:
	print("Player connected %d" % id)
	
func _player_disconnected(id: int) -> void:
	print("Player disconnected %d" % id)
