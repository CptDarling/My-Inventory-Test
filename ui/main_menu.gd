class_name MainMenu extends ColorRect

@onready var resume_button: Button = %ResumeButton
@onready var quit_button: Button = %QuitButton
@onready var options_button: Button = %OptionsButton

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	GameManager.ui = self


func unpause() -> void:
	animation_player.play("Unpause")
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func pause() -> void:
	print("request animation: pause")
	animation_player.play("Pause")
	print("request animation: pause should have played")
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_resume_button_pressed() -> void:
	unpause()


func _on_quit_button_pressed() -> void:
	get_tree().quit(0)


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	print("Animation started: ", anim_name)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("Animation finished: ", anim_name)

