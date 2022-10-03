# Network
# Controller script for connecting to/hosting the server

extends Node

var peer
const DEFAULT_PORT = 11598

func _ready() -> void:
	var err = 0
	err += get_tree().connect("network_peer_connected", self, "_player_connected")
	err += get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	if err != OK:
		printerr("Error connecting network signals")
	
func host(port: int = DEFAULT_PORT) -> void:
	peer = WebSocketServer.new()
	var err = peer.listen(port, [], true)
	get_tree().set_network_peer(peer)
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


func reset() -> void:
	if peer.has_method("stop"):
		peer.stop()
	else:
		peer.disconnect_from_host(0, "back to homescreen")
