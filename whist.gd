# Whist

extends Node

var Player = preload("res://entities/Player.tscn")

var players = {}

func _ready() -> void:
	randomize()
	deal_hand()

func deal_hand() -> void:
	CardHelper.shuffle()
	CardHelper.deal()
	$Player.set_hand(CardHelper.hands[0])

func _process(_delta: float) -> void:
	$Player.display_cards()

