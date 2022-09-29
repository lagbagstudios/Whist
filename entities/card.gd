# Card

extends Node2D

class_name Card

var card: String = "" setget set_card
var sprite_rotation setget set_sprite_rotation
var sprite_scale setget set_sprite_scale
var highlighted_scale setget set_sprite_highlighted_scale
var sprite_centered setget set_sprite_centered

var clickable = false

signal clicked

func _ready() -> void:
	var err = 0
	err += $Sprite/Button.connect("mouse_entered", self, "highlight")
	err += $Sprite/Button.connect("mouse_exited", self, "unhighlight")
	err += $Sprite/Button.connect("pressed", self, "clicked")
	if err:
		printerr("Something went wrong connecting card signals")

func set_card(c: String):
	if c == "back":
		$Sprite.frame = 54
	if c == "blank":
		$Sprite.frame = 52
	else:
		var sprite_frame = CardHelper.CARDS.find(c)
		$Sprite.frame = 54 if sprite_frame < 0 else sprite_frame
	card = c
	
func set_sprite_rotation(degrees: int) -> void:
	$Sprite.rotation_degrees = degrees
	
func set_sprite_scale(s: float) -> void:
	$Sprite.scale = Vector2(s, s)
	
func set_sprite_centered(center: bool) -> void:
	$Sprite.centered = center

func set_sprite_highlighted_scale(s: float) -> void:
	highlighted_scale = s

func highlight() -> void:
	if clickable:
		$Sprite.scale = Vector2(0.6, 0.6)
		$Sprite.offset.y -= 30

func unhighlight() -> void:
	if clickable:
		$Sprite.scale = Vector2(0.5, 0.5)
		$Sprite.offset.y += 30

func clicked() -> void:
	emit_signal("clicked", self)
