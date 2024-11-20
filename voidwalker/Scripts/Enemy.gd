extends CharacterBody2D

class_name Enemy

@export var movement_speed : float = 30.0
@export var nav_agent : NavigationAgent2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var anim_enemy : AnimationPlayer = $AnimationEnemy

var chase_player : bool = false
var attack_player : bool = false
var direction : Vector2
var player : Player

signal facing_direction_changed(facing_right : bool)
	
func get_animation_enemy () -> AnimationPlayer:
	return anim_enemy
	
func choose(array : Array):
	array.shuffle()
	return array.front()

func recalc_path():
	if chase_player and player:
		nav_agent.target_position = player.global_position
