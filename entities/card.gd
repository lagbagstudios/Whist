# Card

extends Node2D

export var card: String = ""

func _ready() -> void:
	var err = 0
	err += $Button.connect("mouse_entered", self, "highlight")
	err += $Button.connect("mouse_exited", self, "unhighlight")
	err += $Button.connect("pressed", self, "clicked")
	if err:
		printerr("Something went wrong connecting card signals")

func set_card(c: String):
	var sprite_frame = CardHelper.CARDS.find(c)
	$Sprite.frame = 54 if sprite_frame < 0 else sprite_frame
	card = c

func highlight() -> void:
	$Sprite.scale = Vector2(0.6, 0.6)
	$Sprite.offset.y -= 30

func unhighlight() -> void:
	$Sprite.scale = Vector2(0.5, 0.5)
	$Sprite.offset.y += 30

func clicked() -> void:
	CardHelper.card_clicked(card)
