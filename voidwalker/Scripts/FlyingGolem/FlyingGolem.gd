extends Enemy

class_name FlyingGolem

@export var timer_movement : Timer

@onready var music : AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	anim_enemy.play("Idle")
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	MusicManager.add_sound(music)

func _physics_process(delta: float) -> void:
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
	
	emit_signal("facing_direction_changed", !sprite.flip_h)
	
	move_and_slide()

func _on_random_movement_timeout() -> void:
	$RandomMovement.wait_time = choose([0.2, 0.5, 0.8])
	if !chase_player:
		direction = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN, Vector2.UP])
	
func _on_aggro_range_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		chase_player = true

func _on_de_aggro_range_body_exited(body: Node2D) -> void:
	if body is Player:
		chase_player = false
		
func _on_recalculate_timer_timeout() -> void:
	recalc_path()
