extends State
class_name PlayerDash

@export var player: Player
@export var dash_curve : Curve

const DASH_MAX_DIST = 30.0
const DASH_SPEED = 100.0

var dash_direction = 0
var dash_start_position = 0
var anim_player : AnimationPlayer

func Enter():
	if not anim_player:
		anim_player = player.get_animation_player()
	anim_player.play("Dash")
	player.can_dash = false
	dash_start_position = player.position.x
		
func Update(delta: float):	
	var current_distance = abs(player.position.x - dash_start_position)
	if current_distance <= DASH_MAX_DIST and not player.is_on_wall():
		player.velocity.x = player.direction * DASH_SPEED * dash_curve.sample(current_distance / DASH_MAX_DIST)
	else:
		Transitioned.emit(self, "playeridle")
