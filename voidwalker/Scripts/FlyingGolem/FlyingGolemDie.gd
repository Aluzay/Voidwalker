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
			if flying_golem is FlyingGolem:
				print("FlyingGolem killed")
				Global.emit_signal("enemy_killed")
			elif flying_golem is FlyingGolemBoss:
				print("FlyingGolemBoss killed")
				Global.emit_signal("boss_killed")
				
			flying_golem.queue_free()
