# game.gd
# Handles actual gameplay, main script that controls everything within the game

extends Node

var player_seat = 0

func _ready() -> void:
	randomize()
	deal_hand()
	initialize_hands()
	draw_table()
	if $Player.connect("card_clicked", self, "_card_clicked") != 0:
		print("couldn't connect card_clicked from Player to _card_clicked in Whist")


func deal_hand() -> void:
	CardHelper.deal()
	
	
func initialize_hands() -> void:
	$Player.initialize_hand()
	for opponent in $Opponents.get_children():
		opponent.initialize_cards()


func _card_clicked(c: Card) -> void:
	print("Clicked %s" % c.card)
	CardHelper.remove_card(0, c.card)
	c.queue_free()


func draw_table() -> void:
	$Player.display_cards()
	for opponent in $Opponents.get_children():
		opponent.display_cards()
