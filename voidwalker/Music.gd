extends HSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_focus()
	value = MusicManager.volume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_drag_ended(value_changed: bool) -> void:
	MusicManager.set_volume(value)
	print ("val : " + str(value))


func _on_value_changed(value: float) -> void:
	MusicManager.set_volume(value)
	print ("val : " + str(value))
