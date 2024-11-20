extends TextureProgressBar

@export var character: CharacterBody2D

var damageable: Damageable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damageable = character.get_child(0)
	damageable.connect("on_hit", update)
	update(null, 0, Vector2.ZERO)
	

func update(node : Node, damage_taken : int, knockback_direction : Vector2) -> void:
	value = damageable.health * 100 / damageable.max_health
