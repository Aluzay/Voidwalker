extends CharacterBody2D

class_name Player

@onready var camera: Camera2D = $Camera2D
var anim_player : AnimationPlayer
var sprite : Sprite2D
var can_dash : bool = true
var can_jump : bool = true
var direction = 0

func _ready() -> void:
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	anim_player.play("Idle")

func _physics_process(delta: float) -> void:
	if (velocity.x > 0):
		sprite.flip_h = false
	elif (velocity.x < 0):
		sprite.flip_h = true
	
	move_and_slide()
	
func get_animation_player () -> AnimationPlayer:
	return anim_player

func _on_timer_timeout() -> void:
	if not can_dash:
		can_dash = !can_dash
	if not can_jump:
		can_jump = !can_jump
