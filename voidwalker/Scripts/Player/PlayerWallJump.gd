extends State
class_name PlayerWallJump

@export var player: Player
var anim_player : AnimationPlayer
var control_timer = 0
const JUMP_VELOCITY = -400.0
const BACK_VELOCITY = 250.0
const DECAY_RATE = 2000.0
const SPEED = 300.0
const CONTROL_DELAY = 0.3

func Enter():
	if not anim_player:
		anim_player = player.get_animation_player()
	anim_player.play("Jump")
	
	if player:
		player.velocity.y = JUMP_VELOCITY
		player.velocity.x = BACK_VELOCITY * (-1 * player.direction)
		control_timer = 0.0
		player.can_jump_on_wall = false
		
func Update(delta: float):	
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
		player.direction = Input.get_axis("Left", "Right")
	
	control_timer += delta
	if control_timer >= CONTROL_DELAY:
		player.direction = Input.get_axis("Left", "Right")
		if player.direction != 0:
			player.velocity.x = player.direction * SPEED
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, SPEED * delta)
	else:
		if player.velocity.x != 0:
			player.velocity.x = move_toward(player.velocity.x, 0, DECAY_RATE * delta)	
				
	if (player.velocity.y > 0):
		Transitioned.emit(self, "playerfalling")
		
	if Input.is_action_just_pressed("Dash") and player.direction and player.can_dash:
		Transitioned.emit(self, "playerdash")
