class_name Opponent
extends Node2D

var Card = preload("res://entities/Card.tscn")

enum Seat {LEFT = 1, TOP = 2, RIGHT = 3}

export var seat = Seat.LEFT

func display_cards() -> void:
	if seat == Seat.LEFT:
		pass 
	if seat == Seat.TOP:
		pass
	if seat == Seat.RIGHT:
		pass
	for card in GameState.hands[seat]:
		print(card.card)
