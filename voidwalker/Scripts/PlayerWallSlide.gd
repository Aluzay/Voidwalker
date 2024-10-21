extends State
class_name PlayerWallSide

@export var player: Player
var anim_player : AnimationPlayer
const SPEED = 300.0
const WALL_SLIDING_SPEED = 150
func Enter():
	if not anim_player:
		anim_player = player.get_animation_player()
	anim_player.play("WallSlide")

func Update(delta: float):
	if player:
		player.direction = Input.get_axis("Left", "Right")
		
		if Input.is_action_just_pressed("ui_accept") and player.direction and player.can_jump_on_wall:
			Transitioned.emit(self, "playerwalljump")
		
		if player.is_on_floor():
			Transitioned.emit(self, "playeridle")
			
		if player.direction and player.wall_collider.is_colliding():
			player.velocity.y += WALL_SLIDING_SPEED * delta
			player.velocity.y = min(player.velocity.y, WALL_SLIDING_SPEED)
		else:
			Transitioned.emit(self, "playerfalling")
