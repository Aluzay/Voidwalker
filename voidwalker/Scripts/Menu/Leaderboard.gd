extends Control

@onready var line_edit = $PanelContainer/HBoxContainer/LineEdit

var player_name : String

func _ready() -> void:
	#Global.connect("ask_name", showNameAsk)
	pass

func _on_submit_pressed() -> void:
	await Leaderboards.post_guest_score("voidwalkerleaderboar-voidwalker-lead-Wh7W", Global.player_time_score, player_name)
	$AnimationPlayer.play_backwards("Blur")
	get_tree().change_scene_to_file("res://Scenes/Menu/MainMenu.tscn")

func _on_line_edit_text_changed(new_text: String) -> void:
	player_name = line_edit.text
	print(player_name)

func showNameAsk() -> void:
	print("show")
	$AnimationPlayer.play("Blur")
	#await get_tree().process_frame
	#$HBoxContainer/LineEdit.grab_focus()
