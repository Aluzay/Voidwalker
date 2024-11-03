extends State

class_name FlyingGolemHurt

@export var damageable : Damageable
@export var flying_golem : Enemy
@export var knockback_speed : float = 100.0

var anim_enemy : AnimationPlayer

func _ready() -> void:
	damageable.connect("on_hit", on_damagable_hit)

func Enter():
	if flying_golem:
		anim_enemy = flying_golem.get_animation_enemy()
	anim_enemy.play("Hurt")

func Update(delta: float):
	if not anim_enemy.is_playing():
		Transitioned.emit(self, "flyinggolemidle")
		flying_golem.velocity = Vector2.ZERO
	
func on_damagable_hit(node : Node, damage_amout : int, knockback_direction : Vector2):
	if damageable.health > 0:
		flying_golem.velocity = knockback_speed * knockback_direction
		interrupt_state.emit("flyinggolemhurt")
	else:
		interrupt_state.emit("flyinggolemdie")
