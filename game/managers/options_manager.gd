#class_name OptionsManager
extends Node

@onready var user_prefs: UserPreferences
@onready var options_menu: ColorRect = %OptionsMenu

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


func show() -> void:
	options_menu.show()


func _on_options_menu_options_menu_closed() -> void:
	GameManager.show_main_menu()
