extends Panel

signal filled(currency_produced)

@export var production_value: float = 1.0
@export var fill_rate: float = 1.0
@export var hold_multiplier: float = 2.0
@export var auto_activate: bool = false

var progress: float = 0.0
var is_being_held: bool = false
var max_progress: float = 100.0

@onready var progress_bar = $VBoxContainer/ProgressBar

func _ready():
	add_to_group("boxes")
	progress_bar.max_value = max_progress
	progress_bar.value = progress

func _process(delta):
	var current_fill_rate = fill_rate
	
	if is_being_held:
		current_fill_rate *= hold_multiplier
	
	if auto_activate or is_being_held:
		progress += current_fill_rate * delta
		
	if progress >= max_progress:
		emit_signal("filled", production_value)
		progress = 0
		
	progress_bar.value = progress

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_being_held = true
			else:
				is_being_held = false
