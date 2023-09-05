class_name OptionsMenu extends ColorRect

signal options_menu_closed
signal invert_y_changed(value: bool)
signal sensitivity_changed(value: float)
signal ui_fps_changed(value: bool)

@onready var toggle_invert_y: CheckButton = %ToggleInvertY
@onready var sensitivity: HSlider = %Sensitivity
@onready var sensitivity_label: Label = %SensitivityLabel
@onready var toggle_fps = %ToggleFPS

@onready var back_button: Button = %BackButton

var _is_ready: bool = false

func _ready() -> void:
	back_button.pressed.connect(hide)
	hide()
	
	_is_ready = true


func _update_ui() -> void:
	
	# Invert the mouse Y axis
	toggle_invert_y.set_pressed_no_signal(Config.get_input(Config.Key.INVERT_Y, false))

	# Map GUI slider range 1 to 10 to the float value range 0.001 to 0.01
	var mapped_value: float = remap(Config.get_input(Config.Key.SENSITIVITY, 0.005), 0.001, 0.01, sensitivity.min_value, sensitivity.max_value)
	sensitivity.value = mapped_value
	
	# UI elements
	toggle_fps.set_pressed_no_signal(Config.get_ui(Config.Key.FPS, false))


func _on_invert_y_toggled(button_pressed: bool) -> void:
	invert_y_changed.emit(button_pressed)


func _on_back_button_pressed() -> void:
	hide()
	options_menu_closed.emit()


func _on_visibility_changed() -> void:
	if visible and _is_ready:
		_update_ui()


func _on_h_slider_value_changed(value: float) -> void:
	# consider adding a debouncing timer so the control is polled much less frequently.
	_set_sensitivity(value)


func _set_sensitivity(value: float) -> void:

	# Map GUI slider range 1 to 10 to the float value range 0.001 to 0.01
	var mapped_value: float = remap(value, sensitivity.min_value, sensitivity.max_value, 0.001, 0.01)
	sensitivity_changed.emit(mapped_value)

	# Set the sensitivity label with a number.
	sensitivity_label.text = String.num(value)


func _on_toggle_fps_toggled(button_pressed):
	ui_fps_changed.emit(button_pressed)
