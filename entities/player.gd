# Player

extends Node

var Card = preload("res://entities/Card.tscn")

var screen_buffer = 40
var spread_distance = 40
var curve_amount = 0.6
var base_card_scale = 0.5
var highlighted_card_scale = 0.6
var card_rotation_factor = 1.75

var screen_height = ProjectSettings.get_setting("display/window/size/height")
var screen_center = ProjectSettings.get_setting("display/window/size/width") / 2

signal card_clicked

func initialize_hand() -> void:
	GameState.hands[0] = CardHelper.sort_hand(GameState.hands[0], false)
	add_cards()

func add_cards() -> void:
	for card in GameState.hands[0]:
		var c = Card.instance()
		c.card = card
		c.clickable = true
		c.sprite_centered = true
		c.sprite_scale = base_card_scale
		c.highlighted_scale = highlighted_card_scale
		c.highlight_offset = 10
		$Cards.add_child(c)
		c.connect("clicked", self, "_card_clicked")
		c.connect("tree_exited", self, "display_cards")

var hand_size: float
func get_left_card_x() -> int:
	hand_size = ($Cards.get_child_count() - 1) * spread_distance
	return screen_center - (hand_size / 2)

func display_cards() -> void:
	for i in range($Cards.get_child_count()):
		var card = $Cards.get_child(i)
		card.position = Vector2(
			get_left_card_x() + (spread_distance * i),
			calculate_card_height(i)
		)
		card.sprite_rotation = calculate_card_rotation(i)

func calculate_card_rotation(i: int) -> float:
	return card_rotation_factor * int(i - $Cards.get_child_count() / 2.0)

func calculate_card_height(i: int) -> float:
	return screen_height - screen_buffer + curve_amount * (pow(i - $Cards.get_child_count() / 2.0, 2))
	
func _card_clicked(c: Card) -> void:
	print("Player saw card clicked %s" % c.card)
	emit_signal("card_clicked", c)
