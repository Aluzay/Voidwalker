extends Label

var alphabet : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"  # Lettres disponibles
var current_index : int = 0

func _ready() -> void:
	update_letter()
	#add_theme_color_override("font_color", Color(1, 0, 1))
	
func update_letter() -> void:
	text = alphabet[current_index]

func next_letter() -> void:
	current_index = (current_index + 1) % alphabet.length()
	update_letter()

func previous_letter() -> void:
	current_index = (current_index - 1 + alphabet.length()) % alphabet.length()
	update_letter()
