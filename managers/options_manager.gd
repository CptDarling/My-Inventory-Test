#class_name OptionsManager
extends Node

@onready var user_prefs: UserPreferences

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
