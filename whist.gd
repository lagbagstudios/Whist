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
	if WebsocketClient.connect("update_gamestate", self, "_update_game_state"):
		print("error connecting update_gamestate signal")

func deal_hand() -> void:
	CardHelper.deal()
	$Player.initialize_hand()
	for opponent in $Opponents.get_children():
		opponent.initialize_cards()

func _card_clicked(c: Card) -> void:
	print("Clicked %s" % c.card)
	var event = {"clicked": c.card}
	WebsocketClient.send_data(event)

func _update_game_state(game_state: Dictionary) -> void:
	print("updating gamestate from server %s" % str(game_state))
	if "hands" in game_state:
		GameState.hands = game_state["hands"]
