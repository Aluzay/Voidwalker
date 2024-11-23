extends Node

signal enemy_killed
signal boss_killed
signal ask_name
signal healed

var player : Player
var player_name : String
var player_time_score : float = 0.0
var nbr_enemies : int = 5
var nbr_toasts : int = 20
var player_data = PlayerData.new()
var level1_data = Level1Data.new()

var save_file_path = "user://save/"
var save_file_player = "player_save.tres"
var save_file_level1 = "level1_save.tres"

func _ready() -> void:
	verify_save_directory(save_file_path)

func increase_nbr_enemies() -> void:
	nbr_enemies += 1

func calculate_score(base_points: float, difficulty: float, time: float, scaling_factor: float, time_adjustment_factor: float) -> float:
	var adjusted_time = time / (difficulty ** time_adjustment_factor)
	return base_points * (difficulty ** scaling_factor) / (1 + adjusted_time)

func get_player_score() -> float:
	var base_points : float = 100.0
	var scaling_factor : float = 2.5
	var time_adjustment_factor : float = 1.2
	
	var score : float = calculate_score(base_points, nbr_enemies, player_time_score, scaling_factor, time_adjustment_factor)
	
	return score

func verify_save_directory(path : String) -> void:
	DirAccess.make_dir_absolute(path)

func save_game() -> void:
	ResourceSaver.save(player_data, save_file_path + save_file_player)
	ResourceSaver.save(level1_data, save_file_path + save_file_level1)

func load_game() -> void:
	# duplicate(true) permet de charger une copie profonde (deep copy) de la ressource, i.e. une copie des sous-ressources. Autrement, les sous-ressources ne seront pas chargées (shallow copy).
	player_data = ResourceLoader.load(save_file_path + save_file_player).duplicate(true)
	level1_data = ResourceLoader.load(save_file_path + save_file_level1).duplicate(true)
