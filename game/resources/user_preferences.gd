class_name UserPreferences
extends Resource

const OPTIONS_FILENAME = "user://options.tres"

@export var mouse_invert_y: bool = false

func save() -> void:
	ResourceSaver.save(self, OPTIONS_FILENAME)


static func load_or_create() -> UserPreferences:
	var res: UserPreferences = load(OPTIONS_FILENAME) as UserPreferences
	if !res:
		res = UserPreferences.new()
	return res
