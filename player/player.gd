class_name Player extends PlayerInput

@onready var camera_3d: Camera3D = $Camera3D
@onready var main_menu: MainMenu = $MainMenu

func _ready() -> void:
	camera = camera_3d


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		main_menu.pause()
