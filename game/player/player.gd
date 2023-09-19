class_name Player extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var player_camera: Camera3D = %PlayerCamera
@onready var player_camera = %PlayerCamera

var original_transform = self.transform
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

signal reset_player_transform(original_transform: Transform3D)


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.player = self


## Use for mouse events.
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var sensitivity = Config.get_input(Config.Key.SENSITIVITY, .005)
		rotate_y(-event.relative.x * sensitivity)
		active_camera.rotate_x(remap(Config.get_input(Config.Key.INVERT_Y, false) , 1, 0, -1, 1) * -event.relative.y * sensitivity)
		active_camera.rotation.x = clamp(active_camera.rotation.x, -PI/4, PI/4)


func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("move_jump") and (is_on_floor() or double_jump):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)) #.normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func reset_player() -> void:
	print("player transform reset requested")
	reset_player_transform.emit(original_transform)
