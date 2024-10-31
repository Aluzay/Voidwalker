extends Area2D

@export var damage : int = 10
@export var player : Player
@export var facing_shape : FacingCollisionShape

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monitoring = false
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)
			print_debug(body.name + " took " + str(damage))
			
	print(body.name)

func _on_player_facing_direction_changed(facing_right : bool):
	if facing_right:
		facing_shape.position.x = facing_shape.facing_right_position.x
	else:
		facing_shape.position.x = facing_shape.facing_left_position.x
