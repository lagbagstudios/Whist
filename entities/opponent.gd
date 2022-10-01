# Opponent
# Controller script for displaying opponents

extends Node2D
class_name Opponent

var Card = preload("res://entities/Card.tscn")

enum Seat {LEFT = 1, TOP = 2, RIGHT = 3}

export var seat = Seat.LEFT

var game_state_seat = 1

var initial_sprite_rotation: int
var initial_position: Vector2
var spread_direction: Vector2
var curve_direction: Vector2

var spread_distance = 15
var screen_buffer = 40
var curve_amount = 0.4
var card_scale = 0.45

var spread: Vector2
var curve: Vector2

var screen_size_x = ProjectSettings.get_setting("display/window/size/width")
var screen_size_y = ProjectSettings.get_setting("display/window/size/height")

var screen_center_x = ProjectSettings.get_setting("display/window/size/width") / 2
var screen_center_y = ProjectSettings.get_setting("display/window/size/height") / 2

func initialize_cards() -> void:
	for card in GameState.hands[game_state_seat]:
		var c = Card.instance()
		c.card = "back"
		c.sprite_scale = card_scale
		c.sprite_centered = true
		$Cards.add_child(c)
		
func remove_card() -> void:
	if $Cards.get_child_count():
		$Cards.get_child(0).queue_free()

func display_cards() -> void:
	calculate_initial_position_and_rotation()
	for i in range($Cards.get_child_count()):
		var c = $Cards.get_child(i)
		c.position = calculate_position(i)
		c.sprite_rotation = initial_sprite_rotation + (5 * i)
		
func calculate_position(i: int) -> Vector2:
	spread = (spread_direction * (spread_distance * i))
	curve = curve_direction * (curve_amount * pow(i - $Cards.get_child_count() / 2.0, 2)) * -1
	return initial_position + spread + curve

func calculate_initial_position_and_rotation() -> void:
	var card_count = $Cards.get_child_count()
	var degrees = (card_count / 2) * 5
	if seat == Seat.LEFT:
		initial_sprite_rotation = 270 - degrees
		spread_direction = Vector2.DOWN
		curve_direction = Vector2.RIGHT
		initial_position = Vector2(
			screen_buffer, 
			screen_center_y - ((card_count - 1) * spread_distance) / 2
		)
	if seat == Seat.TOP:
		initial_sprite_rotation = 360 - degrees
		spread_direction = Vector2.LEFT
		curve_direction = Vector2.DOWN
		initial_position = Vector2(
			screen_center_x + ((card_count - 1) * spread_distance) / 2, 
			screen_buffer
		)
	if seat == Seat.RIGHT:
		initial_sprite_rotation = 90 - degrees
		spread_direction = Vector2.UP
		curve_direction = Vector2.LEFT
		initial_position = Vector2(
			screen_size_x - screen_buffer, 
			screen_center_y + ((card_count - 1) * spread_distance) / 2
		)
