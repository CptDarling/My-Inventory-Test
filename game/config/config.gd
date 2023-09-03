extends Node

var config: ConfigFile

const CONFIG_FILEPATH = "user://config.cfg"

var Sections: Dictionary = {"INPUT": "input"}
var Keys: Dictionary = {"INVERT_Y": "invert_y"}

enum Section {
	INPUT
}

enum Key {
	INVERT_Y
}

func _ready() -> void:
	_load_config()


func _load_config() -> void:
	config = ConfigFile.new()
	var err = config.load(CONFIG_FILEPATH)
	if err != OK:
		_load_default_settings()
		_save_config()

	for section in config.get_sections():
		for key in config.get_section_keys(section):
			var value = config.get_value(section, key)


func get_input(key: int, default: Variant) -> Variant:
	return _get_value(Section.INPUT, key, default)


func set_input(key: int, value: Variant) -> void:
	_set_value(Section.INPUT, key, value)


func _load_default_settings() -> void:
	set_input(Key.INVERT_Y, false)


func _save_config() -> void:
	config.save(CONFIG_FILEPATH)


func _set_value(section: int, key: int, value) -> void:
	config.set_value(Sections[Section.keys()[section]], Keys[Key.keys()[key]], value)
	_save_config()


func _get_value(section: int, key: int, default: Variant = null) -> Variant:
	return config.get_value(Sections[Section.keys()[section]], Keys[Key.keys()[key]], default)
