extends Control

func _ready() -> void:
	visible = false

func showMenu() -> void:
	visible = true
	get_tree().paused = true
	$AnimationPlayer.play("Blur")

func _on_continue_pressed() -> void:
	get_tree().paused = false
	visible = false
	Global.increase_nbr_enemies()
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")

func _on_quit_pressed() -> void:
	$AnimationPlayer.play_backwards("Blur")
	Global.emit_signal("ask_name")