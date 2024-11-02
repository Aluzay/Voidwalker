extends CharacterBody2D

class_name Enemy

@export var movement_speed : float = 30.0
@export var nav_agent : NavigationAgent2D

@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D 

var anim_enemy : AnimatedSprite2D
var chase_player : bool = false
var direction : Vector2
var home_pos : Vector2 = Vector2.ZERO
var player : Player


const JUMP_VELOCITY = -400.0

func _ready() -> void:
	anim_enemy = $AnimatedSprite2D
	anim_enemy.play("Idle")
	home_pos = self.global_position
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	
	
func get_animation_enemy () -> AnimatedSprite2D:
	return anim_enemy

func _physics_process(delta: float) -> void:
	
	if direction.x == -1:
		anim_sprite.flip_h = true
	elif direction.x == 1:
		anim_sprite.flip_h = false
	#print(to_local(nav_agent.get_next_path_position()).normalized())
	print(nav_agent.get_next_path_position())
	print(nav_agent.target_position)
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
