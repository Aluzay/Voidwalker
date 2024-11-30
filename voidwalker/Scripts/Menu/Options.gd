extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_on_arcade():
		$Sauter.text = "Sauter : A"
		$Attack.text = "Attack : X"
		$Dash.text = "Dash : B"
		$Switch.text = "Switch : Y"
		$Escape.text = "Press start to go back"
	else:
		$Sauter.text = "Sauter : Space"
		$Attack.text = "Attack : V"
		$Dash.text = "Dash : Ctrl"
		$Switch.text = "Switch : R"
		$Escape.text = "Press escape to go back"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Escape"):
		get_tree().change_scene_to_file("res://Scenes/Menu/MainMenu.tscn")


func is_on_arcade() -> bool:
	return OS.get_executable_path().to_lower().contains("retropie")

func manage_end_game() -> void:
	if is_on_arcade() :
		if Input.is_action_pressed("hotkey") and Input.is_action_pressed("quit"):
			get_tree().quit()
	else :
		if Input.is_action_just_pressed("quit"):
			get_tree().quit()	
