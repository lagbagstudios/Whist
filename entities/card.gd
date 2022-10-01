# Card
extends Node2D

class_name Card

var card = "" setget set_card
var sprite_rotation: int setget set_sprite_rotation
var sprite_scale: float setget set_sprite_scale
var highlighted_scale: float setget set_sprite_highlighted_scale
var sprite_centered: bool setget set_sprite_centered
var highlight_offset: int setget set_highlight_offset

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
	scale = Vector2(s, s)
	sprite_scale = s
	
func set_sprite_centered(center: bool) -> void:
	$Sprite.centered = center

func set_sprite_highlighted_scale(s: float) -> void:
	highlighted_scale = s
	
func set_highlight_offset(o: int) -> void:
	highlight_offset = o

func highlight() -> void:
	if clickable:
		scale = Vector2(highlighted_scale, highlighted_scale)
		position.y -= highlight_offset

func unhighlight() -> void:
	if clickable:
		scale = Vector2(sprite_scale, sprite_scale)
		position.y += highlight_offset

func clicked() -> void:
	emit_signal("clicked", self)
