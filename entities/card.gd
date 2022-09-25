# Card

extends Node2D

export var card: String = ""

func set_card(c: String):
	var sprite_frame = CardHelper.CARDS.find(c)
	$Sprite.frame = 54 if sprite_frame < 0 else sprite_frame
	card = c
