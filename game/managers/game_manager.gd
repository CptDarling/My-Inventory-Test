#class_name GameManager
extends Node

var player: Player

@onready var main_menu: MainMenu = %MainMenu
@onready var options_menu: OptionsMenu = %OptionsMenu

func _ready() -> void:
	main_menu.pause()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		main_menu.pause()

	if event.is_action_pressed("reset_player"):
		if player:
			player.reset_player()


func _on_main_menu_options_requested() -> void:
	options_menu.show()


func _on_options_menu_options_menu_closed() -> void:
	main_menu.show()


func _on_options_menu_invert_y_changed(value) -> void:
	Config.set_input(Config.Key.INVERT_Y, value)


func _on_options_menu_sensitivity_changed(value) -> void:
	Config.set_input(Config.Key.SENSITIVITY, value)
