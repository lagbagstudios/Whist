extends Node

var hands = {}

func handle_card_click(c: String) -> void:
	hands[0].pop_at(hands[0].find(c))
	print(hands[0])
