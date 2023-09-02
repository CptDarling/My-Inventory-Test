extends Node

@onready var main_menu: MainMenu = %MainMenu

func _ready() -> void:
	main_menu.pause()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		main_menu.pause()


func show_main_menu() -> void:
	main_menu.show()


func _on_main_menu_options_requested() -> void:
	OptionsManager.show()
