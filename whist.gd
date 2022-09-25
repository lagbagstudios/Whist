# Whist

extends Node

var Player = preload("res://entities/Player.tscn")

func _ready():
	randomize()
	$Deck.shuffle()
	add_players()
	deal()
	
func add_players():
	for i in range(4):
		var p = Player.instance()
		$Players.add_child(p)
		p.name = "Player %d" % i

func deal():
	for i in range(4):
		var player = $Players.get_child(i)
		var hand = $Deck.shuffled.slice(12 * i, 12 * (i + 1))
		player.set_hand(hand)
		print("Player", i, " has hand", hand)
		if i == 0:
			player.display_cards()
