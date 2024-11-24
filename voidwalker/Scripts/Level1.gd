extends Node2D

var is_level1_finish : bool
var is_player_inside_end : bool
var target_kill : int = 5

@export var mob_scene : PackedScene
@export var toast_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_kill = Global.nbr_enemies
	
	for i in target_kill:
		var mob = mob_scene.instantiate()
		var mob_spawn_locaton = $Path2D/PathFollow2D
		mob_spawn_locaton.progress_ratio = randf()
		
		mob.position = mob_spawn_locaton.position
		print(mob.position)
		
		add_child(mob)
		
	for i in Global.nbr_toasts:
		var toast = toast_scene.instantiate()
		var toast_spawn_location = $Path2D/PathFollow2D
		toast_spawn_location.progress_ratio = randf()
		
		toast.position = toast_spawn_location.position
	
		add_child(toast)
	
	if MusicManager.sounds.is_empty():
		MusicManager.set_sounds()	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gameEnd()
	manage_end_game()

func gameEnd() -> void:
	if is_level1_finish:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level2.tscn")

func is_on_arcade() -> bool:
	return OS.get_executable_path().to_lower().contains("retropie")

func manage_end_game() -> void:
	if is_on_arcade() :
		if Input.is_action_pressed("hotkey") and Input.is_action_pressed("quit"):
			get_tree().quit()
	else :
		if Input.is_action_just_pressed("quit"):
			get_tree().quit()	

func _on_end_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_inside_end = true
		
		if Global.player.enemies_killed == target_kill:
			is_level1_finish = true


func _on_end_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_inside_end = false
