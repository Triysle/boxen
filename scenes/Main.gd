extends Node

@onready var currency_label = $MarginContainer/HBoxContainer/UpgradePanel/VBoxContainer/CurrencyLabel

func _ready():
	GameManager.connect("currency_changed", Callable(self, "_on_currency_changed"))
	currency_label.text = "Currency: " + str(GameManager.currency)

func _on_currency_changed(amount):
	currency_label.text = "Currency: " + str(amount)
