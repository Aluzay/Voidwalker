extends Node2D

var is_level1_finish : bool
var is_player_inside_end : bool
var target_kill : int = 5
var rooms : Array

@export var mob_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_kill = Global.nbr_enemies
	
	rooms = get_node("Rooms").get_children()
	
	for i in target_kill:
		var mob = mob_scene.instantiate()
		var mob_spawn_locaton = $Path2D/PathFollow2D
		mob_spawn_locaton.progress_ratio = randf()
		
		mob.position = mob_spawn_locaton.position
		print(mob.position)
		
		add_child(mob)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gameEnd()

func gameEnd() -> void:
	if is_level1_finish:
		get_tree().change_scene_to_file("res://Scenes/Levels/Level2.tscn")
		

func _on_end_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_inside_end = true
		
		if Global.player.enemies_killed == target_kill:
			is_level1_finish = true


func _on_end_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_inside_end = false
