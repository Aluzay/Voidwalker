extends Node
class_name Damageable

@export var health : float = 20
@export var max_health = 20

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

func hit(damage : int, knockback_direciton : Vector2):
	health -= damage
	
	emit_signal("on_hit", get_parent(), damage, knockback_direciton)
