extends State

class_name PlayerHurt

@export var damageable : Damageable
@export var player : Player
@export var knockback_speed : float = 100.0

var anim_player : AnimationPlayer

func _ready() -> void:
	damageable.connect("on_hit", on_damagable_hit)

func Enter():
	if player:
		anim_player = player.get_animation_player()
	anim_player.play("Hurt")

func Update(delta: float):
	if not player.is_on_floor() and not anim_player.is_playing():
		Transitioned.emit(self, "playerfalling")
	
	if not anim_player.is_playing():
		Transitioned.emit(self, "playeridle")

func on_damagable_hit(node : Node, damage_amout : int, knockback_direction : Vector2):
	if damageable.health > 0:
		player.velocity = knockback_speed * knockback_direction
		interrupt_state.emit("playerhurt")
	else:
		interrupt_state.emit("playerdie")
