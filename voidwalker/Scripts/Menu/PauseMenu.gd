extends Control

func _ready() -> void:
	visible = false
	$AnimationPlayer.play("RESET")

func resume():
	visible = false
	get_tree().paused = false
	$AnimationPlayer.play_backwards("Blur")
	
func pause():
	visible = true
	get_tree().paused = true
	$AnimationPlayer.play("Blur")
	
func testEscape():
	if Input.is_action_just_pressed("Escape") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused:
		resume()

func _process(delta: float) -> void:
	testEscape()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	TimeManager.reset_timer()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	Global.save_game()
	get_tree().quit()
