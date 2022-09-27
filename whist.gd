# Whist

extends Node

func _ready() -> void:
	randomize()
	deal_hand()

func deal_hand() -> void:
	CardHelper.deal()
	$Player.initialize_hand()

func _process(_delta: float) -> void:
	$Player.display_cards()
	for opponent in $Opponents.get_children():
		opponent.display_cards()
