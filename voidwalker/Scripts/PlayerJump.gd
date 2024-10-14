extends State
class_name PlayerJump

@export var player: Player
var anim_player : AnimationPlayer
const JUMP_VELOCITY = -400.0
const SPEED = 300.0

func Enter():
	if not anim_player:
		anim_player = player.get_animation_player()
		
	if player:
		player.velocity.y = JUMP_VELOCITY
		anim_player.play("Jump")
		player.can_jump = false

func Update(delta: float):	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		player.direction = Input.get_axis("Left", "Right")
	
		if player.direction:
			player.velocity.x = player.direction * SPEED
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
			
	if (player.velocity.y > 0):
		Transitioned.emit(self, "playerfalling")
		
	if Input.is_action_just_pressed("Dash") and player.direction and player.can_dash:
		Transitioned.emit(self, "playerdash")
