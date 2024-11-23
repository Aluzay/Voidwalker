extends Node

var sounds : Array = []
var volume : float = 0.5

func add_sound(sound : AudioStreamPlayer) -> void:
	sounds.append(sound) 
	print("Added sound " + str(sound))

func set_volume(value : float) -> void:
	print(value)
	volume = value

func set_sounds() -> void:
	print(volume)
	for sound in sounds:
		sound.volume_db = linear_to_db(volume)
