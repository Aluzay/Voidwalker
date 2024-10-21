extends CharacterBody2D

class_name Player

@onready var camera: Camera2D = $Camera2D
@onready var wall_collider = $WallCollider
@onready var stair_collider = $StairCollider
@onready var stair_collider2 = $StairCollider2

var anim_player : AnimationPlayer
var sprite : Sprite2D
var can_dash : bool = true
var can_jump_on_wall : bool = true
var can_double_jump = true
var direction = 0

func _ready() -> void:
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	anim_player.play("Idle")

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("Left", "Right")
	
	if (stair_collider.is_colliding() or stair_collider2.is_colliding()) and direction:
		var collision = stair_collider.get_collider()
		print("cOLLIDE")
		if collision != null:
			if collision.name == "StairTiles":
				velocity.y = -100
	
	if (direction == 1):
		sprite.flip_h = false
		wall_collider.scale.x = 1
	elif (direction == -1):
		sprite.flip_h = true
		wall_collider.scale.x = -1
	move_and_slide()
	
func get_animation_player () -> AnimationPlayer:
	return anim_player

func _on_timer_timeout() -> void:
	if not can_dash:
		can_dash = !can_dash
	if not can_jump_on_wall:
		can_jump_on_wall = !can_jump_on_wall
