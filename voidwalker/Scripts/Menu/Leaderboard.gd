extends Control

@onready var line_edit = $HBoxContainer/LineEdit

var player_name : String

func _ready() -> void:
	Global.connect("ask_name", showNameAsk)
	#visible = false

func _on_submit_pressed() -> void:
	await Leaderboards.post_guest_score("voidwalkerleaderboar-voidwalker-lead-Wh7W", Global.player_time_score, player_name)
	visible = false
	get_tree().change_scene_to_file("res://Scenes/Menu/MainMenu.tscn")

func _on_line_edit_text_changed(new_text: String) -> void:
	player_name = line_edit.text
	print(player_name)

func showNameAsk() -> void:
	visible = true
