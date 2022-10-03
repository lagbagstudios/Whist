extends MarginContainer

enum States {HOSTJOIN, WAITING}

var current_state = States.HOSTJOIN

func _ready() -> void:
	if current_state == States.HOSTJOIN:
		$HostJoin.visible = true
		


func _on_Host_pressed() -> void:
	Network.host()


func _on_Join_pressed() -> void:
	pass # Replace with function body.
