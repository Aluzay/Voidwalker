extends State

class_name FlyingGolemDie

@export var flying_golem : Enemy

var anim_enemy : AnimationPlayer
var coll_enemy : CollisionShape2D

func Enter():
	if flying_golem:
		anim_enemy = flying_golem.get_animation_enemy()
	flying_golem.velocity = Vector2.ZERO
	anim_enemy.play("Die")	
	coll_enemy = flying_golem.get_node("CollisionShape2D")
	
func Update(delta: float):
	if not coll_enemy.disabled:
		coll_enemy.set_disabled(true)
		
	if not anim_enemy.is_playing():
			flying_golem.queue_free()
