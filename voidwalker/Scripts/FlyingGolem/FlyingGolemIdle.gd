extends State

class_name FlyingGolemIdle

@export var flying_golem : Enemy

var anim_enemy : AnimatedSprite2D

func Enter():
	if anim_enemy:
		anim_enemy.play("Idle")
	
func Update(delta: float):
	if not anim_enemy:
		anim_enemy = flying_golem.get_animation_enemy()
	if flying_golem.direction:
		Transitioned.emit(self, "flyinggolemfly")
