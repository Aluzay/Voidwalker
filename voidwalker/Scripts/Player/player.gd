extends CharacterBody2D

class_name Player

@onready var wall_collider = $WallCollider
@onready var stair_collider = $StairCollider
@onready var stair_collider2 = $StairCollider2
@onready var attack_area = $AttackArea
@onready var dash : GPUParticles2D = $Dash

var anim_player : AnimationPlayer
var sprite : Sprite2D
var can_dash : bool = true
var can_jump_on_wall : bool = true
var can_double_jump = true
var direction = 0
var current_room
var previous_room

signal facing_direction_changed(facing_right : bool)

func _ready() -> void:
	dash.emitting = false
	Global.player = self
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	anim_player.play("Idle")

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("Left", "Right")
	
	if (stair_collider.is_colliding() or stair_collider2.is_colliding()) and direction:
		var collision = stair_collider.get_collider()
		
		if collision != null:
			if collision.name == "StairTiles":
				velocity.y = -100
	
	if (direction == 1):
		sprite.flip_h = false
		wall_collider.scale.x = 1
		dash.scale.x = 1
		
	elif (direction == -1):
		sprite.flip_h = true
		wall_collider.scale.x = -1
		dash.scale.x = -1
	
	emit_signal("facing_direction_changed", !sprite.flip_h)
	
	move_and_slide()
	
func get_animation_player () -> AnimationPlayer:
	return anim_player

func _on_timer_timeout() -> void:
	if not can_dash:
		can_dash = !can_dash
	if not can_jump_on_wall:
		can_jump_on_wall = !can_jump_on_wall

func _on_room_detector_area_entered(area: Area2D) -> void:
	if area is Room:
		var collision_shape : CollisionShape2D = area.get_children()[0]
		current_room = collision_shape
		RoomTransitor.change_room(collision_shape.global_position, collision_shape.shape.size * 2, area)
	
func _on_room_detector_area_exited(area: Area2D) -> void:
	var collision_shape : CollisionShape2D = area.get_children()[0]
	
	if collision_shape != current_room:
		previous_room = current_room
	else:
		if previous_room:
			RoomTransitor.change_room(previous_room.global_position, previous_room.shape.size * 2, area)
