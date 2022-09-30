extends Node

var server_url = "127.0.0.1:9123"

var _client = WebSocketClient.new()

signal update_gamestate

func _ready() -> void:
	var err = OK
	err += _client.connect("connection_established", self, "_connected")
	err += _client.connect("connection_error", self, "_closed")
	err += _client.connect("connection_closed", self, "_closed")
	err += _client.connect("data_received", self, "_on_data")
	if err != OK:
		print("error connecting signals")
	err = _client.connect_to_url(server_url)
	if err != OK:
		print("Unable to connect to %s" % server_url)
		set_process(false)
	else:
		print("Connecting to %s" % server_url)
		
func _connected(protocol = "") -> void:
	print("Connected with protocol %s" % protocol)
	
func _closed(was_clean = false) -> void:
	print("Closed, was clean: %s" % str(was_clean))
	set_process(false)
	
func _on_data() -> void:
	var data: String = _client.get_peer(1).get_packet().get_string_from_utf8()
	var json_data = JSON.parse(data).result
	print("Received data from the server: %s" % data)
	if typeof(json_data) == TYPE_DICTIONARY:
		emit_signal("update_gamestate", json_data)
	
func _process(_delta: float) -> void:
	_client.poll()
	
func send_data(data: Dictionary) -> void:
	_client.get_peer(1).put_packet(JSON.print(data).to_utf8())
