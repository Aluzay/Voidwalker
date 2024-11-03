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

func _ready() -> void:
	anim_enemy.play("Idle")
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	
func get_animation_enemy () -> AnimationPlayer:
	return anim_enemy

func _physics_process(delta: float) -> void:
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
	
	emit_signal("facing_direction_changed", !sprite.flip_h)
	
	move_and_slide()

func _on_random_movement_timeout() -> void:
	$RandomMovement.wait_time = choose([0.2, 0.5, 0.8])
	if !chase_player:
		direction = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN, Vector2.UP])
	
func choose(array : Array):
	array.shuffle()
	return array.front()

func recalc_path():
	if chase_player and player:
		nav_agent.target_position = player.global_position
	
func _on_aggro_range_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		chase_player = true

func _on_de_aggro_range_body_exited(body: Node2D) -> void:
	if body is Player:
		chase_player = false
		
func _on_recalculate_timer_timeout() -> void:
	recalc_path()
