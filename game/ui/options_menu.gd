class_name OptionsMenu extends ColorRect

@onready var toggle_invert_y: CheckButton = %ToggleInvertY
@onready var back_button: Button = %BackButton

signal config_changed
signal options_menu_closed

var cfg: Dictionary
var _is_ready: bool = false

func _ready() -> void:
	back_button.pressed.connect(hide)
	hide()
	_is_ready = true


func _update_ui() -> void:
	if !cfg: cfg = Config.get_config()
	toggle_invert_y.set_pressed_no_signal(cfg.get(Config.CFG_MOUSE_INVERT_Y, false))


func _on_invert_y_toggled(button_pressed: bool) -> void:
	cfg[Config.CFG_MOUSE_INVERT_Y] = button_pressed
	Config.set_config(cfg)
	config_changed.emit()


func _on_back_button_pressed() -> void:
	hide()
	options_menu_closed.emit()


func _on_visibility_changed() -> void:
	if visible and _is_ready:
		_update_ui()
