class_name OptionsMenu extends ColorRect

@onready var toggle_invert_y: CheckButton = %ToggleInvertY

func _ready() -> void:
	toggle_invert_y.set_pressed_no_signal(OptionsManager.mouse_invert_y)


func _on_invert_y_toggled(button_pressed: bool) -> void:
	OptionsManager.mouse_invert_y = button_pressed
