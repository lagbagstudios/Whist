# Card

extends Node2D

export var card: String = ""

func set_card(c: String):
	var sprite_frame = CardHelper.CARDS.find(c)
	$Sprite.frame = 54 if sprite_frame < 0 else sprite_frame
	card = c

func _on_Control_mouse_entered() -> void:
	$Sprite.scale = Vector2(0.6, 0.6)


func _mouse_entered() -> void:
	$Sprite.scale = Vector2(0.6, 0.6)
	$Sprite.offset.y -= 30


func _mouse_exited() -> void:
	$Sprite.scale = Vector2(0.5, 0.5)
	$Sprite.offset.y += 30
