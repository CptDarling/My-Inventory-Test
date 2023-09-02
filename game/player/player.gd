class_name Player extends PlayerInput

@onready var camera_3d: Camera3D = $Camera3D

var original_transform = self.transform

signal reset_player_transform(original_transform: Transform3D)

func _ready() -> void:
	camera = camera_3d
	GameManager.player = self
	GameManager.config_changed.connect(load_config)
	load_config()


func reset_player() -> void:
	print("player transform reset requested")
	reset_player_transform.emit(original_transform)
