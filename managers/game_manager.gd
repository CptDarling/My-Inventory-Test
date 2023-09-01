#class_name GameManager
extends Node

## The main menu UI
var ui: MainMenu:
	set(value):
		ui = value


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if ui:
			ui.pause()
		else:
			get_tree().quit()
