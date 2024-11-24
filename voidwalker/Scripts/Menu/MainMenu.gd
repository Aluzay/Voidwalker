extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Start.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	TimeManager.reset_timer()
	TimeManager.start_timer()
	Global.load_game()
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Options.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_leaderboard_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/quiver_leaderboards/leaderboard_ui.tscn")
