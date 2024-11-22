extends VBoxContainer

var current_slot_index : int = 0
@onready var slots : Array = $HBoxContainer.get_children()  # Récupère les Labels (les slots)

func _ready():
	highlight_slot(current_slot_index)

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		change_letter("up")
	elif Input.is_action_just_pressed("ui_down"):
		change_letter("down")
	elif Input.is_action_just_pressed("ui_right"):
		next_slot()
	elif Input.is_action_just_pressed("ui_left"):
		previous_slot()
	elif Input.is_action_just_pressed("ui_accept"):
		confirm_name()

func confirm_name():
	var name = ""
	for slot in slots:
		name += slot.text
	print("Nom confirmé : ", name)

	await Leaderboards.post_guest_score("voidwalkerleaderboar-voidwalker-lead-3Hgs", Global.get_player_score(), name)
	get_tree().change_scene_to_file("res://Scenes/Menu/MainMenu.tscn")

# Met en évidence le slot actif
func highlight_slot(index):
	for i in range(slots.size()):
		if i == index:
			slots[i].add_theme_color_override("font_color", Color(1, 1, 1))  # Rouge pour activer
		else:
			slots[i].add_theme_color_override("font_color", Color("3b3b5e"))  # Blanc pour inactif

# Naviguer entre les slots
func next_slot():
	current_slot_index = (current_slot_index + 1) % slots.size()
	highlight_slot(current_slot_index)

func previous_slot():
	current_slot_index = (current_slot_index - 1 + slots.size()) % slots.size()
	highlight_slot(current_slot_index)

# Modifier la lettre active
func change_letter(direction):
	if direction == "up":
		slots[current_slot_index].next_letter()
	elif direction == "down":
		slots[current_slot_index].previous_letter()
