extends Node2D

@export var mob_scene : PackedScene

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
		print(mob.position)
		
		add_child(mob)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_boss_killed() -> void:
	print("The boss have been killed")
	$EndMenu/EndMenu.showMenu()

func choose(array : Array):
	array.shuffle()
	return array.front()
