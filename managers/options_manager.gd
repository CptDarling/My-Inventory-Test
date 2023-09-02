#class_name OptionsManager
extends ColorRect

@onready var user_prefs: UserPreferences

@onready var toggle_invert_y: CheckButton = %ToggleInvertY
@onready var back_button: Button = %BackButton

@export var mouse_invert_y: bool = false:
	get:
		if user_prefs:
			return user_prefs.mouse_invert_y
		else:
			return false
	set(value):
		user_prefs.mouse_invert_y = value
		user_prefs.save()

func _ready() -> void:
	user_prefs = UserPreferences.load_or_create()
	toggle_invert_y.set_pressed_no_signal(mouse_invert_y)
	back_button.pressed.connect(hide)
	hide()


func _on_invert_y_toggled(button_pressed: bool) -> void:
	mouse_invert_y = button_pressed


func _on_back_button_pressed() -> void:
	hide()
