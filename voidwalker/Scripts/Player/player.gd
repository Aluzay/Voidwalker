extends CharacterBody2D

class_name Player

@export var damageable : Damageable

@onready var wall_collider = $WallCollider
@onready var stair_collider = $StairCollider
@onready var stair_collider2 = $StairCollider2
@onready var attack_area = $AttackArea
@onready var attack_weapon_area = $AttackWithWeapon
@onready var dash : GPUParticles2D = $Dash
@onready var music : AudioStreamPlayer = $Audio

var anim_player : AnimationPlayer
var sprite : Sprite2D
var can_dash : bool = true
var can_jump_on_wall : bool = true
var can_double_jump = true
var direction = 0
var current_room
var previous_room
var enemies_killed : int = 0
var is_using_weapon : bool = false

signal facing_direction_changed(facing_right : bool)

func _ready() -> void:
	dash.emitting = false
	Global.player = self
	Global.connect("enemy_killed", _on_enemy_killed)
	MusicManager.add_sound(music)
	#damageable.health = Global.player_data.health
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	anim_player.play("Idle")

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("Left", "Right")
	
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
	if area is Room:
		var collision_shape : CollisionShape2D = area.get_children()[0]
		
		if collision_shape != current_room:
			previous_room = current_room
		else:
			if previous_room:
				RoomTransitor.change_room(previous_room.global_position, previous_room.shape.size * 2, area)


func _on_death_area_body_entered(body: Node2D) -> void:
	var damage : int = 2000
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage, Vector2.ZERO)

func _on_enemy_killed() -> void:
	enemies_killed += 1
	print(enemies_killed)
