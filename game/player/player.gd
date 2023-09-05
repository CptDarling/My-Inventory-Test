class_name Player extends PlayerInput

@onready var player_camera = %PlayerCamera

var original_transform = self.transform

signal reset_player_transform(original_transform: Transform3D)

func _ready() -> void:
	camera = player_camera
	GameManager.player = self


func reset_player() -> void:
	print("player transform reset requested")
	reset_player_transform.emit(original_transform)
