class_name Opponent
extends Node2D

var Card = preload("res://entities/Card.tscn")

enum Seat {LEFT = 1, TOP = 2, RIGHT = 3}

export var seat = Seat.LEFT

var initial_sprite_rotation
var initial_position
var spread_direction

var spread_distance = 15
var screen_buffer = 60

var screen_size_x = ProjectSettings.get_setting("display/window/size/width")
var screen_size_y = ProjectSettings.get_setting("display/window/size/height")

var screen_center_x = ProjectSettings.get_setting("display/window/size/width") / 2
var screen_center_y = ProjectSettings.get_setting("display/window/size/height") / 2

func initialize_cards() -> void:
	for card in GameState.hands[seat]:
		var c = Card.instance()
		c.card = "back"
		c.sprite_scale = 0.33
		c.sprite_centered = true
		$Cards.add_child(c)
		
func remove_card() -> void:
	if $Cards.get_child_count():
		$Cards.get_child(0).queue_free()

func display_cards() -> void:
	calculate_initial_position_and_rotation()
	for i in range($Cards.get_child_count()):
		var c = $Cards.get_child(i)
		c.position = initial_position + spread_direction * (spread_distance * i)
		c.sprite_rotation = initial_sprite_rotation + (5 * i)

func calculate_initial_position_and_rotation() -> void:
	var card_count = $Cards.get_child_count()
	var degrees = (card_count / 2) * 5
	if seat == Seat.LEFT:
		initial_sprite_rotation = 270 - degrees
		spread_direction = Vector2.DOWN
		initial_position = Vector2(
			screen_buffer, 
			screen_center_y - ((card_count - 1) * spread_distance) / 2
		)
	if seat == Seat.TOP:
		initial_sprite_rotation = 360 - degrees
		spread_direction = Vector2.LEFT
		initial_position = Vector2(
			screen_center_x + ((card_count - 1) * spread_distance) / 2, 
			screen_buffer
		)
	if seat == Seat.RIGHT:
		initial_sprite_rotation = 90 - degrees
		spread_direction = Vector2.UP
		initial_position = Vector2(
			screen_size_x - screen_buffer, 
			screen_center_y + ((card_count - 1) * spread_distance) / 2
		)
