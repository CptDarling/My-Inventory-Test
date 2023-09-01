class_name Player extends PlayerInput

@onready var camera_3d: Camera3D = $Camera3D

func _ready() -> void:
	camera = camera_3d
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
