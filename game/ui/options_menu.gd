class_name OptionsMenu extends ColorRect

@onready var toggle_invert_y: CheckButton = %ToggleInvertY
@onready var back_button: Button = %BackButton

signal options_menu_closed

var _is_ready: bool = false

func _ready() -> void:
	back_button.pressed.connect(hide)
	hide()
	_is_ready = true


func _update_ui() -> void:
	toggle_invert_y.set_pressed_no_signal(Config.get_input(Config.Key.INVERT_Y, false))


func _on_invert_y_toggled(button_pressed: bool) -> void:
	Config.set_input(Config.Key.INVERT_Y, button_pressed)


func _on_back_button_pressed() -> void:
	hide()
	options_menu_closed.emit()


func _on_visibility_changed() -> void:
	if visible and _is_ready:
		_update_ui()
