extends CharacterBody2D

class_name Enemy

@export var movement_speed : float = 30.0

@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D 

var anim_enemy : AnimatedSprite2D
var chase_player : bool = false
var direction : Vector2

const JUMP_VELOCITY = -400.0

func _ready() -> void:
	anim_enemy = $AnimatedSprite2D
	anim_enemy.play("Idle")
	
func get_animation_enemy () -> AnimatedSprite2D:
	return anim_enemy


func _physics_process(delta: float) -> void:
	
	if direction.x == -1:
		anim_sprite.flip_h = true
	elif direction.x == 1:
		anim_sprite.flip_h = false
	
	move_and_slide()


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		chase_player = true
	
func _on_player_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		chase_player = false

func _on_random_movement_timeout() -> void:
	$RandomMovement.wait_time = choose([1.0, 1.5, 2.0])
	if !chase_player:
		direction = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN, Vector2.UP])
	
func choose(array : Array):
	array.shuffle()
	
	return array.front()
