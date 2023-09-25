class_name Player extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

## Set to allow the player to perform a double jump.
@export var can_double_jump:bool = false

@onready var player_camera: Camera3D = %PlayerCamera
@onready var orbit_camera: Camera3D = %OrbitCamera
@onready var nose: MeshInstance3D = %Nose

enum camera_selector {
	CAMERA_FIRST_PERSON,
	CAMERA_THIRD_PERSON,
}

var active_camera: Camera3D

var original_transform = self.transform
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var selected_camera: camera_selector = camera_selector.CAMERA_FIRST_PERSON
var double_jump: bool = false

signal reset_player_transform(original_transform: Transform3D)


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GameManager.player = self
	set_camera(camera_selector.CAMERA_FIRST_PERSON)


## Use for mouse events.
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var sensitivity = Config.get_input(Config.Key.SENSITIVITY, .005)
		rotate_y(-event.relative.x * sensitivity)
		active_camera.rotate_x(remap(Config.get_input(Config.Key.INVERT_Y, false) , 1, 0, -1, 1) * -event.relative.y * sensitivity)
		active_camera.rotation.x = clamp(active_camera.rotation.x, -PI/4, PI/4)


func _physics_process(delta: float) -> void:

	# select first or third person camera
	if Input.is_action_just_pressed("camera_toggle"):
		toggle_camera()

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("move_jump") and (is_on_floor() or double_jump):
		if can_double_jump:
			if is_on_floor():
				double_jump = true
			else:
				double_jump = false

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

	# move and detect collision
	if move_and_slide():
		for index in get_slide_collision_count():
			var collision: KinematicCollision3D = get_slide_collision(index)
			if collision.get_collider().is_in_group("Interactable"):
				print(collision.get_collider().name)
				Input.start_joy_vibration(0, 1, 0, 0.1)

func reset_player() -> void:
	print("player transform reset requested")
	reset_player_transform.emit(original_transform)


func set_camera(camera: camera_selector) -> void:
	match camera:
		camera_selector.CAMERA_FIRST_PERSON:
			active_camera = player_camera
			active_camera.current = true
			nose.hide()
		camera_selector.CAMERA_THIRD_PERSON:
			active_camera = orbit_camera
			active_camera.current = true
			nose.show()
		_:
			set_camera(camera_selector.CAMERA_FIRST_PERSON)


func toggle_camera() -> void:
	if active_camera == player_camera:
		set_camera(camera_selector.CAMERA_THIRD_PERSON)
	else:
		set_camera(camera_selector.CAMERA_FIRST_PERSON)
