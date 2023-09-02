class_name MainMenu extends ColorRect

@onready var resume_button: Button = %ResumeButton
@onready var quit_button: Button = %QuitButton
@onready var options_button: Button = %OptionsButton

@onready var animation_player: AnimationPlayer = %AnimationPlayer

signal options_requested

func _ready() -> void:
	quit_button.pressed.connect(get_tree().quit)
	resume_button.pressed.connect(unpause)


func unpause() -> void:
	animation_player.play("Unpause")
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func pause() -> void:
	animation_player.play("Pause")
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_options_button_pressed() -> void:
	options_requested.emit()
	hide()
