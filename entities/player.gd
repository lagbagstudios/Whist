# Player

extends Node

var Card = preload("res://entities/Card.tscn")

export var hand = []

func display_cards():
	for card in hand:
		var c = Card.instance()
		add_child(c)
		c.set_card(card)
		c.show()
		
func set_hand(h):
	hand = h
