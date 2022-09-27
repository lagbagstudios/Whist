# Player

extends Node

var Card = preload("res://entities/Card.tscn")

func initialize_hand() -> void:
	GameState.hands[0] = CardHelper.sort_hand(GameState.hands[0], false)
	add_cards()

func add_cards() -> void:
	for card in GameState.hands[0]:
		var c = Card.instance()
		c.card = card
		c.clickable = true
		$Cards.add_child(c)

func get_left_card_x() -> int:
	var screen_center = ProjectSettings.get_setting("display/window/size/width") / 2
	var cards = $Cards.get_child_count()
	var hand_size = (cards - 1) * 50 + 74
	return screen_center - (hand_size / 2)

func display_cards() -> void:
	for i in range($Cards.get_child_count()):
		var card = $Cards.get_child(i)
		card.position = Vector2(
			get_left_card_x() + (50 * i), 
			ProjectSettings.get_setting("display/window/size/height") - 150
		)
