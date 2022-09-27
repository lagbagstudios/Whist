# Whist

extends Node

func _ready() -> void:
	randomize()
	deal_hand()
	$Player.display_cards()
	for opponent in $Opponents.get_children():
		opponent.display_cards()

func deal_hand() -> void:
	CardHelper.deal()
	$Player.initialize_hand()
	for opponent in $Opponents.get_children():
		opponent.initialize_cards()
