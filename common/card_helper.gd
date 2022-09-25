
extends Node

const CARDS = [
	"1c", "2c", "3c", "4c", "5c", "6c", "7c", "8c", "9c", "10c", "11c", "12c", "13c",
	"1h", "2h", "3h", "4h", "5h", "6h", "7h", "8h", "9h", "10h", "11h", "12h", "13h",
	"1s", "2s", "3s", "4s", "5s", "6s", "7s", "8s", "9s", "10s", "11s", "12s", "13s",
	"1d", "2d", "3d", "4d", "5d", "6d", "7d", "8d", "9d", "10d", "11d", "12d", "13d",
]

const SUITS = {
	"c": 0,
	"h": 20,
	"s": 40,
	"d": 60
}

var cards = CARDS.duplicate(false)
var deck = []
var hands = {}

func shuffle() -> void:
	for i in cards.size():
		deck.append(cards.pop_at(rand_range(0, cards.size())))
		
func deal() -> void:
	for i in range(4):
		var hand = CardHelper.deck.slice(12 * i, 12 * (i + 1))
		hands[i] = hand
		print("Player ", i, " has hand ", hand)
		
func sort_hand(h) -> Array:
	h.sort_custom(self, "sort_cards")
	return h
	
func get_card_val(c: String) -> int:
	return 14 if c.to_int() == 1 else c.to_int()

func sort_cards(a: String, b: String, dir: bool = false) -> bool:
	var a_val = SUITS[a[-1]] + get_card_val(a)
	var b_val = SUITS[b[-1]] + get_card_val(b)
	return a_val > b_val if dir else a_val < b_val
