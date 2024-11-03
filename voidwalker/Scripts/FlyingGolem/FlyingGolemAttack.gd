extends State

class_name FlyingGolemAttack

@export var flying_golem : Enemy

var anim_enemy : AnimationPlayer

func Enter():
	if not anim_enemy:
		anim_enemy = flying_golem.get_animation_enemy()
	flying_golem.velocity = Vector2.ZERO
	anim_enemy.play("Attack")
	
func Update(delta: float):
	if not anim_enemy.is_playing():
		Transitioned.emit(self, "flyinggolemidle")
