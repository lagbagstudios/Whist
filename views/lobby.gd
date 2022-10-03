extends MarginContainer

enum States {HOSTJOIN, WAITING, JOIN}

var current_state = States.HOSTJOIN
onready var players_list = $WaitingRoom/VBoxContainer/ListContainer/List

func _process(_delta: float) -> void:
	if current_state == States.HOSTJOIN:
		$HostJoin.visible = true
		$WaitingRoom.visible = false
	elif current_state == States.WAITING:
		$HostJoin.visible = false
		$WaitingRoom.visible = true


func _on_Host_pressed() -> void:
	if $HostJoin/Name.text != "":
		GameState.my_name = $HostJoin/Name.text
	else:
		GameState.my_name = "Default name"
	Network.host()
	current_state = States.WAITING
	players_list.clear()
	players_list.add_item(GameState.my_name)


func _on_Join_pressed() -> void:
	if $HostJoin/JoinIp/IP.text != "":
		Network.join($HostJoin/JoinIp/IP.text)
	else:
		Network.join("127.0.0.1")

func _on_Back_pressed() -> void:
	current_state = States.HOSTJOIN
	Network.reset()
