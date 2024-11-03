extends State

class_name FlyingGolemFly

@export var flying_golem : Enemy
@export var attack_distance : float = 52.0

var anim_enemy : AnimationPlayer

func Enter():
	if not anim_enemy:
		anim_enemy = flying_golem.get_animation_enemy()
	anim_enemy.play("Fly")
	
func Update(delta: float):
	if not flying_golem.direction:
		Transitioned.emit(self, "flyinggolemidle")
	
	var distance = flying_golem.global_position.distance_to(Global.player.global_position)
		
	if distance <= attack_distance:
		Transitioned.emit(self, "flyinggolemattack")
	
	#if flying_golem.attack_player:
		#Transitioned.emit(self, "flyinggolemattack")
	
	if not flying_golem.chase_player:
		flying_golem.velocity += flying_golem.direction * flying_golem.movement_speed * delta
	else:
		if flying_golem.nav_agent.is_navigation_finished():
			return
		
		var axis = flying_golem.to_local(flying_golem.nav_agent.get_next_path_position()).normalized()
		flying_golem.direction = axis
		flying_golem.velocity = axis * flying_golem.movement_speed
