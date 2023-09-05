extends CanvasLayer

@onready var fps_meter = %FPSMeter

var fps_visible: bool = false:
	get:
		return fps_meter.visible
	set(value):
		if value:
			fps_meter.show()
		else:
			fps_meter.hide()

func _ready():
	GameManager.fps_changed.connect(_on_fps_changed)
	
	
func _on_fps_changed(value: bool) -> void:
	fps_visible = value
	
