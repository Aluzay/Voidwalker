extends State

class_name PlayerDie

@export var player : Player

var anim_player : AnimationPlayer
var coll_enemy : CollisionShape2D

func Enter():
	if not anim_player:
		anim_player = player.get_animation_player()
	player.velocity = Vector2.ZERO
	anim_player.play("Die")	
	
	
func Update(delta: float):		
	if not anim_player.is_playing():
			get_tree().quit()