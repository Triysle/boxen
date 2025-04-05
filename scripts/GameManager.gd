extends Node

signal currency_changed(amount)

var currency: float = 10.0  # Starting currency
var total_currency_earned: float = 0.0

func _ready():
	for box in get_tree().get_nodes_in_group("boxes"):
		box.connect("filled", Callable(self, "_on_Box_filled"))

func add_currency(amount: float):
	currency += amount
	total_currency_earned += amount
	emit_signal("currency_changed", currency)

func spend_currency(amount: float) -> bool:
	if currency >= amount:
		currency -= amount
		emit_signal("currency_changed", currency)
		return true
	return false

func _on_Box_filled(amount):
	add_currency(amount)
