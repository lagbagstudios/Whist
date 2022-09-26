# Player

extends Node

var Card = preload("res://entities/Card.tscn")

var hand = []

func set_hand(h) -> void:
	hand = CardHelper.sort_hand(h, false)
	add_cards()

func add_cards() -> void:
	for card in hand:
		var c = Card.instance()
		c.set_card(card)
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
