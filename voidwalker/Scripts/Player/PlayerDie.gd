extends State

class_name PlayerDie

@export var player : Player

var anim_player : AnimationPlayer
var coll_enemy : CollisionShape2D

func Enter():
	if not anim_player:
		anim_player = player.get_animation_player()
	player.velocity = Vector2.ZERO
	anim_player.play("Die")	
	
	
func Update(delta: float):		
	if not anim_player.is_playing():
		TimeManager.reset_timer()
		get_tree().change_scene_to_file("res://Scenes/Menu/MainMenu.tscn")

func Exit():
	player.attack_area.monitoring = false
	player.attack_weapon_area.monitoring = false
