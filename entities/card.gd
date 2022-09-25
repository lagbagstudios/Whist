# Card

extends Node2D

export var card: String = ""

func set_card(c):
	var sprite_fame = CardHelper.CARDS.find(c)
	$Sprite.frame = 54 if sprite_fame < 0 else sprite_fame
	card = c
