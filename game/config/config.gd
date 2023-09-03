class_name Config

const FILE_NAME = "config.cfg"
const FILE_PATH = "user://" + FILE_NAME

const CFG_MOUSE_INVERT_Y = "invert_y"

static func set_config(config:Dictionary):
	print("File write: set_config()")
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	var content = var_to_str(config)
	file.store_string(content)


static func get_config() -> Dictionary:
	print("File read: get_config()")
	if FileAccess.file_exists(FILE_PATH):
		var file = FileAccess.open(FILE_PATH, FileAccess.READ)
		var content = file.get_as_text()
		var config:Dictionary = str_to_var(content)
		if config: return config
	return {}


static func get_value(key:String, default:Variant) -> Variant:
	return get_config().get(key, default)


static func set_value(key:String, val:Variant) -> void:
	var config = get_config()
	config[key] = val
	set_config(config)