class_name MainMenu extends ColorRect

@onready var resume_button: Button = %ResumeButton
@onready var quit_button: Button = %QuitButton
@onready var options_button: Button = %OptionsButton

@onready var animation_player: AnimationPlayer = %AnimationPlayer

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


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	print("Animation started: ", anim_name)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("Animation finished: ", anim_name)

