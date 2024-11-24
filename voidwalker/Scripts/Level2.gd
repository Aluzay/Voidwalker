extends Node2D

@export var mob_scene : PackedScene
@export var toast_scene : PackedScene

var target_kill : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.connect("boss_killed", _on_boss_killed)
	
	target_kill = Global.nbr_enemies
	
	for i in target_kill:
		var mob = mob_scene.instantiate()
		var mob_spawn_locaton = choose([$EnemiesSpawnPath/Salle1/PathFollow2D, $EnemiesSpawnPath/Salle2/PathFollow2D, $EnemiesSpawnPath/Salle3/PathFollow2D])
		mob_spawn_locaton.progress_ratio = randf()
		
		mob.position = mob_spawn_locaton.position
		
		add_child(mob)
		
	for i in Global.nbr_toasts:
		var toast = toast_scene.instantiate()
		var toast_spawn_location = choose([$EnemiesSpawnPath/Salle1/PathFollow2D, $EnemiesSpawnPath/Salle2/PathFollow2D, $EnemiesSpawnPath/Salle3/PathFollow2D])
		toast_spawn_location.progress_ratio = randf()
		
		toast.position = toast_spawn_location.position
	
		add_child(toast)	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	manage_end_game()

func is_on_arcade() -> bool:
	return OS.get_executable_path().to_lower().contains("retropie")

func manage_end_game() -> void:
	if is_on_arcade() :
		if Input.is_action_pressed("hotkey") and Input.is_action_pressed("quit"):
			get_tree().quit()
	else :
		if Input.is_action_just_pressed("quit"):
			get_tree().quit()

func _on_boss_killed() -> void:
	print("The boss have been killed")
	$EndMenu/EndMenu.showMenu()

func choose(array : Array):
	array.shuffle()
	return array.front()
