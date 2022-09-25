# Whist

extends Node

var Player = preload("res://entities/Player.tscn")

var players = {}

func _ready() -> void:
	randomize()
	CardHelper.shuffle()
	CardHelper.deal()
	$Player.set_hand(CardHelper.hands[0])
	$Player.display_cards()
	
func _process(_delta: float) -> void:
	pass

