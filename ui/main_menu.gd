class_name MainMenu extends ColorRect

@onready var resume_button: Button = %ResumeButton
@onready var quit_button: Button = %QuitButton
@onready var options_button: Button = %OptionsButton

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	quit_button.pressed.connect(get_tree().quit)
	resume_button.pressed.connect(unpause)
	OptionsManager.visibility_changed.connect(_options_manager_visibility_changed)


func unpause() -> void:
	animation_player.play("Unpause")
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func pause() -> void:
	animation_player.play("Pause")
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_options_button_pressed() -> void:
	OptionsManager.show()
	hide()


## We are the main menu.
## The Options Manager will emit the visibility_changed signal when it is
## shown or hidden. If it was just hidden and we are active then we need to
## be seen again. This is because we were hidden whilst the options manager
## was visible.
func _options_manager_visibility_changed() -> void:
	if !OptionsManager.visible:
		show()
