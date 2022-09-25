# Deck

extends Node

var deck = Array(CardHelper.CARDS)
var shuffled = []

func shuffle():
	for i in deck.size():
		shuffled.append(deck.pop_at(rand_range(0, deck.size())))
