extends Area2D

@export var damage : int = 10
@export var character : CharacterBody2D
@export var facing_shape : FacingCollisionShape

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = false
	character.connect("facing_direction_changed", _on_player_facing_direction_changed)

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Damageable:
			var direciton_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direciton_to_damageable.x)
			
			if direction_sign > 0:
				child.hit(damage, Vector2.RIGHT)
			elif direction_sign < 0:
				child.hit(damage, Vector2.LEFT)			
			
			print_debug(body.name + " took " + str(damage))	
	set_deferred("monitoring", false)
	
func _on_player_facing_direction_changed(facing_right : bool):
	if facing_right:
		facing_shape.position.x = facing_shape.facing_right_position.x
	else:
		facing_shape.position.x = facing_shape.facing_left_position.x
