extends Node

var sounds : Array = []
var volume : float = 0.5

func remove_sounds() -> void:
	sounds.clear()

func add_sound(sound : AudioStreamPlayer) -> void:
	sounds.append(sound) 

func set_volume(value : float) -> void:
	volume = value

func set_sounds() -> void:
	for sound in sounds:
		if is_instance_valid(sound):
			sound.volume_db = linear_to_db(volume)
		else: 
			print("Sound was freed: " + str(sound))
