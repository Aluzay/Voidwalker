extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	Global.load_game()
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_leaderboard_pressed() -> void:
	get_tree().change_scene_to_file("res://addons/quiver_leaderboards/leaderboard_ui.tscn")