extends Node3D

@onready var player: CharacterBody3D = %Player

func _on_player_reset_player_transform(original_transform) -> void:
	print("i have received a request to reset the player transform")
	player.transform = original_transform
