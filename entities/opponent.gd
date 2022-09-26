extends Node2D

var hand_len = []

var Card = preload("res://entities/Card.tscn")

func set_hand(h: Array) -> void:
	hand_len = h.size()
	var c = Card.instance()
	add_child(c)
	c.set_card("back")

func show_hand() -> void:
	for i in range(hand_len):
		pass
