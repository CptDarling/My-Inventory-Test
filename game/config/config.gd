extends Node

var config: ConfigFile

const CONFIG_FILEPATH = "user://config.cfg"

enum Section {
	INPUT,
	UI,
}

enum Key {
	INVERT_Y,
	SENSITIVITY,
	FPS,
}

func _ready() -> void:
	_load_config()
	_load_default_settings()


func _load_config() -> void:
	config = ConfigFile.new()
	var err = config.load(CONFIG_FILEPATH)
	if err != OK:
		_load_default_settings()
		_save_config()


func section_to_str(value: int) -> String:
	var resp: String = Section.keys()[value]
	return resp.to_lower()


func key_to_str(value: int) -> String:
	var resp: String = Key.keys()[value]
	return resp.to_lower()


func get_input(key: int, default: Variant) -> Variant:
	return _get_value(Section.INPUT, key, default)


func set_input(key: int, value: Variant) -> void:
	_set_value(Section.INPUT, key, value)


func get_ui(key: int, default: Variant) -> Variant:
	return _get_value(Section.UI, key, default)


func set_ui(key: int, value: Variant) -> void:
	_set_value(Section.UI, key, value)

func _save_config() -> void:
	config.save(CONFIG_FILEPATH)


func _set_value(section: int, key: int, value) -> void:
	config.set_value(section_to_str(section), key_to_str(key), value)
	_save_config()


func _get_value(section: int, key: int, default: Variant = null) -> Variant:
	return config.get_value(section_to_str(section), key_to_str(key), default)


func _load_default_settings() -> void:
	
	# Input section defaults
	if !config.has_section_key(section_to_str(Section.INPUT), key_to_str(Key.INVERT_Y)):
		set_input(Key.INVERT_Y, false)
	if !config.has_section_key(section_to_str(Section.INPUT), key_to_str(Key.SENSITIVITY)):
		set_input(Key.SENSITIVITY, 0.005)
	
	# UI section defaults	
	if !config.has_section_key(section_to_str(Section.UI), key_to_str(Key.FPS)):
		set_ui(Key.FPS, false)
