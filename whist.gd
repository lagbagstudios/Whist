# Whist

extends Node

func _ready() -> void:
	randomize()
	deal_hand()
	$Player.display_cards()
	if $Player.connect("card_clicked", self, "_card_clicked") != 0:
		print("couldn't connect card_clicked from Player to _card_clicked in Whist")
	for opponent in $Opponents.get_children():
		opponent.display_cards()

func deal_hand() -> void:
	CardHelper.deal()
	$Player.initialize_hand()
	for opponent in $Opponents.get_children():
		opponent.initialize_cards()

func _card_clicked(c: Card) -> void:
	print("Whist saw card clicked %s" % c.card)
	CardHelper.remove_card(0, c.card)
	c.queue_free()
